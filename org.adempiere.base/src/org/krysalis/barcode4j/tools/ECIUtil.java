/*
 * Copyright 2012 Jeremias Maerki, Switzerland
 *
 * Licensed under the Apache License, Version 2.0 (the "License");
 * you may not use this file except in compliance with the License.
 * You may obtain a copy of the License at
 *
 *      http://www.apache.org/licenses/LICENSE-2.0
 *
 * Unless required by applicable law or agreed to in writing, software
 * distributed under the License is distributed on an "AS IS" BASIS,
 * WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
 * See the License for the specific language governing permissions and
 * limitations under the License.
 */

/* $Id: ECIUtil.java,v 1.1 2012-01-27 14:36:35 jmaerki Exp $ */

package org.krysalis.barcode4j.tools;

import java.util.Map;

/**
 * Utilities around ECI (extended channel interpretation).
 *
 * @version $Id: ECIUtil.java,v 1.1 2012-01-27 14:36:35 jmaerki Exp $
 */
public class ECIUtil {

    /** ECI code for 8-bit binary data */
    public static final int ECI_BINARY = 899;

    private static final Map<String, Integer> encodingToECI = new java.util.HashMap<String, Integer>();

    static {
        mapEncoding("Cp437", 2);
        mapEncoding("ISO-8859-1", 3);
        mapEncoding("ISO-8859-2", 4);
        mapEncoding("ISO-8859-3", 5);
        mapEncoding("ISO-8859-4", 6);
        mapEncoding("ISO-8859-5", 7);
        mapEncoding("ISO-8859-6", 8);
        mapEncoding("ISO-8859-7", 9);
        mapEncoding("ISO-8859-8", 10);
        mapEncoding("ISO-8859-9", 11);
        mapEncoding("ISO-8859-10", 12);
        mapEncoding("ISO-8859-11", 13);
        mapEncoding("ISO-8859-13", 15);
        mapEncoding("ISO-8859-14", 16);
        mapEncoding("ISO-8859-15", 17);
        mapEncoding("ISO-8859-16", 18);
        mapEncoding("SJIS", 20);
        mapEncoding("Cp1250", 21);
        mapEncoding("Cp1251", 22);
        mapEncoding("Cp1252", 23);
        mapEncoding("Cp1256", 24);
        mapEncoding("UnicodeBigUnmarked", 25);
        mapEncoding("UTF-8", 26);
        mapEncoding("US-ASCII", 27);
        mapEncoding("Big5", 28);
        mapEncoding("GB18030", 29);
    }

    private static void mapEncoding(String encoding, int eci) {
        encodingToECI.put(encoding, Integer.valueOf(eci));
    }

    /**
     * Returns the ECI code for a given encoding.
     * @param encoding the encoding
     * @return the corresponding ECI code
     */
    public static int getECIForEncoding(String encoding) {
        Integer code = encodingToECI.get(encoding);
        if (code != null) {
            return code.intValue();
        } else {
            return -1; //undefined
        }
    }

}
