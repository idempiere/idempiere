/******************************************************************************
 * Product: Adempiere ERP & CRM Smart Business Solution                       *
 * Copyright (C) 2010 Heng Sin Low                							  *
 * This program is free software; you can redistribute it and/or modify it    *
 * under the terms version 2 of the GNU General Public License as published   *
 * by the Free Software Foundation. This program is distributed in the hope   *
 * that it will be useful, but WITHOUT ANY WARRANTY; without even the implied *
 * warranty of MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.           *
 * See the GNU General Public License for more details.                       *
 * You should have received a copy of the GNU General Public License along    *
 * with this program; if not, write to the Free Software Foundation, Inc.,    *
 * 59 Temple Place, Suite 330, Boston, MA 02111-1307 USA.                     *
 *****************************************************************************/
package org.adempiere.base;

import java.awt.event.WindowAdapter;
import java.awt.event.WindowEvent;
import java.io.File;
import java.io.IOException;
import java.io.OutputStream;
import java.io.PrintStream;
import java.nio.charset.StandardCharsets;
import java.nio.file.Files;
import java.nio.file.Path;
import java.nio.file.Paths;
import java.util.ArrayList;
import java.util.Comparator;
import java.util.List;
import java.util.Map;
import java.util.stream.Stream;

import javax.swing.JFrame;

import org.adempiere.util.ModelClassGenerator;
import org.adempiere.util.ModelGeneratorDialog;
import org.adempiere.util.ModelGeneratorOptions;
import org.adempiere.util.ModelInterfaceGenerator;
import org.compiere.Adempiere;
import org.compiere.model.MEntityType;
import org.compiere.model.MModelGeneratorTemplate;
import org.compiere.model.Query;
import org.compiere.util.Env;
import org.eclipse.equinox.app.IApplication;
import org.eclipse.equinox.app.IApplicationContext;

/**
 * Eclipse application to launch the swing based model generation dialog.
 * @author hengsin
 * @author tbayen - command line start
 *
 */
public class ModelGeneratorApplication implements IApplication {

	/** exit code: a safety rule refused the call, or {@code --check} found a difference */
	private static final Integer EXIT_FAILED = Integer.valueOf(1);

	/** outcome of a command line run, printed as the last output line */
	private enum Result {
		OK("ok", IApplication.EXIT_OK), REFUSED("refused", EXIT_FAILED), ERROR("error", EXIT_FAILED), DIFFERS("differs", EXIT_FAILED);

		private final String label;
		private final Integer exitCode;

		Result(String label, Integer exitCode) {
			this.label = label;
			this.exitCode = exitCode;
		}
	}

	/* (non-Javadoc)
	 * @see org.eclipse.equinox.app.IApplication#start(org.eclipse.equinox.app.IApplicationContext)
	 */
	@Override
	public Object start(IApplicationContext context) throws Exception {
		Adempiere.startup(false);
		Map<?, ?> args = context.getArguments();
		// IDEMPIERE-1686 - GenerateModel does not take commandline arguments
		String commandlineArgs[] = (String[]) args.get("application.args");
		if (commandlineArgs.length != 0) {
			return runCommandLine(commandlineArgs);
		} else {
			ModelGeneratorDialog dialog = new ModelGeneratorDialog();
			dialog.addWindowListener(new WindowAdapter() {
				@Override
				public void windowClosed(WindowEvent e) {
					context.setResult(IApplication.EXIT_OK, ModelGeneratorApplication.this);
					stop();
				}
				
			});
			//dialog.setModal(true);
			dialog.setDefaultCloseOperation(JFrame.DISPOSE_ON_CLOSE);
			dialog.pack();
			dialog.setLocationRelativeTo(null);
			dialog.setVisible(true);
			
		}
		
		// async stop on close window
		return IApplicationContext.EXIT_ASYNC_RESULT;
	}

	/**
	 * Generate (or check) from command line arguments, positional or named. The last output line is {@code result: <outcome>}.
	 * @param commandlineArgs arguments
	 * @return {@link IApplication#EXIT_OK}, or 1 when the call was refused, failed or {@code --check} found a difference
	 */
	private Object runCommandLine(String[] commandlineArgs) {
		Result result;
		try {
			result = execute(commandlineArgs);
		} catch (RuntimeException | IOException e) {
			System.out.println("ERROR " + e);
			result = Result.ERROR;
		}
		System.out.println("result: " + result.label);
		return result.exitCode;
	}

