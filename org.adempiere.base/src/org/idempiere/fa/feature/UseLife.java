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
package org.idempiere.fa.feature;

import java.sql.Timestamp;
import java.util.Properties;
import org.compiere.model.SetGetModel;
 
/**	
 * Describe Use life Feature
 * @author Teo Sarca, SC Arhipac SRL
 * @version $Id$
 */
public interface UseLife extends SetGetModel {
	public Properties getCtx();
	
	//~ public void setUseLifeMonths(int value);
	//~ public int getUseLifeMonths();
	
	//~ public void setUseLifeYears(int value);
	//~ public int getUseLifeYears();

	//~ public void setUseLifeMonths_F(int value);
	//~ public int getUseLifeMonths_F();
	
	//~ public void setUseLifeYears_F(int value);
	//~ public int getUseLifeYears_F();
	
	public Timestamp getAssetServiceDate();
	
	/* commented out by @win
	public int getA_Asset_Class_ID();
	*/
 }