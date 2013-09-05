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

import java.sql.ResultSet;
import java.util.List;
import java.util.Properties;
import java.util.logging.Level;

import org.compiere.util.CCache;
import org.compiere.util.DB;
import org.compiere.util.Env;

/**
 *	Document Type Model
 *	
 *  @author Jorg Janke
 *  @author Karsten Thiemann FR [ 1782412 ]
 *  @author Teo Sarca, www.arhipac.ro
 *  		<li>BF [ 2476824 ] MDocType.getOfDocBaseType should return ONLY active records
 *  		<li>BF [ -       ] MDocType.getOfClient should return ONLY active records.
 *  							See https://sourceforge.net/forum/message.php?msg_id=6499893
 *  @version $Id: MDocType.java,v 1.3 2006/07/30 00:54:54 jjanke Exp $
 */
public class MDocType extends X_C_DocType
{
	/**
	 * 
	 */
	private static final long serialVersionUID = -6556521509479670059L;

	/**
	 * Return the first Doc Type for this BaseType
	 * @param DocBaseType
	 * @return
	 */
	static public int getDocType(String DocBaseType)
	{
		MDocType[] doc = MDocType.getOfDocBaseType(Env.getCtx(), DocBaseType);
		return doc.length > 0 ? doc[0].get_ID() : 0;
	}
	
	/**
	 * 	Get Client Document Type with DocBaseType
	 *	@param ctx context
	 *	@param DocBaseType base document type
	 *	@return array of doc types
	 */
	static public MDocType[] getOfDocBaseType (Properties ctx, String DocBaseType)
	{
		final String whereClause  = "AD_Client_ID=? AND DocBaseType=?";
		List<MDocType> list = new Query(ctx, Table_Name, whereClause, null)
									.setParameters(Env.getAD_Client_ID(ctx), DocBaseType)
									.setOnlyActiveRecords(true)
									.setOrderBy("IsDefault DESC, C_DocType_ID")
									.list();
		return list.toArray(new MDocType[list.size()]);
	}	//	getOfDocBaseType
	
	/**
	 * 	Get Client Document Types
	 *	@param ctx context
	 *	@return array of doc types
	 */
	static public MDocType[] getOfClient (Properties ctx)
	{
		List<MDocType> list = new Query(ctx, Table_Name, null, null)
									.setClient_ID()
									.setOnlyActiveRecords(true)
									.list();
		return list.toArray(new MDocType[list.size()]);
	}	//	getOfClient
	
	/**
	 * 	Get Document Type (cached)
	 *	@param ctx context
	 *	@param C_DocType_ID id
	 *	@return document type
	 */
	static public MDocType get (Properties ctx, int C_DocType_ID)
	{
		MDocType retValue = (MDocType)s_cache.get(C_DocType_ID);
		if (retValue == null)
		{
			retValue = new MDocType (ctx, C_DocType_ID, null);
			s_cache.put(C_DocType_ID, retValue);
		}
		return retValue; 
	} 	//	get
	
	/**	Cache					*/
	static private CCache<Integer,MDocType>	s_cache = new CCache<Integer,MDocType>(Table_Name, 20);
	
	/**************************************************************************
	 * 	Standard Constructor
	 *	@param ctx context
	 *	@param C_DocType_ID id
	 *	@param trxName transaction
	 */
	public MDocType(Properties ctx, int C_DocType_ID, String trxName)
	{
		super(ctx, C_DocType_ID, trxName);
		if (C_DocType_ID == 0)
		{
		//	setName (null);
		//	setPrintName (null);
		//	setDocBaseType (null);
		//	setGL_Category_ID (0);
			setDocumentCopies (0);
			setHasCharges (false);
			setIsDefault (false);
			setIsDocNoControlled (false);
			setIsSOTrx (false);
			setIsPickQAConfirm(false);
			setIsShipConfirm(false);
			setIsSplitWhenDifference(false);
			//
			setIsCreateCounter(true);
			setIsDefaultCounterDoc(false);
			setIsIndexed(true);
		}
	}	//	MDocType

