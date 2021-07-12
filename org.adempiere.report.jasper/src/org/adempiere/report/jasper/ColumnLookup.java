/***********************************************************************
 * This file is part of iDempiere ERP Open Source                      *
 * http://www.idempiere.org                                            *
 *                                                                     *
 * Copyright (C) Contributors                                          *
 *                                                                     *
 * This program is free software; you can redistribute it and/or       *
 * modify it under the terms of the GNU General Public License         *
 * as published by the Free Software Foundation; either version 2      *
 * of the License, or (at your option) any later version.              *
 *                                                                     *
 * This program is distributed in the hope that it will be useful,     *
 * but WITHOUT ANY WARRANTY; without even the implied warranty of      *
 * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE. See the        *
 * GNU General Public License for more details.                        *
 *                                                                     *
 * You should have received a copy of the GNU General Public License   *
 * along with this program; if not, write to the Free Software         *
 * Foundation, Inc., 51 Franklin Street, Fifth Floor, Boston,          *
 * MA 02110-1301, USA.                                                 *
 *                                                                     *
 * Contributors:                                                       *
 * - hengsin                         								   *
 **********************************************************************/
package org.adempiere.report.jasper;

import java.awt.image.BufferedImage;
import java.math.BigDecimal;
import java.util.function.BiFunction;

import org.adempiere.apps.graph.ChartBuilder;
import org.compiere.model.MAccount;
import org.compiere.model.MAttributeSetInstance;
import org.compiere.model.MChart;
import org.compiere.model.MColumn;
import org.compiere.model.MImage;
import org.compiere.model.MLocation;
import org.compiere.model.MLocator;
import org.compiere.model.MLookup;
import org.compiere.model.MLookupFactory;
import org.compiere.model.MLookupInfo;
import org.compiere.model.MTable;
import org.compiere.util.DisplayType;
import org.compiere.util.Env;
import org.compiere.util.Language;
import org.compiere.util.Msg;
import org.compiere.util.Util;
import org.jfree.chart.ChartRenderingInfo;
import org.jfree.chart.JFreeChart;

/**
 * @author hengsin
 *
 */
public class ColumnLookup implements BiFunction<String, Object, Object> {

	private Language language;

	/**
	 * @param language
	 */
	public ColumnLookup(Language language) {
		this.language = language;
	}

	@Override
	public Object apply(String t, Object key) {
		if (!Util.isEmpty(t, true) && key != null) {
			String[] parts = t.split("[.]");
			if (parts.length == 2) {
				String tableName = parts[0];
				String columnName = parts[1];
				MTable table = MTable.get(Env.getCtx(), tableName);
				if (table != null) {
					MColumn column = table.getColumn(columnName);
					if (column != null) {
						if (DisplayType.isList(column.getAD_Reference_ID())) {
							MLookupInfo linfo = MLookupFactory.getLookup_List(language, column.getAD_Reference_Value_ID());
							MLookup lookup = new MLookup(linfo, -1);
							return lookup.getDisplay(key);
						} else if (DisplayType.isLookup(column.getAD_Reference_ID()) && (key instanceof Number)) {
							return getLookupDisplay(column, (Number) key);
						} else if ((column.getAD_Reference_ID()==DisplayType.ChosenMultipleSelectionList 
								|| column.getAD_Reference_ID()==DisplayType.ChosenMultipleSelectionSearch
								|| column.getAD_Reference_ID()==DisplayType.ChosenMultipleSelectionTable) && (key instanceof String)) {
							return getMultiLookupDisplay(column, (String) key);
						} else if (DisplayType.Location == column.getAD_Reference_ID() && (key instanceof Number)) {
							return getLocation((Number) key);									
						} else if (DisplayType.Image == column.getAD_Reference_ID() && (key instanceof Number)) {
							return getImage(((Number)key).intValue());
						} else if (DisplayType.YesNo == column.getAD_Reference_ID() && (key instanceof String)) {
							String value = (String) key;
							return getYesNoText(value);
						} else if (DisplayType.Account == column.getAD_Reference_ID() && (key instanceof Number)) {
							return getAccountCombination((Number) key);
						} else if (DisplayType.Locator == column.getAD_Reference_ID() && (key instanceof Number)) {
							return getLocator((Number) key);
						} else if (DisplayType.PAttribute == column.getAD_Reference_ID() && (key instanceof Number)) {
							return getAttributeSetInstance((Number) key);
						}
					}
				}
			} else if (t.equalsIgnoreCase("location") && (key instanceof Number)) {
				return getLocation((Number) key);
			} else if (t.equalsIgnoreCase("account") && (key instanceof Number)) {
				return getAccountCombination((Number) key);
			} else if (t.equalsIgnoreCase("locator") && (key instanceof Number)) {
				return getLocator((Number) key);
			} else if (t.equalsIgnoreCase("asi") && (key instanceof Number)) {
				return getAttributeSetInstance((Number) key);
			} else if (t.equalsIgnoreCase("AmtInWords")) {
				if (key instanceof String) {
					return Msg.getAmtInWords(language, (String) key);
				} else if (key instanceof BigDecimal) {
					String s = DisplayType.getNumberFormat(DisplayType.Amount, language).format((BigDecimal)key);
					return Msg.getAmtInWords(language, s);
				}
			} else if (t.equalsIgnoreCase("Image") && (key instanceof Number)) {
				return getImage(((Number)key).intValue());				
			} else if (t.equalsIgnoreCase("YesNo") && (key instanceof String)) {
				return getYesNoText((String) key);
			} else if (t.toLowerCase().startsWith("chart/") && (key instanceof Number)) {
				parts = t.split("[/]");
				if (parts.length == 3) {
					int width = 0;
					int height = 0;
					try {
						width = Integer.parseInt(parts[1]);
						height = Integer.parseInt(parts[1]);
					} catch (Exception e) {}
					if (width > 0 && height > 0) {
						return getChartImage(((Number)key).intValue(), width, height);
					}
				}
				return null;
			}
		}
		return "";
	}

