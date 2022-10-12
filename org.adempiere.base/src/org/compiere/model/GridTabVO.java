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

import java.io.Serializable;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.Collections;
import java.util.Properties;
import java.util.logging.Level;

import org.compiere.util.CCache;
import org.compiere.util.CLogger;
import org.compiere.util.DB;
import org.compiere.util.Env;
import org.compiere.util.Evaluatee;
import org.compiere.util.Util;

/**
 *  Model Tab Value Object
 *
 *  @author Jorg Janke
 *  @version  $Id: GridTabVO.java,v 1.4 2006/07/30 00:58:38 jjanke Exp $
 */
public class GridTabVO implements Evaluatee, Serializable
{

	/**
	 * 
	 */
	private static final long serialVersionUID = 8781340605954851838L;

	/**************************************************************************
	 *	Create MTab VO
	 *
	 *  @param wVO value object
	 *  @param TabNo tab no
	 *	@param rs ResultSet from AD_Tab_v
	 *	@param isRO true if window is r/o
	 *  @param onlyCurrentRows if true query is limited to not processed records
	 *  @return TabVO
	 */
	public static GridTabVO create (GridWindowVO wVO, int TabNo, ResultSet rs, 
		boolean isRO, boolean onlyCurrentRows)
	{
		CLogger.get().config("#" + TabNo);

		GridTabVO vo = new GridTabVO (wVO.ctx, wVO.WindowNo);
		vo.AD_Window_ID = wVO.AD_Window_ID;
		vo.TabNo = TabNo;
		//
		if (!loadTabDetails(vo, rs))
			return null;

		if (isRO)
		{
			CLogger.get().fine("Tab is ReadOnly");
			vo.IsReadOnly = true;
		}
		vo.onlyCurrentRows = onlyCurrentRows;

		//  Create Fields
		if (vo.IsSortTab)
		{
			vo.Fields = new ArrayList<GridFieldVO>();	//	dummy
		}

		return vo;
	}	//	create

