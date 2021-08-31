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

import org.adempiere.webui.LayoutUtils;
import org.adempiere.webui.component.Column;
import org.adempiere.webui.component.ConfirmPanel;
import org.adempiere.webui.component.Grid;
import org.adempiere.webui.component.GridFactory;
import org.adempiere.webui.component.Group;
import org.adempiere.webui.component.Label;
import org.adempiere.webui.component.ListHead;
import org.adempiere.webui.component.ListHeader;
import org.adempiere.webui.component.Listbox;
import org.adempiere.webui.component.Row;
import org.adempiere.webui.component.Rows;
import org.adempiere.webui.component.Window;
import org.adempiere.webui.component.ZkCssHelper;
import org.adempiere.webui.editor.WEditor;
import org.adempiere.webui.editor.WNumberEditor;
import org.adempiere.webui.editor.WStringEditor;
import org.adempiere.webui.editor.WTableDirEditor;
import org.adempiere.webui.editor.WYesNoEditor;
import org.adempiere.webui.util.ZKUpdateUtil;
import org.compiere.model.MColumn;
import org.compiere.model.MLookup;
import org.compiere.model.MLookupFactory;
import org.compiere.print.MPrintFormatItem;
import org.compiere.util.DisplayType;
import org.compiere.util.Env;
import org.compiere.util.Msg;
import org.zkoss.zk.ui.HtmlBasedComponent;
import org.zkoss.zk.ui.event.DropEvent;
import org.zkoss.zk.ui.event.Events;
import org.zkoss.zk.ui.event.KeyEvent;
import org.zkoss.zul.Absolutelayout;
import org.zkoss.zul.Borderlayout;
import org.zkoss.zul.Cell;
import org.zkoss.zul.Center;
import org.zkoss.zul.Columns;
import org.zkoss.zul.Div;
import org.zkoss.zul.East;
import org.zkoss.zul.Separator;
import org.zkoss.zul.South;
import org.zkoss.zul.Vlayout;
import org.zkoss.zul.West;

/**
 * 
 * @author hengsin
 *
 */
public class WPrintFormatEditorForm extends Window
{
	/**
	 * generated serial id
	 */
	private static final long serialVersionUID = -2533099650671242190L;

	private WPrintFormatEditor pfe;

	protected Borderlayout mainLayout = new Borderlayout();
	private ConfirmPanel confirmPanel = new ConfirmPanel(true, false, true, false, false, false);
	protected Listbox printedItemListbox = new Listbox();
	protected Listbox nonPrintedItemListbox = new Listbox();
	private Div centerDiv;
	private Vlayout westPaneLayout;
	protected Absolutelayout printLayout = null;
	
	protected WEditor editorName = null;
	protected WEditor editorPrintName = null;
	protected WEditor editorSeqNo = null;
	protected WEditor fieldAlignment = null;
	protected WEditor maxWidth = null;
	protected WEditor maxHeight = null;
	protected WEditor fixedWidth = null;
	protected WEditor printFont = null;
	protected WEditor imageField = null;
	protected WEditor imageAttached = null;
	protected WEditor imageUrl = null;
	protected WEditor lineAlignment = null;
	protected WEditor lineWidth = null;
	protected WEditor includedPrintFormat = null;
	protected WEditor shapeType = null;
	protected WEditor oneLineOnly = null;
	protected WEditor nextLine = null;
	protected WEditor nextPage = null;
	protected WEditor xSpace = null;
	protected WEditor ySpace = null;
	protected WEditor xPosition = null;
	protected WEditor yPosition = null;
	protected WYesNoEditor relativePosition = null;
	protected WEditor setNLPosition = null;
	protected WEditor supressNull = null;
	protected WEditor printColor = null;
	protected WEditor fillShape = null;
	protected WEditor arcDiameter = null;
	protected WEditor printAreaType = null;
	protected WEditor editorTestValue = null;
	protected WEditor editorBelowColumn = null;
	protected WEditor editorFormatPattern = null;
	protected WEditor editorScript = null;
	protected WEditor editorIsOrderBy = null;
	protected WEditor editorSortNo = null;
	protected WEditor editorIsGroupBy = null;
	protected WEditor editorIsAveraged = null;
	protected WEditor editorIsCounted = null;
	protected WEditor editorIsDeviationCalc = null;
	protected WEditor editorIsMaxCalc = null;
	protected WEditor editorIsMinCalc = null;
	protected WEditor editorIsSummarized = null;
	protected WEditor editorIsVarianceCalc = null;
	protected WEditor editorIsRunningTotal = null;
	protected WEditor editorRunningTotalLines = null;
	protected WEditor editorIsPrintInstanceAttributes = null;
	
