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
package org.adempiere.base.markdown;

/**
 * Markdown rendering interface
 */
public interface IMarkdownRenderer {

	static final String MARKDOWN_OPENING_TAG = "<#md>";
	static final String MARKDOWN_CLOSING_TAG = "</#md>";
	
	/**
	 * Render inputText with markdown to html (with table and autolink extension)
	 * @param inputText
	 * @return html
	 */
	default String renderToHtml(String inputText) {
		return renderToHtml(inputText, true);
	}
	
	/**
	 * @param inputText
	 * @param autoLink
	 * @return html
	 */
	default String renderToHtml(String inputText, boolean autoLink) {
		return renderToHtml(inputText, autoLink, null);
	}
	
	/**
	 * Render inputText with markdown to html (with table and optional autolink extension)
	 * @param inputText
	 * @param autoLink true to enable autolink extension
	 * @param baseURL base URL for relative links
	 * @return html
	 */
	String renderToHtml(String inputText, boolean autoLink, String baseURL);
}