	/**
	 * 	Load Tab Details from rs into vo
	 * 	@param vo Tab value object
	 *	@param rs ResultSet from AD_Tab_v/t
	 * 	@return true if read ok
	 */
	private static boolean loadTabDetails (GridTabVO vo, ResultSet rs)
	{
		MRole role = MRole.getDefault(vo.ctx, false);
		boolean showTrl = "Y".equals(Env.getContext(vo.ctx, Env.SHOW_TRANSLATION));
		boolean showAcct = "Y".equals(Env.getContext(vo.ctx, Env.SHOW_ACCOUNTING));
		boolean showAdvanced = "Y".equals(Env.getContext(vo.ctx, Env.SHOW_ADVANCED));

		try
		{
			vo.AD_Tab_ID = rs.getInt("AD_Tab_ID");
			Env.setContext(vo.ctx, vo.WindowNo, vo.TabNo, GridTab.CTX_AD_Tab_ID, String.valueOf(vo.AD_Tab_ID));
			vo.AD_Tab_UU = rs.getString("AD_Tab_UU");
			Env.setContext(vo.ctx, vo.WindowNo, vo.TabNo, GridTab.CTX_AD_Tab_UU, vo.AD_Tab_UU);
			// FR IDEMPIERE-177
			MUserDefTab userDef = MUserDefTab.get(vo.ctx, vo.AD_Tab_ID, vo.AD_Window_ID);
			MTab tab = MTab.get(vo.AD_Tab_ID);
			vo.Name = rs.getString("Name");
			if (userDef != null) {
				if(!Util.isEmpty(userDef.getName()))
					vo.Name = userDef.getName();
				
				if(!Util.isEmpty(userDef.getDeleteConfirmationLogic()))
					vo.deleteConfirmationLogic = userDef.getDeleteConfirmationLogic();
				else if((tab != null) && (!Util.isEmpty(tab.getDeleteConfirmationLogic())))
					vo.deleteConfirmationLogic = tab.getDeleteConfirmationLogic();
					
			}
			else if((tab != null) && (!Util.isEmpty(tab.getDeleteConfirmationLogic()))) {
				vo.deleteConfirmationLogic = tab.getDeleteConfirmationLogic();
			}
			Env.setContext(vo.ctx, vo.WindowNo, vo.TabNo, GridTab.CTX_Name, vo.Name);

			//	Translation Tab	**
			if (rs.getString("IsTranslationTab").equals("Y"))
			{
				//	Document Translation
				vo.TableName = rs.getString("TableName");
				if (!Env.isBaseTranslation(vo.TableName)	//	C_UOM, ...
					&& !Env.isMultiLingualDocument(vo.ctx))
					showTrl = false;
				if (!showTrl)
				{
					CLogger.get().config("TrlTab Not displayed - AD_Tab_ID=" 
						+ vo.AD_Tab_ID + "=" + vo.Name + ", Table=" + vo.TableName
						+ ", BaseTrl=" + Env.isBaseTranslation(vo.TableName)
						+ ", MultiLingual=" + Env.isMultiLingualDocument(vo.ctx));
					return false;
				}
			}
			//	Advanced Tab	**
			if (!showAdvanced && rs.getString("IsAdvancedTab").equals("Y"))
			{
				CLogger.get().config("AdvancedTab Not displayed - AD_Tab_ID=" 
					+ vo.AD_Tab_ID + " " + vo.Name);
				return false;
			}
			//	Accounting Info Tab	**
			if (!showAcct && rs.getString("IsInfoTab").equals("Y"))
			{
				CLogger.get().fine("AcctTab Not displayed - AD_Tab_ID=" 
					+ vo.AD_Tab_ID + " " + vo.Name);
				return false;
			}
			
			//	DisplayLogic
			vo.DisplayLogic = rs.getString("DisplayLogic");
			if (userDef != null && userDef.getDisplayLogic() != null)
				vo.DisplayLogic = userDef.getDisplayLogic();
			
			//	Access Level
			vo.AccessLevel = rs.getString("AccessLevel");
			if (!role.canView (vo.ctx, vo.AccessLevel))	//	No Access
			{
				CLogger.get().fine("No Role Access - AD_Tab_ID=" + vo.AD_Tab_ID + " " + vo. Name);
				return false;
			}	//	Used by MField.getDefault
			Env.setContext(vo.ctx, vo.WindowNo, vo.TabNo, GridTab.CTX_AccessLevel, vo.AccessLevel);

			//	Table Access
			vo.AD_Table_ID = rs.getInt("AD_Table_ID");
			Env.setContext(vo.ctx, vo.WindowNo, vo.TabNo, GridTab.CTX_AD_Table_ID, String.valueOf(vo.AD_Table_ID));
			if (!role.isTableAccess(vo.AD_Table_ID, true))
			{
				CLogger.get().config("No Table Access - AD_Tab_ID=" 
					+ vo.AD_Tab_ID + " " + vo. Name);
				return false;
			}
			vo.AD_Table_UU = rs.getString("AD_Table_UU");
			Env.setContext(vo.ctx, vo.WindowNo, vo.TabNo, GridTab.CTX_AD_Table_UU, vo.AD_Table_UU);
			
			if (rs.getString("IsReadOnly").equals("Y"))
				vo.IsReadOnly = true;
			if (userDef != null && userDef.getIsReadOnly() != null)
				vo.IsReadOnly = MUserDefTab.ISREADONLY_Yes.equals(userDef.getIsReadOnly());
			vo.ReadOnlyLogic = rs.getString("ReadOnlyLogic");
			if (userDef != null && userDef.getReadOnlyLogic() != null)
				vo.ReadOnlyLogic = userDef.getReadOnlyLogic();
			
			if (rs.getString("IsInsertRecord").equals("N"))
				vo.IsInsertRecord = false;
			
			//
			vo.Description = rs.getString("Description");
			if (vo.Description == null)
				vo.Description = "";
			if (userDef != null && userDef.getDescription() != null)
				vo.Description = userDef.getDescription();

			vo.Help = rs.getString("Help");
			if (vo.Help == null)
				vo.Help = "";
			if (userDef != null && userDef.getHelp() != null)
				vo.Help = userDef.getHelp();

			if (rs.getString("IsSingleRow").equals("Y"))
				vo.IsSingleRow = true;
			if (userDef != null && userDef.getIsSingleRow() != null)
				vo.IsSingleRow = MUserDefTab.ISSINGLEROW_Yes.equals(userDef.getIsSingleRow());

			if (rs.getString("HasTree").equals("Y"))
				vo.HasTree = true;

			vo.TreeDisplayedOn = rs.getString("TreeDisplayedOn");

			vo.MaxQueryRecords = rs.getInt("MaxQueryRecords");

			vo.AD_Table_ID = rs.getInt("AD_Table_ID");
			vo.TableName = rs.getString("TableName");
			if (rs.getString("IsView").equals("Y"))
				vo.IsView = true;
			vo.AD_Column_ID = rs.getInt("AD_Column_ID");   //  Primary Link Column
			vo.Parent_Column_ID = rs.getInt("Parent_Column_ID");   // Parent tab link column

			if (rs.getString("IsSecurityEnabled").equals("Y"))
				vo.IsSecurityEnabled = true;
			if (rs.getString("IsDeleteable").equals("Y"))
				vo.IsDeleteable = true;
			if (rs.getString("IsHighVolume").equals("Y"))
				vo.IsHighVolume = true;
			if (userDef != null && !Util.isEmpty(userDef.getIsHighVolume()))
				vo.IsHighVolume = "Y".equals(userDef.getIsHighVolume());

			// Lookup Only Selection Fields
			if (rs.getString("IsLookupOnlySelection").equals("Y"))
				vo.IsLookupOnlySelection = true;
			if (userDef != null && userDef.getIsLookupOnlySelection() != null)
				vo.IsLookupOnlySelection =  "Y".equals(userDef.getIsLookupOnlySelection());
			Env.setContext(vo.ctx, vo.WindowNo, vo.TabNo, GridTab.CTX_IsLookupOnlySelection, vo.IsLookupOnlySelection);
			// Allow Advanced Lookup
			if (rs.getString("IsAllowAdvancedLookup").equals("Y"))
				vo.IsAllowAdvancedLookup = true;
			if (userDef != null && userDef.getIsAllowAdvancedLookup() != null)
				vo.IsAllowAdvancedLookup =  "Y".equals(userDef.getIsAllowAdvancedLookup());
			Env.setContext(vo.ctx, vo.WindowNo, vo.TabNo, GridTab.CTX_IsAllowAdvancedLookup, vo.IsAllowAdvancedLookup);			
			vo.CommitWarning = rs.getString("CommitWarning");
			if (vo.CommitWarning == null)
				vo.CommitWarning = "";
			vo.WhereClause = rs.getString("WhereClause");
			if (vo.WhereClause == null)
				vo.WhereClause = "";
			//jz col=null not good for Derby
			if (vo.WhereClause.indexOf("=null")>0)				
				vo.WhereClause = vo.WhereClause.replaceAll("=null", " IS NULL ");
			// Where Clauses should be surrounded by parenthesis - teo_sarca, BF [ 1982327 ] 
			if (vo.WhereClause.trim().length() > 0) {
				vo.WhereClause = "("+vo.WhereClause+")";
			}
			//	Make sure the tab where is not replaced
			if (userDef != null && userDef.getWhereClause() != null && !userDef.getWhereClause().trim().isEmpty())
			{
				if (vo.WhereClause.trim().length() > 0)
					vo.WhereClause += " AND ";
				vo.WhereClause += " (" + userDef.getWhereClause() + ")";
			}
			
			vo.OrderByClause = rs.getString("OrderByClause");
			if (vo.OrderByClause == null)
				vo.OrderByClause = "";
			if (userDef != null && userDef.getOrderByClause() != null && !userDef.getOrderByClause().trim().isEmpty())
				vo.OrderByClause = userDef.getOrderByClause();

			vo.AD_Process_ID = rs.getInt("AD_Process_ID");
			if (rs.wasNull())
				vo.AD_Process_ID = 0;
			if (userDef != null && userDef.getAD_Process_ID() > 0)
				vo.AD_Process_ID = userDef.getAD_Process_ID();
			vo.AD_Image_ID = rs.getInt("AD_Image_ID");
			if (rs.wasNull())
				vo.AD_Image_ID = 0;
			vo.Included_Tab_ID = rs.getInt("Included_Tab_ID");
			if (rs.wasNull())
				vo.Included_Tab_ID = 0;
			//
			vo.TabLevel = rs.getInt("TabLevel");
			if (rs.wasNull())
				vo.TabLevel = 0;
			//
			vo.IsSortTab = rs.getString("IsSortTab").equals("Y");
			Env.setContext(vo.ctx, vo.WindowNo, vo.TabNo, GridTab.CTX_IsSortTab, vo.IsSortTab ? "Y" : "N");
			if (vo.IsSortTab)
			{
				vo.AD_ColumnSortOrder_ID = rs.getInt("AD_ColumnSortOrder_ID");
				vo.AD_ColumnSortYesNo_ID = rs.getInt("AD_ColumnSortYesNo_ID");
			}
			vo.AD_TabType = rs.getString("AD_TabType");
			//
			//	Replication Type - set R/O if Reference
			try
			{
				int index = rs.findColumn ("ReplicationType");
				vo.ReplicationType = rs.getString (index);
				if ("R".equals(vo.ReplicationType))
					vo.IsReadOnly = true;
			}
			catch (Exception e)
			{
			}
		}
		catch (SQLException ex)
		{
			CLogger.get().log(Level.SEVERE, "", ex);
			return false;
		}
		
		return true;
	}	//	loadTabDetails

