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
 * Contributor: Carlos Ruiz - globalqss                                       *
 *****************************************************************************/
package org.compiere.process;

import java.math.BigDecimal;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Timestamp;
import java.util.logging.Level;

import org.compiere.model.MAccount;
import org.compiere.model.MJournal;
import org.compiere.model.MJournalBatch;
import org.compiere.model.MJournalLine;
import org.compiere.model.X_I_GLJournal;
import org.compiere.util.CLogger;
import org.compiere.util.DB;
import org.compiere.util.TimeUtil;

/**
 *	Import GL Journal Batch/JournalLine from I_Journal
 *
 * 	@author 	Jorg Janke
 * 	@version 	$Id: ImportGLJournal.java,v 1.2 2006/07/30 00:51:02 jjanke Exp $
 */
public class ImportGLJournal extends SvrProcess
{
	/**	Client to be imported to		*/
	private int 			m_AD_Client_ID = 0;
	/**	Organization to be imported to	*/
	private int 			m_AD_Org_ID = 0;
	/**	Acct Schema to be imported to	*/
	private int				m_C_AcctSchema_ID = 0;
	/** Default Date					*/
	private Timestamp		m_DateAcct = null;
	/**	Delete old Imported				*/
	private boolean			m_DeleteOldImported = false;
	/**	Don't import					*/
	private boolean			m_IsValidateOnly = false;
	/** Import if no Errors				*/
	private boolean			m_IsImportOnlyNoErrors = true;


	/**
	 *  Prepare - e.g., get Parameters.
	 */
	protected void prepare()
	{
		ProcessInfoParameter[] para = getParameter();
		for (int i = 0; i < para.length; i++)
		{
			String name = para[i].getParameterName();
			if (para[i].getParameter() == null)
				;
			else if (name.equals("AD_Client_ID"))
				m_AD_Client_ID = ((BigDecimal)para[i].getParameter()).intValue();
			else if (name.equals("AD_Org_ID"))
				m_AD_Org_ID = ((BigDecimal)para[i].getParameter()).intValue();
			else if (name.equals("C_AcctSchema_ID"))
				m_C_AcctSchema_ID = ((BigDecimal)para[i].getParameter()).intValue();
			else if (name.equals("DateAcct"))
				m_DateAcct = (Timestamp)para[i].getParameter();
			else if (name.equals("IsValidateOnly"))
				m_IsValidateOnly = "Y".equals(para[i].getParameter());
			else if (name.equals("IsImportOnlyNoErrors"))
				m_IsImportOnlyNoErrors = "Y".equals(para[i].getParameter());
			else if (name.equals("DeleteOldImported"))
				m_DeleteOldImported = "Y".equals(para[i].getParameter());
			else
				log.log(Level.SEVERE, "Unknown Parameter: " + name);
		}
	}	//	prepare


