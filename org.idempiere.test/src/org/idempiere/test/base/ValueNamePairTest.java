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
 * - Carlos Ruiz - globalqss - bxservice                               *
 **********************************************************************/

/**
 *
 * @author Carlos Ruiz - globalqss - bxservice
 *
 */
package org.idempiere.test.base;

import static org.junit.jupiter.api.Assertions.assertEquals;
import static org.junit.jupiter.api.Assertions.assertFalse;
import static org.junit.jupiter.api.Assertions.assertNull;
import static org.junit.jupiter.api.Assertions.assertTrue;

import org.compiere.util.ValueNamePair;
import org.idempiere.test.AbstractTestCase;
import org.junit.jupiter.api.Test;

public class ValueNamePairTest extends AbstractTestCase {

    @Test
    public void testConstructorAndGetValue() {
        ValueNamePair pair = new ValueNamePair("key", "name");
        assertEquals("key", pair.getValue());
        assertEquals("name", pair.getName());
    }

    @Test
    public void testConstructorWithNullValue() {
        ValueNamePair pair = new ValueNamePair(null, "name");
        assertEquals("", pair.getValue());
    }

    @Test
    public void testGetID() {
        ValueNamePair pair = new ValueNamePair("key", "name");
        assertEquals("key", pair.getID());
        ValueNamePair emptyPair = new ValueNamePair("", "name");
        assertNull(emptyPair.getID());
    }

    @Test
    public void testEquals() {
        ValueNamePair pair1 = new ValueNamePair("key", "name");
        ValueNamePair pair2 = new ValueNamePair("key", "name");
        ValueNamePair pair3 = new ValueNamePair("other", "name");
        ValueNamePair pair4 = new ValueNamePair("key", "otherName");
        assertTrue(pair1.equals(pair2));
        assertFalse(pair1.equals(pair3));
        assertFalse(pair1.equals(pair4));
        assertFalse(pair1.equals(null));
        assertFalse(pair1.equals("not a pair"));
    }

    @Test
    public void testGetValueObject() {
        ValueNamePair pair = new ValueNamePair("key", "name");
        assertEquals("key", pair.getValueObject());
    }

    @Test
    public void testHashCode() {
        ValueNamePair pair1 = new ValueNamePair("key", "name");
        ValueNamePair pair2 = new ValueNamePair("key", "name");
        assertEquals(pair1.hashCode(), pair2.hashCode());
    }

    @Test
    public void testEmptyConstant() {
        assertEquals("", ValueNamePair.EMPTY.getValue());
        assertEquals("", ValueNamePair.EMPTY.getName());
        assertNull(ValueNamePair.EMPTY.getID());
    }

}