	private static final CCache<String, ArrayList<GridFieldVO>> s_gridFieldCache = new CCache<String, ArrayList<GridFieldVO>>(MField.Table_Name, "GridFieldVO Cache", 100, CCache.DEFAULT_EXPIRE_MINUTE, false, 1000);
	
	/**************************************************************************
	 *  Create Tab Fields
	 *  @param mTabVO tab value object
	 *  @return true if fields were created
	 */
	private static boolean createFields (GridTabVO mTabVO)
	{
		//local only or remote fail for vpn profile
		mTabVO.Fields = new ArrayList<GridFieldVO>();
		
		String sql = GridFieldVO.getSQL(mTabVO.ctx);
		String cacheKey = sql + "|" + mTabVO.AD_Tab_ID;
		ArrayList<GridFieldVO> cache = s_gridFieldCache.get(cacheKey);
		if (cache != null)
		{
			for(GridFieldVO gvo : cache)
			{
				GridFieldVO clone = gvo.clone(mTabVO.ctx, mTabVO.WindowNo, mTabVO.TabNo, mTabVO.AD_Window_ID, mTabVO.AD_Tab_ID, mTabVO.IsReadOnly);
				mTabVO.Fields.add(clone.afterCreate());
			}
		}
		else
		{			
			PreparedStatement pstmt = null;
			ResultSet rs = null;
			try
			{
				cache = new ArrayList<GridFieldVO>();
				pstmt = DB.prepareStatement(sql, null);
				pstmt.setInt(1, mTabVO.AD_Tab_ID);
				rs = pstmt.executeQuery();
				while (rs.next())
				{
					GridFieldVO voF = GridFieldVO.createFromResultSet(mTabVO.ctx, 
						mTabVO.WindowNo, mTabVO.TabNo, 
						mTabVO.AD_Window_ID, mTabVO.AD_Tab_ID, 
						mTabVO.IsReadOnly, rs);
					if (voF != null)
					{
						cache.add(voF.clone(Env.getCtx(), mTabVO.WindowNo, mTabVO.TabNo, mTabVO.AD_Window_ID, mTabVO.AD_Tab_ID, mTabVO.IsReadOnly));
						mTabVO.Fields.add(voF.afterCreate());
					}					
				}
				if (!cache.isEmpty())
					s_gridFieldCache.put(cacheKey, cache);
			}
			catch (Exception e)
			{
				CLogger.get().log(Level.SEVERE, "", e);
				return false;
			}
			finally
			{
				DB.close(rs, pstmt);
				rs = null;
				pstmt = null;
			}
		}
		
		Collections.sort(mTabVO.Fields, new GridFieldVO.SeqNoComparator());
		mTabVO.initFields = true;
		
		return mTabVO.Fields.size() != 0;
	}   //  createFields
	
