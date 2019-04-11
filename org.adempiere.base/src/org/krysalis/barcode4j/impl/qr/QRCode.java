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

/* $Id: QRCode.java,v 1.1 2012-01-27 14:36:35 jmaerki Exp $ */

package org.krysalis.barcode4j.impl.qr;

import java.awt.Dimension;

import org.krysalis.barcode4j.impl.ConfigurableBarcodeGenerator;
import org.krysalis.barcode4j.tools.Length;

import org.apache.avalon.framework.configuration.Configurable;
import org.apache.avalon.framework.configuration.Configuration;
import org.apache.avalon.framework.configuration.ConfigurationException;

/**
 * This class is an implementation of QR Code.
 *
 * @version $Id: QRCode.java,v 1.1 2012-01-27 14:36:35 jmaerki Exp $
 */
public class QRCode extends ConfigurableBarcodeGenerator
            implements Configurable {

    /** Create a new instance. */
    public QRCode() {
        this.bean = new QRCodeBean();
    }

    /**
     * @see org.apache.avalon.framework.configuration.Configurable#configure(Configuration)
     */
    public void configure(Configuration cfg) throws ConfigurationException {
        //Module width (MUST ALWAYS BE FIRST BECAUSE QUIET ZONE MAY DEPEND ON IT)
        String mws = cfg.getChild("module-width").getValue(null);
        if (mws != null) {
            Length mw = new Length(mws, "mm");
            getQRBean().setModuleWidth(mw.getValueAsMillimeter());
        }

        super.configure(cfg);

        String encoding = cfg.getChild("encoding").getValue(null);
        if (encoding != null) {
            getQRBean().setEncoding(encoding);
        }

        String ecLevel = cfg.getChild("ec-level").getValue(null);
        if (ecLevel != null && ecLevel.length() > 0) {
            getQRBean().setErrorCorrectionLevel(ecLevel.charAt(0));
        }

        String size;
        size = cfg.getChild("min-symbol-size").getValue(null);
        if (size != null) {
            getQRBean().setMinSize(parseSymbolSize(size));
        }
        size = cfg.getChild("max-symbol-size").getValue(null);
        if (size != null) {
            getQRBean().setMaxSize(parseSymbolSize(size));
        }
    }

    private Dimension parseSymbolSize(String size) {
        int idx = size.indexOf('x');
        Dimension dim;
        if (idx > 0) {
            dim = new Dimension(Integer.parseInt(size.substring(0, idx)),
                    Integer.parseInt(size.substring(idx + 1)));
        } else {
            int extent = Integer.parseInt(size);
            dim = new Dimension(extent, extent);
        }
        return dim;
    }

    /**
     * @return the underlying DataMatrix bean
     */
    public QRCodeBean getQRBean() {
        return (QRCodeBean)getBean();
    }

}