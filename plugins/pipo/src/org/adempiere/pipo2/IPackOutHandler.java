package org.adempiere.pipo2;

import javax.xml.transform.sax.TransformerHandler;

import org.compiere.model.MPackageExp;
import org.compiere.model.MPackageExpDetail;

public interface IPackOutHandler {

	public void packOut(PackOut packout, MPackageExp packageExp, MPackageExpDetail packageExpDetail,TransformerHandler packOutDocument,TransformerHandler packageDocument,int recordId) throws Exception;

}


