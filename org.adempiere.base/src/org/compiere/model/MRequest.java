/******************************************************************************
 * Product: Adempiere ERP & CRM Smart Business Solution                       *
 * Copyright (C) 1999-2006 ComPiere, Inc. All Rights Reserved.                *
 * This program is free software; you can redistribute it and/or modify it    *
 * under the terms version 2 of the GNU General Public License as published   *
 * by the Free Software Foundation. This program is distributed in the hope   *
 * that it will be useful, but WITHOUT ANY WARRANTY; without even the implied *
 * warranty of MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.           *
 * See the GNU General Public License for more details.                       *
 * You should have received a copy of the GNU General Public License along    *
 * with this program; if not, write to the Free Software Foundation, Inc.,    *
 * 59 Temple Place, Suite 330, Boston, MA 02111-1307 USA.                     *
 * For the text or an alternative of this public license, you may reach us    *
 * ComPiere, Inc., 2620 Augustine Dr. #245, Santa Clara, CA 95054, USA        *
 * or via info@compiere.org or http://www.compiere.org/license.html           *
 *****************************************************************************/
package org.compiere.model;

import java.io.File;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.Timestamp;
import java.util.ArrayList;
import java.util.List;
import java.util.Properties;

import org.adempiere.exceptions.AdempiereException;
import org.compiere.util.CLogger;
import org.compiere.util.DB;
import org.compiere.util.Env;
import org.compiere.util.TimeUtil;
import org.compiere.util.Util;

/**
 * 	Request Model
 *
 *  @author Jorg Janke
 *  @version $Id: MRequest.java,v 1.2 2006/07/30 00:51:03 jjanke Exp $
 */
public class MRequest extends X_R_Request
{
	/**
	 * generated serial id
	 */
	private static final long serialVersionUID = -3807801381988066060L;

	/**
	 * 	Get Request ID from mail text
	 *	@param mailText mail text
	 *	@return R_Request_ID if mailText has request id tag ([Req#R_Request_ID#ID]), otherwise 0
	 */
	public static int getR_Request_ID (String mailText)
	{
		if (mailText == null)
			return 0;
		int indexStart = mailText.indexOf(TAG_START);
		if (indexStart == -1)
			return 0;
		int indexEnd = mailText.indexOf(TAG_END, indexStart);
		if (indexEnd == -1)
			return 0;
		//
		indexStart += 5; 
		String idString = mailText.substring(indexStart, indexEnd);
		int R_Request_ID = 0;
		try
		{
			R_Request_ID = Integer.parseInt(idString);
		}
		catch (Exception e)
		{
			s_log.severe ("Cannot parse " + idString);
		}
		return R_Request_ID;
	}	//	getR_Request_ID

	/**	Static Logger					*/
	private static CLogger	s_log	= CLogger.getCLogger (MRequest.class);
	/** Request Tag Start				*/
	private static final String		TAG_START = "[Req#";
	/** Request Tag End					*/
	private static final String		TAG_END = "#ID]";

    /**
     * UUID based Constructor
     * @param ctx  Context
     * @param R_Request_UU  UUID key
     * @param trxName Transaction
     */
    public MRequest(Properties ctx, String R_Request_UU, String trxName) {
        super(ctx, R_Request_UU, trxName);
		if (Util.isEmpty(R_Request_UU))
			setInitialDefaults();
    }

	/**
	 * 	Constructor
	 * 	@param ctx context
	 * 	@param R_Request_ID request or 0 for new
	 *	@param trxName transaction
	 */
	public MRequest(Properties ctx, int R_Request_ID, String trxName)
	{
		this (ctx, R_Request_ID, trxName, (String[]) null);
	}	//	MRequest

	/**
	 * @param ctx
	 * @param R_Request_ID
	 * @param trxName
	 * @param virtualColumns
	 */
	public MRequest(Properties ctx, int R_Request_ID, String trxName, String... virtualColumns) {
		super(ctx, R_Request_ID, trxName, virtualColumns);
		if (R_Request_ID == 0)
			setInitialDefaults();
	}

	/**
	 * Set the initial defaults for a new record
	 */
	private void setInitialDefaults() {
		setDueType (DUETYPE_Due);
		setConfidentialType (CONFIDENTIALTYPE_PublicInformation);	// A
		setConfidentialTypeEntry (CONFIDENTIALTYPEENTRY_PublicInformation);	// A
		setProcessed (false);
		setRequestAmt (Env.ZERO);
		setPriorityUser (PRIORITY_Low);
		setIsEscalated (false);
		setIsSelfService (false);
		setIsInvoiced (false);
	}

