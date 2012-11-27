/**
 * 
 */
package org.idempiere.fitnesse.server;

import java.io.PrintStream;

import org.idempiere.fitnesse.server.fit.FitServlet;

import fit.Counts;

/**
 * Adapted from http://sourceforge.net/projects/patang/
 * @author hengsin
 *
 */
public abstract class Runner {
	protected Parameters parameters;

	public void execute() {
		final PrintStream out = parameters.outputStream();
		try {
			Counts results = run(parameters.list());
			out.println(results.toString());
			out.println(FitServlet.EXIT_CODE_PREFIX + exitCode(results));
		} catch (Exception e) {
			e.printStackTrace(out);
			out.println(FitServlet.EXIT_CODE_PREFIX + -1);
		}
	}

	protected int exitCode(Counts results) {
		return results.exceptions + results.wrong;
	}

	protected abstract Counts run(String[] params) throws Exception;
}
