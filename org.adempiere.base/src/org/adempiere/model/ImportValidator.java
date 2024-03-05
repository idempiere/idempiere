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
package org.adempiere.model;

import org.adempiere.process.ImportProcess;

/**
 * Import Validator Interface
 * @author Teo Sarca, www.arhipac.ro
 * 			<li>FR [ 2788276 ] Data Import Validator
 * 				https://sourceforge.net/p/adempiere/feature-requests/712/
 */
public interface ImportValidator
{
	/** Event triggered before all import records are validated */
	public static final int TIMING_BEFORE_VALIDATE = 10;
	/** Event triggered after all import records are validated */
	public static final int TIMING_AFTER_VALIDATE = 20;
	/** Event triggered before an import record is processed */
	public static final int TIMING_BEFORE_IMPORT = 30;
	/** Event triggered after an import record is processed */
	public static final int TIMING_AFTER_IMPORT = 40;
	
	/**
	 * Handle import event
	 * @param process
	 * @param importModel
	 * @param targetModel
	 * @param timing {@link #TIMING_BEFORE_VALIDATE}, {@link #TIMING_AFTER_VALIDATE},
	 * {@link #TIMING_BEFORE_IMPORT} or {@link #TIMING_AFTER_IMPORT}.
	 */
	public void validate(ImportProcess process, Object importModel, Object targetModel, int timing);
}
