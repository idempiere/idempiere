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
 * - Trek Global                         							   *
 **********************************************************************/

package org.idempiere.printformat.editor.ui;

import java.awt.Color;
import java.awt.Font;
import java.awt.FontMetrics;
import java.util.ArrayList;
import java.util.Collections;
import java.util.Comparator;
import java.util.HashMap;
import java.util.LinkedHashMap;
import java.util.List;
import java.util.Map;
import java.util.logging.Level;

import javax.print.attribute.standard.MediaSize;

import org.adempiere.webui.LayoutUtils;
import org.adempiere.webui.adwindow.ADWindowContent;
import org.adempiere.webui.component.Label;
import org.adempiere.webui.component.ListItem;
import org.adempiere.webui.component.Listbox;
import org.adempiere.webui.component.Window;
import org.adempiere.webui.component.ZkCssHelper;
import org.adempiere.webui.editor.WEditor;
import org.adempiere.webui.event.ValueChangeEvent;
import org.adempiere.webui.event.ValueChangeListener;
import org.adempiere.webui.session.SessionManager;
import org.adempiere.webui.util.ZKUpdateUtil;
import org.compiere.model.MColumn;
import org.compiere.model.MTable;
import org.compiere.model.X_AD_PrintFormatItem;
import org.compiere.model.X_AD_PrintPaper;
import org.compiere.print.MPrintColor;
import org.compiere.print.MPrintFont;
import org.compiere.print.MPrintFormat;
import org.compiere.print.MPrintFormatItem;
import org.compiere.print.MPrintPaper;
import org.compiere.print.layout.LocationElement;
import org.compiere.print.layout.StringElement;
import org.compiere.util.CLogger;
import org.compiere.util.DB;
import org.compiere.util.DisplayType;
import org.compiere.util.Env;
import org.compiere.util.Evaluatee;
import org.compiere.util.Evaluator;
import org.compiere.util.Msg;
import org.compiere.util.Util;
import org.idempiere.printformat.editor.FieldPosition;
import org.idempiere.printformat.editor.PrintAreaBean;
import org.idempiere.printformat.editor.action.EditorAction;
import org.zkoss.zk.ui.Component;
import org.zkoss.zk.ui.event.DropEvent;
import org.zkoss.zk.ui.event.Event;
import org.zkoss.zk.ui.event.EventListener;
import org.zkoss.zk.ui.event.Events;
import org.zkoss.zk.ui.event.KeyEvent;
import org.zkoss.zk.ui.util.Clients;
import org.zkoss.zul.Absolutechildren;
import org.zkoss.zul.Div;
import org.zkoss.zul.Window.Mode;

/**
 * @author milap
 * @author hengsin
 *
 */
public class WPrintFormatEditor implements ValueChangeListener {

	private static final String PRINTFORMAT_ITEM_ATTR = "printFormatItem";
	private static final String PT = "pt";
	private static final String selectedStyle = "curser:pointer; border:solid 1px #0000FF;";
	private static final String normalStyle = "curser:pointer; border:solid 1px #CCC;";

	private static final int AREA_HEADER = 0;
	private static final int AREA_CONTENT = 1;	
	private static final int AREA_FOOTER = 2;

	protected float paperHeight = 11.5f;
	protected float paperWidth = 8;

	private float leftRef = 0;
	private float rightRef = 0;
	private float topRef = 0;
	private float bottomRef = 0;

	private WPrintFormatEditorForm printFormatForm = null;
	
	private HashMap<MPrintFormatItem, Absolutechildren> printFormatItemMap = new HashMap<MPrintFormatItem, Absolutechildren>();
	private LinkedHashMap<MPrintFormatItem, FieldPosition> fieldPosMap = new LinkedHashMap<MPrintFormatItem, FieldPosition>();
	private Map<MPrintFormatItem, String> testValueMap = new HashMap<MPrintFormatItem, String>();

	private Div prevSelectedItem = null;
	private String prevStyle = "";

	// The grid components
	private ArrayList<MPrintFormatItem> formatItems;

	private HashMap<String, WEditor> editorMap = new HashMap<String, WEditor>();
	private ArrayList<String> currentEditors = new ArrayList<String>();

	protected MPrintFormat m_printFormat = null;

	private float lineHeight;
	private int AD_PrintFormat_ID;
	private ADWindowContent adWindowContent;

	/** Logger */
	private static final CLogger log = CLogger.getCLogger(WPrintFormatEditor.class);

	/**
	 * 
	 * @param AD_PrintFormat_ID
	 * @param adWindowContent
	 */
	public WPrintFormatEditor(int AD_PrintFormat_ID, ADWindowContent adWindowContent) {
		this.AD_PrintFormat_ID = AD_PrintFormat_ID;
		this.adWindowContent = adWindowContent;
		printFormatForm = new WPrintFormatEditorForm(this);
		LayoutUtils.addSclass("report-editor-form", printFormatForm);

	}

	/**
	 * show editor window
	 */
	public void showEditorWindow() {
		try {
			m_printFormat = new MPrintFormat(Env.getCtx(), AD_PrintFormat_ID, null);
			loadPrintPaper();
			printFormatForm.init();
			String title = Msg.getMsg(Env.getCtx(), EditorAction.class.getName()+".label", true);
			title = Util.cleanAmp(title);
			printFormatForm.setTitle(title+": "+m_printFormat.getName());
			printFormatForm.setVisible(true);
			printFormatForm.setAttribute(Window.MODE_KEY, Mode.HIGHLIGHTED);
			SessionManager.getAppDesktop().showWindow(printFormatForm);
			initMap();
			initFormatItemListbox();
			updatePreview();
		} catch (Exception ex) {
			log.log(Level.SEVERE, ex.getLocalizedMessage(), ex);
		}
	}
	
	private void loadPrintPaper() {
		int paperID = m_printFormat.getAD_PrintPaper_ID();
		MPrintPaper printPaper = MPrintPaper.get(paperID);

		paperHeight = printPaper.getSizeY().floatValue();
		paperWidth = printPaper.getSizeX().floatValue();
		if (paperHeight > 0 & paperWidth > 0) {
			if (X_AD_PrintPaper.DIMENSIONUNITS_MM.equals(printPaper.getDimensionUnits())) {
				paperHeight = PrintFormatEditorUtil.mmToPointValue(paperHeight);
				paperWidth = PrintFormatEditorUtil.mmToPointValue(paperWidth);
			} else {
				paperHeight = PrintFormatEditorUtil.inchToPointValue(paperHeight);
				paperWidth = PrintFormatEditorUtil.inchToPointValue(paperWidth);
			}
		} else {
			MediaSize mediaSize = printPaper.getMediaSize();
			float mediaHeight=0;
			float mediaWidth=0;
			if (X_AD_PrintPaper.DIMENSIONUNITS_MM.equals(printPaper.getDimensionUnits())) {
				mediaHeight = mediaSize.getY(MediaSize.MM);
				mediaWidth = mediaSize.getX(MediaSize.MM);
				paperHeight = PrintFormatEditorUtil.mmToPointValue(mediaHeight);
				paperWidth = PrintFormatEditorUtil.mmToPointValue(mediaWidth);
			} else {
				mediaHeight = mediaSize.getY(MediaSize.INCH);
				mediaWidth = mediaSize.getX(MediaSize.INCH);
				paperHeight = PrintFormatEditorUtil.inchToPointValue(mediaHeight);
				paperWidth = PrintFormatEditorUtil.inchToPointValue(mediaWidth);
			}
		}
		
		if (printPaper.isLandscape()) {
			float t = paperHeight;
			paperHeight = paperWidth;
			paperWidth = t;
		}

		leftRef = printPaper.getMarginLeft();
		rightRef = printPaper.getMarginRight();
		topRef = printPaper.getMarginTop();
		bottomRef = printPaper.getMarginBottom();
	}

