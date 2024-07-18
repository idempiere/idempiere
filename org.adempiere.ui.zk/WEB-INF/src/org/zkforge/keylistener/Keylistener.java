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
package org.zkforge.keylistener;

import java.io.IOException;

import org.zkoss.lang.Objects;
import org.zkoss.mesg.MCommon;
import org.zkoss.zk.ui.HtmlBasedComponent;
import org.zkoss.zk.ui.UiException;
import org.zkoss.zk.ui.WrongValueException;
import org.zkoss.zk.ui.sys.ContentRenderer;

/**
 * Keylistener component. See Window for specification of ctrlKey format.
 *
 * @author boha
 *
 */
public class Keylistener extends HtmlBasedComponent {

	private String _ctrlKeys;

	private String _jsCtrlKeys;

	private boolean _autoBlur = true;

	/**
	 * generated serial UID
	 */
	private static final long serialVersionUID = 4611014738053691844L;

	/**
	 * Is auto blur active
	 *
	 * @return true if autoBlur is enable, false otherwise
	 */
	public boolean isAutoBlur() {
		return _autoBlur;
	}

	/**
	 * Set auto blur. If auto blur is set, focus will be moved to keylistener
	 * component before onCtrlKey event is triggered. This is used to force any
	 * pending onChange events to be triggered first.
	 *
	 * @param autoBlur
	 *            the autoBlur to set
	 */
	public void setAutoBlur(boolean autoBlur) {
		this._autoBlur = autoBlur;
		smartUpdate("autoblur", _autoBlur);
	}

	/**
	 * Get control keys
	 *
	 * @return the ctrlKeys
	 */
	public String getCtrlKeys() {
		return _ctrlKeys;
	}

	/**
	 * Set control keys to listen for
	 *
	 * @param ctrlKeys
	 *            the ctrlKeys to set
	 */
	public void setCtrlKeys(String ctrlKeys) {
		if (ctrlKeys != null && ctrlKeys.length() == 0)
			ctrlKeys = null;
		if (!Objects.equals(this._ctrlKeys, ctrlKeys)) {
			parseCtrlKeys(ctrlKeys);
			smartUpdate("ctrlKeys", _jsCtrlKeys);
		}
	}

	@Override
	protected void renderProperties(ContentRenderer renderer)
			throws IOException {
		super.renderProperties(renderer);
		render(renderer, "ctrlKeys", _jsCtrlKeys);
		render(renderer, "autoblur", _autoBlur);
	}

	private void parseCtrlKeys(String keys) throws UiException {
		if (keys == null || keys.length() == 0) {
			_ctrlKeys = _jsCtrlKeys = null;
			return;
		}

		final StringBuffer sbctl = new StringBuffer(), sbsft = new StringBuffer(), sbalt = new StringBuffer(), sbext = new StringBuffer();
		StringBuffer sbcur = null;
		for (int j = 0, len = keys.length(); j < len; ++j) {
			char cc = keys.charAt(j);
			switch (cc) {
			case '^':
			case '$':
			case '@':
				if (sbcur != null)
					throw new WrongValueException(
							"Combination of Shift, Alt and Ctrl not supported: "
									+ keys);
				sbcur = cc == '^' ? sbctl : cc == '@' ? sbalt : sbsft;
				break;
			case '#': {
				int k = j + 1;
				for (; k < len; ++k) {
					final char c2 = (char) keys.charAt(k);
					if ((c2 > 'Z' || c2 < 'A') && (c2 > 'z' || c2 < 'a')
							&& (c2 > '9' || c2 < '0'))
						break;
				}
				if (k == j + 1)
					throw new WrongValueException(MCommon.UNEXPECTED_CHARACTER,
							new Object[] { Character.valueOf(cc), keys });

				final String s = keys.substring(j + 1, k).toLowerCase();
				if ("pgup".equals(s))
					cc = 'A';
				else if ("pgdn".equals(s))
					cc = 'B';
				else if ("end".equals(s))
					cc = 'C';
				else if ("home".equals(s))
					cc = 'D';
				else if ("left".equals(s))
					cc = 'E';
				else if ("up".equals(s))
					cc = 'F';
				else if ("right".equals(s))
					cc = 'G';
				else if ("down".equals(s))
					cc = 'H';
				else if ("ins".equals(s))
					cc = 'I';
				else if ("del".equals(s))
					cc = 'J';
				else if ("enter".equals(s))
					cc = 'K';
				else if (s.length() > 1 && s.charAt(0) == 'f') {
					final int v;
					try {
						v = Integer.parseInt(s.substring(1));
					} catch (Throwable ex) {
						throw new WrongValueException("Unknown #" + s + " in "
								+ keys);
					}
					if (v == 0 || v > 12)
						throw new WrongValueException(
								"Unsupported function key: #f" + v);
					cc = (char) ('O' + v); // 'P': F1, 'Q': F2... 'Z': F12
				} else
					throw new WrongValueException("Unknown #" + s + " in "
							+ keys);

				if (sbcur == null)
					sbext.append(cc);
				else {
					sbcur.append(cc);
					sbcur = null;
				}
				j = k - 1;
			}
				break;
			default:
				if (sbcur == null
						|| ((cc > 'Z' || cc < 'A') && (cc > 'z' || cc < 'a') && (cc > '9' || cc < '0')))
					throw new WrongValueException(MCommon.UNEXPECTED_CHARACTER,
							new Object[] { Character.valueOf(cc), keys });
				if (sbcur == sbsft)
					throw new WrongValueException("$" + cc + " not supported: "
							+ keys);

				if (cc <= 'Z' && cc >= 'A')
					cc = (char) (cc + ('a' - 'A')); // to lower case
				sbcur.append(cc);
				sbcur = null;
				break;
			}
		}

		_jsCtrlKeys = new StringBuffer().append('^').append(sbctl).append(';')
				.append('@').append(sbalt).append(';').append('$')
				.append(sbsft).append(';').append('#').append(sbext)
				.append(';').toString();
		_ctrlKeys = keys;
	}

	/* (non-Javadoc)
	 * @see org.zkoss.zk.ui.AbstractComponent#isChildable()
	 */
	public boolean isChildable() {
		return false;
	}
}