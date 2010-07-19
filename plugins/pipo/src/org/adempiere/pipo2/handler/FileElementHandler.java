package org.adempiere.pipo2.handler;

import java.io.File;
import java.util.logging.Level;

import javax.xml.transform.sax.TransformerHandler;

import org.adempiere.exceptions.AdempiereException;
import org.adempiere.pipo2.IPackOutHandler;
import org.adempiere.pipo2.PackOut;
import org.compiere.model.MPackageExp;
import org.compiere.model.MPackageExpDetail;
import org.compiere.util.CLogger;
import org.xml.sax.helpers.AttributesImpl;

public class FileElementHandler implements IPackOutHandler{

	private CLogger log = CLogger.getCLogger(FileElementHandler.class);

	public void packOut(PackOut packout, MPackageExp header, MPackageExpDetail detail,TransformerHandler packOutDocument,TransformerHandler packageDocument,int recordId) throws Exception
	{
	    	log.log(Level.INFO,"In PackOut.java handling Code or Other 2pack module creation");
			String fileDirectory = header.getFile_Directory() + header.getName() + detail.getTarget_Directory();
			log.log(Level.INFO,"targetDirectory" + fileDirectory);
			String targetDirectory=null;
			char fileseperator1 = '/';
			char fileseperator2 = '\\';
			//Correct package for proper file seperator
			if (File.separator.equals("/")){
				targetDirectory = fileDirectory.replace(fileseperator2,fileseperator1);
			}
			else
				targetDirectory = fileDirectory.replace(fileseperator1,fileseperator2);

			String sourceDirectory = null;
			fileDirectory = detail.getFile_Directory();
			//Correct package for proper file seperator
			if (File.separator.equals("/")){
				sourceDirectory = fileDirectory.replace(fileseperator2,fileseperator1);
			}
			else
				sourceDirectory = fileDirectory.replace(fileseperator2,fileseperator1);

			packout.copyFile(
					sourceDirectory + detail.getFileName(),
					targetDirectory + detail.getFileName()
					);

			AttributesImpl atts = new AttributesImpl();

			if(detail.getDestination_Directory() != null){

				fileDirectory = detail.getDestination_Directory();
				String destinationDirectory=null;

				//Correct package for proper file seperator
				if (File.separator.equals("/")){
					destinationDirectory = fileDirectory.replace(fileseperator2,fileseperator1);
				}
				else
					destinationDirectory = fileDirectory.replace(fileseperator2,fileseperator1);

				try{
					new DistFileElementHandler(destinationDirectory).doPackout(packout,null,detail,packOutDocument,null,null,0);
				}
				catch(Exception e)
				{
					throw new AdempiereException(e.getLocalizedMessage(), e);
				}
			}

			if(detail.getFileName() != null){
				PackOut.addTextElement(packageDocument, "file", "File: "+detail.getFileName(),atts);
			}
			PackOut.addTextElement(packageDocument, "filedirectory", "Directory: " + detail.getTarget_Directory(), atts);
			PackOut.addTextElement(packageDocument, "filenotes", "Notes: " + detail.getDescription(), atts);
		}
	}