	private float getActualPaperWidth() {
		return paperWidth - leftRef - rightRef;
	}

	private float getActualPaperHeight() {
		return paperHeight - topRef - bottomRef;
	}

	private void initPrintArea(PrintAreaBean[] pArea) {

		float x = 0;
		float y = 0;

		if (!(m_printFormat.isForm() && !(m_printFormat.isStandardHeaderFooter() || m_printFormat.getAD_PrintHeaderFooter_ID() > 0))) {
			pArea[AREA_CONTENT] = new PrintAreaBean(AREA_CONTENT, x, y);
		} else {

			float height = 0;
			height = m_printFormat.getHeaderMargin();
			pArea[AREA_HEADER] = new PrintAreaBean(AREA_HEADER, x, y);

			y += height;
			height = getActualPaperHeight() - m_printFormat.getHeaderMargin()
					- m_printFormat.getFooterMargin();
			pArea[AREA_CONTENT] = new PrintAreaBean(AREA_CONTENT, x, y);

			y += height;
			pArea[AREA_FOOTER] = new PrintAreaBean(AREA_FOOTER, x, y);
		}
	}

	private void initMap() {

		editorMap.put(MPrintFormatItem.COLUMNNAME_IsSuppressNull, printFormatForm.supressNull);
		editorMap.put(MPrintFormatItem.COLUMNNAME_IsSetNLPosition,
				printFormatForm.setNLPosition);
		editorMap.put(MPrintFormatItem.COLUMNNAME_IsRelativePosition,
				printFormatForm.relativePosition);
		editorMap.put(MPrintFormatItem.COLUMNNAME_IsFilledRectangle, printFormatForm.fillShape);
		editorMap.put(MPrintFormatItem.COLUMNNAME_IsNextPage, printFormatForm.nextPage);
		editorMap.put(MPrintFormatItem.COLUMNNAME_IsNextLine, printFormatForm.nextLine);
		editorMap.put(MPrintFormatItem.COLUMNNAME_IsHeightOneLine, printFormatForm.oneLineOnly);
		editorMap.put(MPrintFormatItem.COLUMNNAME_ImageIsAttached,
				printFormatForm.imageAttached);
		editorMap.put(MPrintFormatItem.COLUMNNAME_IsImageField, printFormatForm.imageField);
		editorMap.put(MPrintFormatItem.COLUMNNAME_IsFixedWidth, printFormatForm.fixedWidth);
		editorMap.put(MPrintFormatItem.COLUMNNAME_YPosition, printFormatForm.yPosition);
		editorMap.put(MPrintFormatItem.COLUMNNAME_XPosition, printFormatForm.xPosition);
		editorMap.put(MPrintFormatItem.COLUMNNAME_YSpace, printFormatForm.ySpace);
		editorMap.put(MPrintFormatItem.COLUMNNAME_XSpace, printFormatForm.xSpace);
		editorMap.put(MPrintFormatItem.COLUMNNAME_MaxHeight, printFormatForm.maxHeight);
		editorMap.put(MPrintFormatItem.COLUMNNAME_MaxWidth, printFormatForm.maxWidth);
		editorMap.put(MPrintFormatItem.COLUMNNAME_ArcDiameter, printFormatForm.arcDiameter);
		editorMap.put(MPrintFormatItem.COLUMNNAME_ShapeType, printFormatForm.shapeType);
		editorMap.put(MPrintFormatItem.COLUMNNAME_AD_PrintFormatChild_ID,
				printFormatForm.includedPrintFormat);
		editorMap.put(MPrintFormatItem.COLUMNNAME_AD_PrintColor_ID, printFormatForm.printColor);
		editorMap.put(MPrintFormatItem.COLUMNNAME_LineWidth, printFormatForm.lineWidth);
		editorMap.put(MPrintFormatItem.COLUMNNAME_LineAlignmentType,
				printFormatForm.lineAlignment);
		editorMap.put(MPrintFormatItem.COLUMNNAME_ImageURL, printFormatForm.imageUrl);
		editorMap.put(MPrintFormatItem.COLUMNNAME_AD_PrintFont_ID, printFormatForm.printFont);
		editorMap.put(MPrintFormatItem.COLUMNNAME_FieldAlignmentType,
				printFormatForm.fieldAlignment);
		editorMap.put(MPrintFormatItem.COLUMNNAME_Name, printFormatForm.editorName);
		editorMap.put(MPrintFormatItem.COLUMNNAME_SeqNo, printFormatForm.editorSeqNo);
		editorMap.put(MPrintFormatItem.COLUMNNAME_PrintAreaType, printFormatForm.printAreaType);

		editorMap.put(MPrintFormatItem.COLUMNNAME_PrintName, printFormatForm.editorPrintName);
		editorMap.put(MPrintFormatItem.COLUMNNAME_BelowColumn, printFormatForm.editorBelowColumn);
		editorMap.put(MPrintFormatItem.COLUMNNAME_FormatPattern, printFormatForm.editorFormatPattern);
		editorMap.put(MPrintFormatItem.COLUMNNAME_Script, printFormatForm.editorScript);
		editorMap.put(MPrintFormatItem.COLUMNNAME_IsOrderBy, printFormatForm.editorIsOrderBy);
		editorMap.put(MPrintFormatItem.COLUMNNAME_SortNo, printFormatForm.editorSortNo);
		editorMap.put(MPrintFormatItem.COLUMNNAME_IsGroupBy, printFormatForm.editorIsGroupBy);
		editorMap.put(MPrintFormatItem.COLUMNNAME_IsAveraged, printFormatForm.editorIsAveraged);
		editorMap.put(MPrintFormatItem.COLUMNNAME_IsCounted, printFormatForm.editorIsCounted);
		editorMap.put(MPrintFormatItem.COLUMNNAME_IsDeviationCalc, printFormatForm.editorIsDeviationCalc);
		editorMap.put(MPrintFormatItem.COLUMNNAME_IsMaxCalc, printFormatForm.editorIsMaxCalc);
		editorMap.put(MPrintFormatItem.COLUMNNAME_IsMinCalc, printFormatForm.editorIsMinCalc);
		editorMap.put(MPrintFormatItem.COLUMNNAME_IsSummarized, printFormatForm.editorIsSummarized);
		editorMap.put(MPrintFormatItem.COLUMNNAME_IsVarianceCalc, printFormatForm.editorIsVarianceCalc);
		editorMap.put(MPrintFormatItem.COLUMNNAME_IsRunningTotal, printFormatForm.editorIsRunningTotal);
		editorMap.put(MPrintFormatItem.COLUMNNAME_RunningTotalLines, printFormatForm.editorRunningTotalLines);
		editorMap.put(MPrintFormatItem.COLUMNNAME_IsPrintInstanceAttributes, printFormatForm.editorIsPrintInstanceAttributes);
	}

