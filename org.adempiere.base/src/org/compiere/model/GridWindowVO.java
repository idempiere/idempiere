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
import java.util.Properties;
import java.util.logging.Level;

import org.compiere.util.CCache;
import org.compiere.util.CLogger;
import org.compiere.util.DB;
import org.compiere.util.Env;

/**
 *  Model Window Value Object
 *
 *  @author Jorg Janke
 *  @version  $Id: GridWindowVO.java,v 1.4 2006/07/30 00:58:04 jjanke Exp $
 */
public class GridWindowVO implements Serializable
{
	/**
	 * 
	 */
	private static final long serialVersionUID = 6884332743173214735L;
	
	private static final CLogger log = CLogger.getCLogger(GridWindowVO.class);

	/**	Window Cache		*/
	private static CCache<Integer,GridWindowVO>	s_windowsvo
		= new CCache<Integer,GridWindowVO>(I_AD_Window.Table_Name, I_AD_Window.Table_Name+"|GridWindowVO", 10);
	
	/**
	 * 
	 * @param AD_Window_ID
	 * @param windowNo
	 * @return {@link GridWindowVO}
	 */
	public static GridWindowVO get(int AD_Window_ID, int windowNo)
	{
		return get(AD_Window_ID, windowNo, -1);
	}
	
	/**
	 * 
	 * @param AD_Window_ID
	 * @param windowNo
	 * @param AD_Menu_ID
	 * @return {@link GridWindowVO}
	 */
	public static GridWindowVO get(int AD_Window_ID, int windowNo, int AD_Menu_ID) 
	{
		GridWindowVO mWindowVO = s_windowsvo.get(AD_Window_ID);
		if (mWindowVO != null)
		{
			mWindowVO = mWindowVO.clone(windowNo);
			if (log.isLoggable(Level.INFO)) log.info("Cached=" + mWindowVO);
		}
		if (mWindowVO == null)
		{
			if (log.isLoggable(Level.CONFIG)) log.config("create local");
			mWindowVO = GridWindowVO.create (Env.getCtx(), windowNo, AD_Window_ID, AD_Menu_ID);
			if (mWindowVO != null) 
			{
				s_windowsvo.put(AD_Window_ID, mWindowVO);
			}
		}
		return mWindowVO;
	}
	
	/**
	 *  Create Window Value Object
	 *  @param WindowNo window no for ctx
	 *  @param AD_Window_ID window id
	 *  @return MWindowVO
	 */
	public static GridWindowVO create (int WindowNo, int AD_Window_ID)
	{
		return create(Env.getCtx(), WindowNo, AD_Window_ID);
	}
	
	/**
	 *  Create Window Value Object
	 *  @param ctx context
	 *  @param WindowNo window no for ctx
	 *  @param AD_Window_ID window id
	 *  @return MWindowVO
	 */
	public static GridWindowVO create (Properties ctx, int WindowNo, int AD_Window_ID)
	{
		return create (ctx, WindowNo, AD_Window_ID, 0);
	}   //  create

