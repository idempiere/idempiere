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
package org.idempiere.jettison.mapped;

import javax.xml.stream.XMLStreamException;
import javax.xml.stream.XMLStreamReader;

import org.codehaus.jettison.AbstractXMLInputFactory;
import org.codehaus.jettison.json.JSONException;
import org.codehaus.jettison.json.JSONObject;
import org.codehaus.jettison.json.JSONTokener;
import org.codehaus.jettison.mapped.MappedNamespaceConvention;
import org.codehaus.jettison.mapped.MappedXMLStreamReader;

/**
 * @author hengsin
 *
 */
public class MappedXMLInputFactory extends AbstractXMLInputFactory {


    private MappedNamespaceConvention convention;

    /**
     * 
     * @param convention
     */
    public MappedXMLInputFactory(MappedNamespaceConvention convention) {
        this.convention = convention;
    }
    
    /**
     * @param tokener
     * @return {@link XMLStreamReader}
     */
    public XMLStreamReader createXMLStreamReader(JSONTokener tokener) throws XMLStreamException {
        try {
            JSONObject root = createJSONObject(tokener);
            return new MappedXMLStreamReader(root, convention);
        } catch (JSONException e) {
            throw new XMLStreamException(e);
        }
    }
    
    /**
     * 
     * @param tokener
     * @return {@link JSONObject}
     * @throws JSONException
     */
    protected JSONObject createJSONObject(JSONTokener tokener) throws JSONException {
    	return new JSONObject(tokener);
    }
}
