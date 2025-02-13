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
 **********************************************************************/
package org.adempiere.base.event.delegate;

import java.util.ArrayList;
import java.util.Arrays;
import java.util.List;

import org.adempiere.base.annotation.EventTopicDelegate;
import org.adempiere.base.annotation.ModelEventTopic;
import org.adempiere.base.event.annotations.ModelEventDelegate;
import org.adempiere.base.event.annotations.po.AfterChange;
import org.adempiere.base.event.annotations.po.AfterNew;
import org.compiere.model.MAttribute;
import org.compiere.model.MAttributeInstance;
import org.compiere.model.MAttributeInstanceLine;
import org.compiere.util.Env;
import org.compiere.util.Util;
import org.osgi.service.event.Event;

@EventTopicDelegate
@ModelEventTopic(modelClass = MAttributeInstance.class)
public class AttributeInstanceEventDelegate extends ModelEventDelegate<MAttributeInstance> {

	public AttributeInstanceEventDelegate(MAttributeInstance po, Event event) {
		super(po, event);
	}

	/**
	 * Create new MAttributeInstanceLine records for ATTRIBUTEVALUETYPE_ChosenMultipleSelectionList
	 */
	@AfterNew
	public void afterNew() {
		MAttributeInstance mai = getModel();
		MAttribute attribute = MAttribute.get(Env.getCtx(), mai.getM_Attribute_ID());
		if (attribute.getAttributeValueType().equals(MAttribute.ATTRIBUTEVALUETYPE_ChosenMultipleSelectionList)) {
			if (!Util.isEmpty(mai.getValueMultipleSelection(), true)) {
				String[] selectedIds = mai.getValueMultipleSelection().split("[,]");
				int lineNo = 0;
				for(String id : selectedIds) {
					lineNo += 10;
					MAttributeInstanceLine line = new MAttributeInstanceLine(Env.getCtx(), 0, mai.get_TrxName());
					line.setLine(lineNo);
					line.setM_AttributeInstance_UU(mai.getM_AttributeInstance_UU());
					line.setM_AttributeValue_ID(Integer.parseInt(id));
					line.setIsActive(true);
					line.saveEx();
				}
			}
		}
	}
	
	/**
	 * Update MAttributeInstanceLine records for ATTRIBUTEVALUETYPE_ChosenMultipleSelectionList
	 */
	@AfterChange
	public void afterChange() {
		MAttributeInstance mai = getModel();
		MAttribute attribute = MAttribute.get(Env.getCtx(), mai.getM_Attribute_ID());
		if (attribute.getAttributeValueType().equals(MAttribute.ATTRIBUTEVALUETYPE_ChosenMultipleSelectionList)) {
			List<MAttributeInstanceLine> existing = MAttributeInstanceLine.getOfAttributeInstance(mai);
			List<MAttributeInstanceLine> selectedLines = new ArrayList<MAttributeInstanceLine>();
			List<Integer> selectedList = new ArrayList<Integer>();
			if (!Util.isEmpty(mai.getValueMultipleSelection(), true)) {
				String[] selectedIds = mai.getValueMultipleSelection().split("[,]");
				Arrays.stream(selectedIds).forEach(e -> selectedList.add(Integer.parseInt(e)));
			}
			for(Integer selectedId : selectedList) {
				int existingIndex = -1;
				for(int i = 0; i < existing.size(); i++) {
					if (existing.get(i).getM_AttributeValue_ID() == selectedId.intValue()) {
						existingIndex = i;
						break;
					}
				}
				if (existingIndex >= 0) {
					selectedLines.add(existing.remove(existingIndex));
				} else {
					MAttributeInstanceLine line = new MAttributeInstanceLine(Env.getCtx(), 0, mai.get_TrxName());
					line.setLine(0);
					line.setM_AttributeInstance_UU(mai.getM_AttributeInstance_UU());
					line.setM_AttributeValue_ID(selectedId);
					line.setIsActive(true);
					selectedLines.add(line);
				}
			}
			for(MAttributeInstanceLine il : existing) {
				il.deleteEx(true);
			}
			int lineNo = 0;
			for(MAttributeInstanceLine il : selectedLines) {
				lineNo += 10;
				il.setLine(lineNo);
				if (il.is_new() || il.is_Changed())
					il.saveEx();
			}
		}
	}
}