	/**
	 * 
	 * @param printFormatEditor
	 */
	public WPrintFormatEditorForm(WPrintFormatEditor printFormatEditor) {
		pfe = printFormatEditor;
	}
	
	/**
	 * Static init
	 * 
	 * @throws Exception
	 */
	public void init() throws Exception {
		setSizable(true);
		setClosable(true);
		setMaximizable(true);
		setMaximized(true);
		appendChild(mainLayout);
		LayoutUtils.addSclass("tab-editor-form-content", mainLayout);
		setBorder("normal");
		setHeight("80%");
		setWidth("80%");

		confirmPanel.addActionListener(Events.ON_CLICK, e -> pfe.onConfirmPanelClick(e));
		addEventListener(Events.ON_CANCEL, e -> pfe.onCancel());

		Borderlayout eastPaneLayout = new Borderlayout();

		Center eastPaneCenter = new Center();
		Grid propGrid = initPropertiesGrid();
		ZKUpdateUtil.setVflex(propGrid, "1");
		eastPaneCenter.appendChild(propGrid);
		eastPaneLayout.appendChild(eastPaneCenter);		
		South south = new South();
		eastPaneLayout.appendChild(south);
		ZKUpdateUtil.setVflex(confirmPanel, "min");
		ZKUpdateUtil.setHflex(confirmPanel, "1");
		south.appendChild(confirmPanel);
		ZKUpdateUtil.setWidth(eastPaneLayout, "100%");
		ZKUpdateUtil.setHeight(eastPaneLayout, "100%");
				
		East east = new East();
		LayoutUtils.addSclass("tab-editor-form-east-panel", east);
		mainLayout.appendChild(east);
		east.appendChild(eastPaneLayout);
		ZKUpdateUtil.setWidth(east, "25%");

		Label formatItemLabel = new Label();
		ListHead printedHead = new ListHead();
		printedHead.setParent(printedItemListbox);
		ListHeader visibleHeader = new ListHeader();
		formatItemLabel.setText("Displayed");
		visibleHeader.appendChild(formatItemLabel);
		visibleHeader.setParent(printedHead);

		ListHead nonPrintedHead = new ListHead();
		nonPrintedHead.setParent(nonPrintedItemListbox);
		ListHeader nonPrintedHeader = new ListHeader();
		nonPrintedHeader.appendChild(new Label("Not Displayed"));
		nonPrintedHeader.setParent(nonPrintedHead);

		westPaneLayout = new Vlayout();
		ZKUpdateUtil.setHeight(westPaneLayout, "100%");
		westPaneLayout.appendChild(printedItemListbox);
		ZKUpdateUtil.setVflex(printedItemListbox, "1");
		westPaneLayout.appendChild(nonPrintedItemListbox);
		ZKUpdateUtil.setVflex(nonPrintedItemListbox, "1");

		printedItemListbox.addEventListener(Events.ON_DROP, (DropEvent e) -> pfe.onDrop(e));
		nonPrintedItemListbox.addEventListener(Events.ON_DROP, (DropEvent e) -> pfe.onDrop(e));

		West west = new West();
		LayoutUtils.addSclass("tab-editor-form-west-panel", west);
		mainLayout.appendChild(west);
		west.appendChild(westPaneLayout);
		west.setCollapsible(true);
		west.setSplittable(true);
		ZKUpdateUtil.setWidth(west, "200px");

		Center center = new Center();

		centerDiv = new Div();
		PrintFormatEditorUtil
				.addCSSStyle(
						centerDiv,
						"border: dashed 1px black; overflow: auto; background-color: grey;",
						false);
		ZKUpdateUtil.setHeight(centerDiv, "100%");

		Div previewDiv = new Div();
		ZKUpdateUtil.setHeight(previewDiv, pfe.paperHeight + "pt");
		ZKUpdateUtil.setWidth(previewDiv, pfe.paperWidth + "pt");

		printLayout = new Absolutelayout();
		PrintFormatEditorUtil.addCSSStyle(printLayout,
				" border: 1px black solid; background-color:#E1E1E1;", false);

		ZKUpdateUtil.setWidth(printLayout, (pfe.paperWidth + "pt"));
		ZKUpdateUtil.setHeight(printLayout, (pfe.paperHeight + "pt"));
		printLayout.setDroppable("true");
		printLayout.addEventListener(Events.ON_DROP, (DropEvent e) -> pfe.onDrop(e));

		previewDiv.appendChild(printLayout);
		centerDiv.appendChild(previewDiv);
		center.appendChild(centerDiv);

		mainLayout.appendChild(center);
		setCtrlKeys("#left#right#up#down#del");
		addEventListener(Events.ON_CTRL_KEY, (KeyEvent e) -> pfe.onCtrlKey(e));	
		
		ZkCssHelper.appendStyle(printLayout, "overflow: auto;");
	} 
	