	private void validateProperties(final MPrintFormatItem pfItem) {
		Evaluatee evaluatee = new Evaluatee() {
			@Override
			public String get_ValueAsString(String variableName) {

				String retString = null;
				//ref column
				String foreignColumn = "";
				int f = variableName.indexOf('.');
				if (f > 0) {
					foreignColumn = variableName.substring(f+1, variableName.length());
					variableName = variableName.substring(0, f);
				}
				
				if (pfItem.get_ColumnIndex(variableName) >= 0 ) {					
					if (pfItem.get_Value(variableName) instanceof Boolean) {
						retString = pfItem.get_Value(variableName).equals(true) ? "Y"
								: "N";
					} else {
						retString = pfItem.get_ValueAsString(variableName);
					}
				}

				//check . foreign reference
				if (!Util.isEmpty(retString) && !Util.isEmpty(foreignColumn) && variableName.endsWith("_ID")) {
					int id = 0;
					try {
						id = Integer.parseInt(retString);
					} catch (Exception e){}
					if (id > 0) {
						String foreignTable = variableName.substring(0, variableName.length()-3);
						MTable table = MTable.get(Env.getCtx(), foreignTable);
						if (table != null) {
							retString = DB.getSQLValueString(null,
									"SELECT " + foreignColumn + " FROM " + foreignTable + " WHERE " 
											+ foreignTable + "_ID = ?", id);
						}
					}
				}
				
				if (Util.isEmpty(retString)) {
					MPrintFormat format = MPrintFormat.get(Env.getCtx(),
							pfItem.getAD_PrintFormat_ID(), false);
					if (format.get_ColumnIndex(variableName) >= 0) {
						if (format.get_Value(variableName) instanceof Boolean) {
							retString = format.get_Value(variableName).equals(true) ? "Y"
									: "N";
						} else {
							retString = format.get_ValueAsString(variableName);
						}
					}
				}
				return retString;
			}
		};

		for (Map.Entry<String, WEditor> entry : editorMap.entrySet()) {

			String sql = "Select displaylogic from AD_Field Where AD_Column_ID = ? ";
			String logic = DB.getSQLValueString(
					null,
					sql,
					MColumn.getColumn_ID(MPrintFormatItem.Table_Name,
							entry.getKey()));

			boolean retValue = true;
			if (logic != null && logic.trim().length() > 0) {
				retValue = Evaluator.evaluateLogic(evaluatee, logic);
			}

			if (retValue) {
				entry.getValue().getComponent().getParent().setVisible(true);
				if (!currentEditors.contains(entry.getKey())) {
					currentEditors.add(entry.getKey());
				}
			} else {
				entry.getValue().getComponent().getParent().setVisible(false);
				if (currentEditors.contains(entry.getKey())) {
					currentEditors.remove(entry.getKey());
				}
			}
		}
	}

	private void updatePreview() {
		if (m_printFormat.isForm())
			updateFormPreview();
		else
			updateTablePreview();
	}
	