	/**
	 *  Return the SQL statement used for the MTabVO.create
	 *  @param ctx context
	 *  @return SQL SELECT String
	 */
	protected static String getSQL (Properties ctx)
	{
		MClient client = MClient.get(ctx);
		String ASPFilter = "";
		if (client.isUseASP())
		{
			StringBuilder stringBuilder = new StringBuilder()
					// Just ASP subscribed tabs for client "
					.append("     AND (   AD_Tab_ID IN ( ")
					.append("              SELECT t.AD_Tab_ID ")
					.append("                FROM ASP_Tab t, ASP_Window w, ASP_Level l, ASP_ClientLevel cl ")
					.append("               WHERE w.ASP_Level_ID = l.ASP_Level_ID ")
					.append("                 AND cl.AD_Client_ID = ")
					.append(client.getAD_Client_ID())
					.append("                 AND cl.ASP_Level_ID = l.ASP_Level_ID ")
					.append("                 AND t.ASP_Window_ID = w.ASP_Window_ID ")
					.append("                 AND t.IsActive = 'Y' ")
					.append("                 AND w.IsActive = 'Y' ")
					.append("                 AND l.IsActive = 'Y' ")
					.append("                 AND cl.IsActive = 'Y' ")
					.append("                 AND t.ASP_Status = 'S') ") // Show
					.append("        OR AD_Tab_ID IN ( ")
					// + show ASP exceptions for client
					.append("              SELECT AD_Tab_ID ")
					.append("                FROM ASP_ClientException ce ")
					.append("               WHERE ce.AD_Client_ID = ")
					.append(client.getAD_Client_ID())
					.append("                 AND ce.IsActive = 'Y' ")
					.append("                 AND ce.AD_Tab_ID IS NOT NULL ")
					.append("                 AND ce.AD_Field_ID IS NULL ")
					.append("                 AND ce.ASP_Status = 'S') ") // Show
					.append("       ) ")
					.append("   AND AD_Tab_ID NOT IN ( ")
					// minus hide ASP exceptions for client
					.append("          SELECT AD_Tab_ID ")
					.append("            FROM ASP_ClientException ce ")
					.append("           WHERE ce.AD_Client_ID = ")
					.append(client.getAD_Client_ID())
					.append("             AND ce.IsActive = 'Y' ")
					.append("             AND ce.AD_Tab_ID IS NOT NULL ")
					.append("             AND ce.AD_Field_ID IS NULL ")
					.append("             AND ce.ASP_Status = 'H')"); // Hide
			ASPFilter = stringBuilder.toString(); 
		}
		//  View only returns IsActive='Y'
		MRole role = MRole.getDefault(ctx, false);
		String advancedFilter=" AND IsAdvancedTab='N' ";
		StringBuilder sql;
		if (!Env.isBaseLanguage(ctx, "AD_Window")) {
			sql = new StringBuilder( "SELECT * FROM AD_Tab_vt WHERE AD_Window_ID=?");
			sql.append(" AND AD_Language='" + Env.getAD_Language(ctx) + "'")
				.append(ASPFilter);
			if (!role.isAccessAdvanced()) {
				sql.append(advancedFilter);
			}
			sql.append(" ORDER BY SeqNo");
		}else{
			sql =  new StringBuilder("SELECT * FROM AD_Tab_v WHERE AD_Window_ID=?");
			sql.append(ASPFilter) ;
			if (!role.isAccessAdvanced()) {
				sql.append(advancedFilter);
			}
			sql.append(" ORDER BY SeqNo");
		}
		return sql.toString();
	}   //  getSQL
	
	
	/**************************************************************************
	 *  Private constructor - must use Factory
	 *  @param Ctx context
	 *  @param windowNo window
	 */
	private GridTabVO (Properties Ctx, int windowNo)
	{
		ctx = Ctx;
		WindowNo = windowNo;
	}

