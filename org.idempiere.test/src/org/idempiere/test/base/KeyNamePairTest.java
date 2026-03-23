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

import org.compiere.util.KeyNamePair;
import org.idempiere.test.AbstractTestCase;
import org.junit.jupiter.api.Test;

public class KeyNamePairTest extends AbstractTestCase {

    @Test
    public void testConstructorAndGetters() {
        KeyNamePair pair = new KeyNamePair(123, "TestName");
        assertEquals(123, pair.getKey());
        assertEquals("TestName", pair.getName());
    }

    @Test
    public void testConstructorWithNegativeKey() {
        KeyNamePair pair = new KeyNamePair(-1, "NegativeKey");
        assertEquals(-1, pair.getKey());
        assertEquals("NegativeKey", pair.getName());
    }

    @Test
    public void testGetID() {
        KeyNamePair pair = new KeyNamePair(456, "Name");
        assertEquals("456", pair.getID());
        KeyNamePair nullPair = new KeyNamePair(-1, "Name");
        assertNull(nullPair.getID());
    }

    @Test
    public void testEquals() {
        KeyNamePair pair1 = new KeyNamePair(1, "A");
        KeyNamePair pair2 = new KeyNamePair(1, "A");
        KeyNamePair pair3 = new KeyNamePair(2, "A");
        KeyNamePair pair4 = new KeyNamePair(1, "B");
        assertTrue(pair1.equals(pair2));
        assertFalse(pair1.equals(pair3));
        assertFalse(pair1.equals(pair4));
        assertFalse(pair1.equals(null));
        assertFalse(pair1.equals("not a pair"));
    }

    @Test
    public void testHashCode() {
        KeyNamePair pair1 = new KeyNamePair(99, "Hash");
        KeyNamePair pair2 = new KeyNamePair(99, "Hash");
        assertEquals(pair1.hashCode(), pair2.hashCode());
    }

    @Test
    public void testEmptyConstant() {
        assertEquals(-1, KeyNamePair.EMPTY.getKey());
        assertEquals("", KeyNamePair.EMPTY.getName());
        assertNull(KeyNamePair.EMPTY.getID());
    }
}