	private void updateFormPreview() {

		PrintAreaBean[] printArea = new PrintAreaBean[3];
		initPrintArea(printArea);
		float[] prevWidth = { 0, 0, 0 };
		float[] prevHeight = { 0, 0, 0 };

		float nlPosition = 0;

		printFormatForm.printLayout.getChildren().clear();

		printFormatItemMap.clear();
		fieldPosMap.clear();

		Absolutechildren area = new Absolutechildren();
		area.setX(PrintFormatEditorUtil.pointToPixel(leftRef));
		area.setY(PrintFormatEditorUtil.pointToPixel(topRef));

		Div printableArea = new Div();
		PrintFormatEditorUtil.addCSSStyle(printableArea,
				"border: 1px black solid; background-color: white;", false);
		ZKUpdateUtil.setWidth(printableArea, getActualPaperWidth() + PT);
		ZKUpdateUtil.setHeight(printableArea, getActualPaperHeight() + PT);
		printableArea.setTooltiptext(printableArea.getWidth() + " x " + printableArea.getHeight());

		area.appendChild(printableArea);
		printFormatForm.printLayout.appendChild(area);

		lineHeight = new FontMetrics(MPrintFont.get(
				m_printFormat.getAD_PrintFont_ID()).getFont()) {
			private static final long serialVersionUID = 7467192921216454967L;
		}.getHeight() * 1.25f;
		
		for (MPrintFormatItem pfItem : formatItems) {

			if (!pfItem.isActive() || pfItem.getSeqNo() <= 0
					|| pfItem.isPrinted() == false)
				continue;
			
			int currentPrintArea = AREA_CONTENT;
			float x = 0;
			float y = 0;
			float width = 0;
			float height = 0;

			if (pfItem.getPrintAreaType().equals(
					MPrintFormatItem.PRINTAREATYPE_Header)) {
				currentPrintArea = AREA_HEADER;
			} else if (pfItem.getPrintAreaType().equals(
					MPrintFormatItem.PRINTAREATYPE_Footer)) {
				currentPrintArea = AREA_FOOTER;
			}

			Absolutechildren child = new Absolutechildren();

			x = printArea[currentPrintArea].getCurrentX();
			y = printArea[currentPrintArea].getCurrentY();

			if (pfItem.isRelativePosition() && pfItem.isSetNLPosition()) {
				nlPosition = 0;
			}

			if (pfItem.isNextLine()) {
				y = y + (prevHeight[currentPrintArea] > 0 ? prevHeight[currentPrintArea] : lineHeight) + 2;
				x = nlPosition;
			} else {
				x = x + prevWidth[currentPrintArea] + 2;
			}

			if (pfItem.isRelativePosition()) {
				x += pfItem.getXSpace();
				y += pfItem.getYSpace();
			} else {
				x = printArea[currentPrintArea].getPointX()
						+ pfItem.getXPosition();
				y = printArea[currentPrintArea].getPointY()
						+ pfItem.getYPosition();
				if (pfItem.isSetNLPosition())
					nlPosition = x;
			}
			
			Div fieldDiv = new Div();
			fieldDiv.setAttribute(PRINTFORMAT_ITEM_ATTR, pfItem);
			String printText = pfItem.getPrintName();

			if (pfItem.getPrintFormatType().equals(
					MPrintFormatItem.PRINTFORMATTYPE_Field)
					|| pfItem.getPrintFormatType().equals(
							MPrintFormatItem.PRINTFORMATTYPE_Text)
					|| pfItem.getPrintFormatType().equals(
							MPrintFormatItem.PRINTFORMATTYPE_Image)) {
				String printString = printText != null ? printText : "";
				String displayData = testValueMap.get(pfItem);
				
				if (pfItem.isTypeText())
				{
					if (displayData != null && displayData.length() > 0)
						printString = displayData;
					else if (printString.length() == 0)						
						printString = ("{"+pfItem.getName()+"}");			
				}
				else
					printString += displayData != null ? displayData : ("{"+pfItem.getName()+"}");
				
				if (pfItem.getAD_Column().getAD_Reference_ID() == DisplayType.Location) {
					LocationElement element = new LocationElement(Env.getCtx(), 109, getFont(pfItem), Color.black, 
							pfItem.isHeightOneLine(), "", "", Env.getAD_Language(Env.getCtx()));
					width = pfItem.getMaxWidth() > 0 ? pfItem.getMaxWidth() : element.getWidth();
					height = pfItem.getMaxHeight() > 0 ? pfItem.getMaxHeight() : element.getHeight();
				} else if (pfItem.getPrintFormatType().equals(MPrintFormatItem.PRINTFORMATTYPE_Image)) {
					width = pfItem.getMaxWidth();
					height = pfItem.getMaxHeight();
				} else {
					StringElement element = new StringElement(printString, getFont(pfItem), null, null, false);
					width = pfItem.getMaxWidth() > 0 ? pfItem.getMaxWidth() : element.getWidth();
					height = pfItem.getMaxHeight() > 0 ? pfItem.getMaxHeight() : element.getHeight();
				}

				Label text = new Label(printString);
				text.setTooltiptext(printString);
				PrintFormatEditorUtil.addCSSStyle(text,
						getCssColorStyle(pfItem), false);				
				if (pfItem.isHeightOneLine())
					PrintFormatEditorUtil.addCSSStyle(text, 
							"white-space: nowrap;", true);				
				PrintFormatEditorUtil.addCSSStyle(fieldDiv,
						normalStyle, true);				
				PrintFormatEditorUtil.addCSSStyle(fieldDiv, 
						"overflow: hidden;", true);
				
				fieldDiv.appendChild(text);
				if (pfItem.getMaxWidth() == 0 && pfItem.isFieldAlignBlock()) {
					width = getActualPaperWidth();
					x = 0;
					y = y + (prevHeight[currentPrintArea] > 0 ? prevHeight[currentPrintArea] : lineHeight) + 2;
				}				
			} else if (pfItem.getPrintFormatType().equals(
					MPrintFormatItem.PRINTFORMATTYPE_Rectangle)) {

				if (pfItem.getShapeType().equals(
						MPrintFormatItem.SHAPETYPE_NormalRectangle)) {
					PrintFormatEditorUtil.addCSSStyle(fieldDiv,
							"border: 1pt solid black;", false);
				} else if (pfItem.getShapeType().equals(
						MPrintFormatItem.SHAPETYPE_RoundRectangle)) {
					PrintFormatEditorUtil.addCSSStyle(fieldDiv,
							"border-radius: " + pfItem.getArcDiameter() / 2
									+ "pt;border: 1pt solid black;", false);
				}
				width = pfItem.getMaxWidth();
				height = pfItem.getMaxHeight();
				if (pfItem.isFilledRectangle()) {
					MPrintColor itemColor = getPrintColor(pfItem);
					if (itemColor != null && itemColor.getAD_PrintColor_ID() > 0) {
						PrintFormatEditorUtil.addCSSStyle(fieldDiv, "background-color: #" +
								ZkCssHelper.createHexColorString(itemColor.getColor()) + ";"
								, true);
					}
				}
			} else if (pfItem.getPrintFormatType().equals(
					MPrintFormatItem.PRINTFORMATTYPE_PrintFormat)) {
				Label text = new Label(pfItem.getName()
						+ "(Included print format)");
				PrintFormatEditorUtil.addCSSStyle(text, getCssColorStyle(pfItem), false);
				fieldDiv.appendChild(text);
				height = lineHeight;
				ZKUpdateUtil.setHeight(fieldDiv, height + PT);
				fieldDiv.setStyle("border: 2px solid black;");
				width = getActualPaperWidth() - 4;
				x = x+2;

			} else if (pfItem.getPrintFormatType().equals(
					MPrintFormatItem.PRINTFORMATTYPE_Line)) {
				width = pfItem.getMaxWidth();
				height = pfItem.getLineWidth();
				MPrintColor itemColor = getPrintColor(pfItem);
				PrintFormatEditorUtil.addCSSStyle(fieldDiv, "background-color: #" +
						ZkCssHelper.createHexColorString(itemColor.getColor())+";", true);
			}

			ZKUpdateUtil.setHeight(fieldDiv, height + PT);
			if (width > 0)
				ZKUpdateUtil.setWidth(fieldDiv, width + PT);
			
			if (pfItem.isTypePrintFormat()) {
				height = height + 2;
			} 
			
			if ((x+width) > getActualPaperWidth()) {
				if (pfItem.getMaxWidth() == 0) {
					width = getActualPaperWidth() - x;
					ZKUpdateUtil.setWidth(fieldDiv, width + PT);
					if (!pfItem.isHeightOneLine()) {
						height = height * 2;
						ZKUpdateUtil.setHeight(fieldDiv, height + PT);
					}
					PrintFormatEditorUtil.addCSSStyle(fieldDiv, "overflow: hidden;", true);
				}
			}
			
			if (height != lineHeight
					&& !pfItem.getPrintFormatType().equals(
							MPrintFormatItem.PRINTFORMATTYPE_Rectangle))
				prevHeight[currentPrintArea] = height;
			else
				prevHeight[currentPrintArea] = 0;

			if (!pfItem.getPrintFormatType().equals(
					MPrintFormatItem.PRINTFORMATTYPE_Rectangle))
				prevWidth[currentPrintArea] = width;
			else
				prevWidth[currentPrintArea] = 0;
		
			printArea[currentPrintArea].setCurrentX(x);
			printArea[currentPrintArea].setCurrentY(y);

			child.setX(PrintFormatEditorUtil.pointToPixel(x + leftRef));
			child.setY(PrintFormatEditorUtil.pointToPixel(y + topRef));
			child.setDroppable("true");
			child.addEventListener(Events.ON_DROP, (DropEvent e) -> onDrop(e));

			child.appendChild(fieldDiv);
			child.setDraggable("true");
			
			printFormatForm.printLayout.appendChild(child);

			PrintFormatEditorUtil.addCSSStyle(fieldDiv, "text-align:"
					+ PrintFormatEditorUtil.getAlignmentStyleCSS(pfItem) + ";",
					true);
			printFormatItemMap.put(pfItem, child);

			if (printFormatForm.printedItemListbox.getSelectedItem().getValue().equals(pfItem)) {
				prevStyle = fieldDiv.getStyle();
				prevSelectedItem = fieldDiv;
				PrintFormatEditorUtil
						.addCSSStyle(fieldDiv, selectedStyle, true);
			}
			fieldDiv.addEventListener(Events.ON_CLICK, e -> onFieldDivClick(e));

			FieldPosition pos = new FieldPosition();
			pos.setX(x);
			pos.setY(y);
			pos.setPrintFormatItem(pfItem);

			fieldPosMap.put(pfItem, pos);			
		}
		
		if (!m_printFormat.isStandardHeaderFooter() && m_printFormat.getAD_PrintHeaderFooter_ID() == 0) {
			Absolutechildren line = new Absolutechildren();
			ZKUpdateUtil.setHeight(line, "0px");
			line.setId("headerMargin");
			line.setStyle("border: 1px solid #666;cursor: move;");
			line.setY(PrintFormatEditorUtil.pointToPixel(m_printFormat.getHeaderMargin()+topRef));
			line.setX(PrintFormatEditorUtil.pointToPixel(leftRef)-2);
			ZKUpdateUtil.setWidth(line, getActualPaperWidth()+4+PT);
			line.setDraggable("true");
			printFormatForm.printLayout.appendChild(line);
			
			line = new Absolutechildren();
			ZKUpdateUtil.setHeight(line, "0px");
			line.setStyle("border: 1px solid #666;cursor: move;");
			line.setY(PrintFormatEditorUtil.pointToPixel(paperHeight - bottomRef - m_printFormat.getFooterMargin()));
			line.setX(PrintFormatEditorUtil.pointToPixel(leftRef)-2);
			ZKUpdateUtil.setWidth(line, getActualPaperWidth()+4+PT);
			line.setDraggable("true");
			line.setId("footerMargin");
			printFormatForm.printLayout.appendChild(line);
		}
	}