	/**
	 * 	SelfService Constructor
	 * 	@param ctx context
	 * 	@param SalesRep_ID SalesRep
	 * 	@param R_RequestType_ID request type
	 * 	@param Summary summary
	 * 	@param isSelfService self service
	 *	@param trxName transaction
	 */
	public MRequest (Properties ctx, int SalesRep_ID,
		int R_RequestType_ID, String Summary, boolean isSelfService, String trxName)
	{
		this(ctx, 0, trxName);
		set_Value ("SalesRep_ID", Integer.valueOf(SalesRep_ID));	//	could be 0
		set_Value ("R_RequestType_ID", Integer.valueOf(R_RequestType_ID));
		setSummary (Summary);
		setIsSelfService(isSelfService);
		getRequestType();
		if (m_requestType != null)
		{
			String ct = m_requestType.getConfidentialType();
			if (ct != null)
			{
				setConfidentialType (ct);
				setConfidentialTypeEntry (ct);
			}
		}
	}	//	MRequest

	/**
	 * 	Load Constructor
	 *	@param ctx context
	 *	@param rs result set
	 *	@param trxName transaction
	 */
	public MRequest (Properties ctx, ResultSet rs, String trxName)
	{
		super(ctx, rs, trxName);
	}	//	MRequest

	/** Request Type				*/
	private MRequestType	m_requestType = null;
	/**	Changed						*/
	private boolean			m_changed = false;
	/**	BPartner					*/
	private MBPartner		m_partner = null;
	/** User/Contact				*/
	private MUser			m_user = null;

	/** Separator line				*/
	public static final String	SEPARATOR = 
		"\n---------.----------.----------.----------.----------.----------\n";
	
	/**
	 * 	Find and Set Default Request Type.
	 */
	public void setR_RequestType_ID ()
	{
		m_requestType = MRequestType.getDefault(getCtx());
		if (m_requestType == null)
			log.warning("No default found");
		else
			super.setR_RequestType_ID(m_requestType.getR_RequestType_ID());
	}	//	setR_RequestType_ID

	/**
	 * Find and Set Default Request Status.
	 */
	public void setR_Status_ID ()
	{
		MStatus status = MStatus.getDefault(getCtx(), getR_RequestType_ID());
		if (status == null)
		{
			log.warning("No default found");
			if (getR_Status_ID() != 0)
				setR_Status_ID(0);
		}
		else
			setR_Status_ID(status.getR_Status_ID());
	}	//	setR_Status_ID
	
	/**
	 * 	Add To Result
	 * 	@param Result text to append
	 */
	public void addToResult (String Result)
	{
		String oldResult = getResult();
		if (Result == null || Result.length() == 0)
			;
		else if (oldResult == null || oldResult.length() == 0)
			setResult (Result);
		else
			setResult (oldResult + "\n-\n" + Result);
	}	//	addToResult

	/**
	 * 	Set DueType (DUETYPE_*) based on Date Next Action
	 */
	public void setDueType()
	{
		Timestamp due = getDateNextAction();
		if (due == null)
			return;
		//
		Timestamp overdue = TimeUtil.addDays(due, getRequestType().getDueDateTolerance());
		Timestamp now = new Timestamp (System.currentTimeMillis());
		//
		String DueType = DUETYPE_Due;
		if (now.before(due))
			DueType = DUETYPE_Scheduled;
		else if (now.after(overdue))
			DueType = DUETYPE_Overdue;
		super.setDueType(DueType);
	}	//	setDueType
	
	/**
	 * 	Get Action History
	 *	@return array of MRequestAction
	 */
	public MRequestAction[] getActions()
	{
		final String whereClause = MRequestAction.COLUMNNAME_R_Request_ID+"=?";
		List<MRequestAction> list = new Query(getCtx(), I_R_RequestAction.Table_Name, whereClause, get_TrxName())
										.setParameters(get_ID())
										.setOrderBy("Created DESC")
										.list();
		return list.toArray(new MRequestAction[list.size()]);
	}	//	getActions