	private Object getAttributeSetInstance(Number key) {
		MAttributeSetInstance asi = new MAttributeSetInstance (Env.getCtx(), key.intValue(), null);
		if (asi.getM_AttributeSetInstance_ID() > 0)
			return asi.getDescription();
		else
			return "";
	}

	private Object getLocator(Number key) {
		MLocator locator = MLocator.get(key.intValue());
		return locator != null ? locator.toString() : "";
	}

	private Object getAccountCombination(Number key) {
		MAccount account = MAccount.get(key.intValue());
		return account != null ? account.getCombination() : "";
	}

	private Object getLocation(Number key) {
		MLocation loc = MLocation.get(key.intValue());
		return loc.toStringCR();
	}

	private Object getChartImage(int id, int width, int height) {
		MChart mc = new MChart(Env.getCtx(), id, null);
		if (mc.get_ID() == id) {
			ChartBuilder chartBuilder = new ChartBuilder(mc);
			JFreeChart chart = chartBuilder.createChart();
			chart.getPlot().setForegroundAlpha(0.8f);
			ChartRenderingInfo info = new ChartRenderingInfo();
			BufferedImage bi = chart.createBufferedImage(width, height,
					BufferedImage.TRANSLUCENT, info);
			return bi;
		}
		return null;
	}

	private Object getYesNoText(String value) {
		if (value.equals("Y")) {
			return Msg.getMsg(language, "Yes");
		} else if (value.equals("N")) {
			return Msg.getMsg(language, "No");
		} else {
			return "";
		}
	}

	private Object getImage(int key) {
		MImage image = MImage.get(key);
		return image != null ? image.getImage() : null;
	}

	private Object getMultiLookupDisplay(MColumn column, String key) {
		MLookupInfo mli = MLookupFactory.getLookupInfo(Env.getCtx(), -1, column.getAD_Column_ID(), column.getAD_Reference_ID(), language, column.getColumnName(), 
				column.getAD_Reference_Value_ID(), false, "");

		MLookup lookup = new MLookup(mli, -1);
		return lookup.getDisplay(key);
	}

	private String getLookupDisplay(MColumn column, Number key) {
		MLookupInfo mli = MLookupFactory.getLookupInfo(Env.getCtx(), -1, column.getAD_Column_ID(), column.getAD_Reference_ID(), language, column.getColumnName(), 
				column.getAD_Reference_Value_ID(), false, "");

		MLookup lookup = new MLookup(mli, -1);
		return lookup.getDisplay(key);
	}

}
