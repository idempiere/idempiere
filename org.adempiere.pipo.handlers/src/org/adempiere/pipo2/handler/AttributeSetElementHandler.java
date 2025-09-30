/******************************************************************************
 * Copyright (C) 2016 Logilite Technologies LLP								  *
 * This program is free software; you can redistribute it and/or modify it    *
 * under the terms version 2 of the GNU General Public License as published   *
 * by the Free Software Foundation. This program is distributed in the hope   *
 * that it will be useful, but WITHOUT ANY WARRANTY; without even the implied *
 * warranty of MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.           *
 * See the GNU General Public License for more details.                       *
 * You should have received a copy of the GNU General Public License along    *
 * with this program; if not, write to the Free Software Foundation, Inc.,    *
 * 59 Temple Place, Suite 330, Boston, MA 02111-1307 USA.                     *
 *****************************************************************************/
package org.adempiere.pipo2.handler;

import java.util.List;

import javax.xml.transform.sax.TransformerHandler;

import org.adempiere.exceptions.AdempiereException;
import org.adempiere.pipo2.AbstractElementHandler;
import org.adempiere.pipo2.Element;
import org.adempiere.pipo2.PIPOContext;
import org.adempiere.pipo2.PackOut;
import org.adempiere.pipo2.PoExporter;
import org.adempiere.pipo2.PoFiller;
import org.adempiere.pipo2.exception.POSaveFailedException;
import org.compiere.model.MAttributeSet;
import org.compiere.model.MAttributeUse;
import org.compiere.model.Query;
import org.compiere.model.X_AD_Package_Imp_Detail;
import org.compiere.model.X_M_AttributeSet;
import org.compiere.util.Env;
import org.xml.sax.SAXException;
import org.xml.sax.helpers.AttributesImpl;

public class AttributeSetElementHandler extends AbstractElementHandler
{

	@Override
	public void startElement(PIPOContext ctx, Element element) throws SAXException
	{
		List<String> excludes = defaultExcludeList(X_M_AttributeSet.Table_Name);
		String entitytype = getStringValue(element, "EntityType");
		if (isProcessElement(ctx.ctx, entitytype))
		{
			MAttributeSet mAttributeSet = findPO(ctx, element);
			if (mAttributeSet == null)
			{
				mAttributeSet = new MAttributeSet(ctx.ctx, 0, getTrxName(ctx));
			}

			PoFiller filler = new PoFiller(ctx, mAttributeSet, element, this);
			List<String> notfounds = filler.autoFill(excludes);
			if (notfounds.size() > 0)
			{
				element.defer = true;
				element.unresolved = notfounds.toString();
				return;
			}

			if (mAttributeSet.is_new() || mAttributeSet.is_Changed())
			{
				X_AD_Package_Imp_Detail impDetail = createImportDetail(ctx, element.qName, X_M_AttributeSet.Table_Name, X_M_AttributeSet.Table_ID);
				String action = null;
				if (!mAttributeSet.is_new())
				{
					backupRecord(ctx, impDetail.getAD_Package_Imp_Detail_ID(), X_M_AttributeSet.Table_Name, mAttributeSet);
					action = "Update";
				}
				else
				{
					action = "New";
				}
				if (mAttributeSet.save(getTrxName(ctx)) == true)
				{
					logImportDetail(ctx, impDetail, 1, mAttributeSet.getName(), mAttributeSet.get_ID(), action);
					element.recordId = mAttributeSet.getM_AttributeSet_ID();
				}
				else
				{
					logImportDetail(ctx, impDetail, 0, mAttributeSet.getName(), mAttributeSet.get_ID(), action);
					throw new POSaveFailedException("Failed to save Attribute Set " + mAttributeSet.getName());
				}
			}
		}
		else
		{
			element.skip = true;
		}
	}

	@Override
	public void endElement(PIPOContext ctx, Element element) throws SAXException
	{
	}

	@Override
	public void packOut(PackOut packout, TransformerHandler packoutHandler, TransformerHandler docHandler, int recordId) throws Exception
	{
		Env.setContext(packout.getCtx().ctx, X_M_AttributeSet.COLUMNNAME_M_AttributeSet_ID, recordId);
		this.create(packout.getCtx(), packoutHandler);
		packout.getCtx().ctx.remove(X_M_AttributeSet.COLUMNNAME_M_AttributeSet_ID);
	}

	private void create(PIPOContext ctx, TransformerHandler document) throws SAXException
	{
		int mAttributeSet_id = Env.getContextAsInt(ctx.ctx, X_M_AttributeSet.COLUMNNAME_M_AttributeSet_ID);
		if (ctx.packOut.isExported(X_M_AttributeSet.COLUMNNAME_M_AttributeSet_ID + "|" + mAttributeSet_id))
			return;

		X_M_AttributeSet mAdElement = new X_M_AttributeSet(ctx.ctx, mAttributeSet_id, null);
		boolean createElement = isPackOutElement(ctx, mAdElement);

		if (createElement)
		{
			verifyPackOutRequirement(mAdElement);
			AttributesImpl atts = new AttributesImpl();
			addTypeName(atts, "table");
			document.startElement("", "", X_M_AttributeSet.Table_Name, atts);
			createAttributeSetBinding(ctx, document, mAdElement);
		}

		List<MAttributeUse> attributeUses = new Query(ctx.ctx, MAttributeUse.Table_Name, "M_AttributeSet_ID=?", getTrxName(ctx))
																																.setParameters(mAttributeSet_id)
																																.setOrderBy("SeqNo").list();
		try
		{
			for (MAttributeUse attUse : attributeUses)
			{
				Env.setContext(ctx.ctx, MAttributeUse.COLUMNNAME_M_AttributeUse_UU, attUse.getM_AttributeUse_UU());
				new AttributeUseElementHandler().packOut(ctx.packOut, document, null, 0, attUse.getM_AttributeUse_UU());
				ctx.ctx.remove(MAttributeUse.COLUMNNAME_M_AttributeUse_UU);
			}
		}
		catch (Exception e)
		{
			throw new AdempiereException(e);
		}

		if (createElement)
			document.endElement("", "", X_M_AttributeSet.Table_Name);
	}

	private void createAttributeSetBinding(PIPOContext ctx, TransformerHandler document, X_M_AttributeSet mAdElement)
	{
		PoExporter filler = new PoExporter(ctx, document, mAdElement);
		if (mAdElement.getM_AttributeSet_ID() <= PackOut.MAX_OFFICIAL_ID)
			filler.add(X_M_AttributeSet.COLUMNNAME_M_AttributeSet_ID, new AttributesImpl());

		List<String> excludes = defaultExcludeList(X_M_AttributeSet.Table_Name);
		filler.export(excludes);
	}

}