	/** Context - replicated    */
	public  Properties      ctx;
	/** Window No - replicated  */
	public  int				WindowNo;
	/** AD Window - replicated  */
	public  int             AD_Window_ID;

	/** Tab No (not AD_Tab_ID) 0.. */
	public  int				TabNo;

	/**	Tab	ID			*/
	public	int		    AD_Tab_ID;
	/** Tab UUID		*/
	public  String		AD_Tab_UU;
	/** Name			*/
	public	String	    Name = "";
	/** Description		*/
	public	String	    Description = "";
	/** Help			*/
	public	String	    Help = "";
	/** Single Row		*/
	public	boolean	    IsSingleRow = false;
	/** Read Only		*/
	public  boolean     IsReadOnly = false;
	/** Insert Record	*/
	public 	boolean		IsInsertRecord = true;
	/** Tree			*/
	public  boolean	    HasTree = false;
	/** Tree displayed on	*/
	public  String	    TreeDisplayedOn = "";
	/** Max Query Records	*/
	public  int         MaxQueryRecords = 0;
	/** Table			*/
	public  int		    AD_Table_ID;
	/** Table UUID		*/
	public  String		AD_Table_UU;
	/** Primary Link Column   */
	public  int		    AD_Column_ID = 0;
	/** Parent Tab Link Column */
	public	int			Parent_Column_ID = 0;
	/** Table Name		*/
	public  String	    TableName;
	/** Table is View	*/
	public  boolean     IsView = false;
	/** Table Access Level	*/
	public  String	    AccessLevel;
	/** Security		*/
	public  boolean	    IsSecurityEnabled = false;
	/** Table Deleteable	*/
	public  boolean	    IsDeleteable = false;
	/** Table High Volume	*/
	public  boolean     IsHighVolume = false;
	/** Allow use of advanced Lookup panel **/
	public boolean IsAllowAdvancedLookup = false;
	/** Only allow Lookup using selection defined fields **/
	public boolean IsLookupOnlySelection = false;
	/** Process			*/
	public	int		    AD_Process_ID = 0;
	/** Process UUID		*/
	public  String		AD_Process_UU;
	/** Commit Warning	*/
	public  String	    CommitWarning;
	/** Where			*/
	public  String	    WhereClause;
	/** Order by		*/
	public  String      OrderByClause;
	/** Tab Read Only	*/
	public  String      ReadOnlyLogic;
	/** Tab Display		*/
	public  String      DisplayLogic;
	/** Level			*/
	public  int         TabLevel = 0;
	/** Image			*/
	public int          AD_Image_ID = 0;
	/** Included Tab	*/
	public int          Included_Tab_ID = 0;
	/** Replication Type	*/
	public String		ReplicationType = "L";