	/**
	 *  Create Window Value Object
	 *
	 *  @param ctx context
	 *  @param WindowNo window no for ctx
	 *  @param AD_Window_ID window id
	 *  @param AD_Menu_ID menu id
	 *  @return MWindowVO
	 */
	public static GridWindowVO create (Properties ctx, int WindowNo, int AD_Window_ID, int AD_Menu_ID)
	{
		CLogger.get().config("#" + WindowNo
			+ " - AD_Window_ID=" + AD_Window_ID + "; AD_Menu_ID=" + AD_Menu_ID);
		GridWindowVO vo = new GridWindowVO (ctx, WindowNo);
		vo.AD_Window_ID = AD_Window_ID;

		//  Get Window_ID if required	- (used by HTML UI)
		if (vo.AD_Window_ID == 0 && AD_Menu_ID != 0)
		{
			String sql = "SELECT AD_Window_ID, IsSOTrx, IsReadOnly FROM AD_Menu "
				+ "WHERE AD_Menu_ID=? AND Action='W'";
			PreparedStatement pstmt = null;
			ResultSet rs = null;
			try
			{
				pstmt = DB.prepareStatement(sql, null);
				pstmt.setInt(1, AD_Menu_ID);
				rs = pstmt.executeQuery();
				if (rs.next())
				{
					vo.AD_Window_ID = rs.getInt(1);
					String IsSOTrx = rs.getString(2);
					Env.setContext(ctx, WindowNo, "IsSOTrx", (IsSOTrx != null && IsSOTrx.equals("Y")));
					//
					String IsReadOnly = rs.getString(3);
					if (IsReadOnly != null && IsReadOnly.equals("Y"))
						vo.IsReadWrite = "Y";
					else
						vo.IsReadWrite = "N";
				}
			}
			catch (SQLException e)
			{
				CLogger.get().log(Level.SEVERE, "Menu", e);
				return null;
			}
			finally
			{
				DB.close(rs, pstmt);
				rs = null; pstmt = null;
			}
			CLogger.get().config("AD_Window_ID=" + vo.AD_Window_ID);
		}

		//  --  Get Window

		MWindow window = MWindow.get(AD_Window_ID);
		boolean base = Env.isBaseLanguage(vo.ctx, "AD_Window");
		if (window != null)
		{
			vo.Name = base ? window.getName() : window.get_Translation(MWindow.COLUMNNAME_Name); 
			vo.Description = base ? window.getDescription() : window.get_Translation(MWindow.COLUMNNAME_Description);
			if (vo.Description == null)
				vo.Description = "";
			vo.Help = base ? window.getHelp() : window.get_Translation(MWindow.COLUMNNAME_Help);
			if (vo.Help == null)
				vo.Help = "";
			vo.WindowType = window.getWindowType();
			//
			vo.AD_Color_ID = window.getAD_Color_ID();
			vo.AD_Image_ID = window.getAD_Image_ID();
			//vo.IsReadWrite = rs.getString(7);
			//
			vo.WinHeight = window.getWinHeight();
			vo.WinWidth = window.getWinWidth();
			//
			vo.IsSOTrx = window.isSOTrx();
			vo.AD_Window_UU = window.getAD_Window_UU();
		}
		else
		{
			vo = null;
		}
		
		// Ensure ASP exceptions
		MRole role = MRole.getDefault(ctx, false);
		final Boolean windowAccess = vo!=null ? role.getWindowAccess(vo.AD_Window_ID) : null;
		if (vo != null && windowAccess == null)
			vo = null;		//	Not found
		if (vo != null && windowAccess != null)
			vo.IsReadWrite = (windowAccess.booleanValue() ? "Y" : "N");
		if (vo == null)
		{
			CLogger.get().log(Level.SEVERE, "No Window - AD_Window_ID=" + AD_Window_ID
				+ ", AD_Role_ID=" + role);
			CLogger.get().saveError("AccessTableNoView", "(Not found)");
			return null;
		}
		//	Read Write
		if (vo.IsReadWrite == null)
		{
			CLogger.get().saveError("AccessTableNoView", "(found)");
			return null;
		}

		// FR IDEMPIERE-177
		// User Customization
		MUserDefWin userDef = MUserDefWin.getBestMatch(ctx, AD_Window_ID);
		if (userDef != null)
		{
			if (userDef.getName() != null)
				vo.Name = userDef.getName();
			if (userDef.getDescription() != null)
				vo.Description = userDef.getDescription();
			if (userDef.getHelp() != null)
				vo.Help = userDef.getHelp();
		}

		//  Create Tabs
		createTabs (vo);
		if (vo.Tabs == null || vo.Tabs.size() == 0)
			return null;

		return vo;
	}   //  create

	/**
	 *  Create Window Tabs
	 *  @param mWindowVO Window Value Object
	 *  @return true if tabs were created
	 */
	private static boolean createTabs (GridWindowVO mWindowVO)
	{
		mWindowVO.Tabs = new ArrayList<GridTabVO>();

		String sql = GridTabVO.getSQL(mWindowVO.ctx);
		int TabNo = 0;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		try
		{
			//	create statement
			pstmt = DB.prepareStatement(sql, null);
			pstmt.setInt(1, mWindowVO.AD_Window_ID);
			rs = pstmt.executeQuery();
			boolean firstTab = true;
			while (rs.next())
			{
				if (mWindowVO.AD_Table_ID == 0)
					mWindowVO.AD_Table_ID = rs.getInt("AD_Table_ID");
				//  Create TabVO
				GridTabVO mTabVO = GridTabVO.create(mWindowVO, TabNo, rs,
					mWindowVO.WindowType.equals(WINDOWTYPE_QUERY),  //  isRO
					mWindowVO.WindowType.equals(WINDOWTYPE_TRX));   //  onlyCurrentRows
				if (mTabVO == null && firstTab)
					break;		//	don't continue if first tab is null
				if (mTabVO != null)
				{
					if (!mTabVO.IsReadOnly && "N".equals(mWindowVO.IsReadWrite))
						mTabVO.IsReadOnly = true;
					mWindowVO.Tabs.add(mTabVO);
					TabNo++;        //  must be same as mWindow.getTab(x)
					firstTab = false;
				}
			}
		}
		catch (SQLException e)
		{
			CLogger.get().log(Level.SEVERE, "createTabs", e);
			return false;
		}
		finally
		{
			DB.close(rs, pstmt);
			rs = null; pstmt = null;
		}

		//  No Tabs
		if (TabNo == 0 || mWindowVO.Tabs.size() == 0)
		{
			CLogger.get().log(Level.SEVERE, "No Tabs - AD_Window_ID=" 
				+ mWindowVO.AD_Window_ID + " - " + sql);
			return false;
		}

		//	Put base table of window in ctx (for VDocAction)
		Env.setContext(mWindowVO.ctx, mWindowVO.WindowNo, "BaseTable_ID", mWindowVO.AD_Table_ID);
		return true;
	}   //  createTabs

	
	/**************************************************************************
	 *  Private Constructor
	 *  @param Ctx context
	 *  @param windowNo window no
	 */
	private GridWindowVO (Properties Ctx, int windowNo)
	{
		ctx = Ctx;
		WindowNo = windowNo;
	}   //  MWindowVO