	/**
	 * 	Load Constructor
	 *	@param ctx context
	 *	@param rs result set
	 *	@param trxName transaction
	 */
	public MDocType(Properties ctx, ResultSet rs, String trxName)
	{
		super(ctx, rs, trxName);
	}	//	MDocType

	/**
	 * 	New Constructor
	 *	@param ctx context
	 *	@param DocBaseType document base type
	 *	@param Name name
	 *	@param trxName transaction
	 */
	public MDocType (Properties ctx, String DocBaseType, String Name, String trxName)
	{
		this (ctx, 0, trxName);
		setAD_Org_ID(0);
		setDocBaseType (DocBaseType);
		setName (Name);
		setPrintName (Name);
		setGL_Category_ID ();
	}	//	MDocType

	/**
	 * 	Set Default GL Category
	 */
	public void setGL_Category_ID()
	{
		final String sql = "SELECT GL_Category_ID FROM GL_Category"
						+" WHERE AD_Client_ID=?"
						+" ORDER BY IsDefault DESC, GL_Category_ID";
		int GL_Category_ID = DB.getSQLValue(get_TrxName(), sql, getAD_Client_ID());
		setGL_Category_ID(GL_Category_ID);
	}	//	setGL_Category_ID

	
	/**
	 * 	Set SOTrx based on document base type
	 */
	public void setIsSOTrx ()
	{
		boolean isSOTrx = DOCBASETYPE_SalesOrder.equals(getDocBaseType()) 
			|| DOCBASETYPE_MaterialDelivery.equals(getDocBaseType())
			|| getDocBaseType().startsWith("AR");
		super.setIsSOTrx (isSOTrx);
	}	//	setIsSOTrx
	
	/**
	 * 	String Representation
	 *	@return info
	 */
	public String toString()
	{
		StringBuilder sb = new StringBuilder("MDocType[");
		sb.append(get_ID()).append("-").append(getName())
			.append(",DocNoSequence_ID=").append(getDocNoSequence_ID())
			.append("]");
		return sb.toString();
	}	//	toString

	/**
	 * 	Is this a Quotation (Binding)
	 *	@return true if Quotation
	 */
	public boolean isQuotation()
	{
		return DOCSUBTYPESO_Quotation.equals(getDocSubTypeSO())
			&& DOCBASETYPE_SalesOrder.equals(getDocBaseType());
	}	//	isQuotation
	
	/**
	 * 	Is this a Proposal (Not binding)
	 *	@return true if proposal
	 */
	public boolean isProposal()
	{
		return DOCSUBTYPESO_Proposal.equals(getDocSubTypeSO())
			&& DOCBASETYPE_SalesOrder.equals(getDocBaseType());
	}	//	isProposal
	
	/**
	 * 	Is this a Proposal or Quotation
	 *	@return true if proposal or quotation
	 */
	public boolean isOffer()
	{
		return (DOCSUBTYPESO_Proposal.equals(getDocSubTypeSO())
				|| DOCSUBTYPESO_Quotation.equals(getDocSubTypeSO()))
			&& DOCBASETYPE_SalesOrder.equals(getDocBaseType());
	}	//	isOffer

	
	/**
	 * 	Get Print Name
	 * 	@param AD_Language language
	 *	@return print Name if available translated
	 */
	public String getPrintName (String AD_Language)
	{
		if (AD_Language == null || AD_Language.length() == 0)
			return super.getPrintName();
		return get_Translation (COLUMNNAME_PrintName, AD_Language);
	}	//	getPrintName
	
	/**
	 * 	Before Save
	 *	@param newRecord new
	 *	@return true
	 */
	protected boolean beforeSave (boolean newRecord)
	{
		/*if (getAD_Org_ID() != 0)
			setAD_Org_ID(0);*/
		return true;
	}	//	beforeSave
	
