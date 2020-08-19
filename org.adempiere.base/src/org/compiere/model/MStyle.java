/**
 * 
 */
package org.compiere.model;

import java.sql.ResultSet;
import java.util.Arrays;
import java.util.List;
import java.util.Properties;

import org.compiere.util.CCache;
import org.compiere.util.Env;
import org.compiere.util.Evaluatee;
import org.compiere.util.Evaluator;
import org.compiere.util.Util;

/**
 * @author hengsin
 *
 */
public class MStyle extends X_AD_Style {
	/**
	 * 
	 */
	private static final long serialVersionUID = 712675285511854305L;

	/**	Cache					*/
	private static  CCache<Integer,MStyle> s_cache = new CCache<Integer,MStyle>(Table_Name, 30, 60);
	private MStyleLine[] m_lines = null;
	
    public static final String SCLASS_PREFIX = "@sclass=";
    public static final String ZCLASS_PREFIX = "@zclass=";

	public MStyle(Properties ctx, int AD_Style_ID, String trxName) {
		super(ctx, AD_Style_ID, trxName);
	}

	public MStyle(Properties ctx, ResultSet rs, String trxName) {
		super(ctx, rs, trxName);
	}

	/**
	 * 
	 * @param copy
	 */
	public MStyle(MStyle copy) {
		this(Env.getCtx(), copy);
	}

	/**
	 * 
	 * @param ctx
	 * @param copy
	 */
	public MStyle(Properties ctx, MStyle copy) {
		this(ctx, copy, (String) null);
	}

	/**
	 * 
	 * @param ctx
	 * @param copy
	 * @param trxName
	 */
	public MStyle(Properties ctx, MStyle copy, String trxName) {
		this(ctx, 0, trxName);
		copyPO(copy);
		this.m_lines = copy.m_lines != null ? Arrays.stream(copy.m_lines).map(e -> {return new MStyleLine(ctx, e, trxName);}).toArray(MStyleLine[]::new) : null;
	}
	
	public static MStyle get (Properties ctx, int AD_Style_ID)
	{
		Integer key = Integer.valueOf(AD_Style_ID);
		MStyle retValue = (MStyle)s_cache.get(key);
		if (retValue == null)
		{
			retValue = new MStyle (ctx, AD_Style_ID, (String)null);
			if (retValue.get_ID() == AD_Style_ID)
			{
				s_cache.put(key, new MStyle(Env.getCtx(), retValue));
				return retValue;
			}
			return null;
		}
		return new MStyle(ctx, retValue);
	}	//	get
	
	public MStyleLine[] getStyleLines() {
		if (m_lines == null) {
			Query query = new Query(Env.getCtx(), I_AD_StyleLine.Table_Name, "AD_Style_ID=? AND InlineStyle IS NOT NULL", null);
			List<X_AD_StyleLine> lines = query.setParameters(getAD_Style_ID()).setOnlyActiveRecords(true).setOrderBy("Line").list();
			m_lines = lines.toArray(new MStyleLine[0]);
		}
		return m_lines;
	}
	
	public String buildStyle(String defaultTheme, Evaluatee evaluatee) {
		X_AD_StyleLine[] lines = getStyleLines();
		StringBuilder styleBuilder = new StringBuilder();
		for (X_AD_StyleLine line : lines) 
		{
			String inlineStyle = line.getInlineStyle().trim();
			String displayLogic = line.getDisplayLogic();
			String theme = line.getTheme();
			if (!Util.isEmpty(theme)) {
				if (!theme.equals(defaultTheme))
					continue;
			}
			if (!Util.isEmpty(displayLogic))
			{
				if (!Evaluator.evaluateLogic(evaluatee, displayLogic)) 
					continue;
			}
			if (styleBuilder.length() > 0 && !(styleBuilder.charAt(styleBuilder.length()-1)==';'))
				styleBuilder.append("; ");
			styleBuilder.append(inlineStyle);
		}
		return styleBuilder.toString();
	}
}