	private void updateTablePreview() {
		PrintAreaBean[] printArea = new PrintAreaBean[3];
		initPrintArea(printArea);
		float[] prevWidth = { 0, 0, 0 };
		float[] prevHeight = { 0, 0, 0 };

		printFormatForm.printLayout.getChildren().clear();

		printFormatItemMap.clear();
		fieldPosMap.clear();

		Absolutechildren area = new Absolutechildren();
		area.setX(PrintFormatEditorUtil.pointToPixel(leftRef));
		area.setY(PrintFormatEditorUtil.pointToPixel(topRef));

		Div printableArea = new Div();
		PrintFormatEditorUtil.addCSSStyle(printableArea,
				"border: 1px black solid; background-color: white;", false);
		ZKUpdateUtil.setWidth(printableArea, getActualPaperWidth() + PT);
		ZKUpdateUtil.setHeight(printableArea, getActualPaperHeight() + PT);
		printableArea.setTooltiptext(printableArea.getWidth() + " x " + printableArea.getHeight());

		area.appendChild(printableArea);
		printFormatForm.printLayout.appendChild(area);

		lineHeight = new FontMetrics(MPrintFont.get(
				m_printFormat.getAD_PrintFont_ID()).getFont()) {
			private static final long serialVersionUID = 7467192921216454967L;
		}.getHeight() * 1.25f;
		
		List<float[]> columns = new ArrayList<>();
		for (MPrintFormatItem pfItem : formatItems) {

			if (!pfItem.isActive() || pfItem.getSeqNo() <= 0
					|| pfItem.isPrinted() == false)
				continue;
			
			int currentPrintArea = AREA_CONTENT;
			float x = 0;
			float y = 0;
			float width = 0;
			float height = 0;

			Absolutechildren child = new Absolutechildren();

			x = printArea[currentPrintArea].getCurrentX();
			y = printArea[currentPrintArea].getCurrentY();

			float[] belowColumn = null;
			if (pfItem.isNextLine() && pfItem.getBelowColumn() > 0 && pfItem.getBelowColumn() <= columns.size()) {
				belowColumn = columns.get(pfItem.getBelowColumn()-1);
			} else {
				x = x + prevWidth[currentPrintArea] + 2;
			}
			
			Div fieldDiv = new Div();
			fieldDiv.setAttribute(PRINTFORMAT_ITEM_ATTR, pfItem);
			String printText = pfItem.getPrintName();

			if (pfItem.getPrintFormatType().equals(
					MPrintFormatItem.PRINTFORMATTYPE_Field)
					|| pfItem.getPrintFormatType().equals(
							MPrintFormatItem.PRINTFORMATTYPE_Text)
					|| pfItem.getPrintFormatType().equals(
							MPrintFormatItem.PRINTFORMATTYPE_Image)) {
				String printString = (printText != null ? printText + "\n" : "");
				String displayData = testValueMap.get(pfItem);
				
				if (pfItem.isTypeText())
				{
					if (displayData != null && displayData.length() > 0)
						printString = displayData;
					else if (printString.length() == 0)						
						printString = ("{"+pfItem.getName()+"}");			
				}
				else
				{
					if (belowColumn == null)
						printString += displayData != null ? displayData : ("{"+pfItem.getName()+"}");
					else
						printString = displayData != null ? displayData : ("{"+pfItem.getName()+"}");
				}
				
				if (pfItem.getAD_Column().getAD_Reference_ID() == DisplayType.Location) {
					LocationElement element = new LocationElement(Env.getCtx(), 109, getFont(pfItem), Color.black, 
							pfItem.isHeightOneLine(), "", "", Env.getAD_Language(Env.getCtx()));
					width = pfItem.getMaxWidth() > 0 ? pfItem.getMaxWidth() : element.getWidth();
					height = pfItem.getMaxHeight() > 0 ? pfItem.getMaxHeight() : element.getHeight();
				} else if (pfItem.getPrintFormatType().equals(MPrintFormatItem.PRINTFORMATTYPE_Image)) {
					width = pfItem.getMaxWidth();
					height = pfItem.getMaxHeight();
				} else {
					StringElement element = new StringElement(printString, getFont(pfItem), null, null, false);
					width = pfItem.getMaxWidth() > 0 ? pfItem.getMaxWidth() : element.getWidth();
					height = element.getHeight() + 4; 
				}

				Label text = new Label(printString);
				text.setMultiline(true);
				text.setTooltiptext(printString);
				PrintFormatEditorUtil.addCSSStyle(text,
						getCssColorStyle(pfItem), false);				
				if (pfItem.isHeightOneLine())
					PrintFormatEditorUtil.addCSSStyle(text, 
							"white-space: nowrap;", true);				
				PrintFormatEditorUtil.addCSSStyle(fieldDiv,
						normalStyle, true);				
				PrintFormatEditorUtil.addCSSStyle(fieldDiv, 
						"overflow: hidden;", true);
				
				fieldDiv.appendChild(text);
			} else if (pfItem.getPrintFormatType().equals(
					MPrintFormatItem.PRINTFORMATTYPE_Rectangle)) {

				if (pfItem.getShapeType().equals(
						MPrintFormatItem.SHAPETYPE_NormalRectangle)) {
					PrintFormatEditorUtil.addCSSStyle(fieldDiv,
							"border: 1pt solid black;", false);
				} else if (pfItem.getShapeType().equals(
						MPrintFormatItem.SHAPETYPE_RoundRectangle)) {
					PrintFormatEditorUtil.addCSSStyle(fieldDiv,
							"border-radius: " + pfItem.getArcDiameter() / 2
									+ "pt;border: 1pt solid black;", false);
				}
				width = pfItem.getMaxWidth();
				height = pfItem.getMaxHeight();
				if (pfItem.isFilledRectangle()) {
					MPrintColor itemColor = getPrintColor(pfItem);
					if (itemColor != null && itemColor.getAD_PrintColor_ID() > 0) {
						PrintFormatEditorUtil.addCSSStyle(fieldDiv, "background-color: #" +
								ZkCssHelper.createHexColorString(itemColor.getColor()) + ";"
								, true);
					}
				}
			} else if (pfItem.getPrintFormatType().equals(
					MPrintFormatItem.PRINTFORMATTYPE_PrintFormat)) {
				Label text = new Label(pfItem.getName()
						+ "(Included print format)");
				PrintFormatEditorUtil.addCSSStyle(text, getCssColorStyle(pfItem), false);
				fieldDiv.appendChild(text);
				height = lineHeight;
				ZKUpdateUtil.setHeight(fieldDiv, height + PT);
				fieldDiv.setStyle("border: 2px solid black;");
				width = getActualPaperWidth() - 4;
				x = x+2;

			} else if (pfItem.getPrintFormatType().equals(
					MPrintFormatItem.PRINTFORMATTYPE_Line)) {
				width = pfItem.getMaxWidth();
				height = pfItem.getLineWidth();
				MPrintColor itemColor = getPrintColor(pfItem);
				PrintFormatEditorUtil.addCSSStyle(fieldDiv, "background-color: #" +
						ZkCssHelper.createHexColorString(itemColor.getColor())+";", true);
			}

			if (belowColumn != null) {
				x = belowColumn[0];
				y = belowColumn[1] +  belowColumn[3] + 2;
				width = belowColumn[2];
				belowColumn[1] = y;
				belowColumn[3] = height;
			}
			
			ZKUpdateUtil.setHeight(fieldDiv, height + PT);
			if (width > 0)
				ZKUpdateUtil.setWidth(fieldDiv, width + PT);
			
			if (pfItem.isTypePrintFormat()) {
				height = height + 2;
			} 
			
			if (belowColumn == null) {
				if (height != lineHeight
						&& !pfItem.getPrintFormatType().equals(
								MPrintFormatItem.PRINTFORMATTYPE_Rectangle))
					prevHeight[currentPrintArea] = height;
				else
					prevHeight[currentPrintArea] = 0;
	
				if (!pfItem.getPrintFormatType().equals(
						MPrintFormatItem.PRINTFORMATTYPE_Rectangle))
					prevWidth[currentPrintArea] = width;
				else
					prevWidth[currentPrintArea] = 0;
	
				printArea[currentPrintArea].setCurrentX(x);
				printArea[currentPrintArea].setCurrentY(y);
			}

			child.setX(PrintFormatEditorUtil.pointToPixel(x + leftRef));
			child.setY(PrintFormatEditorUtil.pointToPixel(y + topRef));
			child.setDroppable("true");
			child.addEventListener(Events.ON_DROP, (DropEvent e) -> onDrop(e));

			child.appendChild(fieldDiv);
			child.setDraggable("true");
			
			printFormatForm.printLayout.appendChild(child);

			PrintFormatEditorUtil.addCSSStyle(fieldDiv, "text-align:"
					+ PrintFormatEditorUtil.getAlignmentStyleCSS(pfItem) + ";",
					true);
			printFormatItemMap.put(pfItem, child);

			if (printFormatForm.printedItemListbox.getSelectedItem().getValue().equals(pfItem)) {
				prevStyle = fieldDiv.getStyle();
				prevSelectedItem = fieldDiv;
				PrintFormatEditorUtil
						.addCSSStyle(fieldDiv, selectedStyle, true);
			}
			fieldDiv.addEventListener(Events.ON_CLICK, e -> onFieldDivClick(e));

			FieldPosition pos = new FieldPosition();
			pos.setX(x);
			pos.setY(y);
			pos.setPrintFormatItem(pfItem);

			fieldPosMap.put(pfItem, pos);
			
			if (belowColumn == null)
				columns.add(new float[] {x, y, width, height});
		}
		
		if (m_printFormat.isStandardHeaderFooter()) {
			Absolutechildren line = new Absolutechildren();
			ZKUpdateUtil.setHeight(line, "0px");
			line.setId("headerMargin");
			line.setStyle("border: 1px solid #666;cursor: move;");
			line.setY(PrintFormatEditorUtil.pointToPixel(m_printFormat.getHeaderMargin()+topRef));
			line.setX(PrintFormatEditorUtil.pointToPixel(leftRef)-2);
			ZKUpdateUtil.setWidth(line, getActualPaperWidth()+4+PT);
			line.setDraggable("true");
			printFormatForm.printLayout.appendChild(line);
			
			line = new Absolutechildren();
			ZKUpdateUtil.setHeight(line, "0px");
			line.setStyle("border: 1px solid #666;cursor: move;");
			line.setY(PrintFormatEditorUtil.pointToPixel(paperHeight - bottomRef - m_printFormat.getFooterMargin()));
			line.setX(PrintFormatEditorUtil.pointToPixel(leftRef)-2);
			ZKUpdateUtil.setWidth(line, getActualPaperWidth()+4+PT);
			line.setDraggable("true");
			line.setId("footerMargin");
			printFormatForm.printLayout.appendChild(line);
		}
	}
	
