/******************************************************************************
 * Product: Adempiere ERP & CRM Smart Business Solution                       *
 * Copyright (C) 1999-2006 Adempiere, Inc. All Rights Reserved.               *
 * This program is free software; you can redistribute it and/or modify it    *
 * under the terms version 2 of the GNU General Public License as published   *
 * by the Free Software Foundation. This program is distributed in the hope   *
 * that it will be useful, but WITHOUT ANY WARRANTY; without even the implied *
 * warranty of MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.           *
 * See the GNU General Public License for more details.                       *
 * You should have received a copy of the GNU General Public License along    *
 * with this program; if not, write to the Free Software Foundation, Inc.,    *
 * 59 Temple Place, Suite 330, Boston, MA 02111-1307 USA.                     *
 *****************************************************************************/
package org.adempiere.pdf;

import java.awt.Font;
import java.awt.Graphics2D;
import java.awt.GraphicsEnvironment;
import java.awt.print.PageFormat;
import java.awt.print.Pageable;
import java.io.ByteArrayOutputStream;
import java.io.File;
import java.io.FileOutputStream;
import java.io.OutputStream;
import java.util.Locale;
import java.util.logging.Level;

import org.adempiere.exceptions.AdempiereException;
import org.compiere.model.MSysConfig;
import org.compiere.util.CCache;
import org.compiere.util.CLogger;
import org.compiere.util.Ini;
import org.compiere.util.Util;

import com.lowagie.text.FontFactory;
import com.lowagie.text.Rectangle;
import com.lowagie.text.pdf.DefaultFontMapper;
import com.lowagie.text.pdf.PdfContentByte;
import com.lowagie.text.pdf.PdfGraphics2D;
import com.lowagie.text.pdf.PdfTemplate;
import com.lowagie.text.pdf.PdfWriter;

/**
 * Create PDF document from {@link Pageable} using iText (openpdf)
 * @author Low Heng Sin
 */
public class Document {

	private static final CLogger log = CLogger.getCLogger(Document.class);

	private static final Object FONT_MAPPER_LOCK = new Object();
	private static final Object AWT_FONT_LOCK = new Object();
	private static final CCache<String, DefaultFontMapper> s_fontMapperCache =
			new CCache<>(MSysConfig.Table_Name, "Document_DefaultFontMapper", 5, 0, false, 0);
	private static final CCache<String, Boolean> s_registeredAwtFontDirs =
			new CCache<>(MSysConfig.Table_Name, "Document_AwtFonts", 5, 0, false, 0);
	private static boolean s_fontDirectoriesRegistered = false;

	private static String getPdfFontDir() {
		String pdfFontDir = MSysConfig.getValue(MSysConfig.PDF_FONT_DIR, "");
		if (Util.isEmpty(pdfFontDir, true)) {
			return new File(Ini.getAdempiereHome().trim(), "fonts").getPath();
		}
		return pdfFontDir.trim();
	}

	/**
	 * Register custom fonts (.ttf, .otf, .ttc) from PDF_FONT_DIR or IDEMPIERE_HOME/fonts with AWT GraphicsEnvironment
	 */
	public static void registerCustomAwtFonts() {
		String pdfFontDir = getPdfFontDir();
		if (Util.isEmpty(pdfFontDir, true) || Boolean.TRUE.equals(s_registeredAwtFontDirs.get(pdfFontDir))) {
			return;
		}
		synchronized (AWT_FONT_LOCK) {
			if (Boolean.TRUE.equals(s_registeredAwtFontDirs.get(pdfFontDir))) {
				return;
			}
			File dir = new File(pdfFontDir);
			if (dir.exists() && dir.isDirectory()) {
				File[] files = dir.listFiles();
				if (files != null) {
					GraphicsEnvironment ge = GraphicsEnvironment.getLocalGraphicsEnvironment();
					for (File file : files) {
						if (!file.isFile()) {
							continue;
						}
						String name = file.getName().toLowerCase(Locale.ROOT);
						if (name.endsWith(".ttf") || name.endsWith(".otf") || name.endsWith(".ttc")) {
							try {
								for (Font font : Font.createFonts(file)) {
									ge.registerFont(font);
								}
							} catch (Exception e) {
								log.log(Level.WARNING, file.getPath(), e);
							}
						}
					}
				}
			}
			s_registeredAwtFontDirs.put(pdfFontDir, Boolean.TRUE);
		}
	}

