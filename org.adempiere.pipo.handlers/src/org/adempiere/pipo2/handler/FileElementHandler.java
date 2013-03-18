package org.adempiere.pipo2.handler;

import java.io.File;
import java.util.logging.Level;

import javax.xml.transform.sax.TransformerHandler;

import org.adempiere.exceptions.AdempiereException;
import org.adempiere.pipo2.Element;
import org.adempiere.pipo2.ElementHandler;
import org.adempiere.pipo2.FileElementParameters;
import org.adempiere.pipo2.PIPOContext;
import org.adempiere.pipo2.PackOut;
import org.adempiere.pipo2.PackoutDocument;
import org.adempiere.pipo2.PackoutItem;
import org.compiere.util.CLogger;
import org.xml.sax.SAXException;
import org.xml.sax.helpers.AttributesImpl;

public class FileElementHandler implements ElementHandler {

	private CLogger log = CLogger.getCLogger(FileElementHandler.class);

	public void packOut(PackOut packout, TransformerHandler packoutHandler,
			TransformerHandler docHandler, int recordId) throws Exception {
		PackoutDocument header = packout.getPackoutDocument();
		PackoutItem detail = packout.getCurrentPackoutItem();
		if (log.isLoggable(Level.INFO))log.log(Level.INFO,
				"In PackOut.java handling Code or Other 2pack module creation");
		String fileDirectory = packout.getPackoutDirectory() + header.getPackageName()
				+ detail.getProperty(FileElementParameters.TARGET_DIRECTORY);
		if (log.isLoggable(Level.INFO))log.log(Level.INFO, "targetDirectory" + fileDirectory);
		String targetDirectory = null;
		char fileseperator1 = '/';
		char fileseperator2 = '\\';
		// Correct package for proper file seperator
		if (File.separator.equals("/")) {
			targetDirectory = fileDirectory.replace(fileseperator2,
					fileseperator1);
		} else
			targetDirectory = fileDirectory.replace(fileseperator1,
					fileseperator2);

		String sourceDirectory = null;
		fileDirectory = (String) detail.getProperty(FileElementParameters.SOURCE_DIRECTORY);
		// Correct package for proper file seperator
		if (File.separator.equals("/")) {
			sourceDirectory = fileDirectory.replace(fileseperator2,
					fileseperator1);
		} else
			sourceDirectory = fileDirectory.replace(fileseperator2,
					fileseperator1);

		packout.copyFile(sourceDirectory + detail.getProperty(FileElementParameters.FILE_NAME),
				targetDirectory + detail.getProperty(FileElementParameters.FILE_NAME));

		AttributesImpl atts = new AttributesImpl();

		if (detail.getProperty(FileElementParameters.DESTINATION_DIRECTORY) != null) {

			fileDirectory = (String) detail.getProperty(FileElementParameters.DESTINATION_DIRECTORY);
			String destinationDirectory = null;

			// Correct package for proper file seperator
			if (File.separator.equals("/")) {
				destinationDirectory = fileDirectory.replace(fileseperator2,
						fileseperator1);
			} else
				destinationDirectory = fileDirectory.replace(fileseperator2,
						fileseperator1);

			try {
				new DistFileElementHandler(destinationDirectory).doPackout(
						packout, null, detail, packoutHandler, null, null, 0);
			} catch (Exception e) {
				throw new AdempiereException(e.getLocalizedMessage(), e);
			}
		}

		if (detail.getProperty(FileElementParameters.FILE_NAME) != null) {
			PackOut.addTextElement(docHandler, "file",
					"File: " + detail.getProperty(FileElementParameters.FILE_NAME), atts);
		}
		PackOut.addTextElement(docHandler, "filedirectory", "Directory: "
				+ detail.getProperty(FileElementParameters.TARGET_DIRECTORY), atts);
		PackOut.addTextElement(docHandler, "filenotes",
				"Notes: " + detail.getProperty(FileElementParameters.DESCRIPTION), atts);
	}

	@Override
	public void startElement(PIPOContext ctx, Element element)
			throws SAXException {
	}

	@Override
	public void endElement(PIPOContext ctx, Element element) throws SAXException {
	}
}