	/**
	 *  Perform process.
	 *  @return Message
	 *  @throws Exception
	 */
	protected String doIt() throws java.lang.Exception
	{
		StringBuilder msglog = new StringBuilder("IsValidateOnly=").append(m_IsValidateOnly).append(", IsImportOnlyNoErrors=").append(m_IsImportOnlyNoErrors);
		log.info(msglog.toString());
		StringBuilder sql = null;
		int no = 0;
		StringBuilder clientCheck = new StringBuilder(" AND AD_Client_ID=").append(m_AD_Client_ID);

		//	****	Prepare	****

		//	Delete Old Imported
		if (m_DeleteOldImported)
		{
			sql = new StringBuilder ("DELETE I_GLJournal ")
				  .append("WHERE I_IsImported='Y'").append (clientCheck);
			no = DB.executeUpdate(sql.toString(), get_TrxName());
			log.fine("Delete Old Impored =" + no);
		}

		//	Set IsActive, Created/Updated
		sql = new StringBuilder ("UPDATE I_GLJournal ")
			.append("SET IsActive = COALESCE (IsActive, 'Y'),")
			.append(" Created = COALESCE (Created, SysDate),")
			.append(" CreatedBy = COALESCE (CreatedBy, 0),")
			.append(" Updated = COALESCE (Updated, SysDate),")
			.append(" UpdatedBy = COALESCE (UpdatedBy, 0),")
			.append(" I_ErrorMsg = ' ',")
			.append(" I_IsImported = 'N' ")
			.append("WHERE I_IsImported<>'Y' OR I_IsImported IS NULL");
		no = DB.executeUpdate(sql.toString(), get_TrxName());
		log.info ("Reset=" + no);

		//	Set Client from Name
		sql = new StringBuilder ("UPDATE I_GLJournal i ")
			.append("SET AD_Client_ID=(SELECT c.AD_Client_ID FROM AD_Client c WHERE c.Value=i.ClientValue) ")
			.append("WHERE (AD_Client_ID IS NULL OR AD_Client_ID=0) AND ClientValue IS NOT NULL")
			.append(" AND I_IsImported<>'Y'");
		no = DB.executeUpdate(sql.toString(), get_TrxName());
		log.fine("Set Client from Value=" + no);

		//	Set Default Client, Doc Org, AcctSchema, DatAcct
		sql = new StringBuilder ("UPDATE I_GLJournal ")
			  .append("SET AD_Client_ID = COALESCE (AD_Client_ID,").append (m_AD_Client_ID).append ("),")
			  .append(" AD_OrgDoc_ID = COALESCE (AD_OrgDoc_ID,").append (m_AD_Org_ID).append ("),");
		if (m_C_AcctSchema_ID != 0)
			sql.append(" C_AcctSchema_ID = COALESCE (C_AcctSchema_ID,").append (m_C_AcctSchema_ID).append ("),");
		if (m_DateAcct != null)
			sql.append(" DateAcct = COALESCE (DateAcct,").append (DB.TO_DATE(m_DateAcct)).append ("),");
		sql.append(" Updated = COALESCE (Updated, SysDate) ")
			  .append("WHERE I_IsImported<>'Y' OR I_IsImported IS NULL");
		no = DB.executeUpdate(sql.toString(), get_TrxName());
		log.fine("Client/DocOrg/Default=" + no);

		//	Error Doc Org
		sql = new StringBuilder ("UPDATE I_GLJournal o ")
			.append("SET I_IsImported='E', I_ErrorMsg=I_ErrorMsg||'ERR=Invalid Doc Org, '")
			.append("WHERE (AD_OrgDoc_ID IS NULL OR AD_OrgDoc_ID=0")
			.append(" OR EXISTS (SELECT * FROM AD_Org oo WHERE o.AD_OrgDoc_ID=oo.AD_Org_ID AND (oo.IsSummary='Y' OR oo.IsActive='N')))")
			.append(" AND I_IsImported<>'Y'").append (clientCheck);
		no = DB.executeUpdate(sql.toString(), get_TrxName());
		if (no != 0)
			log.warning ("Invalid Doc Org=" + no);

		//	Set AcctSchema
		sql = new StringBuilder ("UPDATE I_GLJournal i ")
			.append("SET C_AcctSchema_ID=(SELECT a.C_AcctSchema_ID FROM C_AcctSchema a")
			.append(" WHERE i.AcctSchemaName=a.Name AND i.AD_Client_ID=a.AD_Client_ID) ")
			.append("WHERE C_AcctSchema_ID IS NULL AND AcctSchemaName IS NOT NULL")
			.append(" AND I_IsImported<>'Y'").append (clientCheck);
		no = DB.executeUpdate(sql.toString(), get_TrxName());
		log.fine("Set AcctSchema from Name=" + no);
		sql = new StringBuilder ("UPDATE I_GLJournal i ")
			.append("SET C_AcctSchema_ID=(SELECT c.C_AcctSchema1_ID FROM AD_ClientInfo c WHERE c.AD_Client_ID=i.AD_Client_ID) ")
			.append("WHERE C_AcctSchema_ID IS NULL AND AcctSchemaName IS NULL")
			.append(" AND I_IsImported<>'Y'").append (clientCheck);
		no = DB.executeUpdate(sql.toString(), get_TrxName());
		log.fine("Set AcctSchema from Client=" + no);
		//	Error AcctSchema
		sql = new StringBuilder ("UPDATE I_GLJournal i ")
			.append("SET I_IsImported='E', I_ErrorMsg=I_ErrorMsg||'ERR=Invalid AcctSchema, '")
			.append("WHERE (C_AcctSchema_ID IS NULL OR C_AcctSchema_ID=0")
			.append(" OR NOT EXISTS (SELECT * FROM C_AcctSchema a WHERE i.AD_Client_ID=a.AD_Client_ID))")
			.append(" AND I_IsImported<>'Y'").append (clientCheck);
		no = DB.executeUpdate(sql.toString(), get_TrxName());
		if (no != 0)
			log.warning ("Invalid AcctSchema=" + no);

		//	Set DateAcct (mandatory)
		sql = new StringBuilder ("UPDATE I_GLJournal i ")
			.append("SET DateAcct=SysDate ")
			.append("WHERE DateAcct IS NULL")
			.append(" AND I_IsImported<>'Y'").append (clientCheck);
		no = DB.executeUpdate(sql.toString(), get_TrxName());
		log.fine("Set DateAcct=" + no);

		//	Document Type
		sql = new StringBuilder ("UPDATE I_GLJournal i ")
			.append("SET C_DocType_ID=(SELECT d.C_DocType_ID FROM C_DocType d")
			.append(" WHERE d.Name=i.DocTypeName AND d.DocBaseType='GLJ' AND i.AD_Client_ID=d.AD_Client_ID) ")
			.append("WHERE C_DocType_ID IS NULL AND DocTypeName IS NOT NULL")
			.append(" AND I_IsImported<>'Y'").append (clientCheck);
		no = DB.executeUpdate(sql.toString(), get_TrxName());
		log.fine("Set DocType=" + no);
		sql = new StringBuilder ("UPDATE I_GLJournal i ")
			.append("SET I_IsImported='E', I_ErrorMsg=I_ErrorMsg||'ERR=Invalid DocType, '")
			.append("WHERE (C_DocType_ID IS NULL OR C_DocType_ID=0")
			.append(" OR NOT EXISTS (SELECT * FROM C_DocType d WHERE i.AD_Client_ID=d.AD_Client_ID AND d.DocBaseType='GLJ'))")
			.append(" AND I_IsImported<>'Y'").append (clientCheck);
		no = DB.executeUpdate(sql.toString(), get_TrxName());
		if (no != 0)
			log.warning ("Invalid DocType=" + no);

		//	GL Category
		sql = new StringBuilder ("UPDATE I_GLJournal i ")
			.append("SET GL_Category_ID=(SELECT c.GL_Category_ID FROM GL_Category c")
			.append(" WHERE c.Name=i.CategoryName AND i.AD_Client_ID=c.AD_Client_ID) ")
			.append("WHERE GL_Category_ID IS NULL AND CategoryName IS NOT NULL")
			.append(" AND I_IsImported<>'Y'").append (clientCheck);
		no = DB.executeUpdate(sql.toString(), get_TrxName());
		log.fine("Set DocType=" + no);
		sql = new StringBuilder ("UPDATE I_GLJournal i ")
			.append("SET I_IsImported='E', I_ErrorMsg=I_ErrorMsg||'ERR=Invalid Category, '")
			.append("WHERE (GL_Category_ID IS NULL OR GL_Category_ID=0)")
			.append(" AND I_IsImported<>'Y'").append (clientCheck);
		no = DB.executeUpdate(sql.toString(), get_TrxName());
		if (no != 0)
			log.warning ("Invalid GLCategory=" + no);

		//	Set Currency
		sql = new StringBuilder ("UPDATE I_GLJournal i ")
			.append("SET C_Currency_ID=(SELECT c.C_Currency_ID FROM C_Currency c")
			.append(" WHERE c.ISO_Code=i.ISO_Code AND c.AD_Client_ID IN (0,i.AD_Client_ID)) ")
			.append("WHERE C_Currency_ID IS NULL AND ISO_Code IS NOT NULL")
			.append(" AND I_IsImported<>'Y'").append (clientCheck);
		no = DB.executeUpdate(sql.toString(), get_TrxName());
		log.fine("Set Currency from ISO=" + no);
		sql = new StringBuilder ("UPDATE I_GLJournal i ")
			.append("SET C_Currency_ID=(SELECT a.C_Currency_ID FROM C_AcctSchema a")
			.append(" WHERE a.C_AcctSchema_ID=i.C_AcctSchema_ID AND a.AD_Client_ID=i.AD_Client_ID)")
			.append("WHERE C_Currency_ID IS NULL AND ISO_Code IS NULL")
			.append(" AND I_IsImported<>'Y'").append (clientCheck);
		no = DB.executeUpdate(sql.toString(), get_TrxName());
		log.fine("Set Default Currency=" + no);
		sql = new StringBuilder ("UPDATE I_GLJournal i ")
			.append("SET I_IsImported='E', I_ErrorMsg=I_ErrorMsg||'ERR=Invalid Currency, '")
			.append("WHERE (C_Currency_ID IS NULL OR C_Currency_ID=0)")
			.append(" AND I_IsImported<>'Y'").append (clientCheck);
		no = DB.executeUpdate(sql.toString(), get_TrxName());
		if (no != 0)
			log.warning ("Invalid Currency=" + no);

		//	Set Conversion Type
		sql = new StringBuilder ("UPDATE I_GLJournal i ") 
			.append("SET ConversionTypeValue='S' ")
			.append("WHERE C_ConversionType_ID IS NULL AND ConversionTypeValue IS NULL")
			.append(" AND I_IsImported='N'").append (clientCheck);
		no = DB.executeUpdate(sql.toString(), get_TrxName());
		log.fine("Set CurrencyType Value to Spot =" + no);
		sql = new StringBuilder ("UPDATE I_GLJournal i ") 
			.append("SET C_ConversionType_ID=(SELECT c.C_ConversionType_ID FROM C_ConversionType c")
			.append(" WHERE c.Value=i.ConversionTypeValue AND c.AD_Client_ID IN (0,i.AD_Client_ID)) ")
			.append("WHERE C_ConversionType_ID IS NULL AND ConversionTypeValue IS NOT NULL")
			.append(" AND I_IsImported<>'Y'").append (clientCheck);
		no = DB.executeUpdate(sql.toString(), get_TrxName());
		log.fine("Set CurrencyType from Value=" + no);
		sql = new StringBuilder ("UPDATE I_GLJournal i ")
			.append("SET I_IsImported='E', I_ErrorMsg=I_ErrorMsg||'ERR=Invalid CurrencyType, '")
			.append("WHERE (C_ConversionType_ID IS NULL OR C_ConversionType_ID=0) AND ConversionTypeValue IS NOT NULL")
			.append(" AND I_IsImported<>'Y'").append (clientCheck);
		no = DB.executeUpdate(sql.toString(), get_TrxName());
		if (no != 0)
			log.warning ("Invalid CurrencyTypeValue=" + no);


		sql = new StringBuilder ("UPDATE I_GLJournal i ")
			.append("SET I_IsImported='E', I_ErrorMsg=I_ErrorMsg||'ERR=No ConversionType, '")
			.append("WHERE (C_ConversionType_ID IS NULL OR C_ConversionType_ID=0)")
			.append(" AND I_IsImported<>'Y'").append (clientCheck);
		no = DB.executeUpdate(sql.toString(), get_TrxName());
		if (no != 0)
			log.warning ("No CourrencyType=" + no);

		//	Set/Overwrite Home Currency Rate
		sql = new StringBuilder ("UPDATE I_GLJournal i ")
			.append("SET CurrencyRate=1")
			.append("WHERE EXISTS (SELECT * FROM C_AcctSchema a")
			.append(" WHERE a.C_AcctSchema_ID=i.C_AcctSchema_ID AND a.C_Currency_ID=i.C_Currency_ID)")
			.append(" AND C_Currency_ID IS NOT NULL AND I_IsImported<>'Y'").append (clientCheck);
		no = DB.executeUpdate(sql.toString(), get_TrxName());
		log.fine("Set Home CurrencyRate=" + no);
		//	Set Currency Rate
		sql = new StringBuilder ("UPDATE I_GLJournal i ")
		   .append("SET CurrencyRate=(SELECT MAX(r.MultiplyRate) FROM C_Conversion_Rate r, C_AcctSchema s")
		   .append(" WHERE s.C_AcctSchema_ID=i.C_AcctSchema_ID AND s.AD_Client_ID=i.AD_Client_ID")
		   .append(" AND r.C_Currency_ID=i.C_Currency_ID AND r.C_Currency_ID_TO=s.C_Currency_ID")
		   .append(" AND r.AD_Client_ID=i.AD_Client_ID AND r.AD_Org_ID=i.AD_OrgDoc_ID")
		   .append(" AND r.C_ConversionType_ID=i.C_ConversionType_ID")
		   .append(" AND i.DateAcct BETWEEN r.ValidFrom AND r.ValidTo ")
	   //	ORDER BY ValidFrom DESC
		   .append(") WHERE CurrencyRate IS NULL OR CurrencyRate=0 AND C_Currency_ID>0")
		   .append(" AND I_IsImported<>'Y'").append (clientCheck);
		no = DB.executeUpdate(sql.toString(), get_TrxName());
		log.fine("Set Org Rate=" + no);
		sql = new StringBuilder ("UPDATE I_GLJournal i ")
			.append("SET CurrencyRate=(SELECT MAX(r.MultiplyRate) FROM C_Conversion_Rate r, C_AcctSchema s")
			.append(" WHERE s.C_AcctSchema_ID=i.C_AcctSchema_ID AND s.AD_Client_ID=i.AD_Client_ID")
			.append(" AND r.C_Currency_ID=i.C_Currency_ID AND r.C_Currency_ID_TO=s.C_Currency_ID")
			.append(" AND r.AD_Client_ID=i.AD_Client_ID")
			.append(" AND r.C_ConversionType_ID=i.C_ConversionType_ID")
			.append(" AND i.DateAcct BETWEEN r.ValidFrom AND r.ValidTo ")
		//	ORDER BY ValidFrom DESC
			.append(") WHERE CurrencyRate IS NULL OR CurrencyRate=0 AND C_Currency_ID>0")
			.append(" AND I_IsImported<>'Y'").append (clientCheck);
		no = DB.executeUpdate(sql.toString(), get_TrxName());
		log.fine("Set Client Rate=" + no);
		sql = new StringBuilder ("UPDATE I_GLJournal i ")
			.append("SET I_IsImported='E', I_ErrorMsg=I_ErrorMsg||'ERR=No Rate, '")
			.append("WHERE CurrencyRate IS NULL OR CurrencyRate=0")
			.append(" AND I_IsImported<>'Y'").append (clientCheck);
		no = DB.executeUpdate(sql.toString(), get_TrxName());
		if (no != 0)
			log.warning ("No Rate=" + no);

		//	Set Period
		sql = new StringBuilder ("UPDATE I_GLJournal i ")
			.append("SET C_Period_ID=(SELECT MAX(p.C_Period_ID) FROM C_Period p")
			.append(" INNER JOIN C_Year y ON (y.C_Year_ID=p.C_Year_ID)")
			.append(" INNER JOIN AD_ClientInfo c ON (c.C_Calendar_ID=y.C_Calendar_ID)")
			.append(" WHERE c.AD_Client_ID=i.AD_Client_ID")
			// globalqss - cruiz - Bug [ 1577712 ] Financial Period Bug
			.append(" AND i.DateAcct BETWEEN p.StartDate AND p.EndDate AND p.IsActive='Y' AND p.PeriodType='S') ")
			.append("WHERE C_Period_ID IS NULL")
			.append(" AND I_IsImported<>'Y'").append (clientCheck);
		no = DB.executeUpdate(sql.toString(), get_TrxName());
		log.fine("Set Period=" + no);
		sql = new StringBuilder ("UPDATE I_GLJournal i ")
			.append("SET I_IsImported='E', I_ErrorMsg=I_ErrorMsg||'ERR=Invalid Period, '")
			.append("WHERE C_Period_ID IS NULL OR C_Period_ID NOT IN")
			.append("(SELECT C_Period_ID FROM C_Period p")
			.append(" INNER JOIN C_Year y ON (y.C_Year_ID=p.C_Year_ID)")
			.append(" INNER JOIN AD_ClientInfo c ON (c.C_Calendar_ID=y.C_Calendar_ID) ")
			.append(" WHERE c.AD_Client_ID=i.AD_Client_ID")
			// globalqss - cruiz - Bug [ 1577712 ] Financial Period Bug
			.append(" AND i.DateAcct BETWEEN p.StartDate AND p.EndDate AND p.IsActive='Y' AND p.PeriodType='S')")
			.append(" AND I_IsImported<>'Y'").append (clientCheck);
		no = DB.executeUpdate(sql.toString(), get_TrxName());
		if (no != 0)
			log.warning ("Invalid Period=" + no);
		sql = new StringBuilder ("UPDATE I_GLJournal i ")
			.append("SET I_ErrorMsg=I_ErrorMsg||'WARN=Period Closed, ' ")
			.append("WHERE C_Period_ID IS NOT NULL AND NOT EXISTS")
			.append(" (SELECT * FROM C_PeriodControl pc WHERE pc.C_Period_ID=i.C_Period_ID AND DocBaseType='GLJ' AND PeriodStatus='O') ")
			.append(" AND I_IsImported<>'Y'").append (clientCheck);
		no = DB.executeUpdate(sql.toString(), get_TrxName());
		if (no != 0)
			log.warning ("Period Closed=" + no);

		//	Posting Type
		sql = new StringBuilder ("UPDATE I_GLJournal i ")
			.append("SET PostingType='A' ")
			.append("WHERE PostingType IS NULL AND I_IsImported<>'Y'").append (clientCheck);
		no = DB.executeUpdate(sql.toString(), get_TrxName());
		log.fine("Set Actual PostingType=" + no);
		sql = new StringBuilder ("UPDATE I_GLJournal i ")
			.append("SET I_IsImported='E', I_ErrorMsg=I_ErrorMsg||'ERR=Invalid PostingType, ' ")
			.append("WHERE PostingType IS NULL OR NOT EXISTS")
			.append(" (SELECT * FROM AD_Ref_List r WHERE r.AD_Reference_ID=125 AND i.PostingType=r.Value)")
			.append(" AND I_IsImported<>'Y'").append (clientCheck);
		no = DB.executeUpdate(sql.toString(), get_TrxName());
		if (no != 0)
			log.warning ("Invalid PostingTypee=" + no);


		//	** Account Elements (optional) **
		//	(C_ValidCombination_ID IS NULL OR C_ValidCombination_ID=0)

		//	Set Org from Name (* is overwritten and default)
		sql = new StringBuilder ("UPDATE I_GLJournal i ")
			.append("SET AD_Org_ID=COALESCE((SELECT o.AD_Org_ID FROM AD_Org o")
			.append(" WHERE o.Value=i.OrgValue AND o.IsSummary='N' AND i.AD_Client_ID=o.AD_Client_ID),AD_Org_ID) ")
			.append("WHERE (AD_Org_ID IS NULL OR AD_Org_ID=0) AND OrgValue IS NOT NULL")
			.append(" AND (C_ValidCombination_ID IS NULL OR C_ValidCombination_ID=0) AND I_IsImported<>'Y'");
		no = DB.executeUpdate(sql.toString(), get_TrxName());
		log.fine("Set Org from Value=" + no);
		sql = new StringBuilder ("UPDATE I_GLJournal i ")
			.append("SET AD_Org_ID=AD_OrgDoc_ID ")
			.append("WHERE (AD_Org_ID IS NULL OR AD_Org_ID=0) AND OrgValue IS NULL AND AD_OrgDoc_ID IS NOT NULL AND AD_OrgDoc_ID<>0")
			.append(" AND (C_ValidCombination_ID IS NULL OR C_ValidCombination_ID=0) AND I_IsImported<>'Y'").append (clientCheck);
		no = DB.executeUpdate(sql.toString(), get_TrxName());
		log.fine("Set Org from Doc Org=" + no);
		//	Error Org
		sql = new StringBuilder ("UPDATE I_GLJournal o ")
			.append("SET I_IsImported='E', I_ErrorMsg=I_ErrorMsg||'ERR=Invalid Org, '")
			.append("WHERE (AD_Org_ID IS NULL OR AD_Org_ID=0")
			.append(" OR EXISTS (SELECT * FROM AD_Org oo WHERE o.AD_Org_ID=oo.AD_Org_ID AND (oo.IsSummary='Y' OR oo.IsActive='N')))")
			.append(" AND (C_ValidCombination_ID IS NULL OR C_ValidCombination_ID=0) AND I_IsImported<>'Y'").append (clientCheck);
		no = DB.executeUpdate(sql.toString(), get_TrxName());
		if (no != 0)
			log.warning ("Invalid Org=" + no);

		//	Set Account
		sql = new StringBuilder ("UPDATE I_GLJournal i ")
			.append("SET Account_ID=(SELECT MAX(ev.C_ElementValue_ID) FROM C_ElementValue ev")
			.append(" INNER JOIN C_Element e ON (e.C_Element_ID=ev.C_Element_ID)")
			.append(" INNER JOIN C_AcctSchema_Element ase ON (e.C_Element_ID=ase.C_Element_ID AND ase.ElementType='AC')")
			.append(" WHERE ev.Value=i.AccountValue AND ev.IsSummary='N'")
			.append(" AND i.C_AcctSchema_ID=ase.C_AcctSchema_ID AND i.AD_Client_ID=ev.AD_Client_ID) ")
			.append("WHERE Account_ID IS NULL AND AccountValue IS NOT NULL")
			.append(" AND (C_ValidCombination_ID IS NULL OR C_ValidCombination_ID=0) AND I_IsImported<>'Y'").append (clientCheck);
		no = DB.executeUpdate(sql.toString(), get_TrxName());
		log.fine("Set Account from Value=" + no);
		sql = new StringBuilder ("UPDATE I_GLJournal i ")
			.append("SET I_IsImported='E', I_ErrorMsg=I_ErrorMsg||'ERR=Invalid Account, '")
			.append("WHERE (Account_ID IS NULL OR Account_ID=0)")
			.append(" AND (C_ValidCombination_ID IS NULL OR C_ValidCombination_ID=0) AND I_IsImported<>'Y'").append (clientCheck);
		no = DB.executeUpdate(sql.toString(), get_TrxName());
		if (no != 0)
			log.warning ("Invalid Account=" + no);

		//	Set BPartner
		sql = new StringBuilder ("UPDATE I_GLJournal i ")
			.append("SET C_BPartner_ID=(SELECT bp.C_BPartner_ID FROM C_BPartner bp")
			.append(" WHERE bp.Value=i.BPartnerValue AND bp.IsSummary='N' AND i.AD_Client_ID=bp.AD_Client_ID) ")
			.append("WHERE C_BPartner_ID IS NULL AND BPartnerValue IS NOT NULL")
			.append(" AND (C_ValidCombination_ID IS NULL OR C_ValidCombination_ID=0) AND I_IsImported<>'Y'").append (clientCheck);
		no = DB.executeUpdate(sql.toString(), get_TrxName());
		log.fine("Set BPartner from Value=" + no);
		sql = new StringBuilder ("UPDATE I_GLJournal i ")
			.append("SET I_IsImported='E', I_ErrorMsg=I_ErrorMsg||'ERR=Invalid BPartner, '")
			.append("WHERE C_BPartner_ID IS NULL AND BPartnerValue IS NOT NULL")
			.append(" AND (C_ValidCombination_ID IS NULL OR C_ValidCombination_ID=0) AND I_IsImported<>'Y'").append (clientCheck);
		no = DB.executeUpdate(sql.toString(), get_TrxName());
		if (no != 0)
			log.warning ("Invalid BPartner=" + no);

		//	Set Product
		sql = new StringBuilder ("UPDATE I_GLJournal i ")
			.append("SET M_Product_ID=(SELECT MAX(p.M_Product_ID) FROM M_Product p")
			.append(" WHERE (p.Value=i.ProductValue OR p.UPC=i.UPC OR p.SKU=i.SKU)")
			.append(" AND p.IsSummary='N' AND i.AD_Client_ID=p.AD_Client_ID) ")
			.append("WHERE M_Product_ID IS NULL AND (ProductValue IS NOT NULL OR UPC IS NOT NULL OR SKU IS NOT NULL)")
			.append(" AND (C_ValidCombination_ID IS NULL OR C_ValidCombination_ID=0) AND I_IsImported<>'Y'").append (clientCheck);
		no = DB.executeUpdate(sql.toString(), get_TrxName());
		log.fine("Set Product from Value=" + no);
		sql = new StringBuilder ("UPDATE I_GLJournal i ")
			.append("SET I_IsImported='E', I_ErrorMsg=I_ErrorMsg||'ERR=Invalid Product, '")
			.append("WHERE M_Product_ID IS NULL AND (ProductValue IS NOT NULL OR UPC IS NOT NULL OR SKU IS NOT NULL)")
			.append(" AND (C_ValidCombination_ID IS NULL OR C_ValidCombination_ID=0) AND I_IsImported<>'Y'").append (clientCheck);
		no = DB.executeUpdate(sql.toString(), get_TrxName());
		if (no != 0)
			log.warning ("Invalid Product=" + no);

		//	Set Project
		sql = new StringBuilder ("UPDATE I_GLJournal i ")
			.append("SET C_Project_ID=(SELECT p.C_Project_ID FROM C_Project p")
			.append(" WHERE p.Value=i.ProjectValue AND p.IsSummary='N' AND i.AD_Client_ID=p.AD_Client_ID) ")
			.append("WHERE C_Project_ID IS NULL AND ProjectValue IS NOT NULL")
			.append(" AND (C_ValidCombination_ID IS NULL OR C_ValidCombination_ID=0) AND I_IsImported<>'Y'").append (clientCheck);
		no = DB.executeUpdate(sql.toString(), get_TrxName());
		log.fine("Set Project from Value=" + no);
		sql = new StringBuilder ("UPDATE I_GLJournal i ")
			.append("SET I_IsImported='E', I_ErrorMsg=I_ErrorMsg||'ERR=Invalid Project, '")
			.append("WHERE C_Project_ID IS NULL AND ProjectValue IS NOT NULL")
			.append(" AND (C_ValidCombination_ID IS NULL OR C_ValidCombination_ID=0) AND I_IsImported<>'Y'").append (clientCheck);
		no = DB.executeUpdate(sql.toString(), get_TrxName());
		if (no != 0)
			log.warning ("Invalid Project=" + no);
		
		// tbayen: IDEMPIERE-539 Import GL Window does not allow Key Values for Activity, Campaign, Sales Region
		//	Set Campaign
		sql = new StringBuilder ("UPDATE I_GLJournal i ")
			.append("SET C_Campaign_ID=(SELECT p.C_Campaign_ID FROM C_Campaign p")
			.append(" WHERE p.Value=i.CampaignValue AND p.IsSummary='N' AND i.AD_Client_ID=p.AD_Client_ID) ")
			.append("WHERE C_Campaign_ID IS NULL AND CampaignValue IS NOT NULL")
			.append(" AND (C_ValidCombination_ID IS NULL OR C_ValidCombination_ID=0) AND I_IsImported<>'Y'").append (clientCheck);
		no = DB.executeUpdate(sql.toString(), get_TrxName());
		log.fine("Set Campaign from Value=" + no);
		sql = new StringBuilder ("UPDATE I_GLJournal i ")
			.append("SET I_IsImported='E', I_ErrorMsg=I_ErrorMsg||'ERR=Invalid Campaign, '")
			.append("WHERE C_Campaign_ID IS NULL AND CampaignValue IS NOT NULL")
			.append(" AND (C_ValidCombination_ID IS NULL OR C_ValidCombination_ID=0) AND I_IsImported<>'Y'").append (clientCheck);
		no = DB.executeUpdate(sql.toString(), get_TrxName());
		if (no != 0)
			log.warning ("Invalid Campaign=" + no);

		//	Set Activity
		sql = new StringBuilder ("UPDATE I_GLJournal i ")
			.append("SET C_Activity_ID=(SELECT p.C_Activity_ID FROM C_Activity p")
			.append(" WHERE p.Value=i.ActivityValue AND p.IsSummary='N' AND i.AD_Client_ID=p.AD_Client_ID) ")
			.append("WHERE C_Activity_ID IS NULL AND ActivityValue IS NOT NULL")
			.append(" AND (C_ValidCombination_ID IS NULL OR C_ValidCombination_ID=0) AND I_IsImported<>'Y'").append (clientCheck);
		no = DB.executeUpdate(sql.toString(), get_TrxName());
		log.fine("Set Activity from Value=" + no);
		sql = new StringBuilder ("UPDATE I_GLJournal i ")
			.append("SET I_IsImported='E', I_ErrorMsg=I_ErrorMsg||'ERR=Invalid Activity, '")
			.append("WHERE C_Activity_ID IS NULL AND ActivityValue IS NOT NULL")
			.append(" AND (C_ValidCombination_ID IS NULL OR C_ValidCombination_ID=0) AND I_IsImported<>'Y'").append (clientCheck);
		no = DB.executeUpdate(sql.toString(), get_TrxName());
		if (no != 0)
			log.warning ("Invalid Activity=" + no);

		//	Set SalesRegion
		sql = new StringBuilder ("UPDATE I_GLJournal i ")
			.append("SET C_SalesRegion_ID=(SELECT p.C_SalesRegion_ID FROM C_SalesRegion p")
			.append(" WHERE p.Value=i.SalesRegionValue AND p.IsSummary='N' AND i.AD_Client_ID=p.AD_Client_ID) ")
			.append("WHERE C_SalesRegion_ID IS NULL AND SalesRegionValue IS NOT NULL")
			.append(" AND (C_ValidCombination_ID IS NULL OR C_ValidCombination_ID=0) AND I_IsImported<>'Y'").append (clientCheck);
		no = DB.executeUpdate(sql.toString(), get_TrxName());
		log.fine("Set SalesRegion from Value=" + no);
		sql = new StringBuilder ("UPDATE I_GLJournal i ")
			.append("SET I_IsImported='E', I_ErrorMsg=I_ErrorMsg||'ERR=Invalid SalesRegion, '")
			.append("WHERE C_SalesRegion_ID IS NULL AND SalesRegionValue IS NOT NULL")
			.append(" AND (C_ValidCombination_ID IS NULL OR C_ValidCombination_ID=0) AND I_IsImported<>'Y'").append (clientCheck);
		no = DB.executeUpdate(sql.toString(), get_TrxName());
		if (no != 0)
			log.warning ("Invalid SalesRegion=" + no);

		
		//	Set TrxOrg
		sql = new StringBuilder ("UPDATE I_GLJournal i ")
			.append("SET AD_OrgTrx_ID=(SELECT o.AD_Org_ID FROM AD_Org o")
			.append(" WHERE o.Value=i.OrgValue AND o.IsSummary='N' AND i.AD_Client_ID=o.AD_Client_ID) ")
			.append("WHERE AD_OrgTrx_ID IS NULL AND OrgTrxValue IS NOT NULL")
			.append(" AND (C_ValidCombination_ID IS NULL OR C_ValidCombination_ID=0) AND I_IsImported<>'Y'").append (clientCheck);
		no = DB.executeUpdate(sql.toString(), get_TrxName());
		log.fine("Set OrgTrx from Value=" + no);
		sql = new StringBuilder ("UPDATE I_GLJournal i ")
			.append("SET I_IsImported='E', I_ErrorMsg=I_ErrorMsg||'ERR=Invalid OrgTrx, '")
			.append("WHERE AD_OrgTrx_ID IS NULL AND OrgTrxValue IS NOT NULL")
			.append(" AND (C_ValidCombination_ID IS NULL OR C_ValidCombination_ID=0) AND I_IsImported<>'Y'").append (clientCheck);
		no = DB.executeUpdate(sql.toString(), get_TrxName());
		if (no != 0)
			log.warning ("Invalid OrgTrx=" + no);


		//	Source Amounts
		sql = new StringBuilder ("UPDATE I_GLJournal ")
			.append("SET AmtSourceDr = 0 ")
			.append("WHERE AmtSourceDr IS NULL")
			.append(" AND I_IsImported<>'Y'").append (clientCheck);
		no = DB.executeUpdate(sql.toString(), get_TrxName());
		log.fine("Set 0 Source Dr=" + no);
		sql = new StringBuilder ("UPDATE I_GLJournal ")
			.append("SET AmtSourceCr = 0 ")
			.append("WHERE AmtSourceCr IS NULL")
			.append(" AND I_IsImported<>'Y'").append (clientCheck);
		no = DB.executeUpdate(sql.toString(), get_TrxName());
		log.fine("Set 0 Source Cr=" + no);
		sql = new StringBuilder ("UPDATE I_GLJournal i ")
			.append("SET I_ErrorMsg=I_ErrorMsg||'WARN=Zero Source Balance, ' ")
			.append("WHERE (AmtSourceDr-AmtSourceCr)=0")
			.append(" AND I_IsImported<>'Y'").append (clientCheck);
		no = DB.executeUpdate(sql.toString(), get_TrxName());
		if (no != 0)
			log.warning ("Zero Source Balance=" + no);

		//	Accounted Amounts (Only if No Error)
		sql = new StringBuilder ("UPDATE I_GLJournal ")
			.append("SET AmtAcctDr = ROUND(AmtSourceDr * CurrencyRate, 2) ")	//	HARDCODED rounding
			.append("WHERE AmtAcctDr IS NULL OR AmtAcctDr=0")
			.append(" AND I_IsImported='N'").append (clientCheck);
		no = DB.executeUpdate(sql.toString(), get_TrxName());
		log.fine("Calculate Acct Dr=" + no);
		sql = new StringBuilder ("UPDATE I_GLJournal ")
			.append("SET AmtAcctCr = ROUND(AmtSourceCr * CurrencyRate, 2) ")
			.append("WHERE AmtAcctCr IS NULL OR AmtAcctCr=0")
			.append(" AND I_IsImported='N'").append (clientCheck);
		no = DB.executeUpdate(sql.toString(), get_TrxName());
		log.fine("Calculate Acct Cr=" + no);
		sql = new StringBuilder ("UPDATE I_GLJournal i ")
			.append("SET I_ErrorMsg=I_ErrorMsg||'WARN=Zero Acct Balance, ' ")
			.append("WHERE (AmtSourceDr-AmtSourceCr)<>0 AND (AmtAcctDr-AmtAcctCr)=0")
			.append(" AND I_IsImported<>'Y'").append (clientCheck);
		no = DB.executeUpdate(sql.toString(), get_TrxName());
		if (no != 0)
			log.warning ("Zero Acct Balance=" + no);
		//AZ Goodwill
		//BF: 2391401 Remove account balance limitation in Import GL Journal 
		/*
		sql = new StringBuffer ("UPDATE I_GLJournal i "
			+ "SET I_ErrorMsg=I_ErrorMsg||'WARN=Check Acct Balance, ' "
			+ "WHERE ABS(AmtAcctDr-AmtAcctCr)>100000000"	//	100 mio
			+ " AND I_IsImported<>'Y'").append (clientCheck);
		no = DB.executeUpdate(sql.toString(), get_TrxName());
		if (no != 0)
			log.warning ("Check Acct Balance=" + no);
		*/

		/*********************************************************************/

		//	Get Balance
		sql = new StringBuilder ("SELECT SUM(AmtSourceDr)-SUM(AmtSourceCr), SUM(AmtAcctDr)-SUM(AmtAcctCr) ")
			.append("FROM I_GLJournal ")
			.append("WHERE I_IsImported='N'").append (clientCheck);
		PreparedStatement pstmt = null;
		try
		{
			pstmt = DB.prepareStatement (sql.toString(), get_TrxName());
			ResultSet rs = pstmt.executeQuery ();
			if (rs.next ())
			{
				BigDecimal source = rs.getBigDecimal(1);
				BigDecimal acct = rs.getBigDecimal(2);
				if (source != null && source.signum() == 0
					&& acct != null && acct.signum() == 0)
					log.info ("Import Balance = 0");
				else{
					msglog = new StringBuilder("Balance Source=").append(source).append(", Acct=").append(acct);
					log.warning(msglog.toString());
				}	
				if (source != null)
					addLog (0, null, source, "@AmtSourceDr@ - @AmtSourceCr@");
				if (acct != null)
					addLog (0, null, acct, "@AmtAcctDr@ - @AmtAcctCr@");
			}
			rs.close ();
			pstmt.close ();
			pstmt = null;
		}
		catch (SQLException ex)
		{
			log.log(Level.SEVERE, sql.toString(), ex);
		}
		try
		{
			if (pstmt != null)
				pstmt.close ();
		}
		catch (SQLException ex1)
		{
		}
		pstmt = null;

		// globalqss (moved the commit here to save the error messages)
		commitEx();
		
		//	Count Errors
		StringBuilder msgdb = new StringBuilder("SELECT COUNT(*) FROM I_GLJournal WHERE I_IsImported NOT IN ('Y','N')").append(clientCheck);
		int errors = DB.getSQLValue(get_TrxName(), msgdb.toString());

		if (errors != 0)
		{
			if (m_IsValidateOnly || m_IsImportOnlyNoErrors)
				throw new Exception ("@Errors@=" + errors);
		}
		else if (m_IsValidateOnly){
			StringBuilder msgreturn = new StringBuilder("@Errors@=").append(errors);
			return msgreturn.toString();
		}	
		msglog = new StringBuilder("Validation Errors=").append(errors);
		log.info(msglog.toString());
		// moved commit above to save error messages
		// commit();
		
		/*********************************************************************/

		int noInsert = 0;
		int noInsertJournal = 0;
		int noInsertLine = 0;

		MJournalBatch batch = null;		//	Change Batch per Batch DocumentNo
		String BatchDocumentNo = "";
		MJournal journal = null;
		String JournalDocumentNo = "";
		Timestamp DateAcct = null;
		boolean wasCreateNewBatch = false;

		//	Go through Journal Records
		sql = new StringBuilder ("SELECT * FROM I_GLJournal ")
			.append("WHERE I_IsImported='N'").append (clientCheck)
			.append(" ORDER BY COALESCE(BatchDocumentNo, TO_NCHAR(I_GLJournal_ID)||' '), COALESCE(JournalDocumentNo, ")
					.append("TO_NCHAR(I_GLJournal_ID)||' '), C_AcctSchema_ID, PostingType, C_DocType_ID, GL_Category_ID, ")
					.append("C_Currency_ID, TRUNC(DateAcct), Line, I_GLJournal_ID");
		try
		{
			pstmt = DB.prepareStatement (sql.toString (), get_TrxName());
			ResultSet rs = pstmt.executeQuery ();
			//
			while (rs.next())
			{
				X_I_GLJournal imp = new X_I_GLJournal (getCtx (), rs, get_TrxName());
				//	New Batch if Batch Document No changes
				String impBatchDocumentNo = imp.getBatchDocumentNo();
				if (impBatchDocumentNo == null)
					impBatchDocumentNo = "";
				if (imp.isCreateNewBatch() // line states to create a new batch
					|| (journal != null && journal.getC_AcctSchema_ID() != imp.getC_AcctSchema_ID()) // new line changed schema
					|| (imp.getBatchDocumentNo() == null && !wasCreateNewBatch) // new line doesn't have batch info
					|| !BatchDocumentNo.equals(impBatchDocumentNo)) // batch number changed 
				{
					// reset batch
					batch = null;
				}

				if (imp.isCreateNewBatch())
					wasCreateNewBatch = true;

				if (imp.isCreateNewBatch()
					|| (batch == null && imp.getBatchDocumentNo() != null)
					)
				{
					BatchDocumentNo = impBatchDocumentNo;	//	cannot compare real DocumentNo
					batch = new MJournalBatch (getCtx(), 0, get_TrxName());
					batch.setClientOrg(imp.getAD_Client_ID(), imp.getAD_OrgDoc_ID());
					if (imp.getBatchDocumentNo() != null 
						&& imp.getBatchDocumentNo().length() > 0)
						batch.setDocumentNo (imp.getBatchDocumentNo());
					batch.setC_DocType_ID(imp.getC_DocType_ID());
					batch.setPostingType(imp.getPostingType());
					StringBuilder description;
					if (imp.getBatchDescription() == null || imp.getBatchDescription().toString().length() == 0)
						description = new StringBuilder("*Import-");
					else
						description = new StringBuilder(imp.getBatchDescription()).append(" *Import-");
					description.append(new Timestamp(System.currentTimeMillis()));
					batch.setDescription(description.toString());
					if (!batch.save())
					{
						log.log(Level.SEVERE, "Batch not saved");
						Exception ex = CLogger.retrieveException();
						if (ex != null)
						{
							addLog (0, null, null, ex.getLocalizedMessage());
							throw ex;
						}
						break;
					}
					noInsert++;
					journal = null;
				}
				//	Journal
				String impJournalDocumentNo = imp.getJournalDocumentNo();
				if (impJournalDocumentNo == null)
					impJournalDocumentNo = "";
				Timestamp impDateAcct = TimeUtil.getDay(imp.getDateAcct());
				if (journal == null
					|| imp.isCreateNewJournal()
					|| !JournalDocumentNo.equals(impJournalDocumentNo)
					|| journal.getC_DocType_ID() != imp.getC_DocType_ID()
					|| journal.getGL_Category_ID() != imp.getGL_Category_ID()
					|| !journal.getPostingType().equals(imp.getPostingType())
					|| journal.getC_Currency_ID() != imp.getC_Currency_ID()
					|| !impDateAcct.equals(DateAcct)
				)
				{
					JournalDocumentNo = impJournalDocumentNo;	//	cannot compare real DocumentNo
					DateAcct = impDateAcct;
					journal = new MJournal (getCtx(), 0, get_TrxName());
					if (batch != null)
						journal.setGL_JournalBatch_ID(batch.getGL_JournalBatch_ID());
					journal.setClientOrg(imp.getAD_Client_ID(), imp.getAD_OrgDoc_ID());
					//
					String description = imp.getBatchDescription();
					if (description == null || description.length() == 0)
						description = "(Import)";
					journal.setDescription (description);
					if (imp.getJournalDocumentNo() != null && imp.getJournalDocumentNo().length() > 0)
						journal.setDocumentNo (imp.getJournalDocumentNo());
					//
					journal.setC_AcctSchema_ID (imp.getC_AcctSchema_ID());
					journal.setC_DocType_ID (imp.getC_DocType_ID());
					journal.setGL_Category_ID (imp.getGL_Category_ID());
					journal.setPostingType (imp.getPostingType());
					journal.setGL_Budget_ID(imp.getGL_Budget_ID());
					//
					journal.setCurrency (imp.getC_Currency_ID(), imp.getC_ConversionType_ID(), imp.getCurrencyRate());
					//
					journal.setC_Period_ID(imp.getC_Period_ID());
					journal.setDateAcct(imp.getDateAcct());		//	sets Period if not defined
					journal.setDateDoc (imp.getDateAcct());
					//
					if (!journal.save())
					{
						log.log(Level.SEVERE, "Journal not saved");
						Exception ex = CLogger.retrieveException();
						if (ex != null)
						{
							addLog (0, null, null, ex.getLocalizedMessage());
							throw ex;
						}
						break;
					}
					noInsertJournal++;
				}

				//	Lines
				MJournalLine line = new MJournalLine (journal);
				//
				line.setDescription(imp.getDescription());
				line.setCurrency (imp.getC_Currency_ID(), imp.getC_ConversionType_ID(), imp.getCurrencyRate());
				//	Set/Get Account Combination
				if (imp.getC_ValidCombination_ID() == 0)
				{
					MAccount acct = MAccount.get(getCtx(), imp.getAD_Client_ID(), imp.getAD_Org_ID(), 
						imp.getC_AcctSchema_ID(), imp.getAccount_ID(), 0,
						imp.getM_Product_ID(), imp.getC_BPartner_ID(), imp.getAD_OrgTrx_ID(),
						imp.getC_LocFrom_ID(), imp.getC_LocTo_ID(), imp.getC_SalesRegion_ID(),
						imp.getC_Project_ID(), imp.getC_Campaign_ID(), imp.getC_Activity_ID(),
						imp.getUser1_ID(), imp.getUser2_ID(), 0, 0);
					if (acct != null && acct.get_ID() == 0)
						acct.saveEx();
					if (acct == null || acct.get_ID() == 0)
					{
						imp.setI_ErrorMsg("ERROR creating Account");
						imp.setI_IsImported(false);
						imp.saveEx();
						continue;
					}
					else
					{
						line.setC_ValidCombination_ID(acct.get_ID());
						imp.setC_ValidCombination_ID(acct.get_ID());
					}
				}
				else
					line.setC_ValidCombination_ID (imp.getC_ValidCombination_ID());
				//
				line.setLine (imp.getLine());
				line.setAmtSourceCr (imp.getAmtSourceCr());
				line.setAmtSourceDr (imp.getAmtSourceDr());
				line.setAmtAcct (imp.getAmtAcctDr(), imp.getAmtAcctCr());	//	only if not 0
				line.setDateAcct (imp.getDateAcct());
				//
				line.setC_UOM_ID(imp.getC_UOM_ID());
				line.setQty(imp.getQty());
				//
				if (line.save())
				{
					if (batch != null)
						imp.setGL_JournalBatch_ID(batch.getGL_JournalBatch_ID());
					imp.setGL_Journal_ID(journal.getGL_Journal_ID());
					imp.setGL_JournalLine_ID(line.getGL_JournalLine_ID());
					imp.setI_IsImported(true);
					imp.setProcessed(true);
					if (imp.save())
						noInsertLine++;
				}
			}	//	while records
			rs.close();
			pstmt.close();
		}
		catch (Exception e)
		{
			log.log(Level.SEVERE, "", e);
		}
		//	clean up
		try
		{
			if (pstmt != null)
				pstmt.close ();
		}
		catch (SQLException ex1)
		{
		}
		pstmt = null;

		//	Set Error to indicator to not imported
		sql = new StringBuilder ("UPDATE I_GLJournal ")
			.append("SET I_IsImported='N', Updated=SysDate ")
			.append("WHERE I_IsImported<>'Y'").append(clientCheck);
		no = DB.executeUpdate(sql.toString(), get_TrxName());
		addLog (0, null, new BigDecimal (no), "@Errors@");
		//
		addLog (0, null, new BigDecimal (noInsert), "@GL_JournalBatch_ID@: @Inserted@");
		addLog (0, null, new BigDecimal (noInsertJournal), "@GL_Journal_ID@: @Inserted@");
		addLog (0, null, new BigDecimal (noInsertLine), "@GL_JournalLine_ID@: @Inserted@");
		return "";
	}	//	doIt

}	//	ImportGLJournal