	private static DefaultFontMapper getDefaultFontMapper() {
		String pdfFontDir = getPdfFontDir();
		DefaultFontMapper mapper = s_fontMapperCache.get(pdfFontDir);
		if (mapper != null) {
			return mapper;
		}
		synchronized (FONT_MAPPER_LOCK) {
			mapper = s_fontMapperCache.get(pdfFontDir);
			if (mapper != null) {
				return mapper;
			}
			if (!s_fontDirectoriesRegistered) {
				FontFactory.registerDirectories();
				s_fontDirectoriesRegistered = true;
			}
			mapper = new DefaultFontMapper();
			if (!Util.isEmpty(pdfFontDir, true)) {
				File dir = new File(pdfFontDir);
				if (dir.exists() && dir.isDirectory()) {
					mapper.insertDirectory(pdfFontDir);
				}
			}
			s_fontMapperCache.put(pdfFontDir, mapper);
			return mapper;
		}
	}

	/**
	 * write pageable to output
	 * @param pageable
	 * @param output
	 */
	public static void writePDF(Pageable pageable, OutputStream output)
	{
		try {
            final PageFormat pf = pageable.getPageFormat(0);
            
            final com.lowagie.text.Document document =
            	new com.lowagie.text.Document(new Rectangle(
            			(int) pf.getWidth(), (int) pf.getHeight()));
            final PdfWriter writer = PdfWriter.getInstance(
                    document, output);
            writer.setPdfVersion(PdfWriter.VERSION_1_2);
            document.open();
            final DefaultFontMapper mapper = getDefaultFontMapper();
            
            final float w = (float) pf.getWidth();
            final float h = (float) pf.getHeight();
            final PdfContentByte cb = writer.getDirectContent();
            for (int page = 0; page < pageable.getNumberOfPages(); page++) {
            	if (page != 0) {
            		document.newPage();
            	}
            	
	            PdfTemplate tp = cb.createTemplate(w, h);
	            Graphics2D g2 = new PdfGraphics2D(tp, w, h, mapper, false, false, 1f);
	            tp.setWidth(w);
	            tp.setHeight(h);
	            pageable.getPrintable(page).print(g2, pf, page);
	            g2.dispose();
	            cb.addTemplate(tp, 0, 0);
	            writer.releaseTemplate(tp);
            }
            document.close();
            
        } catch (Exception e) {
            throw new AdempiereException(e);
        }
	}
	
	/**
	 * Create pdf file from pageable
	 * @param filename
	 * @param pageable
	 * @return pdf file
	 */
	public static File getPDFAsFile(String filename, Pageable pageable) {
        final File result = new File(filename);
        
        try {
        	writePDF(pageable, new FileOutputStream(result));
        } catch (Exception e) {
            throw new AdempiereException(e);
        }
        
        return result;
    }
    
	/**
	 * Create byte[] pdf content from pageable
	 * @param pageable
	 * @return pdf content
	 */
    public static byte[] getPDFAsArray(Pageable pageable) {
        try {
            ByteArrayOutputStream output = new ByteArrayOutputStream(10240);
            writePDF(pageable, output);
            return output.toByteArray();
        } catch (Exception e) {
            e.printStackTrace();
        } 

        return null;
    }
    
    /**
     * @param layout
     * @return nop, always return true
     */
    public static boolean isValid(Pageable layout) {
    	return true;
    }
    
    /**
     * @return nop, always return true
     */
    public static boolean isLicensed() {
    	return true;
    }    
}
