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

/* $Id: QRConstants.java,v 1.1 2012-01-27 14:36:35 jmaerki Exp $ */

package org.krysalis.barcode4j.impl.qr;

/**
 * Constants for QR Code.
 *
 * @version $Id: QRConstants.java,v 1.1 2012-01-27 14:36:35 jmaerki Exp $
 */
public interface QRConstants {

    char ERROR_CORRECTION_LEVEL_L = 'L';
    char ERROR_CORRECTION_LEVEL_M = 'M';
    char ERROR_CORRECTION_LEVEL_Q = 'Q';
    char ERROR_CORRECTION_LEVEL_H = 'H';

    int QUIET_ZONE_SIZE = 4;
    int QUIET_ZONE_SIZE_MICRO = 2;

    int NUMERIC = 0;
    int ALPHANUMERIC = 1;
    int BINARY = 2;

    int[] ALPHANUMERIC_TABLE = {
            -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1,  //0x00-0x0f
            -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1,  //0x10-0x1f
            36, -1, -1, -1, 37, 38, -1, -1, -1, -1, 39, 40, -1, 41, 42, 43,  //0x20-0x2f
             0,  1,  2,  3,  4,  5,  6,  7,  8,  9, 44, -1, -1, -1, -1, -1,  //0x30-0x3f
            -1, 10, 11, 12, 13, 14, 15, 16, 17, 18, 19, 20, 21, 22, 23, 24,  //0x40-0x4f
            25, 26, 27, 28, 29, 30, 31, 32, 33, 34, 35, -1, -1, -1, -1, -1,  //0x50-0x5f
    };

}
