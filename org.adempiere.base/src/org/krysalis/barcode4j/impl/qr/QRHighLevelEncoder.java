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

/* $Id: QRHighLevelEncoder.java,v 1.1 2012-01-27 14:36:35 jmaerki Exp $ */

package org.krysalis.barcode4j.impl.qr;

/**
 * High-level encoder for QR Code.
 *
 * @version $Id: QRHighLevelEncoder.java,v 1.1 2012-01-27 14:36:35 jmaerki Exp $
 */
public class QRHighLevelEncoder implements QRConstants {

    //private final String msg;
    private int encodingMode;

    public QRHighLevelEncoder(String msg) {
        //this.msg = msg;
        this.encodingMode = analyzeMessage(msg);
    }

    public int getEncodingMode() {
        return this.encodingMode;
    }

    private int analyzeMessage(String msg) {
        int mode = NUMERIC;
        for (int i = 0, c = msg.length(); i < c; i++) {
            char ch = msg.charAt(i);
            if (isDigit(ch)) {
                //nop
            } else if (mode == NUMERIC && isAlphanumeric(ch)) {
                mode = ALPHANUMERIC;
            } else {
                mode = BINARY;
                break;
            }
        }
        return mode;
    }

    private static final boolean isDigit(char ch) {
        return ch >= '0' && ch <= '9';
    }

    private static final boolean isAlphanumeric(char ch) {
        return ALPHANUMERIC_TABLE[ch] >= 0;
    }

}