	private Result execute(String[] commandlineArgs) throws IOException {
		if (ModelGeneratorOptions.isHelp(commandlineArgs)) {
			System.out.println(ModelGeneratorOptions.usage());
			return Result.OK;
		}
		ModelGeneratorOptions options;
		try {
			options = ModelGeneratorOptions.parse(commandlineArgs);
		} catch (IllegalArgumentException e) {
			System.out.println(e.getMessage());
			System.out.println(ModelGeneratorOptions.usage());
			return Result.ERROR;
		}
		if (options.getTemplate() != null) {
			Query templateQuery = new Query(Env.getCtx(), MModelGeneratorTemplate.Table_Name,
					MModelGeneratorTemplate.COLUMNNAME_Name + "=?", null)
					.setParameters(options.getTemplate()).setOnlyActiveRecords(true);
			if (templateQuery.count() > 1) {
				System.out.println("Generate Model Template name is not unique: " + options.getTemplate());
				return Result.ERROR;
			}
			MModelGeneratorTemplate template = templateQuery.first();
			if (template == null) {
				System.out.println("Generate Model Template not found: " + options.getTemplate());
				return Result.ERROR;
			}
			options.applyTemplate(template.getFolder(), template.getPackageName(), template.getTableName(),
					template.getTableEntityType(), template.getColumnEntityType());
		}
		List<String> missing = options.missing();
		if (!missing.isEmpty()) {
			System.out.println("Missing: " + String.join(", ", missing));
			System.out.println(ModelGeneratorOptions.usage());
			return Result.ERROR;
		}
		List<String> problems = options.safetyProblems(et -> {
			MEntityType entityType = MEntityType.get(Env.getCtx(), et);
			return entityType != null && entityType.isSystemMaintained();
		});
		boolean refused = false;
		for (String problem : problems) {
			boolean refuse = options.isRefused(problem);
			System.out.println((refuse ? "REFUSED " : "WARNING ") + problem);
			refused |= refuse;
		}
		if (refused)
			return Result.REFUSED;
		for (String warning : options.warnings())
			System.out.println("WARNING " + warning);

		if (!options.isCheck()) {
			try {
				generate(options, options.getFolder());
			} catch (IllegalArgumentException e) {
				System.out.println("REFUSED " + e.getMessage());
				return Result.REFUSED;
			}
			return Result.OK;
		}
		try {
			return check(options);
		} catch (IllegalArgumentException e) {
			System.out.println("REFUSED " + e.getMessage());
			return Result.REFUSED;
		}
	}

	/**
	 * Generate the interface, the class and/or the accessor into a folder.
	 */
	private static void generate(ModelGeneratorOptions options, String folder) {
		// the accessor refuses first (encrypted column, suffix naming another table), so a refusal leaves no partial output
		if (options.isGenerateAccessor())
			ModelInterfaceGenerator.generateSource(options.isGenerateInterface() ? ModelInterfaceGenerator.GEN_SOURCE_ACCESSOR_INTERFACE
					: ModelInterfaceGenerator.GEN_SOURCE_ACCESSOR, folder, options.getPackageName(),
					options.getTableEntityType(), options.getTableName(), options.getColumnEntityType(), options.getSuffix(), options.getColumns());
		if (options.isGenerateInterface())
			ModelInterfaceGenerator.generateSource(ModelInterfaceGenerator.GEN_SOURCE_INTERFACE, folder, options.getPackageName(),
					options.getTableEntityType(), options.getTableName(), options.getColumnEntityType(), options.getSuffix(), options.getColumns());
		if (options.isGenerateClass())
			ModelClassGenerator.generateSource(folder, options.getPackageName(), options.getTableEntityType(),
					options.getTableName(), options.getColumnEntityType());
	}

	/**
	 * Generate into a temporary folder and compare each file with the same file under the target folder.
	 * The serialVersionUID and @version lines are ignored: they change with the date and the release, not with the dictionary.
	 * @return true when every generated file exists and is equal
	 */
	private static Result check(ModelGeneratorOptions options) throws IOException {
		Path temp = Files.createTempDirectory("modelgen-check");
		try {
			// the generators print a line per file; only the differences and the summary belong to the check
			PrintStream console = System.out;
			System.setOut(new PrintStream(OutputStream.nullOutputStream()));
			try {
				generate(options, temp.toString());
			} finally {
				System.setOut(console);
			}
			Path packagePath = Paths.get(options.getPackageName().replace(".", File.separator));
			Path generated = temp.resolve(packagePath);
			Path committed = Paths.get(options.getFolder()).resolve(packagePath);
			List<String> differ = new ArrayList<>();
			int count = 0;
			if (Files.isDirectory(generated)) {
				try (Stream<Path> files = Files.list(generated)) {
					for (Path file : (Iterable<Path>) files.sorted()::iterator) {
						count++;
						Path other = committed.resolve(file.getFileName());
						if (!Files.exists(other))
							differ.add("missing  " + other);
						else if (!comparable(file).equals(comparable(other)))
							differ.add("differs  " + other);
					}
				}
			}
			for (String line : differ)
				System.out.println(line);
			System.out.println("check: " + count + " generated, " + differ.size() + " out of date");
			if (count == 0) {
				System.out.println("check: no table matches --tables=" + options.getTableName() + " with table entity type "
						+ (options.getTableEntityType() == null ? "U,A (default)" : options.getTableEntityType()));
				return Result.ERROR;
			}
			return ModelGeneratorOptions.isCheckPassed(count, differ.size()) ? Result.OK : Result.DIFFERS;
		} finally {
			try (Stream<Path> walk = Files.walk(temp)) {
				walk.sorted(Comparator.reverseOrder()).forEach(p -> p.toFile().delete());
			}
		}
	}

	private static List<String> comparable(Path file) throws IOException {
		List<String> lines = new ArrayList<>();
		for (String line : Files.readAllLines(file, StandardCharsets.UTF_8)) {
			// only the generated header and field lines, not a description that mentions them
			String t = line.trim();
			if (!t.startsWith("private static final long serialVersionUID") && !t.startsWith("*  @version"))
				lines.add(line);
		}
		return lines;
	}

	/* (non-Javadoc)
	 * @see org.eclipse.equinox.app.IApplication#stop()
	 */
	@Override
	public void stop() {
		System.exit(0);
	}

}