	private Font getFont(MPrintFormatItem pfItem) {
		Font font = null;
		if (pfItem.getAD_PrintFont_ID() > 0) {
			font = MPrintFont.get(pfItem.getAD_PrintFont_ID()).getFont();
		} else if (m_printFormat.getAD_PrintFont_ID() > 0) {
			font = MPrintFont.get(m_printFormat.getAD_PrintFont_ID()).getFont();
		}
		return font;
	}

	private void setItemSelected(MPrintFormatItem pfItem) {
		if (pfItem != null) {
			validateProperties(pfItem);
			setProperties(pfItem);
			Div fieldDiv = ((Div) printFormatItemMap.get(pfItem).getFirstChild());
			printFormatForm.printedItemListbox.setSelectedIndex(formatItems.indexOf(pfItem));
			if (prevSelectedItem != null) {
				PrintFormatEditorUtil.addCSSStyle(prevSelectedItem, prevStyle,
						false);
				PrintFormatEditorUtil.addCSSStyle(fieldDiv, "text-align:"
						+ PrintFormatEditorUtil.getAlignmentStyleCSS(pfItem)
						+ ";", true);
			}
			prevStyle = fieldDiv.getStyle();
			prevSelectedItem = fieldDiv;
			PrintFormatEditorUtil.addCSSStyle(fieldDiv, selectedStyle, false);
			PrintFormatEditorUtil.addCSSStyle(fieldDiv, "text-align:"
					+ PrintFormatEditorUtil.getAlignmentStyleCSS(pfItem) + ";",
					true);
			PrintFormatEditorUtil.addCSSStyle(fieldDiv, "overflow: hidden;", true);
			StringBuilder script = new StringBuilder();
			script.append("var w = zk.Widget.$('#").append(fieldDiv.getUuid()).append("');");
			script.append("if (!(zk(w).isRealScrollIntoView())) w.$n().scrollIntoView();");
			Clients.evalJavaScript(script.toString());
		}
	}

	private String getCssColorStyle(MPrintFormatItem pfItem) {
		String style = "";

		Font font = getFont(pfItem);
		if (font != null) {
			String fontFamily = font.getFamily();
			fontFamily = PrintFormatEditorUtil.getCSSFontFamily(fontFamily);
			if (fontFamily.equalsIgnoreCase("dialog")) {
				fontFamily = "sans-serif";
			}
			style = fontFamily != null ? "font-family:" + fontFamily + ";" : "";
			if (font.isBold()) {
				style = style + "font-weight:bold;";
			}
			if (font.isItalic()) {
				style = style + "font-style:italic;";
			}
			int size = font.getSize();
			style = style + "font-size:" + size + "pt;";
		}

		MPrintColor mPrintColor = getPrintColor(pfItem);
		if (mPrintColor != null && mPrintColor.getAD_PrintColor_ID() > 0) {
			Color color = mPrintColor.getColor();
			if (color != null) {
				style = style + "color: #" + ZkCssHelper.createHexColorString(color) + ";";
			}
		}
		return style;
	}

	private MPrintColor getPrintColor(MPrintFormatItem pfItem) {
		MPrintColor mPrintColor = null;
		if (pfItem.getAD_PrintColor_ID() > 0) {
			mPrintColor = MPrintColor.get(Env.getCtx(),
					pfItem.getAD_PrintColor_ID());
		} else if (m_printFormat.getAD_PrintColor_ID() > 0) {
			mPrintColor = MPrintColor.get(Env.getCtx(),
					m_printFormat.getAD_PrintColor_ID());
		}
		return mPrintColor;
	}

	private void initFormatItemListbox() {

		formatItems = new ArrayList<MPrintFormatItem>();
		MPrintFormatItem[] formatItem = m_printFormat.getAllItems();
		for (MPrintFormatItem pfItem : formatItem) {
			formatItems.add(pfItem);
		}
		updateLists(null);
		resortArrays();

	}

	

	private void setProperties(MPrintFormatItem pfItem) {
		for (String columnName : currentEditors) {

			WEditor editor = editorMap.get(columnName);
			editor.setValue(pfItem.get_Value(columnName));

		}

		printFormatForm.editorTestValue.setValue(testValueMap.get(pfItem));
	}

	

	/**
	 * Dispose
	 */
	public void dispose() {
		SessionManager.getAppDesktop().closeActiveWindow();
	} // dispose

	@Override
	public void valueChange(ValueChangeEvent e) {		
		MPrintFormatItem pfItem = printFormatForm.printedItemListbox.getSelectedItem()
				.getValue();
		if (!"_TestValue_".equals(e.getPropertyName())) {
			pfItem.set_ValueOfColumn(e.getPropertyName(), e.getNewValue());
			validateProperties(pfItem);
		} else {
			testValueMap.put(pfItem, (String)e.getNewValue());
		}
		updatePreview();
	}

	private void onFieldDivClick(Event event) {
		if (event.getTarget() instanceof Div
				&& event.getName().equals(Events.ON_CLICK)
				&& event.getTarget().hasAttribute(PRINTFORMAT_ITEM_ATTR)) {
			Div fieldDiv = (Div) event.getTarget();
			MPrintFormatItem pfItem = (MPrintFormatItem) fieldDiv
					.getAttribute(PRINTFORMAT_ITEM_ATTR);
			setItemSelected(pfItem);
		}
	}

	private void onSelect(Event event) {
		Listbox list = (Listbox) event.getTarget();
		if (list.getSelectedItem() != null) {
			MPrintFormatItem pfItem = list.getSelectedItem().getValue();
			setItemSelected(pfItem);
		}
	}

	protected void onConfirmPanelClick(Event event) {
		if (event.getTarget().getId().equals("Ok")) {
			onOk();
		} else if (event.getTarget().getId().equals("Cancel")) {
			onCancel();
		} else if (event.getTarget().getId().equals("Reset")) {
			onReset();
		}
	}
	
	private void onReset() {
		m_printFormat.load(null);
		initFormatItemListbox();
		updatePreview();
	}

	protected void onCancel() {
		printFormatForm.detach();
	}

	protected void onOk() {
		m_printFormat.saveEx();
		for (MPrintFormatItem item : formatItems) {
			if (!item.isActive())
				continue;
			item.saveEx();
		}
		onCancel();
		adWindowContent.onRefresh();
	}

