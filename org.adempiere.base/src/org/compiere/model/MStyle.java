/**
 * 
 */
package org.compiere.model;

import java.sql.ResultSet;
import java.util.List;
import java.util.Properties;

import org.compiere.util.CCache;
import org.compiere.util.Env;

/**
 * @author hengsin
 *
 */
public class MStyle extends X_AD_Style {

	/**
	 * 
	 */
	private static final long serialVersionUID = -5183438249097292583L;

	/**	Cache					*/
	private static  CCache<Integer,MStyle> s_cache = new CCache<Integer,MStyle>(Table_Name, 30, 60);
	private X_AD_StyleLine[] m_lines = null;
	
	public MStyle(Properties ctx, int AD_Style_ID, String trxName) {
		super(ctx, AD_Style_ID, trxName);
	}

	public MStyle(Properties ctx, ResultSet rs, String trxName) {
		super(ctx, rs, trxName);
	}

	public static MStyle get (Properties ctx, int AD_Style_ID)
	{
		Integer key = new Integer(AD_Style_ID);
		MStyle retValue = (MStyle)s_cache.get(key);
		if (retValue == null)
		{
			retValue = new MStyle (ctx, AD_Style_ID, null);
			s_cache.put(key, retValue);
		}
		return retValue;
	}	//	get
	
	public X_AD_StyleLine[] getStyleLines() {
		if (m_lines == null) {
			Query query = new Query(Env.getCtx(), I_AD_StyleLine.Table_Name, "AD_Style_ID=?", null);
			List<X_AD_StyleLine> lines = query.setParameters(getAD_Style_ID()).setOnlyActiveRecords(true).setOrderBy("Line").list();
			m_lines = lines.toArray(new X_AD_StyleLine[0]);
		}
		return m_lines;
	}
}