	/**
	 * Initialize Grid of Field's Properties return @Grid
	 */
	private Grid initPropertiesGrid() {
		Grid gridView = GridFactory.newGridLayout();
		//
		Columns columns = new Columns();
		gridView.appendChild(columns);
		//
		Column column = new Column();
		columns.appendChild(column);
		ZKUpdateUtil.setHflex(column, "min");
		column.setAlign("right");

		column = new Column();
		columns.appendChild(column);
		ZKUpdateUtil.setHflex(column, "1");
		Rows rows = new Rows();
		gridView.appendChild(rows);

		Row row = null;

		row = new Row();
		Group group = new Group(Msg.getMsg(Env.getCtx(), "Property"));
		Cell cell = (Cell) group.getFirstChild();
		cell.setSclass("z-group-inner");
		cell.setColspan(2);
		cell.setAlign("left");
		group.setOpen(true);
		rows.appendChild(group);

		row = new Row();
		Label labelName = new Label(Msg.getElement(Env.getCtx(),
				MPrintFormatItem.COLUMNNAME_Name));
		editorName = new WStringEditor(MPrintFormatItem.COLUMNNAME_Name, false,
				false, false, 0, 0, null, null);
		editorName.fillHorizontal();
		editorName.addValueChangeListener(pfe);
		row.appendChild(labelName.rightAlign());
		row.appendChild(editorName.getComponent());
		row.setGroup(group);
		rows.appendChild(row);

		row = new Row();
		Label labelPrintName = new Label(Msg.getElement(Env.getCtx(),
				MPrintFormatItem.COLUMNNAME_PrintName));
		editorPrintName = new WStringEditor(MPrintFormatItem.COLUMNNAME_PrintName, false,
				false, false, 0, 0, null, null);
		editorPrintName.fillHorizontal();
		editorPrintName.addValueChangeListener(pfe);
		row.appendChild(labelPrintName.rightAlign());
		row.appendChild(editorPrintName.getComponent());
		row.setGroup(group);
		rows.appendChild(row);
		
		row = new Row();
		Label labelTestValue = new Label(Msg.getElement(Env.getCtx(), "TestValue"));
		editorTestValue = new WStringEditor("_TestValue_", false,
				false, true, 0, 0, null, null);
		editorTestValue.fillHorizontal();
		editorTestValue.addValueChangeListener(pfe);
		row.appendChild(labelTestValue.rightAlign());
		row.appendChild(editorTestValue.getComponent());
		row.setGroup(group);
		rows.appendChild(row);
		
		row = new Row();
		Label labelSeqNo = new Label(Msg.getElement(Env.getCtx(),
				MPrintFormatItem.COLUMNNAME_SeqNo));
		editorSeqNo = new WNumberEditor(MPrintFormatItem.COLUMNNAME_SeqNo,
				false, false, false, DisplayType.Integer, labelSeqNo.getValue());
		editorSeqNo.addValueChangeListener(pfe);
		editorSeqNo.fillHorizontal();
		row.appendChild(labelSeqNo.rightAlign());
		row.appendChild(editorSeqNo.getComponent());
		row.setGroup(group);
		rows.appendChild(row);

		row = new Row();
		Label imgURL = new Label(Msg.getElement(Env.getCtx(),
				MPrintFormatItem.COLUMNNAME_ImageURL));
		imageUrl = new WStringEditor(MPrintFormatItem.COLUMNNAME_ImageURL, false,
				false, false, 0, 0, null, null);
		imageUrl.addValueChangeListener(pfe);
		ZKUpdateUtil.setHflex((HtmlBasedComponent) imageUrl.getComponent(), "1");
		row.appendChild(imgURL.rightAlign());
		row.appendChild(imageUrl.getComponent());
		row.setGroup(group);
		rows.appendChild(row);

		row = new Row();
		Label labelXPos = new Label(Msg.getElement(Env.getCtx(),
				MPrintFormatItem.COLUMNNAME_XPosition));
		xPosition = new WNumberEditor(MPrintFormatItem.COLUMNNAME_XPosition,
				true, false, true, DisplayType.Integer, labelXPos.getValue());
		xPosition.fillHorizontal();
		row.appendChild(labelXPos.rightAlign());
		row.appendChild(xPosition.getComponent());
		xPosition.addValueChangeListener(pfe);
		row.setGroup(group);
		rows.appendChild(row);

		row = new Row();
		Label labelYPos = new Label(Msg.getElement(Env.getCtx(),
				MPrintFormatItem.COLUMNNAME_YPosition));
		yPosition = new WNumberEditor(MPrintFormatItem.COLUMNNAME_YPosition,
				true, false, true, DisplayType.Integer, labelYPos.getValue());
		yPosition.fillHorizontal();
		row.appendChild(labelYPos.rightAlign());
		row.appendChild(yPosition.getComponent());
		yPosition.addValueChangeListener(pfe);
		row.setGroup(group);
		rows.appendChild(row);

		row = new Row();
		Label labelXSpace = new Label(Msg.getElement(Env.getCtx(),
				MPrintFormatItem.COLUMNNAME_XSpace));
		xSpace = new WNumberEditor(MPrintFormatItem.COLUMNNAME_XSpace, true,
				false, true, DisplayType.Integer, labelXSpace.getValue());
		xSpace.fillHorizontal();
		row.appendChild(labelXSpace.rightAlign());
		row.appendChild(xSpace.getComponent());
		xSpace.addValueChangeListener(pfe);
		row.setGroup(group);
		rows.appendChild(row);

		row = new Row();
		Label labelYSpace = new Label(Msg.getElement(Env.getCtx(),
				MPrintFormatItem.COLUMNNAME_YSpace));
		ySpace = new WNumberEditor(MPrintFormatItem.COLUMNNAME_YSpace, true,
				false, true, DisplayType.Integer, labelYSpace.getValue());
		ySpace.fillHorizontal();
		row.appendChild(labelYSpace.rightAlign());
		row.appendChild(ySpace.getComponent());
		ySpace.addValueChangeListener(pfe);
		row.setGroup(group);
		rows.appendChild(row);

		row = new Row();
		Label lblMaxHeight = new Label(Msg.getElement(Env.getCtx(),
				MPrintFormatItem.COLUMNNAME_MaxHeight));
		maxHeight = new WNumberEditor(MPrintFormatItem.COLUMNNAME_MaxHeight,
				true, false, true, DisplayType.Integer, lblMaxHeight.getValue());
		maxHeight.fillHorizontal();
		row.appendChild(lblMaxHeight.rightAlign());
		row.appendChild(maxHeight.getComponent());
		maxHeight.addValueChangeListener(pfe);
		row.setGroup(group);
		rows.appendChild(row);

		row = new Row();
		Label lblMaxWidth = new Label(Msg.getElement(Env.getCtx(),
				MPrintFormatItem.COLUMNNAME_MaxWidth));
		maxWidth = new WNumberEditor(MPrintFormatItem.COLUMNNAME_MaxWidth,
				true, false, true, DisplayType.Integer, lblMaxWidth.getValue());
		maxWidth.fillHorizontal();
		row.appendChild(lblMaxWidth.rightAlign());
		row.appendChild(maxWidth.getComponent());
		maxWidth.addValueChangeListener(pfe);
		row.setGroup(group);
		rows.appendChild(row);

		row = new Row();
		Label label = new Label(Msg.getElement(Env.getCtx(),
				MPrintFormatItem.COLUMNNAME_ArcDiameter));
		arcDiameter = new WNumberEditor(
				MPrintFormatItem.COLUMNNAME_ArcDiameter, true, false, true,
				DisplayType.Integer, label.getValue());
		arcDiameter.fillHorizontal();
		row.appendChild(label.rightAlign());
		row.appendChild(arcDiameter.getComponent());
		arcDiameter.addValueChangeListener(pfe);
		row.setGroup(group);
		rows.appendChild(row);

		row = new Row();
		label = new Label(Msg.getElement(Env.getCtx(),
				MPrintFormatItem.COLUMNNAME_LineWidth));
		lineWidth = new WNumberEditor(MPrintFormatItem.COLUMNNAME_LineWidth,
				true, false, true, DisplayType.Integer, label.getValue());
		lineWidth.fillHorizontal();
		row.appendChild(label.rightAlign());
		row.appendChild(lineWidth.getComponent());
		lineWidth.addValueChangeListener(pfe);
		row.setGroup(group);
		rows.appendChild(row);

		row = new Row();
		row.appendChild(new Label(Msg.getElement(
						Env.getCtx(),
						MPrintFormatItem.COLUMNNAME_IsRelativePosition)));
		relativePosition = new WYesNoEditor(
				MPrintFormatItem.COLUMNNAME_IsRelativePosition, "", null,
				false, false, true);
		row.appendChild(relativePosition.getComponent());
		relativePosition.addValueChangeListener(pfe);	
		row.setGroup(group);
		rows.appendChild(row);

		row = new Row();
		row.appendChild(new Label(Msg.getElement(
						Env.getCtx(),
						MPrintFormatItem.COLUMNNAME_IsSuppressNull)));
		supressNull = new WYesNoEditor(
				MPrintFormatItem.COLUMNNAME_IsSuppressNull, "", null,
				false, false, true);
		row.appendChild(supressNull.getComponent());
		supressNull.addValueChangeListener(pfe);
		row.setGroup(group);
		rows.appendChild(row);

		row = new Row();
		row.appendChild(new Label(Msg.getElement(
				Env.getCtx(),
				MPrintFormatItem.COLUMNNAME_IsSetNLPosition)));
		setNLPosition = new WYesNoEditor(
				MPrintFormatItem.COLUMNNAME_IsSetNLPosition, "", null,
				false, false, true);
		row.appendChild(setNLPosition.getComponent());
		setNLPosition.addValueChangeListener(pfe);
		row.setGroup(group);
		rows.appendChild(row);

		row = new Row();
		row.appendChild(new Label( Msg.getElement(
						Env.getCtx(),
						MPrintFormatItem.COLUMNNAME_IsFilledRectangle)));
		fillShape = new WYesNoEditor(
				MPrintFormatItem.COLUMNNAME_IsFilledRectangle,"", null,
				false, false, true);
		row.appendChild(fillShape.getComponent());
		fillShape.addValueChangeListener(pfe);
		row.setGroup(group);
		rows.appendChild(row);

		row = new Row();
		row.appendChild(new Label(Msg.getElement(Env.getCtx(),
						MPrintFormatItem.COLUMNNAME_IsNextPage)));
		nextPage = new WYesNoEditor(MPrintFormatItem.COLUMNNAME_IsNextPage,
				"", null, false,
				false, true);
		row.appendChild(nextPage.getComponent());
		nextPage.addValueChangeListener(pfe);
		row.setGroup(group);
		rows.appendChild(row);

		row = new Row();
		row.appendChild(new Label(Msg.getElement(Env.getCtx(),
						MPrintFormatItem.COLUMNNAME_IsNextLine)));
		nextLine = new WYesNoEditor(MPrintFormatItem.COLUMNNAME_IsNextLine,
				"", null, false,
				false, true);
		row.appendChild(nextLine.getComponent());
		nextLine.addValueChangeListener(pfe);
		row.setGroup(group);
		rows.appendChild(row);

		row = new Row();
		row.appendChild(new Label(Msg.getElement(Env.getCtx(),
						MPrintFormatItem.COLUMNNAME_BelowColumn)));
		editorBelowColumn = new WNumberEditor(MPrintFormatItem.COLUMNNAME_BelowColumn,
				false, false, true, DisplayType.Integer, "");
		row.appendChild(editorBelowColumn.getComponent());
		editorBelowColumn.addValueChangeListener(pfe);
		row.setGroup(group);
		rows.appendChild(row);
		
		row = new Row();
		row.appendChild(new Label(Msg.getElement(
						Env.getCtx(),
						MPrintFormatItem.COLUMNNAME_IsHeightOneLine)));
		oneLineOnly = new WYesNoEditor(
				MPrintFormatItem.COLUMNNAME_IsHeightOneLine, "", null,
				false, false, true);
		row.appendChild(oneLineOnly.getComponent());
		oneLineOnly.addValueChangeListener(pfe);
		row.setGroup(group);
		rows.appendChild(row);

		row = new Row();
		row.appendChild(new Label(Msg.getElement(
						Env.getCtx(),
						MPrintFormatItem.COLUMNNAME_ImageIsAttached)));
		imageAttached = new WYesNoEditor(
				MPrintFormatItem.COLUMNNAME_ImageIsAttached, "", null,
				false, false, true);
		row.appendChild(imageAttached.getComponent());
		imageAttached.addValueChangeListener(pfe);
		row.setGroup(group);
		rows.appendChild(row);

		row = new Row();
		row.appendChild(new Label(Msg.getElement(Env.getCtx(),
						MPrintFormatItem.COLUMNNAME_IsImageField)));
		imageField = new WYesNoEditor(MPrintFormatItem.COLUMNNAME_IsImageField,
				"", null, false,
				false, true);
		row.appendChild(imageField.getComponent());
		imageField.addValueChangeListener(pfe);
		row.setGroup(group);
		rows.appendChild(row);

		row = new Row();
		row.appendChild(new Label(Msg.getElement(Env.getCtx(),
						MPrintFormatItem.COLUMNNAME_IsFixedWidth)));
		fixedWidth = new WYesNoEditor(MPrintFormatItem.COLUMNNAME_IsFixedWidth,
				"", null, false,
				false, true);
		row.appendChild(fixedWidth.getComponent());
		fixedWidth.addValueChangeListener(pfe);
		row.setGroup(group);
		rows.appendChild(row);

		row = new Row();
		label = new Label(Msg.getElement(Env.getCtx(),
				MPrintFormatItem.COLUMNNAME_PrintAreaType));
		int columnID = MColumn.getColumn_ID(MPrintFormatItem.Table_Name,
				MPrintFormatItem.COLUMNNAME_PrintAreaType);
		MLookup lookup = MLookupFactory.get(Env.getCtx(), 0, 0, columnID,
				DisplayType.List);
		printAreaType = new WTableDirEditor(
				MPrintFormatItem.COLUMNNAME_PrintAreaType, false, false, true,
				lookup);
		printAreaType.fillHorizontal();
		row.appendChild(label.rightAlign());
		row.appendChild(printAreaType.getComponent());
		printAreaType.addValueChangeListener(pfe);
		row.setGroup(group);
		rows.appendChild(row);

		row = new Row();
		label = new Label(Msg.getElement(Env.getCtx(),
				MPrintFormatItem.COLUMNNAME_AD_PrintFont_ID));
		columnID = MColumn.getColumn_ID(MPrintFormatItem.Table_Name,
				MPrintFormatItem.COLUMNNAME_AD_PrintFont_ID);
		lookup = MLookupFactory.get(Env.getCtx(), 0, 0, columnID,
				DisplayType.TableDir);
		printFont = new WTableDirEditor(
				MPrintFormatItem.COLUMNNAME_AD_PrintFont_ID, false, false,
				true, lookup);
		printFont.fillHorizontal();
		row.appendChild(label.rightAlign());
		row.appendChild(printFont.getComponent());
		printFont.addValueChangeListener(pfe);
		row.setGroup(group);
		rows.appendChild(row);

		row = new Row();
		label = new Label(Msg.getElement(Env.getCtx(),
				MPrintFormatItem.COLUMNNAME_AD_PrintColor_ID));
		columnID = MColumn.getColumn_ID(MPrintFormatItem.Table_Name,
				MPrintFormatItem.COLUMNNAME_AD_PrintColor_ID);
		lookup = MLookupFactory.get(Env.getCtx(), 0, 0, columnID,
				DisplayType.TableDir);
		printColor = new WTableDirEditor(
				MPrintFormatItem.COLUMNNAME_AD_PrintColor_ID, false, false,
				true, lookup);
		printColor.fillHorizontal();
		row.appendChild(label.rightAlign());		
		row.appendChild(printColor.getComponent());
		printColor.addValueChangeListener(pfe);
		row.setGroup(group);
		rows.appendChild(row);

		row = new Row();
		label = new Label(Msg.getElement(Env.getCtx(),
				MPrintFormatItem.COLUMNNAME_AD_PrintFormatChild_ID));
		columnID = MColumn.getColumn_ID(MPrintFormatItem.Table_Name,
				MPrintFormatItem.COLUMNNAME_AD_PrintFormatChild_ID);
		lookup = MLookupFactory.get(Env.getCtx(), 0, 0, columnID,
				DisplayType.Table);
		includedPrintFormat = new WTableDirEditor(
				MPrintFormatItem.COLUMNNAME_AD_PrintFormatChild_ID, false,
				false, true, lookup);
		row.appendChild(label.rightAlign());
		row.appendChild(includedPrintFormat.getComponent());
		includedPrintFormat.addValueChangeListener(pfe);
		row.setGroup(group);
		rows.appendChild(row);

		row = new Row();
		label = new Label(Msg.getElement(Env.getCtx(),
				MPrintFormatItem.COLUMNNAME_LineAlignmentType));
		columnID = MColumn.getColumn_ID(MPrintFormatItem.Table_Name,
				MPrintFormatItem.COLUMNNAME_LineAlignmentType);
		lookup = MLookupFactory.get(Env.getCtx(), 0, 0, columnID,
				DisplayType.List);
		lineAlignment = new WTableDirEditor(
				MPrintFormatItem.COLUMNNAME_LineAlignmentType, false, false,
				true, lookup);
		lineAlignment.fillHorizontal();
		row.appendChild(label.rightAlign());
		row.appendChild(lineAlignment.getComponent());
		lineAlignment.addValueChangeListener(pfe);
		row.setGroup(group);
		rows.appendChild(row);

		row = new Row();
		label = new Label(Msg.getElement(Env.getCtx(),
				MPrintFormatItem.COLUMNNAME_FieldAlignmentType));
		columnID = MColumn.getColumn_ID(MPrintFormatItem.Table_Name,
				MPrintFormatItem.COLUMNNAME_FieldAlignmentType);
		lookup = MLookupFactory.get(Env.getCtx(), 0, 0, columnID,
				DisplayType.List);
		fieldAlignment = new WTableDirEditor(
				MPrintFormatItem.COLUMNNAME_FieldAlignmentType, false, false,
				true, lookup);
		fieldAlignment.fillHorizontal();
		row.appendChild(label.rightAlign());
		row.appendChild(fieldAlignment.getComponent());
		fieldAlignment.addValueChangeListener(pfe);
		row.setGroup(group);
		rows.appendChild(row);

		row = new Row();
		label = new Label(Msg.getElement(Env.getCtx(),
				MPrintFormatItem.COLUMNNAME_ShapeType));
		columnID = MColumn.getColumn_ID(MPrintFormatItem.Table_Name,
				MPrintFormatItem.COLUMNNAME_ShapeType);
		lookup = MLookupFactory.get(Env.getCtx(), 0, 0, columnID,
				DisplayType.List);
		shapeType = new WTableDirEditor(MPrintFormatItem.COLUMNNAME_ShapeType,
				false, false, true, lookup);
		row.appendChild(label.rightAlign());
		row.appendChild(shapeType.getComponent());
		shapeType.addValueChangeListener(pfe);
		row.setGroup(group);
		rows.appendChild(row);

		row = new Row();
		label = new Label(Msg.getElement(Env.getCtx(),
				MPrintFormatItem.COLUMNNAME_FormatPattern));
		editorFormatPattern = new WStringEditor(MPrintFormatItem.COLUMNNAME_FormatPattern, false,
				false, false, 0, 0, null, null);
		editorFormatPattern.fillHorizontal();
		editorFormatPattern.addValueChangeListener(pfe);
		row.appendChild(label.rightAlign());
		row.appendChild(editorFormatPattern.getComponent());
		row.setGroup(group);
		rows.appendChild(row);
		
		row = new Row();
		label = new Label(Msg.getElement(Env.getCtx(),
				MPrintFormatItem.COLUMNNAME_Script));
		editorScript = new WStringEditor(MPrintFormatItem.COLUMNNAME_Script, false,
				false, false, 0, 0, null, null);
		editorScript.fillHorizontal();
		editorScript.addValueChangeListener(pfe);
		row.appendChild(label.rightAlign());
		row.appendChild(editorScript.getComponent());
		row.setGroup(group);
		rows.appendChild(row);
		
		row = new Row();
		row.appendChild(new Label(Msg.getElement(
						Env.getCtx(),
						MPrintFormatItem.COLUMNNAME_IsPrintInstanceAttributes)));
		editorIsPrintInstanceAttributes = new WYesNoEditor(
				MPrintFormatItem.COLUMNNAME_IsPrintInstanceAttributes, "", null,
				false, false, true);
		row.appendChild(editorIsPrintInstanceAttributes.getComponent());
		editorIsPrintInstanceAttributes.addValueChangeListener(pfe);	
		row.setGroup(group);
		rows.appendChild(row);
				
		row = new Row();
		row.appendChild(new Label(Msg.getElement(
						Env.getCtx(),
						MPrintFormatItem.COLUMNNAME_IsOrderBy)));
		editorIsOrderBy = new WYesNoEditor(
				MPrintFormatItem.COLUMNNAME_IsOrderBy, "", null,
				false, false, true);
		row.appendChild(editorIsOrderBy.getComponent());
		editorIsOrderBy.addValueChangeListener(pfe);	
		row.setGroup(group);
		rows.appendChild(row);
		
		row = new Row();
		label = new Label(Msg.getElement(Env.getCtx(),
				MPrintFormatItem.COLUMNNAME_SortNo));
		editorSortNo = new WNumberEditor(MPrintFormatItem.COLUMNNAME_SortNo,
				false, false, false, DisplayType.Integer, labelSeqNo.getValue());
		editorSortNo.fillHorizontal();
		editorSortNo.addValueChangeListener(pfe);
		row.appendChild(label.rightAlign());
		row.appendChild(editorSortNo.getComponent());
		row.setGroup(group);
		rows.appendChild(row);		
		
		row = new Row();
		row.appendChild(new Label(Msg.getElement(
						Env.getCtx(),
						MPrintFormatItem.COLUMNNAME_IsGroupBy)));
		editorIsGroupBy = new WYesNoEditor(
				MPrintFormatItem.COLUMNNAME_IsGroupBy, "", null,
				false, false, true);
		row.appendChild(editorIsGroupBy.getComponent());
		editorIsGroupBy.addValueChangeListener(pfe);	
		row.setGroup(group);
		rows.appendChild(row);
		
		row = new Row();
		row.appendChild(new Label(Msg.getElement(
						Env.getCtx(),
						MPrintFormatItem.COLUMNNAME_IsAveraged)));
		editorIsAveraged = new WYesNoEditor(
				MPrintFormatItem.COLUMNNAME_IsAveraged, "", null,
				false, false, true);
		row.appendChild(editorIsAveraged.getComponent());
		editorIsAveraged.addValueChangeListener(pfe);	
		row.setGroup(group);
		rows.appendChild(row);
		
		row = new Row();
		row.appendChild(new Label(Msg.getElement(
						Env.getCtx(),
						MPrintFormatItem.COLUMNNAME_IsCounted)));
		editorIsCounted = new WYesNoEditor(
				MPrintFormatItem.COLUMNNAME_IsCounted, "", null,
				false, false, true);
		row.appendChild(editorIsCounted.getComponent());
		editorIsCounted.addValueChangeListener(pfe);	
		row.setGroup(group);
		rows.appendChild(row);
		
		row = new Row();
		row.appendChild(new Label(Msg.getElement(
						Env.getCtx(),
						MPrintFormatItem.COLUMNNAME_IsDeviationCalc)));
		editorIsDeviationCalc = new WYesNoEditor(
				MPrintFormatItem.COLUMNNAME_IsDeviationCalc, "", null,
				false, false, true);
		row.appendChild(editorIsDeviationCalc.getComponent());
		editorIsDeviationCalc.addValueChangeListener(pfe);	
		row.setGroup(group);
		rows.appendChild(row);
		
		row = new Row();
		row.appendChild(new Label(Msg.getElement(
						Env.getCtx(),
						MPrintFormatItem.COLUMNNAME_IsMaxCalc)));
		editorIsMaxCalc = new WYesNoEditor(
				MPrintFormatItem.COLUMNNAME_IsMaxCalc, "", null,
				false, false, true);
		row.appendChild(editorIsMaxCalc.getComponent());
		editorIsMaxCalc.addValueChangeListener(pfe);	
		row.setGroup(group);
		rows.appendChild(row);
		
		row = new Row();
		row.appendChild(new Label(Msg.getElement(
						Env.getCtx(),
						MPrintFormatItem.COLUMNNAME_IsMinCalc)));
		editorIsMinCalc = new WYesNoEditor(
				MPrintFormatItem.COLUMNNAME_IsMinCalc, "", null,
				false, false, true);
		row.appendChild(editorIsMinCalc.getComponent());
		editorIsMinCalc.addValueChangeListener(pfe);	
		row.setGroup(group);
		rows.appendChild(row);
		
		row = new Row();
		row.appendChild(new Label(Msg.getElement(
						Env.getCtx(),
						MPrintFormatItem.COLUMNNAME_IsSummarized)));
		editorIsSummarized = new WYesNoEditor(
				MPrintFormatItem.COLUMNNAME_IsSummarized, "", null,
				false, false, true);
		row.appendChild(editorIsSummarized.getComponent());
		editorIsSummarized.addValueChangeListener(pfe);	
		row.setGroup(group);
		rows.appendChild(row);
		
		row = new Row();
		row.appendChild(new Label(Msg.getElement(
						Env.getCtx(),
						MPrintFormatItem.COLUMNNAME_IsVarianceCalc)));
		editorIsVarianceCalc = new WYesNoEditor(
				MPrintFormatItem.COLUMNNAME_IsVarianceCalc, "", null,
				false, false, true);
		row.appendChild(editorIsVarianceCalc.getComponent());
		editorIsVarianceCalc.addValueChangeListener(pfe);	
		row.setGroup(group);
		rows.appendChild(row);
		
		row = new Row();
		row.appendChild(new Label(Msg.getElement(
						Env.getCtx(),
						MPrintFormatItem.COLUMNNAME_IsRunningTotal)));
		editorIsRunningTotal = new WYesNoEditor(
				MPrintFormatItem.COLUMNNAME_IsRunningTotal, "", null,
				false, false, true);
		row.appendChild(editorIsRunningTotal.getComponent());
		editorIsRunningTotal.addValueChangeListener(pfe);	
		row.setGroup(group);
		rows.appendChild(row);
		
		row = new Row();
		label = new Label(Msg.getElement(Env.getCtx(),
				MPrintFormatItem.COLUMNNAME_RunningTotalLines));
		editorRunningTotalLines = new WNumberEditor(MPrintFormatItem.COLUMNNAME_RunningTotalLines,
				false, false, false, DisplayType.Integer, labelSeqNo.getValue());
		editorRunningTotalLines.fillHorizontal();
		editorRunningTotalLines.addValueChangeListener(pfe);
		row.appendChild(label.rightAlign());
		row.appendChild(editorRunningTotalLines.getComponent());
		row.setGroup(group);
		rows.appendChild(row);
		
		row = new Row();
		Separator esep = new Separator("horizontal");
		esep.setSpacing("10px");
		row.appendChild(esep);
		row.setGroup(group);
		rows.appendChild(row);

		return gridView;
	}	
}