	protected void onCtrlKey(KeyEvent keyEvent) {
		MPrintFormatItem pfItem = (MPrintFormatItem) prevSelectedItem
				.getAttribute(PRINTFORMAT_ITEM_ATTR);

		int currentX = PrintFormatEditorUtil.getX(pfItem);
		int currentY = PrintFormatEditorUtil.getY(pfItem);

		switch (keyEvent.getKeyCode()) {
		case KeyEvent.LEFT:
			PrintFormatEditorUtil.setX(pfItem, currentX - 1);
			setProperties(pfItem);
			break;

		case KeyEvent.RIGHT:
			PrintFormatEditorUtil.setX(pfItem, currentX + 1);
			setProperties(pfItem);
			break;

		case KeyEvent.UP:
			PrintFormatEditorUtil.setY(pfItem, currentY - 1);
			setProperties(pfItem);
			break;

		case KeyEvent.DOWN:
			PrintFormatEditorUtil.setY(pfItem, currentY + 1);
			setProperties(pfItem);
			break;

		case KeyEvent.DELETE:
			hideItem(pfItem);
		}

		updatePreview();
	}
	
	protected void onDrop(DropEvent de)
	{
		ListItem startItem = null;
		ListItem endItem = null;

		if (de.getDragged() instanceof ListItem) {
			startItem = (ListItem) de.getDragged();
		}
		if (de.getTarget() instanceof ListItem) {
			endItem = (ListItem) de.getTarget();
		}

		if (startItem != null && endItem != null) {
			if (startItem.getListbox() == printFormatForm.printedItemListbox
					&& endItem.getListbox() == printFormatForm.nonPrintedItemListbox) {
				// item moved from visible to invisible
				MPrintFormatItem pfItem = startItem.getValue();
				hideItem(pfItem);
				updateLists(null);
				updatePreview();
				setProperties((MPrintFormatItem) prevSelectedItem
						.getAttribute(PRINTFORMAT_ITEM_ATTR)); // seqno could change
				
			} else if (startItem.getListbox() == printFormatForm.nonPrintedItemListbox
					&& endItem.getListbox() == printFormatForm.printedItemListbox
					&& startItem.getValue() != null) {
				// item moved from invisible to visible
				MPrintFormatItem pfItem = (MPrintFormatItem) startItem
						.getValue();
				MPrintFormatItem pfItemTo = (MPrintFormatItem) endItem
						.getValue();
				pfItem.setSeqNo(pfItemTo.getSeqNo() - 5);
				pfItem.setIsPrinted(true);
				resortArrays();
				setProperties(pfItem); // seqno could change
				updateLists(pfItem);
				updatePreview();
			} else if (startItem.getListbox() == printFormatForm.printedItemListbox
					&& endItem.getListbox() == printFormatForm.printedItemListbox) {
				// item moved from visible to visible - reorder
				MPrintFormatItem pfItem = startItem.getValue();
				MPrintFormatItem pfItem2 = endItem.getValue();
				pfItem.setSeqNo(pfItem2.getSeqNo() - 1);
				resortArrays();
				setProperties(pfItem); // seqno could change
				updateLists(pfItem);
				updatePreview();
			}
		} else if (startItem == null && endItem == null) {
			// Item dragged in preview division
			Absolutechildren child = (Absolutechildren) de.getDragged();
			if ("headerMargin".equals(child.getId())) {
				float ptY = PrintFormatEditorUtil.pixelToPointValue(de.getY());
				m_printFormat.setHeaderMargin(Float.valueOf(ptY - topRef).intValue());
				updatePreview();
				return;
			} else if ("footerMargin".equals(child.getId())) {
				float ptY = PrintFormatEditorUtil.pixelToPointValue(de.getY());
				m_printFormat.setFooterMargin(Float.valueOf(paperHeight - bottomRef - ptY).intValue());
				updatePreview();
				return;
			}
			MPrintFormatItem pfItem = (MPrintFormatItem) child
					.getFirstChild().getAttribute(PRINTFORMAT_ITEM_ATTR);

			Component target = de.getTarget();
			MPrintFormatItem targetItem = target.getFirstChild() != null ?
					(MPrintFormatItem) target.getFirstChild().getAttribute(PRINTFORMAT_ITEM_ATTR) : null;

			float ptY = PrintFormatEditorUtil.pixelToPointValue(de.getY());
			float ptX = PrintFormatEditorUtil.pixelToPointValue(de.getX());
			if (targetItem == null) {
				if (pfItem.isRelativePosition()) {
					FieldPosition fieldpos = fieldPosMap.get(pfItem);
					float diffX = ptX - fieldpos.getX() - leftRef;
					float diffY = ptY - fieldpos.getY() - topRef;
					PrintFormatEditorUtil.setX(pfItem, diffX);
					PrintFormatEditorUtil.setY(pfItem, diffY);
				}
				
				if (m_printFormat.isStandardHeaderFooter() || m_printFormat.getAD_PrintHeaderFooter_ID() > 0) {
					if (!pfItem.isRelativePosition())
						PrintFormatEditorUtil.setY(pfItem, ptY - topRef);					
					pfItem.setPrintAreaType(X_AD_PrintFormatItem.PRINTAREATYPE_Content);
				} else {
					if (ptY < (topRef + m_printFormat.getHeaderMargin())) {
						if (!X_AD_PrintFormatItem.PRINTAREATYPE_Header.equals(pfItem.getPrintAreaType())) {
							pfItem.setPrintAreaType(X_AD_PrintFormatItem.PRINTAREATYPE_Header);
							if (pfItem.isRelativePosition()) {
								pfItem.setIsRelativePosition(false);
							}
						}
						if (!pfItem.isRelativePosition())
							PrintFormatEditorUtil.setY(pfItem, ptY - topRef);							
					} else if (ptY > (paperHeight-bottomRef-m_printFormat.getFooterMargin())) {
						if (!X_AD_PrintFormatItem.PRINTAREATYPE_Footer.equals(pfItem.getPrintAreaType())) {
							pfItem.setPrintAreaType(X_AD_PrintFormatItem.PRINTAREATYPE_Footer);
							if (pfItem.isRelativePosition()) {
								pfItem.setIsRelativePosition(false);
							}
						}
						if (!pfItem.isRelativePosition())
							PrintFormatEditorUtil.setY(pfItem, ptY - (paperHeight-bottomRef-m_printFormat.getFooterMargin()));
					} else {
						if (!X_AD_PrintFormatItem.PRINTAREATYPE_Content.equals(pfItem.getPrintAreaType())) {
							pfItem.setPrintAreaType(X_AD_PrintFormatItem.PRINTAREATYPE_Content);
							if (pfItem.isRelativePosition()) {
								pfItem.setIsRelativePosition(false);
							}
						}
						if (!pfItem.isRelativePosition())
							PrintFormatEditorUtil.setY(pfItem, ptY - topRef - m_printFormat.getHeaderMargin());
					}
				}
					
				if (!pfItem.isRelativePosition())
					PrintFormatEditorUtil.setX(pfItem, ptX - leftRef);
			} else {
				pfItem.setSeqNo(targetItem.getSeqNo()+1);
				pfItem.setIsRelativePosition(true);
				pfItem.setXSpace(0);
				pfItem.setYSpace(0);
				pfItem.setIsPrinted(true);
				pfItem.setPrintAreaType(targetItem.getPrintAreaType());
				resortArrays();					
			}

			setProperties(pfItem);
			updateLists(pfItem);
			updatePreview();
		} else if (startItem != null && endItem == null) {
			Component target = de.getTarget();
			MPrintFormatItem targetItem = target.getFirstChild() != null ?
					(MPrintFormatItem) target.getFirstChild().getAttribute(PRINTFORMAT_ITEM_ATTR) : null;
			// Item moved/dragged from visible/invisible to preview			
			MPrintFormatItem pfItem = startItem.getValue();				
			if (targetItem == null) {
				FieldPosition fieldPos = fieldPosMap.get(pfItem);
				if (fieldPos == null)
					pfItem.setIsRelativePosition(false);
				
				float ptX = PrintFormatEditorUtil.pixelToPointValue(de.getX());
				float ptY = PrintFormatEditorUtil.pixelToPointValue(de.getY());
				if (fieldPos == null || !pfItem.isRelativePosition()) {
					PrintFormatEditorUtil.setX(pfItem, ptX - leftRef);
				} else {
					float diffX = ptX - fieldPos.getX();
					float diffY = ptY - fieldPos.getY();
					PrintFormatEditorUtil.setX(pfItem, diffX);
					PrintFormatEditorUtil.setY(pfItem, diffY);
				}
				if (m_printFormat.isStandardHeaderFooter()) {
					if (fieldPos == null || !pfItem.isRelativePosition()) {
						PrintFormatEditorUtil.setY(pfItem, ptY - topRef);
					}
					pfItem.setPrintAreaType(X_AD_PrintFormatItem.PRINTAREATYPE_Content);
				} else {
					if (ptY < (topRef + m_printFormat.getHeaderMargin())) {
						if (!X_AD_PrintFormatItem.PRINTAREATYPE_Header.equals(pfItem.getPrintAreaType())) {
							pfItem.setPrintAreaType(X_AD_PrintFormatItem.PRINTAREATYPE_Header);
							if (pfItem.isRelativePosition()) {
								pfItem.setIsRelativePosition(false);
								PrintFormatEditorUtil.setX(pfItem, ptX - leftRef);
							}
						}
						if (!pfItem.isRelativePosition()) {
							PrintFormatEditorUtil.setY(pfItem, ptY - topRef);
						}
					} else if (ptY > (paperHeight-bottomRef-m_printFormat.getFooterMargin())) {
						if (!X_AD_PrintFormatItem.PRINTAREATYPE_Footer.equals(pfItem.getPrintAreaType())) {
							pfItem.setPrintAreaType(X_AD_PrintFormatItem.PRINTAREATYPE_Footer);
							if (pfItem.isRelativePosition()) {
								pfItem.setIsRelativePosition(false);
								PrintFormatEditorUtil.setX(pfItem, ptX - leftRef);
							}
						}
						if (!pfItem.isRelativePosition()) {
							PrintFormatEditorUtil.setY(pfItem, ptY - (paperHeight-bottomRef-m_printFormat.getFooterMargin()));
						}
					} else {
						if (!X_AD_PrintFormatItem.PRINTAREATYPE_Content.equals(pfItem.getPrintAreaType())) {
							pfItem.setPrintAreaType(X_AD_PrintFormatItem.PRINTAREATYPE_Content);
							if (pfItem.isRelativePosition()) {
								pfItem.setIsRelativePosition(false);
								PrintFormatEditorUtil.setX(pfItem, ptX - leftRef);
							}
						}
						if (!pfItem.isRelativePosition()) {
							PrintFormatEditorUtil.setY(pfItem, ptY - topRef - m_printFormat.getHeaderMargin());
						}
					}
				}
				pfItem.setIsPrinted(true);
				if (startItem.getListbox() == printFormatForm.nonPrintedItemListbox)
					pfItem.setSeqNo((printFormatItemMap.size() + 1) * 10 + 5);
				resortArrays();
			} else {
				pfItem.setSeqNo(targetItem.getSeqNo()+1);
				pfItem.setIsRelativePosition(true);
				pfItem.setXSpace(0);
				pfItem.setYSpace(0);
				pfItem.setIsPrinted(true);
				pfItem.setPrintAreaType(targetItem.getPrintAreaType());
				resortArrays();					
			}

			setProperties(pfItem); // seqno could change
			updateLists(pfItem);
			updatePreview();
		} else if (startItem == null && endItem != null) {
			// Item moved/dragged from preview to invisible
			Absolutechildren child = (Absolutechildren) de.getDragged();
			MPrintFormatItem pfItem = (MPrintFormatItem) child
					.getFirstChild().getAttribute(PRINTFORMAT_ITEM_ATTR);
			hideItem(pfItem);
			updatePreview();
			setProperties((MPrintFormatItem) prevSelectedItem
					.getAttribute(PRINTFORMAT_ITEM_ATTR)); // seqno could change
		}

	}

