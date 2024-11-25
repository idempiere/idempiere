/**
 * 
 */
package org.compiere.model;

import java.sql.ResultSet;
import java.util.Arrays;
import java.util.List;
import java.util.Properties;

import org.compiere.util.Env;
import org.compiere.util.Evaluatee;
import org.compiere.util.Evaluator;
import org.compiere.util.Util;
import org.idempiere.cache.ImmutableIntPOCache;
import org.idempiere.cache.ImmutablePOSupport;

/**
 * CSS Style model
 * @author hengsin
 */
public class MStyle extends X_AD_Style implements ImmutablePOSupport {
	/**
	 * generated serial id
	 */
	private static final long serialVersionUID = 5409686715292148171L;
	/**	Cache					*/
	private static  ImmutableIntPOCache<Integer,MStyle> s_cache = new ImmutableIntPOCache<Integer,MStyle>(Table_Name, 30, 60);
	private MStyleLine[] m_lines = null;
	
    public static final String SCLASS_PREFIX = "@sclass=";
    public static final String ZCLASS_PREFIX = "@zclass=";

    /**
     * UUID based Constructor
     * @param ctx  Context
     * @param AD_Style_UU  UUID key
     * @param trxName Transaction
     */
    public MStyle(Properties ctx, String AD_Style_UU, String trxName) {
        super(ctx, AD_Style_UU, trxName);
    }

    /**
     * @param ctx
     * @param AD_Style_ID
     * @param trxName
     */
	public MStyle(Properties ctx, int AD_Style_ID, String trxName) {
		super(ctx, AD_Style_ID, trxName);
	}

	/**
	 * @param ctx
	 * @param rs
	 * @param trxName
	 */
	public MStyle(Properties ctx, ResultSet rs, String trxName) {
		super(ctx, rs, trxName);
	}

	/**
	 * Copy constructor
	 * @param copy
	 */
	public MStyle(MStyle copy) {
		this(Env.getCtx(), copy);
	}

	/**
	 * Copy constructor
	 * @param ctx
	 * @param copy
	 */
	public MStyle(Properties ctx, MStyle copy) {
		this(ctx, copy, (String) null);
	}

	/**
	 * Copy constructor
	 * @param ctx
	 * @param copy
	 * @param trxName
	 */
	public MStyle(Properties ctx, MStyle copy, String trxName) {
		this(ctx, 0, trxName);
		copyPO(copy);
		this.m_lines = copy.m_lines != null ? Arrays.stream(copy.m_lines).map(e -> {return new MStyleLine(ctx, e, trxName);}).toArray(MStyleLine[]::new) : null;
	}
	
	/**
	 * Get MStyle from cache (immutable)
	 * @param AD_Style_ID
	 * @return MStyle
	 */
	public static MStyle get (int AD_Style_ID)
	{
		return get(Env.getCtx(), AD_Style_ID);
	}
	
	/**
	 * Get MStyle from cache (immutable)
	 * @param ctx
	 * @param AD_Style_ID
	 * @return MStyle
	 */
	public static MStyle get (Properties ctx, int AD_Style_ID)
	{
		Integer key = Integer.valueOf(AD_Style_ID);
		MStyle retValue = s_cache.get(ctx, key, e -> new MStyle(ctx, e));
		if (retValue == null)
		{
			retValue = new MStyle (ctx, AD_Style_ID, (String)null);
			if (retValue.get_ID() == AD_Style_ID)
			{
				s_cache.put(key, retValue, e -> new MStyle(Env.getCtx(), e));
				return retValue;
			}
			return null;
		}
		return retValue;
	}	//	get
	
	/**
	 * Get lines
	 * @return array of style line
	 */
	public MStyleLine[] getStyleLines() {
		if (m_lines == null) {
			Query query = new Query(Env.getCtx(), I_AD_StyleLine.Table_Name, "AD_Style_ID=? AND InlineStyle IS NOT NULL", null);
			List<MStyleLine> lines = query.setParameters(getAD_Style_ID()).setOnlyActiveRecords(true).setOrderBy("Line").list();
			if (lines.size() > 0 && is_Immutable()) {
				for (MStyleLine line : lines)
					line.markImmutable();
			}
			m_lines = lines.toArray(new MStyleLine[0]);
		}
		return m_lines;
	}
	
	/**
	 * Build inline CSS style text from lines
	 * @param defaultTheme
	 * @param evaluatee
	 * @return CSS style text
	 */
	public String buildStyle(String defaultTheme, Evaluatee evaluatee) {
		return buildStyle(defaultTheme, evaluatee, true);
	}
	
	/**
	 * Build CSS style text from lines
	 * @param defaultTheme
	 * @param evaluatee evaluatee for display logic
	 * @param inline true for inline (for style="..." use), false for css (for class="..." use) 
	 * @return CSS style text
	 */
	public String buildStyle(String defaultTheme, Evaluatee evaluatee, boolean inline) {
		X_AD_StyleLine[] lines = getStyleLines();
		StringBuilder styleBuilder = new StringBuilder();
		for (X_AD_StyleLine line : lines) 
		{
			String styleText = line.getInlineStyle().trim();
			if (!checkStyleType(styleText, inline))
				continue;
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
			if (inline) {
				if (styleBuilder.length() > 0 && !(styleBuilder.charAt(styleBuilder.length()-1)==';'))
					styleBuilder.append("; ");
			} else if (styleBuilder.length() > 0) {
				styleBuilder.append("\n");
			}
			styleBuilder.append(styleText);
		}
		return styleBuilder.toString();
	}

	/**
	 * Check whether the style text is consistent with the inline usage flag
	 * @param styleText
	 * @param inline true for inline (for style="..." use), false for css (for class="..." use)
	 * @return true if style text and inline usage flag agree
	 */
	private boolean checkStyleType(String styleText, boolean inline) {
		boolean cssType = styleText.indexOf("{") > 0 && styleText.endsWith("}");		
		return (inline && !cssType) || (!inline && cssType);
	}

	@Override
	public MStyle markImmutable() {
		if (is_Immutable())
			return this;
		
		makeImmutable();
		if (m_lines != null && m_lines.length > 0)
			Arrays.stream(m_lines).forEach(e -> e.markImmutable());
		return this;
	}
		
}