	/** Sort Tab			*/
	public boolean		IsSortTab = false;
	/** Column Sort			*/
	public int			AD_ColumnSortOrder_ID = 0;
	/** Column Displayed	*/
	public int			AD_ColumnSortYesNo_ID = 0;

	/** Only Current Rows - derived	*/
	public  boolean     onlyCurrentRows = true;
	/**	Only Current Days - derived	*/
	public int			onlyCurrentDays = 0;
	/** Tab type uses by IADTabpanel service to identify implementors*/
	public String AD_TabType = null;

	/** Fields contain MFieldVO entities    */
	private ArrayList<GridFieldVO>	Fields = null;

	private boolean initFields = false;

	/** Delete Confirmation Logic of AD_Tab or AD_UserDef_Tab	 */
	public String deleteConfirmationLogic = null;
	
	public ArrayList<GridFieldVO> getFields()
	{
		if (!initFields) createFields(this);
		return Fields;
	}
	
	/**
	 *  Set Context including contained elements
	 *  @param newCtx new context
	 */
	public void setCtx (Properties newCtx)
	{
		ctx = newCtx;
		if (Fields != null)
		{
			for (int i = 0; i < Fields.size() ; i++)
			{
				GridFieldVO field = (GridFieldVO)Fields.get(i);
				field.setCtx(newCtx);
			}
		}
	}   //  setCtx
	
	/**
	 * 	Get Variable Value (Evaluatee)
	 *	@param variableName name
	 *	@return value
	 */
	public String get_ValueAsString (String variableName)
	{
		return Env.getContext (ctx, WindowNo, variableName, false);	// not just window
	}	//	get_ValueAsString