	private void hideItem(MPrintFormatItem pfItem) {
		pfItem.setSeqNo(0);
		pfItem.setIsPrinted(false);
		resortArrays();
		updateLists(null);
	}

	private EventListener<Event> onSelectListner = e -> onSelect(e);
	
	private void updateLists(MPrintFormatItem selectedItem) {
		printFormatForm.printedItemListbox.removeAllItems();
		printFormatForm.nonPrintedItemListbox.removeAllItems();

		printFormatForm.printedItemListbox.removeEventListener(Events.ON_SELECT, onSelectListner);
		printFormatForm.printedItemListbox.addEventListener(Events.ON_SELECT, onSelectListner);

		for (MPrintFormatItem pfItem : formatItems) {
			if (!pfItem.isActive())
				continue;

			ListItem item = new ListItem(pfItem.getName(), pfItem);
			item.setDroppable("true");
			item.setDraggable("true");
			item.addEventListener(Events.ON_DROP, (DropEvent e) -> onDrop(e));

			if (pfItem.isPrinted()) {
				printFormatForm.printedItemListbox.appendChild(item);
				if (selectedItem != null && pfItem == selectedItem) {
					item.setSelected(true);
				}
			} else {
				printFormatForm.nonPrintedItemListbox.appendChild(item);
				if (selectedItem != null && pfItem == selectedItem) {
					item.setSelected(true);
				}
			}
		}
		if (printFormatForm.nonPrintedItemListbox.getItems().isEmpty()) {
			ListItem item = new ListItem("...", null);
			item.setDroppable("true");
			printFormatForm.nonPrintedItemListbox.appendChild(item);
			item.addEventListener(Events.ON_DROP, (DropEvent e) -> onDrop(e));
		}

		if (printFormatForm.printedItemListbox.getItems().isEmpty()) {
			ListItem item = new ListItem("...", null);
			item.setDroppable("true");
			printFormatForm.printedItemListbox.appendChild(item);
			item.addEventListener(Events.ON_DROP, (DropEvent e) -> onDrop(e));
		}
		if (selectedItem == null)
			printFormatForm.printedItemListbox.setSelectedIndex(0);

		if (printFormatForm.printedItemListbox.getSelectedItem().getValue() != null) {
			validateProperties((MPrintFormatItem) (printFormatForm.printedItemListbox
					.getSelectedItem().getValue()));
			setProperties((MPrintFormatItem) (printFormatForm.printedItemListbox
					.getSelectedItem().getValue()));
		}
	}

	private void resortArrays() {
		Collections.sort(formatItems, new Comparator<MPrintFormatItem>() {
			@Override
			public int compare(MPrintFormatItem pfItem1,
					MPrintFormatItem pfItem2) {
				String compare1 = String.format("%s%10d%s",
						(!pfItem1.isPrinted() ? "1" : "0"),
						(pfItem1.isPrinted() ? pfItem1.getSeqNo() : 0),
						pfItem1.getName());
				String compare2 = String.format("%s%10d%s",
						(!pfItem2.isPrinted() ? "1" : "0"),
						(pfItem2.isPrinted() ? pfItem2.getSeqNo() : 0),
						pfItem2.getName());
				return compare1.compareTo(compare2);
			}
		});

		int seq = 10;
		for (MPrintFormatItem pfItem : formatItems) {
			if (!pfItem.isActive())
				continue;
			if (pfItem.isPrinted()) {
				pfItem.setSeqNo(seq);
				seq = seq + 10;
			} else {
				pfItem.setSeqNo(0);
			}
		}
	}
}