	/**
	 * 	Get Request Updates that should be visible for the given confidentialType
	 * 	@param confidentialType confidential type (CONFIDENTIALTYPEENTRY_*) or null for all
	 *	@return array of MRequestUpdate
	 */
	public MRequestUpdate[] getUpdates(String confidentialType)
	{
		final String whereClause = MRequestUpdate.COLUMNNAME_R_Request_ID+"=?";
		List<MRequestUpdate> listUpdates = new Query(getCtx(), I_R_RequestUpdate.Table_Name, whereClause, get_TrxName())
										.setParameters(get_ID())
										.setOrderBy("Created DESC")
										.list();
		ArrayList<MRequestUpdate> list = new ArrayList<MRequestUpdate>();
		for (MRequestUpdate ru : listUpdates)
		{
			if (confidentialType != null)
			{
				//	Private only if private
				if (ru.getConfidentialTypeEntry().equals(CONFIDENTIALTYPEENTRY_PrivateInformation)
						&& !confidentialType.equals(CONFIDENTIALTYPEENTRY_PrivateInformation))
					continue;
				//	Internal not if Customer/Public
				if (ru.getConfidentialTypeEntry().equals(CONFIDENTIALTYPEENTRY_Internal)
						&& (confidentialType.equals(CONFIDENTIALTYPEENTRY_PartnerConfidential)
								|| confidentialType.equals(CONFIDENTIALTYPEENTRY_PublicInformation)))
					continue;
				//	No Customer if public
				if (ru.getConfidentialTypeEntry().equals(CONFIDENTIALTYPEENTRY_PartnerConfidential)
						&& confidentialType.equals(CONFIDENTIALTYPEENTRY_PublicInformation))
					continue;
			}
			list.add(ru);
		}
		//
		MRequestUpdate[] retValue = new MRequestUpdate[list.size()];
		list.toArray(retValue);
		return retValue;
	}	//	getUpdates
	
	/**
	 * 	Get Public Updates
	 *	@return public updates
	 */
	public MRequestUpdate[] getUpdatesPublic()
	{
		return getUpdates(CONFIDENTIALTYPE_PublicInformation);
	}	//	getUpdatesPublic

	/**
	 * 	Get Customer Updates
	 *	@return customer updates
	 */
	public MRequestUpdate[] getUpdatesCustomer()
	{
		return getUpdates(CONFIDENTIALTYPE_PartnerConfidential);
	}	//	getUpdatesCustomer

	/**
	 * 	Get Internal Updates
	 *	@return internal updates
	 */
	public MRequestUpdate[] getUpdatesInternal()
	{
		return getUpdates(CONFIDENTIALTYPE_Internal);
	}	//	getUpdatesInternal

	/**
	 *	Get Request Type
	 *	@return Request Type 	
	 */
	public MRequestType getRequestType()
	{
		if (m_requestType == null)
		{
			int R_RequestType_ID = getR_RequestType_ID();
			if (R_RequestType_ID == 0)
			{
				setR_RequestType_ID();
				R_RequestType_ID = getR_RequestType_ID();
			}
			m_requestType = MRequestType.getCopy(getCtx(), R_RequestType_ID, get_TrxName());
		}
		return m_requestType;
	}	//	getRequestType
	
	/**
	 *	Get Request Type Name
	 *	@return Request Type Name
	 */
	public String getRequestTypeName()
	{
		if (m_requestType == null)
			getRequestType();
		if (m_requestType == null)
			return "??";
		return m_requestType.getName();
	}	//	getRequestTypeText

	/**
	 * 	Get Request Category
	 *	@return MRequestCategory
	 */
	public MRequestCategory getCategory()
	{
		if (getR_Category_ID() == 0)
			return null;
		return MRequestCategory.getCopy(getCtx(), getR_Category_ID(), get_TrxName());
	}	//	getCategory

	/**
	 * 	Get Request Category Name
	 *	@return Request Category Name
	 */
	public String getCategoryName()
	{
		MRequestCategory cat = getCategory();
		if (cat == null)
			return "";
		return cat.getName();
	}	//	getCategoryName

	/**
	 * 	Get Request Group
	 *	@return MGroup
	 */
	public MGroup getGroup()
	{
		if (getR_Group_ID() == 0)
			return null;
		return MGroup.getCopy(getCtx(), getR_Group_ID(), get_TrxName());
	}	//	getGroup

	/**
	 * 	Get Request Group Name
	 *	@return Request Group Name
	 */
	public String getGroupName()
	{
		MGroup grp = getGroup();
		if (grp == null)
			return "";
		return grp.getName();
	}	//	getGroupName
	
	/**
	 * 	Get Status
	 *	@return MStatus
	 */
	public MStatus getStatus()
	{
		if (getR_Status_ID() == 0)
			return null;
		return MStatus.getCopy(getCtx(), getR_Status_ID(), get_TrxName());
	}	//	getStatus
	
	/**
	 * 	Get Request Status Name
	 *	@return Request Status Name
	 */
	public String getStatusName()
	{
		MStatus sta = getStatus();
		if (sta == null)
			return "?";
		return sta.getName();
	}	//	getStatusName
	
	/**
	 * 	Get Request Resolution
	 *	@return MResolution
	 */
	public MResolution getResolution()
	{
		if (getR_Resolution_ID() == 0)
			return null;
		return MResolution.getCopy(getCtx(), getR_Resolution_ID(), get_TrxName());
	}	//	getResolution
	
	/**
	 * 	Get Request Resolution Name
	 *	@return Request Resolution Name
	 */
	public String getResolutionName()
	{
		MResolution res = getResolution();
		if (res == null)
			return "";
		return res.getName();
	}	//	getResolutionName

