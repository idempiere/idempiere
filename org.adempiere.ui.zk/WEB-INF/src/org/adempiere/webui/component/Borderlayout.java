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
 * - teo_sarca                         								   *
 **********************************************************************/
package org.adempiere.webui.component;

import org.zkoss.zk.ui.Component;
import org.zkoss.zul.Center;
import org.zkoss.zul.East;
import org.zkoss.zul.North;
import org.zkoss.zul.South;
import org.zkoss.zul.West;

/**
 * Extend {@link org.zkoss.zul.Borderlayout}
 * @author teo_sarca
 */
public class Borderlayout extends org.zkoss.zul.Borderlayout
{
	/**
	 * generated serial id
	 */
	private static final long serialVersionUID = -6976820221945897268L;
	
	/**
	 * Default constructor
	 */
	public Borderlayout()
	{
		super();
	}
	
	/**
	 * Add component to North
	 * @param c Component
	 * @return this
	 */
	public Borderlayout appendNorth(Component c)
	{
		North north = getNorth();
		if (north == null)
		{
			north = new North();
			this.appendChild(north);
		}
		north.appendChild(c);
		return this;
	}
	
	/**
	 * Add component to West
	 * @param c Component
	 * @return this
	 */
	public Borderlayout appendWest(Component c)
	{
		West west = getWest();
		if (west == null)
		{
			west = new West();
			this.appendChild(west);
		}
		west.appendChild(c);
		return this;
	}
	
	/**
	 * Add component to South
	 * @param c Component
	 * @return this
	 */
	public Borderlayout appendSouth(Component c)
	{
		South south = getSouth();
		if (south == null)
		{
			south = new South();
			this.appendChild(south);
		}
		south.appendChild(c);
		return this;
	}
	
	/**
	 * Add component to East
	 * @param c Component
	 * @return this
	 */
	public Borderlayout appendEast(Component c)
	{
		East east = getEast();
		if (east == null)
		{
			east = new East();
			this.appendChild(east);
		}
		east.appendChild(c);
		return this;
	}
	
	/**
	 * Add component to Center
	 * @param c Component
	 * @return this
	 */
	public Borderlayout appendCenter(Component c)
	{
		Center center = getCenter();
		if (center == null)
		{
			center = new Center();
			this.appendChild(center);
		}
		center.appendChild(c);
		return this;
	}
}
