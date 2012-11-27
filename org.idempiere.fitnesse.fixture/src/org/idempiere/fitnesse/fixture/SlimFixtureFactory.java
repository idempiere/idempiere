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

import java.lang.reflect.Constructor;
import java.util.ArrayList;
import java.util.Collections;
import java.util.List;

import org.idempiere.fitnesse.server.slim.ISlimFixtureFactory;

import fitnesse.slim.ConverterSupport;

/**
 * Slim fixture factory
 * @author hengsin
 * 
 */
public class SlimFixtureFactory implements ISlimFixtureFactory {

	private List<String> paths = new ArrayList<String>();

	/**
	 * default constructor
	 */
	public SlimFixtureFactory() {
		paths.add("org.idempiere.fitnesse.fixture");
	}

	/*
	 * (non-Javadoc)
	 * 
	 * @see
	 * org.idempiere.fitnesse.server.slim.ISlimFixtureFactory#getFixture(java
	 * .lang.String, java.lang.Object[])
	 */
	@Override
	public Object getFixture(String className, Object[] args) {
		Class<?> k = searchPathsForClass(className);
		if (k == null)
			return null;

		Constructor<?> constructor = getConstructor(k.getConstructors(), args);
		if (constructor == null)
			return null;

		try {
			Object newInstance = constructor.newInstance(ConverterSupport
					.convertArgs(args, constructor.getParameterTypes()));
			return newInstance;
		} catch (Exception e) {
		}
		return null;
	}

	private Constructor<?> getConstructor(Constructor<?>[] constructors,
			Object[] args) {
		for (Constructor<?> constructor : constructors) {
			Class<?> arguments[] = constructor.getParameterTypes();
			if (arguments.length == args.length)
				return constructor;
		}
		return null;
	}

	private Class<?> searchPathsForClass(String className) {
		Class<?> k = getClass(className);
		if (k != null)
			return k;
		List<String> reversedPaths = new ArrayList<String>(paths);
		Collections.reverse(reversedPaths);
		for (String path : reversedPaths) {
			k = getClass(path + "." + className);
			if (k != null)
				return k;
		}
		return null;
	}

	private Class<?> getClass(String className) {
		try {
			return getClass().getClassLoader().loadClass(className);
		} catch (ClassNotFoundException e) {
			return null;
		}
	}
}