	/**
	 * 	Is Overdue
	 *	@return true if overdue
	 */
	public boolean isOverdue()
	{
		return DUETYPE_Overdue.equals(getDueType());
	}	//	isOverdue

	/**
	 * 	Is due
	 *	@return true if due
	 */
	public boolean isDue()
	{
		return DUETYPE_Due.equals(getDueType());
	}	//	isDue

	/**
	 * 	Get DueType Name
	 *	@return DueType Name
	 */
	public String getDueTypeText()
	{
		return MRefList.getListName(getCtx(), DUETYPE_AD_Reference_ID, getDueType());
	}	//	getDueTypeText
	
	/**
	 * 	Get Priority Name
	 *	@return Priority Name
	 */
	public String getPriorityText()
	{
		return MRefList.getListName(getCtx(), PRIORITY_AD_Reference_ID, getPriority());
	}	//	getPriorityText

	/**
	 * 	Get Importance Name
	 *	@return Importance Name
	 */
	public String getPriorityUserText()
	{
		return MRefList.getListName(getCtx(), PRIORITYUSER_AD_Reference_ID, getPriorityUser());
	}	//	getPriorityUserText

	/**
	 * 	Get Confidential Type Name
	 *	@return Confidential Type Name
	 */
	public String getConfidentialText()
	{
		return MRefList.getListName(getCtx(), CONFIDENTIALTYPE_AD_Reference_ID, getConfidentialType());
	}	//	getConfidentialText

	/**
	 * 	Get Confidential Type Entry Name
	 *	@return Confidential Type Entry Name
	 */
	public String getConfidentialEntryText()
	{
		return MRefList.getListName(getCtx(), CONFIDENTIALTYPEENTRY_AD_Reference_ID, getConfidentialTypeEntry());
	}	//	getConfidentialTextEntry
	
	/**
	 * 	Set Date Last Alert to today
	 */
	public void setDateLastAlert ()
	{
		super.setDateLastAlert (new Timestamp(System.currentTimeMillis()));
	}	//	setDateLastAlert

	/**
	 * 	Get Sales Rep
	 *	@return Sales Rep User
	 */
	public MUser getSalesRep()
	{
		if (getSalesRep_ID() == 0)
			return null;
		return MUser.getCopy(getCtx(), getSalesRep_ID(), get_TrxName());
	}	//	getSalesRep
	
	/**
	 * 	Get Sales Rep Name
	 *	@return Sales Rep Name
	 */
	public String getSalesRepName()
	{
		MUser sr = getSalesRep();
		if (sr == null)
			return "n/a";
		return sr.getName();
	}	//	getSalesRepName

	/**
	 * 	Get Created By Name
	 *	@return Created By Name
	 */
	public String getCreatedByName()
	{
		MUser user = MUser.get(getCtx(), getCreatedBy());
		return user.getName();
	}	//	getCreatedByName

	/**
	 * 	Get Contact (may be not defined)
	 *	@return Contact User or null
	 */
	public MUser getUser()
	{
		if (getAD_User_ID() == 0)
			return null;
		if (m_user != null && m_user.getAD_User_ID() != getAD_User_ID())
			m_user = null;
		if (m_user == null)
			m_user = new MUser (getCtx(), getAD_User_ID(), get_TrxName());
		return m_user;
	}	//	getUser
	
	/**
	 * 	Get BPartner (may be not defined)
	 *	@return BPartner or null
	 */
	public MBPartner getBPartner()
	{
		if (getC_BPartner_ID() == 0)
			return null;
		if (m_partner != null && m_partner.getC_BPartner_ID() != getC_BPartner_ID())
			m_partner = null;
		if (m_partner == null)
			m_partner = new MBPartner (getCtx(), getC_BPartner_ID(), get_TrxName());
		return m_partner;
	}	//	getBPartner

	/**
	 * 	Web Can Update Request
	 *	@return true if Web can update
	 */
	public boolean isWebCanUpdate()
	{
		if (isProcessed())
			return false;
		if (getR_Status_ID() == 0)
			setR_Status_ID();
		if (getR_Status_ID() == 0)
			return false;
		MStatus status = MStatus.get(getCtx(), getR_Status_ID());
		if (status == null)
			return false;
		return status.isWebCanUpdate();
	}	//	isWebCanUpdate
	
