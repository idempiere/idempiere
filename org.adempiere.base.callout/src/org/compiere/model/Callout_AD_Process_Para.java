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
 * - Carlos Ruiz - globalqss - BX Service                              *
 **********************************************************************/

package org.compiere.model;

import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.Properties;

import org.adempiere.exceptions.DBException;
import org.adempiere.model.GridTabWrapper;
import org.compiere.util.DB;
import org.compiere.util.DisplayType;

public class Callout_AD_Process_Para extends CalloutEngine {

	public String columnName (Properties ctx, int WindowNo, GridTab mTab, GridField mField, Object value) {
		I_AD_Process_Para pp = GridTabWrapper.create(mTab, I_AD_Process_Para.class);
		boolean ppfound = false;
		// get defaults from most used case
		String sqlpp = ""
				+ "SELECT AD_Reference_ID, "
				+ "       AD_Val_Rule_ID, "
				+ "       AD_Reference_Value_ID, "
				+ "       FieldLength, "
				+ "       DefaultValue, "
				+ "       MandatoryLogic, "
				+ "       ReadOnlyLogic, "
				+ "       COUNT(*) "
				+ "FROM   AD_Process_Para "
				+ "WHERE  ColumnName = ? "
				+ "GROUP  BY AD_Reference_ID, "
				+ "          AD_Val_Rule_ID, "
				+ "          AD_Reference_Value_ID, "
				+ "          FieldLength, "
				+ "          DefaultValue, "
				+ "          MandatoryLogic, "
				+ "          ReadOnlyLogic "
				+ "ORDER  BY COUNT(*) DESC ";
		PreparedStatement pstmtpp = null;
		ResultSet rspp = null;
		try
		{
			pstmtpp = DB.prepareStatement(sqlpp, null);
			pstmtpp.setString(1, pp.getColumnName());
			rspp = pstmtpp.executeQuery();
			if (rspp.next()) {
				ppfound = true;
				int ad_reference_id = rspp.getInt(1);
				if (ad_reference_id == DisplayType.ID)
					ad_reference_id = DisplayType.TableDir;
				pp.setAD_Reference_ID(ad_reference_id);
				pp.setAD_Val_Rule_ID(rspp.getInt(2));
				pp.setAD_Reference_Value_ID(rspp.getInt(3));
				pp.setFieldLength(rspp.getInt(4));
				pp.setDefaultValue(rspp.getString(5));
				pp.setMandatoryLogic(rspp.getString(6));
				pp.setReadOnlyLogic(rspp.getString(7));
			}
		}
		catch (SQLException e)
		{
			throw new DBException(e);
		}
		finally
		{
			DB.close(rspp, pstmtpp);
			rspp = null;
			pstmtpp = null;
		}

		if (! ppfound) {
			// get defaults from most used case in columns
			String sqlcol = ""
					+ "SELECT AD_Reference_ID, "
					+ "       AD_Val_Rule_ID, "
					+ "       AD_Reference_Value_ID, "
					+ "       FieldLength, "
					+ "       COUNT(*) "
					+ "FROM   AD_Column "
					+ "WHERE  ColumnName = ? "
					+ "GROUP  BY AD_Reference_ID, "
					+ "          AD_Val_Rule_ID, "
					+ "          AD_Reference_Value_ID, "
					+ "          FieldLength "
					+ "ORDER  BY COUNT(*) DESC ";
			PreparedStatement pstmtcol = null;
			ResultSet rscol = null;
			try
			{
				pstmtcol = DB.prepareStatement(sqlcol, null);
				pstmtcol.setString(1, pp.getColumnName());
				rscol = pstmtcol.executeQuery();
				if (rscol.next()) {
					int ad_reference_id = rscol.getInt(1);
					if (ad_reference_id == DisplayType.ID)
						ad_reference_id = DisplayType.TableDir;
					pp.setAD_Reference_ID(ad_reference_id);
					pp.setAD_Val_Rule_ID(rscol.getInt(2));
					pp.setAD_Reference_Value_ID(rscol.getInt(3));
					pp.setFieldLength(rscol.getInt(4));
				}
			}
			catch (SQLException e)
			{
				throw new DBException(e);
			}
			finally
			{
				DB.close(rscol, pstmtcol);
				rscol = null;
				pstmtcol = null;
			}
		}

		return "";
	}

	public String element (Properties ctx, int WindowNo, GridTab mTab, GridField mField, Object value) {
		I_AD_Process_Para pp = GridTabWrapper.create(mTab, I_AD_Process_Para.class);
		if (pp.getAD_Element_ID() > 0) {
			M_Element element = new M_Element(ctx, pp.getAD_Element_ID(), null);
			pp.setColumnName(element.getColumnName());
			if (pp.isCentrallyMaintained()) {
				pp.setName(element.getName());
				pp.setDescription(element.getDescription());
				pp.setHelp(element.getHelp());
				pp.setPlaceholder(element.getPlaceholder());
			}
		}

		return "";
	}

}
