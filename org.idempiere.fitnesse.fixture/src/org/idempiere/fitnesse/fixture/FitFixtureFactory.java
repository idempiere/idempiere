/******************************************************************************
 * Copyright (C) 2012 Heng Sin Low                                            *
 * Copyright (C) 2012 Trek Global                 							  *
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
package org.idempiere.fitnesse.fixture;

import org.idempiere.fitnesse.server.fit.IFitFixtureFactory;

import fit.Fixture;
import fit.FixtureName;

/**
 * Fit fixture factory
 * @author hengsin
 *
 */
public class FitFixtureFactory implements IFitFixtureFactory {

	private final static String DEFAULT_PACKAGE = "org.idempiere.fitnesse.fixture";
	
	/**
	 * default constructor 
	 */
	public FitFixtureFactory() {
	}

	/* (non-Javadoc)
	 * @see org.idempiere.fitnesse.server.fit.IFixtureFactory#getFixture(FixtureName)
	 */
	@Override
	public Fixture getFixture(FixtureName fixtureName) {
		String className = fixtureName.toString();
		try {
			Class<Fixture> clazz = (Class<Fixture>) getClass().getClassLoader().loadClass(className);
			return clazz.newInstance();
		} catch (ClassNotFoundException e) {
		} catch (InstantiationException e) {
		} catch (IllegalAccessException e) {
		}
		
		if (!fixtureName.isFullyQualified()) {
			className = DEFAULT_PACKAGE + "." + fixtureName.toString();
			try {
				Class<Fixture> clazz = (Class<Fixture>) getClass().getClassLoader().loadClass(className);
				return clazz.newInstance();
			} catch (ClassNotFoundException e) {
			} catch (InstantiationException e) {
			} catch (IllegalAccessException e) {
			}
		}
		return null;
	}

}