	/**
	 * 	Set Priority to C_BP_Group.PriorityBase or PriorityUser
	 */
	private void setPriority()
	{
		if (getPriorityUser() == null)
			setPriorityUser(PRIORITYUSER_Low);
		//
		if (getBPartner() != null)
		{
			MBPGroup bpg = MBPGroup.get(getCtx(), getBPartner().getC_BP_Group_ID());
			String prioBase = bpg.getPriorityBase();
			if (prioBase != null && !prioBase.equals(X_C_BP_Group.PRIORITYBASE_Same))
			{
				char targetPrio = getPriorityUser().charAt(0);
				if (prioBase.equals(X_C_BP_Group.PRIORITYBASE_Lower))
					targetPrio += 2;
				else
					targetPrio -= 2;
				if (targetPrio < PRIORITY_High.charAt(0))	//	1
					targetPrio = PRIORITY_High.charAt(0);
				if (targetPrio > PRIORITY_Low.charAt(0))	//	9
					targetPrio = PRIORITY_Low.charAt(0);
				if (getPriority() == null)
					setPriority(String.valueOf(targetPrio));
				else	//	previous priority
				{
					if (targetPrio < getPriority().charAt(0))
						setPriority(String.valueOf(targetPrio));
				}
			}
		}
		//	Same if nothing else
		if (getPriority() == null)
			setPriority(getPriorityUser());
	}	//	setPriority
	
	/**
	 * 	Set Confidential Type Entry.<br/>
	 *  Validate new ConfidentialTypeEntry against current ConfidentialTypeEntry value.
	 *	@param ConfidentialTypeEntry confidentiality
	 */
	@Override
	public void setConfidentialTypeEntry (String ConfidentialTypeEntry)
	{
		if (ConfidentialTypeEntry == null)
			ConfidentialTypeEntry = getConfidentialType();
		//
		if (CONFIDENTIALTYPE_Internal.equals(getConfidentialType()))
			super.setConfidentialTypeEntry (CONFIDENTIALTYPE_Internal);
		else if (CONFIDENTIALTYPE_PrivateInformation.equals(getConfidentialType()))
		{
			if (CONFIDENTIALTYPE_Internal.equals(ConfidentialTypeEntry)
				|| CONFIDENTIALTYPE_PrivateInformation.equals(ConfidentialTypeEntry))
				super.setConfidentialTypeEntry (ConfidentialTypeEntry);
			else
				super.setConfidentialTypeEntry (CONFIDENTIALTYPE_PrivateInformation);
		}
		else if (CONFIDENTIALTYPE_PartnerConfidential.equals(getConfidentialType()))
		{
			if (CONFIDENTIALTYPE_Internal.equals(ConfidentialTypeEntry)
				|| CONFIDENTIALTYPE_PrivateInformation.equals(ConfidentialTypeEntry)
				|| CONFIDENTIALTYPE_PartnerConfidential.equals(ConfidentialTypeEntry))
				super.setConfidentialTypeEntry (ConfidentialTypeEntry);
			else
				super.setConfidentialTypeEntry (CONFIDENTIALTYPE_PartnerConfidential);
		}
		else if (CONFIDENTIALTYPE_PublicInformation.equals(getConfidentialType()))
			super.setConfidentialTypeEntry (ConfidentialTypeEntry);
	}	//	setConfidentialTypeEntry
	
	/**
	 * 	Web Update of result
	 *	@param result result text
	 *	@return true if updated
	 */
	public boolean webUpdate (String result)
	{
		MStatus status = MStatus.get(getCtx(), getR_Status_ID());
		if (!status.isWebCanUpdate())
			return false;
		if (status.getUpdate_Status_ID() > 0)
			setR_Status_ID(status.getUpdate_Status_ID());
		setResult(result);
		return true;
	}	//	webUpdate
	
	/**
	 * 	String Representation
	 *	@return info
	 */
	@Override
	public String toString ()
	{
		StringBuilder sb = new StringBuilder ("MRequest[");
		sb.append (get_ID()).append ("-").append(getDocumentNo()).append ("]");
		return sb.toString ();
	}	//	toString

	/**
	 * 	Create PDF
	 *	@return not implemented, always return null
	 */
	public File createPDF ()
	{
		return null;
	}	//	getPDF

	/**
	 * 	Create PDF file
	 *	@param file output file
	 *	@return not implemented, always return null
	 */
	public File createPDF (File file)
	{
		return null;
	}	//	createPDF
	