	/**
	 * 	Clone
	 * 	@param Ctx context
	 * 	@param windowNo no
	 *	@return MTabVO or null
	 */
	protected GridTabVO clone(Properties Ctx, int windowNo)
	{
		GridTabVO clone = new GridTabVO(Ctx, windowNo);
		clone.AD_Window_ID = AD_Window_ID;
		clone.TabNo = TabNo;
		Env.setContext(Ctx, windowNo, clone.TabNo, GridTab.CTX_AD_Tab_ID, String.valueOf(clone.AD_Tab_ID));
		//
		clone.AD_Tab_ID = AD_Tab_ID;
		clone.AD_Tab_UU = AD_Tab_UU;
		clone.Name = Name;
		Env.setContext(Ctx, windowNo, clone.TabNo, GridTab.CTX_Name, clone.Name);
		clone.Description = Description;
		clone.Help = Help;
		clone.IsSingleRow = IsSingleRow;
		clone.IsReadOnly = IsReadOnly;
		clone.IsInsertRecord = IsInsertRecord;
		clone.HasTree = HasTree;
		clone.TreeDisplayedOn = TreeDisplayedOn;
		clone.MaxQueryRecords = MaxQueryRecords;
		clone.AD_Table_ID = AD_Table_ID;
		clone.AD_Column_ID = AD_Column_ID;
		clone.Parent_Column_ID = Parent_Column_ID;
		clone.TableName = TableName;
		clone.IsView = IsView;
		clone.AccessLevel = AccessLevel;
		clone.IsSecurityEnabled = IsSecurityEnabled;
		clone.IsDeleteable = IsDeleteable;
		clone.IsHighVolume = IsHighVolume;
		clone.IsLookupOnlySelection = IsLookupOnlySelection;
		clone.IsAllowAdvancedLookup = IsAllowAdvancedLookup;
		clone.AD_Process_ID = AD_Process_ID;
		clone.CommitWarning = CommitWarning;
		clone.WhereClause = WhereClause;
		clone.OrderByClause = OrderByClause;
		clone.ReadOnlyLogic = ReadOnlyLogic;
		clone.DisplayLogic = DisplayLogic;
		clone.TabLevel = TabLevel;
		clone.AD_Image_ID = AD_Image_ID;
		clone.Included_Tab_ID = Included_Tab_ID;
		clone.ReplicationType = ReplicationType;
		clone.deleteConfirmationLogic = deleteConfirmationLogic;
		Env.setContext(Ctx, windowNo, clone.TabNo, GridTab.CTX_AccessLevel, clone.AccessLevel);
		Env.setContext(Ctx, windowNo, clone.TabNo, GridTab.CTX_AD_Table_ID, String.valueOf(clone.AD_Table_ID));
		Env.setContext(Ctx, windowNo, clone.TabNo, GridTab.CTX_IsLookupOnlySelection, clone.IsLookupOnlySelection);
		Env.setContext(Ctx, windowNo, clone.TabNo, GridTab.CTX_IsAllowAdvancedLookup, clone.IsAllowAdvancedLookup);

		//
		clone.IsSortTab = IsSortTab;
		clone.AD_ColumnSortOrder_ID = AD_ColumnSortOrder_ID;
		clone.AD_ColumnSortYesNo_ID = AD_ColumnSortYesNo_ID;
		//  Derived
		clone.onlyCurrentRows = true;
		clone.onlyCurrentDays = 0;
		clone.AD_TabType = AD_TabType;
		clone.Fields = new ArrayList<GridFieldVO>();
		for (int i = 0; i < Fields.size(); i++)
		{
			GridFieldVO field = Fields.get(i);
			GridFieldVO cloneField = field.clone(Ctx, windowNo, TabNo, 
				AD_Window_ID, AD_Tab_ID, IsReadOnly);
			if (cloneField == null)
				return null;
			clone.Fields.add(cloneField);
		}
		
		return clone;
	}	//	clone

	/**
	 * @return the initFields
	 */
	public boolean isInitFields() {
		return initFields;
	}

}   //  MTabVO