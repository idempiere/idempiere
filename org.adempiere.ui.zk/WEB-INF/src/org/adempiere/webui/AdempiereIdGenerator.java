/******************************************************************************
 * Copyright (C) 2010 Carlos Ruiz                                             *
 * Copyright (C) 2009 Quality Systems & Solutions - globalqss                 *
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

package org.adempiere.webui;

import java.util.regex.Matcher;
import java.util.regex.Pattern;

import org.zkoss.zk.ui.Component;
import org.zkoss.zk.ui.Desktop;
import org.zkoss.zk.ui.Page;
import org.zkoss.zk.ui.sys.IdGenerator;

public class AdempiereIdGenerator implements IdGenerator {

	private static final String DEFAULT_ZK_COMP_PREFIX = "zk_comp_";
	private static final String DESKTOP_ID_ATTRIBUTE = "org.adempiere.comp.id";
	public static final String ZK_COMPONENT_PREFIX_ATTRIBUTE = "zk_component_prefix";

	@Override
	public String nextComponentUuid(Desktop desktop, Component comp) {
		String prefix = (String) comp.getAttribute(ZK_COMPONENT_PREFIX_ATTRIBUTE);
		if (prefix == null || prefix.length() == 0)
			prefix = DEFAULT_ZK_COMP_PREFIX;
		else {
			Pattern pattern = Pattern.compile("[^a-zA-Z_0-9]");
			Matcher matcher = pattern.matcher(prefix);
			StringBuffer sb = new StringBuffer();
			while(matcher.find()) {
				matcher.appendReplacement(sb, "_");
			}
			matcher.appendTail(sb);
			prefix = sb.toString();
		}
		int i = 0;
		try {
			String number = null;
			if (desktop.getAttribute(DESKTOP_ID_ATTRIBUTE) != null) {
				number = desktop.getAttribute(DESKTOP_ID_ATTRIBUTE).toString();
				i = Integer.parseInt(number);
				i++;// Start from 1
			}
		} catch (Throwable t) {
			i = 1;
		}
		desktop.setAttribute(DESKTOP_ID_ATTRIBUTE, String.valueOf(i));
		return prefix + i;
	}

	@Override
	public String nextDesktopId(Desktop desktop) {
		if (desktop.getAttribute(DESKTOP_ID_ATTRIBUTE) == null) {
			String number = "0";
			desktop.setAttribute(DESKTOP_ID_ATTRIBUTE, number);
		}
		return null;
	}

	@Override
	public String nextPageUuid(Page page) {
		return null;
	}

}