	@Override
	protected boolean beforeSave (boolean newRecord)
	{
		//	Request Type
		getRequestType();
		if (newRecord || is_ValueChanged("R_RequestType_ID"))
		{
			// Update IsInvoiced and DateNextAction from request type
			if (m_requestType != null)
			{
				if (isInvoiced() != m_requestType.isInvoiced())
					setIsInvoiced(m_requestType.isInvoiced());
				if (getDateNextAction() == null && m_requestType.getAutoDueDateDays() > 0)
					setDateNextAction(TimeUtil.addDays(new Timestamp(System.currentTimeMillis()), 
						m_requestType.getAutoDueDateDays()));
			}
			// Validate current status against request type. 
			// Reset to default if it is not valid.
			if (getR_Status_ID() != 0)
			{
				MStatus sta = MStatus.get(getCtx(), getR_Status_ID());
				MRequestType rt = MRequestType.get(getCtx(), getR_RequestType_ID());
				if (sta.getR_StatusCategory_ID() != rt.getR_StatusCategory_ID())
					setR_Status_ID();	//	set to default
			}
		}

		//	Set default Request Status
		if (getR_Status_ID() == 0)
			setR_Status_ID();
		//	Validate/Update Due Type
		setDueType();
		MStatus status = MStatus.get(getCtx(), getR_Status_ID());
		// Set default for open, close and final close status
		if (status != null)
		{
			if (status.isOpen())
			{
				if (getStartDate() == null)
					setStartDate (new Timestamp(System.currentTimeMillis()));
				if (getCloseDate() != null)
					setCloseDate(null);
			}
			if (status.isClosed() 
				&& getCloseDate() == null)
				setCloseDate(new Timestamp(System.currentTimeMillis()));
			if (status.isFinalClose())
				setProcessed(true);
		}
		
		// Set Confidential Type (from request type or set to default of public)
		if (getConfidentialType() == null)
		{
			getRequestType();
			if (m_requestType != null)
			{
				String ct = m_requestType.getConfidentialType();
				if (ct != null)
					setConfidentialType (ct);
			}
			if (getConfidentialType() == null)
				setConfidentialType(CONFIDENTIALTYPEENTRY_PublicInformation);
		}
		// Validate ConfidentialTypeEntry
		if (getConfidentialTypeEntry() == null)
			setConfidentialTypeEntry(getConfidentialType());
		else
			setConfidentialTypeEntry(getConfidentialTypeEntry());

		//	Importance / Priority
		setPriority();

		// Set Record_UU from Record_ID
		if (getRecord_ID() > 0 && getAD_Table_ID() > 0 && Util.isEmpty(getRecord_UU())) {
			MTable table = MTable.get(getAD_Table_ID());
			PO po = table.getPO(getRecord_ID(), get_TrxName());
			if (po != null)
				setRecord_UU(po.get_UUID());
		}

		return true;
	}	//	beforeSave

	/**
	 * 	Set SalesRep_ID
	 *	@param SalesRep_ID id
	 */
	@Override
	public void setSalesRep_ID (int SalesRep_ID)
	{
		if (SalesRep_ID != 0)
			super.setSalesRep_ID (SalesRep_ID);
		else if (getSalesRep_ID() != 0)
			log.warning("Ignored - Tried to set SalesRep_ID to 0 from " + getSalesRep_ID());
	}	//	setSalesRep_ID
	
	@Override
	protected boolean afterSave (boolean newRecord, boolean success)
	{
		if (!success)
			return success;
		
		//	Create Request Update record
		if (newRecord && getResult() != null)
		{
			MRequestUpdate update = new MRequestUpdate(this);
			update.saveEx();
		}
		
		//	ChangeRequest - created in Request Processor
		if (getM_ChangeRequest_ID() != 0
			&& is_ValueChanged(COLUMNNAME_R_Group_ID))	//	different ECN assignment?
		{
			int oldID = get_ValueOldAsInt(COLUMNNAME_R_Group_ID);
			if (getR_Group_ID() == 0)
			{
				setM_ChangeRequest_ID(0);	//	not effective as in afterSave
			}
			else
			{
				// Update change request record with request group change
				MGroup oldG = MGroup.get(getCtx(), oldID);
				MGroup newG = MGroup.get(getCtx(), getR_Group_ID());
				if (oldG.getPP_Product_BOM_ID() != newG.getPP_Product_BOM_ID()
					|| oldG.getM_ChangeNotice_ID() != newG.getM_ChangeNotice_ID())
				{
					MChangeRequest ecr = new MChangeRequest(getCtx(), getM_ChangeRequest_ID(), get_TrxName());
					if (!ecr.isProcessed()
						|| ecr.getM_FixChangeNotice_ID() == 0)
					{
						ecr.setPP_Product_BOM_ID(newG.getPP_Product_BOM_ID());
						ecr.setM_ChangeNotice_ID(newG.getM_ChangeNotice_ID());
						ecr.saveEx();
					}
				}
			}
		}
		
		return success;
	}	//	afterSave

	/**
	 * 	Get Mail Tag
	 *	@return [Req#@{id}@#ID]
	 */
	public String getMailTag()
	{
		return TAG_START + get_ID() + TAG_END;
	}	//	getMailTag
	