	/** Properties      */
	public Properties   ctx;
	/** Window Number	*/
	public int 		    WindowNo;

	/** Window				*/
	public	int			AD_Window_ID = 0;
	/** Window UUID			*/
	public String		AD_Window_UU = "";
	/** Name				*/
	public	String		Name = "";
	/** Desription			*/
	public	String		Description = "";
	/** Help				*/
	public	String		Help = "";
	/** Window Type			*/
	public	String		WindowType = "";
	/** Image				*/
	public int          AD_Image_ID = 0;
	/** Color				*/
	public int          AD_Color_ID = 0;
	/** Read Write			*/
	public String		IsReadWrite = null;
	/** Window Width		*/
	public int			WinWidth = 0;
	/** Window Height		*/
	public int			WinHeight = 0;
	/** Sales Order Trx		*/
	public boolean		IsSOTrx = false;

	/** Tabs contains MTabVO elements   */
	public ArrayList<GridTabVO>	Tabs = null;
	/** Base Table		*/
	public int 			AD_Table_ID = 0;

	/** Qyery				*/
	public static final String	WINDOWTYPE_QUERY = "Q";
	/** Transaction			*/
	public static final String	WINDOWTYPE_TRX = "T";
	/** Maintenance			*/
	public static final String	WINDOWTYPE_MMAINTAIN = "M";

	/**
	 *  Set Context including contained elements
	 *  @param newCtx context
	 */
	public void setCtx (Properties newCtx)
	{
		ctx = newCtx;
		for (int i = 0; i < Tabs.size() ; i++)
		{
			GridTabVO tab = (GridTabVO)Tabs.get(i);
			tab.setCtx(newCtx);
		}
	}   //  setCtx

	/**
	 * 	Clone
	 * 	@param windowNo no
	 *	@return WindowVO
	 */
	public GridWindowVO clone (int windowNo)
	{
		GridWindowVO clone = null;
		try
		{
			clone = new GridWindowVO(ctx, windowNo);
			clone.AD_Window_ID = AD_Window_ID;
			clone.AD_Window_UU = AD_Window_UU;
			clone.Name = Name;
			clone.Description = Description;
			clone.Help = Help;
			clone.WindowType = WindowType;
			clone.AD_Image_ID = AD_Image_ID;
			clone.AD_Color_ID = AD_Color_ID;
			clone.IsReadWrite = IsReadWrite;
			clone.WinWidth = WinWidth;
			clone.WinHeight = WinHeight;
			clone.IsSOTrx = IsSOTrx;
			Env.setContext(ctx, windowNo, "IsSOTrx", clone.IsSOTrx);
			clone.AD_Table_ID = AD_Table_ID;
			Env.setContext(ctx, windowNo, "BaseTable_ID", clone.AD_Table_ID);
			//
			clone.Tabs = new ArrayList<GridTabVO>();
			for (int i = 0; i < Tabs.size(); i++)
			{
				GridTabVO tab = Tabs.get(i);
				GridTabVO cloneTab = tab.clone(clone.ctx, windowNo);
				if (cloneTab == null)
					return null;
				clone.Tabs.add(cloneTab);
			}
		}
		catch (Exception e)
		{
			clone = null;
		}
		return clone;
	}	//	clone

}   //  MWindowVO

