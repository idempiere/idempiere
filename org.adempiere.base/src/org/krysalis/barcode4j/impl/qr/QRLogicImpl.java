/*
 * Copyright 2012 Jeremias Maerki.
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

/* $Id: QRLogicImpl.java,v 1.3 2012-02-08 12:59:41 jmaerki Exp $ */

package org.krysalis.barcode4j.impl.qr;

import java.awt.Dimension;
import java.util.Hashtable;

import org.krysalis.barcode4j.TwoDimBarcodeLogicHandler;

import com.google.zxing.EncodeHintType;
import com.google.zxing.WriterException;
import com.google.zxing.qrcode.decoder.ErrorCorrectionLevel;
import com.google.zxing.qrcode.encoder.ByteMatrix;
import com.google.zxing.qrcode.encoder.Encoder;
import com.google.zxing.qrcode.encoder.QRCode;

/**
 * Top-level class for the logic part of the DataMatrix implementation.
 *
 * @version $Id: QRLogicImpl.java,v 1.3 2012-02-08 12:59:41 jmaerki Exp $
 */
public class QRLogicImpl implements QRConstants {

    /**
     * Generates the barcode logic.
     * @param logic the logic handler to receive generated events
     * @param msg the message to encode
     * @param errorCorrectionLevel the error correction level (one of L, M, Q, H)
     * @param encoding the message encoding
     * @param minSize the minimum symbol size constraint or null for no constraint
     * @param maxSize the maximum symbol size constraint or null for no constraint
     */
    public void generateBarcodeLogic(TwoDimBarcodeLogicHandler logic, String msg,
            String encoding,
            char errorCorrectionLevel,
            Dimension minSize, Dimension maxSize) {

        //TODO ZXing doesn't allow to set minSize/maxSize through its API

        ErrorCorrectionLevel zxingErrLevel = getZXingErrorLevel(errorCorrectionLevel);
        Hashtable<EncodeHintType,String> hints = createHints(encoding);

        QRCode code = new QRCode();
        try {
            code = Encoder.encode(msg, zxingErrLevel, hints);
        } catch (WriterException e) {
            throw new RuntimeException(e.getMessage(), e);
        }
        ByteMatrix matrix = code.getMatrix();

        //finally, paint the barcode
        logic.startBarcode(msg, msg);
        encodeLowLevel(logic, matrix);
        logic.endBarcode();
    }

    static Hashtable<EncodeHintType,String> createHints(String encoding) {
        Hashtable<EncodeHintType,String> hints = null;
        if (!"ISO-8859-1".equals(encoding)) {
            hints = new Hashtable<EncodeHintType, String>();
            hints.put(EncodeHintType.CHARACTER_SET, encoding);
        }
        return hints;
    }

    static ErrorCorrectionLevel getZXingErrorLevel(char errorCorrectionLevel) {
        ErrorCorrectionLevel zxingErrLevel;
        switch (errorCorrectionLevel) {
        case ERROR_CORRECTION_LEVEL_L:
            zxingErrLevel = ErrorCorrectionLevel.L;
            break;
        case ERROR_CORRECTION_LEVEL_M:
            zxingErrLevel = ErrorCorrectionLevel.M;
            break;
        case ERROR_CORRECTION_LEVEL_Q:
            zxingErrLevel = ErrorCorrectionLevel.Q;
            break;
        case ERROR_CORRECTION_LEVEL_H:
            zxingErrLevel = ErrorCorrectionLevel.H;
            break;
        default:
            throw new IllegalArgumentException(
                    "Invalid error correction level: " + errorCorrectionLevel);
        }
        return zxingErrLevel;
    }

    private void encodeLowLevel(TwoDimBarcodeLogicHandler logic, ByteMatrix matrix) {
        int symbolWidth = matrix.getWidth();
        int symbolHeight = matrix.getHeight();
        for (int y = 0; y < symbolHeight; y++) {
            logic.startRow();
            for (int x = 0; x < symbolWidth; x++) {
                logic.addBar(matrix.get(x, y) == 1, 1);
            }
            logic.endRow();
        }
    }

}