	/**
	 * 	(Soft) Close request.
	 * 	Must be called after webUpdate.
	 */
	public void doClose()
	{
		MStatus status = MStatus.get(getCtx(), getR_Status_ID());
		if (!status.isClosed())
		{
			MStatus[] closed = MStatus.getClosed(getCtx());
			MStatus newStatus = null;
			for (int i = 0; i < closed.length; i++)
			{
				if (!closed[i].isFinalClose())
				{
					newStatus = closed[i];
					break;
				}
			}
			if (newStatus == null && closed.length > 0)
				newStatus = closed[0];
			if (newStatus != null)
				setR_Status_ID(newStatus.getR_Status_ID());
		}
	}	//	doClose
	
	/**
	 * 	Escalate request
	 * 	@param user true if user escalated (PriorityUser), otherwise system (Priority)
	 */
	public void doEscalate(boolean user)
	{
		if (user)
		{
			String Importance = getPriorityUser();
			if (PRIORITYUSER_Urgent.equals(Importance))
				;	//	high as it goes
			else if (PRIORITYUSER_High.equals(Importance))
				setPriorityUser(PRIORITYUSER_Urgent);
			else if (PRIORITYUSER_Medium.equals(Importance))
				setPriorityUser(PRIORITYUSER_High);
			else if (PRIORITYUSER_Low.equals(Importance))
				setPriorityUser(PRIORITYUSER_Medium);
			else if (PRIORITYUSER_Minor.equals(Importance))
				setPriorityUser(PRIORITYUSER_Low);
		}
		else
		{
			String Importance = getPriority();
			if (PRIORITY_Urgent.equals(Importance))
				;	//	high as it goes
			else if (PRIORITY_High.equals(Importance))
				setPriority(PRIORITY_Urgent);
			else if (PRIORITY_Medium.equals(Importance))
				setPriority(PRIORITY_High);
			else if (PRIORITY_Low.equals(Importance))
				setPriority(PRIORITY_Medium);
			else if (PRIORITY_Minor.equals(Importance))
				setPriority(PRIORITY_Low);
		}
	}	//	doEscalate
	
	/**
	 * @return changed flag
	 */
	public boolean isChanged()
	{
		return m_changed;
	}
	
	/**
	 * Set changed flag
	 * @param changed
	 */
	public void setIsChanged(boolean changed)
	{
		this.m_changed = changed;
	}
	
	/**
	 * Get number of active and inactive request
	 * @param AD_Table_ID
	 * @param Record_ID
	 * @param whereClause
	 * @param trxName
	 * @return int[], [0] = inactive request count and [1] = active request count
	 * @deprecated - use {@link #getRequestCount(int, int, String, StringBuilder, String)} instead
	 */
	@Deprecated
	public static int[] getRequestCount(int AD_Table_ID, int Record_ID, StringBuilder whereClause, String trxName) {
		return getRequestCount(AD_Table_ID, Record_ID, null, whereClause, trxName);
	}

	/**
	 * Get number of active and inactive request
	 * @param AD_Table_ID
	 * @param Record_ID Record ID - used when Record_UU is null, and also to compare with User, BPartner, Order, Invoice, Payment, Project, Campaign and Asset
	 * @param Record_UU Record UUID
	 * @param whereClause
	 * @param trxName
	 * @return int[], [0] = inactive request count (Processed=Y) and [1] = active request count (Processed=N)
	 */
	public static int[] getRequestCount(int AD_Table_ID, int Record_ID, String Record_UU, StringBuilder whereClause, String trxName) {
		int[] counts = new int[] {0, 0};

		whereClause.append("(AD_Table_ID=").append(AD_Table_ID);
		if (Util.isEmpty(Record_UU)) {
			whereClause.append(" AND Record_ID=").append(Record_ID);
		} else {
			whereClause.append(" AND Record_UU=").append(DB.TO_STRING(Record_UU));
		}
		whereClause.append(")");
		//
		if (AD_Table_ID == MUser.Table_ID)
			whereClause.append(" OR AD_User_ID=").append(Record_ID)
				.append(" OR SalesRep_ID=").append(Record_ID);
		else if (AD_Table_ID == MBPartner.Table_ID)
			whereClause.append(" OR C_BPartner_ID=").append(Record_ID);
		else if (AD_Table_ID == MOrder.Table_ID)
			whereClause.append(" OR C_Order_ID=").append(Record_ID);
		else if (AD_Table_ID == MInvoice.Table_ID)
			whereClause.append(" OR C_Invoice_ID=").append(Record_ID);
		else if (AD_Table_ID == MPayment.Table_ID)
			whereClause.append(" OR C_Payment_ID=").append(Record_ID);
		else if (AD_Table_ID == MProduct.Table_ID)
			whereClause.append(" OR M_Product_ID=").append(Record_ID);
		else if (AD_Table_ID == MProject.Table_ID)
			whereClause.append(" OR C_Project_ID=").append(Record_ID);
		else if (AD_Table_ID == MCampaign.Table_ID)
			whereClause.append(" OR C_Campaign_ID=").append(Record_ID);
		else if (AD_Table_ID == MAsset.Table_ID)
			whereClause.append(" OR A_Asset_ID=").append(Record_ID);
		//
		String sql = "SELECT Processed, COUNT(*) "
			+ "FROM R_Request WHERE " + whereClause 
			+ " GROUP BY Processed "
			+ "ORDER BY Processed DESC";
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		try
		{
			pstmt = DB.prepareStatement (sql, trxName);
			rs = pstmt.executeQuery ();
			while (rs.next ())
			{
				if ("Y".equals(rs.getString(1)))
					counts[0] += rs.getInt(2);
				else
					counts[1] += rs.getInt(2);
			}
		}
		catch (Exception e)
		{
			throw new AdempiereException(e);
		}
		finally
		{
			DB.close(rs, pstmt);
		}
		
		return counts;
	}
	
