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
package fi.jawsy.jawwa.zk.atmosphere;

/**
 * class to hold two value, left and right
 * @author hengsin
 *
 * @param <L>
 * @param <R>
 */
public class Either<L, R> {
	private L left;
	private R right;
	
	/**
	 * @param l left value
	 * @param r right value
	 */
	public Either(L l, R r) {
		left = l;
		right = r;
	}
	
	/**
	 * @return left value
	 */
	public L getLeftValue() {
		return left;
	}
	
	/**
	 * @return right value
	 */
	public R getRightValue() {
		return right;
	}
}