	/**
	 * 	After Save
	 *	@param newRecord new
	 *	@param success success
	 *	@return success
	 */
	protected boolean afterSave (boolean newRecord, boolean success)
	{
		if (newRecord && success)
		{
			//	Add doctype/docaction access to all roles of client
			StringBuilder sqlDocAction = new StringBuilder("INSERT INTO AD_Document_Action_Access ")
				.append("(AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,")
				.append("C_DocType_ID , AD_Ref_List_ID, AD_Role_ID) ")
				.append("(SELECT ")
				.append(getAD_Client_ID()).append(",0,'Y', SysDate,") 
				.append(getUpdatedBy()).append(", SysDate,").append(getUpdatedBy()) 
				.append(", doctype.C_DocType_ID, action.AD_Ref_List_ID, rol.AD_Role_ID ")
				.append("FROM AD_Client client ")
				.append("INNER JOIN C_DocType doctype ON (doctype.AD_Client_ID=client.AD_Client_ID) ")
				.append("INNER JOIN AD_Ref_List action ON (action.AD_Reference_ID=135) ")
				.append("INNER JOIN AD_Role rol ON (rol.AD_Client_ID=client.AD_Client_ID) ")
				.append("WHERE client.AD_Client_ID=").append(getAD_Client_ID()) 
				.append(" AND doctype.C_DocType_ID=").append(get_ID())
				.append(" AND rol.IsManual='N'")
				.append(")");
			
			int docact = DB.executeUpdate(sqlDocAction.toString(), get_TrxName());
			if (log.isLoggable(Level.FINE)) log.fine("AD_Document_Action_Access=" + docact);
		}
		return success;
	}	//	afterSave
	
	/**
	 * 	Executed before Delete operation.
	 *
	 *	@return true if delete is a success
	 */
	protected boolean beforeDelete ()
	{
		// delete access records
		StringBuilder msgdb = new StringBuilder("DELETE FROM AD_Document_Action_Access WHERE C_DocType_ID=").append(get_ID());
		int docactDel = DB.executeUpdate(msgdb.toString(), get_TrxName());
		if (log.isLoggable(Level.FINE)) log.fine("Delete AD_Document_Action_Access=" + docactDel + " for C_DocType_ID: " + get_ID());
		return docactDel >= 0;
	}   //  beforeDelete

	/**
     * Returns Document type for the shipment/receipt based
     * on Document type provided for order/rma
     * @param docTypeId
     * @return shipment/receipt doctype id
     */
    public static int getShipmentReceiptDocType(int docTypeId)
    {
        int relatedDocTypeId = 0;
        if (docTypeId != 0)
        {
            MDocType docType = MDocType.get(Env.getCtx(), docTypeId);
            // FIXME: Should refactor code and remove the hard coded name
            // Should change document type to allow query the value
            if ("Return Material".equals(docType.getName()) ||
                    "Vendor Return".equals(docType.getName())|| !docType.isSOTrx())
            {
                String relatedDocTypeName = null;
                if (("Purchase Order").equals(docType.getName()))
                {
                    relatedDocTypeName = "MM Receipt";
                }
                else if ("Return Material".equals(docType.getName()))
                {
                    relatedDocTypeName = "MM Returns";
                }
                else if ("Vendor Return".equals(docType.getName()))
                {
                    relatedDocTypeName = "MM Vendor Returns";
                }

                if (relatedDocTypeName != null)
                {
                    StringBuilder whereClause = new StringBuilder(30);
                    whereClause.append("Name='").append(relatedDocTypeName).append("' ");
                    whereClause.append("and AD_Client_ID=").append(Env.getAD_Client_ID(Env.getCtx()));
                    whereClause.append(" AND IsActive='Y'");

                    int relDocTypeIds[] = MDocType.getAllIDs(MDocType.Table_Name, whereClause.toString(), null);

                    if (relDocTypeIds.length > 0)
                    {
                        relatedDocTypeId = relDocTypeIds[0];
                    }
                }
            }
            else
            {
                relatedDocTypeId = docType.getC_DocTypeShipment_ID();
            }
        }

        return relatedDocTypeId;
    }
   
	/**
	 * 	Get translated doctype name
	 *	@return Name if available translated
	 */
	public String getNameTrl()
	{
		return get_Translation (COLUMNNAME_Name, Env.getAD_Language(getCtx()));
	}	//	getNameTrl

}	//	MDocType
