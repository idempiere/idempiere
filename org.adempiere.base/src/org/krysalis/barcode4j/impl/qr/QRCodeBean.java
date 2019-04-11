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

/* $Id: QRCodeBean.java,v 1.3 2012-02-08 12:59:41 jmaerki Exp $ */

package org.krysalis.barcode4j.impl.qr;

import java.awt.Dimension;

import org.krysalis.barcode4j.BarcodeDimension;
import org.krysalis.barcode4j.TwoDimBarcodeLogicHandler;
import org.krysalis.barcode4j.impl.AbstractBarcodeBean;
import org.krysalis.barcode4j.impl.DefaultTwoDimCanvasLogicHandler;
import org.krysalis.barcode4j.output.Canvas;
import org.krysalis.barcode4j.output.CanvasProvider;
import org.krysalis.barcode4j.tools.ECIUtil;
import org.krysalis.barcode4j.tools.UnitConv;

import com.google.zxing.WriterException;
import com.google.zxing.qrcode.encoder.ByteMatrix;
import com.google.zxing.qrcode.encoder.Encoder;
import com.google.zxing.qrcode.encoder.QRCode;

/**
 * This class is an implementation of QR Code (ISO 18004:2006(E)).
 *
 * @version $Id: QRCodeBean.java,v 1.3 2012-02-08 12:59:41 jmaerki Exp $
 */
public class QRCodeBean extends AbstractBarcodeBean {

    /** The default module width (dot size) for DataMatrix. */
    protected static final double DEFAULT_MODULE_WIDTH = UnitConv.in2mm(1.0 / 72); //1px at 72dpi

    /** Error correction level */
    private char errorCorrectionLevel = QRConstants.ERROR_CORRECTION_LEVEL_L;
    /** Message encoding */
    private String encoding = "ISO-8859-1"; //ECI 000003
    /** Optional: the minimum size of the symbol. */
    private Dimension minSize;
    /** Optional: the maximum size of the symbol. */
    private Dimension maxSize;

    /** Create a new instance. */
    public QRCodeBean() {
        this.height = 0.0; //not used by DataMatrix
        this.moduleWidth = DEFAULT_MODULE_WIDTH;
        setQuietZone(QRConstants.QUIET_ZONE_SIZE * moduleWidth);
    }

    /**
     * Sets the error correction level.
     * @param level the error correction level (one of L, M, Q and H)
     */
    public void setErrorCorrectionLevel(char level) {
        switch (level) {
        case QRConstants.ERROR_CORRECTION_LEVEL_L:
        case QRConstants.ERROR_CORRECTION_LEVEL_M:
        case QRConstants.ERROR_CORRECTION_LEVEL_Q:
        case QRConstants.ERROR_CORRECTION_LEVEL_H:
            this.errorCorrectionLevel = level;
            break;
        default:
            throw new IllegalArgumentException(
                    "Invalid error correction level. Valid levels are: L, M, Q and H");
        }
    }

    /**
     * Returns the selected error correction level.
     * @return the error correction level (one of L, M, Q and H)
     */
    public char getErrorCorrectionLevel() {
        return this.errorCorrectionLevel;
    }

    /**
     * Sets the message encoding. The value must conform to one of Java's encodings and
     * have a mapping in the ECI registry.
     * @param encoding the message encoding
     */
    public void setEncoding(String encoding) {
        if (ECIUtil.getECIForEncoding(encoding) < 0) {
            throw new IllegalArgumentException("Not a valid encoding: " + encoding);
        }
        this.encoding = encoding;
    }

    /**
     * Returns the message encoding.
     * @return the message encoding (default is "ISO-8859-1")
     */
    public String getEncoding() {
        return this.encoding;
    }

    /**
     * Sets the minimum symbol size that is to be produced.
     * @param minSize the minimum size (in pixels), or null for no constraint
     */
    public void setMinSize(Dimension minSize) {
        this.minSize = (minSize != null ? new Dimension(minSize) : null);
    }

    /**
     * Returns the minimum symbol size that is to be produced. If the method returns null,
     * there's no constraint on the symbol size.
     * @return the minimum symbol size (in pixels), or null if there's no size constraint
     */
    public Dimension getMinSize() {
        if (this.minSize != null) {
            return new Dimension(this.minSize);
        } else {
            return null;
        }
    }

    /**
     * Sets the maximum symbol size that is to be produced.
     * @param maxSize the maximum size (in pixels), or null for no constraint
     */
    public void setMaxSize(Dimension maxSize) {
        this.maxSize = (maxSize != null ? new Dimension(maxSize) : null);
    }

    /**
     * Returns the maximum symbol size that is to be produced. If the method returns null,
     * there's no constraint on the symbol size.
     * @return the maximum symbol size (in pixels), or null if there's no size constraint
     */
    public Dimension getMaxSize() {
        if (this.maxSize != null) {
            return new Dimension(this.maxSize);
        } else {
            return null;
        }
    }

    /** {@inheritDoc} */
    public void generateBarcode(CanvasProvider canvas, String msg) {
        if ((msg == null)
                || (msg.length() == 0)) {
            throw new NullPointerException("Parameter msg must not be empty");
        }

        TwoDimBarcodeLogicHandler handler =
                new DefaultTwoDimCanvasLogicHandler(this, new Canvas(canvas));

        QRLogicImpl impl = new QRLogicImpl();
        impl.generateBarcodeLogic(handler, msg, encoding, errorCorrectionLevel,
                getMinSize(), getMaxSize());
    }

    /** {@inheritDoc} */
    public BarcodeDimension calcDimensions(String msg) {
        QRCode code = new QRCode();
        try {
        	code = Encoder.encode(msg,
                    QRLogicImpl.getZXingErrorLevel(errorCorrectionLevel),
                    QRLogicImpl.createHints(encoding));
        } catch (WriterException e) {
            throw new RuntimeException(e.getMessage());
        }
        ByteMatrix matrix = code.getMatrix();
        int effWidth = matrix.getWidth();
        int effHeight = matrix.getHeight();
        checkSizeConstraints(effWidth, effHeight);

        double width = effWidth * getModuleWidth();
        double height = effHeight * getBarHeight();
        double qzh = (hasQuietZone() ? getQuietZone() : 0);
        double qzv = (hasQuietZone() ? getVerticalQuietZone() : 0);
        return new BarcodeDimension(width, height,
                width + (2 * qzh), height + (2 * qzv),
                qzh, qzv);
    }

    private void checkSizeConstraints(int width, int height) {
        //Note: we're only checking the constraints, we can't currently influence ZXing's encoder.
        if (this.minSize != null) {
            if (width < this.minSize.width || height < this.minSize.height) {
                throw new IllegalArgumentException(
                        "The given message would result in a smaller symbol than required."
                        + " Requested minimum: "
                        + this.minSize.width + " x " + this.minSize.height
                        + ", effective: "
                        + width + " x " + height);
            }
        }
        if (this.maxSize != null) {
            if (width > this.maxSize.width || height > this.maxSize.height) {
                throw new IllegalArgumentException(
                        "The given message would result in a larger symbol than required."
                        + " Requested maximum: "
                        + this.maxSize.width + " x " + this.maxSize.height
                        + ", effective: "
                        + width + " x " + height);
            }
        }
    }

    /** {@inheritDoc} */
    public double getVerticalQuietZone() {
        return getQuietZone();
    }

    /** {@inheritDoc} */
    public double getBarWidth(int width) {
        return moduleWidth;
    }

    /** {@inheritDoc} */
    public double getBarHeight() {
        return moduleWidth;
    }

}