	/**
	 * Create new request
	 * @param tab Grid Tab for request
	 * @param AD_Table_ID
	 * @param Record_ID
	 * @param C_BPartner_ID
	 * @deprecated - use {@link #newRequest(GridTab, int, int, String, int)} instead
	 */
	@Deprecated
	public static void newRequest(GridTab tab, int AD_Table_ID, int Record_ID, int C_BPartner_ID) {
		newRequest(tab, AD_Table_ID, Record_ID, null, C_BPartner_ID);
	}

	/**
	 * Create new request
	 * @param tab Grid Tab for request
	 * @param AD_Table_ID
	 * @param Record_ID Record ID - to fill Record_ID and also to fill with BPartner, User, Project, Asset,
	 *   Order (also from OrderLine), Invoice, Product, Payment, InOut, RMA, RequestRelated (when from Request)
	 * @param Record_UU Record UUID
	 * @param C_BPartner_ID
	 */
	public static void newRequest(GridTab tab, int AD_Table_ID, int Record_ID, String Record_UU, int C_BPartner_ID) {
		tab.dataNew (false);
		tab.setValue("AD_Table_ID", Integer.valueOf(AD_Table_ID));
		tab.setValue("Record_ID", Integer.valueOf(Record_ID));
		tab.setValue("Record_UU", Record_UU);
		//
		if (C_BPartner_ID != 0)
			tab.setValue("C_BPartner_ID", Integer.valueOf(C_BPartner_ID));
		//
		if (AD_Table_ID == MBPartner.Table_ID)
			tab.setValue("C_BPartner_ID", Integer.valueOf(Record_ID));
		else if (AD_Table_ID == MUser.Table_ID)
			tab.setValue("AD_User_ID", Integer.valueOf(Record_ID));
		//
		else if (AD_Table_ID == MProject.Table_ID)
			tab.setValue("C_Project_ID", Integer.valueOf(Record_ID));
		else if (AD_Table_ID == MAsset.Table_ID)
			tab.setValue("A_Asset_ID", Integer.valueOf(Record_ID));
		//
		else if (AD_Table_ID == MOrder.Table_ID)
			tab.setValue("C_Order_ID", Integer.valueOf(Record_ID));
		else if (AD_Table_ID == MInvoice.Table_ID)
			tab.setValue("C_Invoice_ID", Integer.valueOf(Record_ID));
		//
		else if (AD_Table_ID == MProduct.Table_ID)
			tab.setValue("M_Product_ID", Integer.valueOf(Record_ID));
		else if (AD_Table_ID == MPayment.Table_ID)
			tab.setValue("C_Payment_ID", Integer.valueOf(Record_ID));
		//
		else if (AD_Table_ID == MInOut.Table_ID)
			tab.setValue("M_InOut_ID", Integer.valueOf(Record_ID));
		else if (AD_Table_ID == MRMA.Table_ID)
			tab.setValue("M_RMA_ID", Integer.valueOf(Record_ID));
		//
		else if (AD_Table_ID == MCampaign.Table_ID)
			tab.setValue("C_Campaign_ID", Integer.valueOf(Record_ID));
		//
		else if (AD_Table_ID == MRequest.Table_ID)
			tab.setValue(MRequest.COLUMNNAME_R_RequestRelated_ID, Integer.valueOf(Record_ID));
		// FR [2842165] - Order Ref link from SO line creating new request
		else if (AD_Table_ID == MOrderLine.Table_ID) {
			MOrderLine oLine = new MOrderLine(Env.getCtx(), Record_ID, null);
			if (oLine != null) {
				tab.setValue(MOrderLine.COLUMNNAME_C_Order_ID, Integer.valueOf(oLine.getC_Order_ID()));
			}
		}
	}

}	//	MRequest
