package org.compiere.process;

import java.util.ArrayList;
import java.util.concurrent.atomic.AtomicInteger;

import org.compiere.model.PO;

public class DocActionEventData {

	public String docStatus;
	public Object processing;
	public String orderType;
	public String isSOTrx;
	public int AD_Table_ID;
	public ArrayList<String> docAction;
	public ArrayList<String> options;
	public AtomicInteger indexObj;
	public PO po;

	public DocActionEventData(String docStatus, Object processing, String orderType, String isSOTrx,
			int AD_Table_ID, ArrayList<String> docAction, ArrayList<String> options, AtomicInteger indexObj, PO po) {
		this.docStatus = docStatus;
		this.processing = processing;
		this.orderType = orderType;
		this.isSOTrx = isSOTrx;
		this.AD_Table_ID = AD_Table_ID;
		this.docAction = docAction;
		this.options = options;
		this.indexObj = indexObj;
		this.po = po;
	}

}
