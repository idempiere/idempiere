/******************************************************************************
 * Copyright (C) 2012 Elaine Tan                                              *
 * Copyright (C) 2012 Trek Global
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
package org.adempiere.process;

import java.awt.Graphics;
import java.awt.Graphics2D;
import java.awt.geom.AffineTransform;
import java.awt.image.BufferedImage;
import java.awt.print.Book;
import java.awt.print.PageFormat;
import java.awt.print.Paper;
import java.awt.print.Printable;
import java.awt.print.PrinterException;
import java.awt.print.PrinterJob;
import java.math.BigDecimal;
import java.util.ArrayList;
import java.util.List;

import javax.imageio.ImageIO;
import javax.print.Doc;
import javax.print.DocFlavor;
import javax.print.DocPrintJob;
import javax.print.PrintService;
import javax.print.SimpleDoc;
import javax.print.attribute.HashDocAttributeSet;
import javax.print.attribute.standard.DocumentName;

import org.compiere.model.MAttachment;
import org.compiere.model.MAttachmentEntry;
import org.compiere.model.MShipperLabels;

/**
 * 
 * @author Elaine
 *
 */
public class DefaultPrintShippingLabel implements IPrintShippingLabel
{
	@Override
	public String printToLabelPrinter(MAttachment attachment, MShipperLabels labelType) throws Exception
	{
		MAttachmentEntry[] entries = attachment.getEntries();
		List<MAttachmentEntry> list = new ArrayList<MAttachmentEntry>();
		if (entries != null && entries.length > 0) 
		{
			for (MAttachmentEntry entry : entries) 
			{
				if (entry.getName().startsWith("shipping_label"))
					list.add(entry);
			}
			if (list.size() > 0) 
			{
				// Create Print Job				
				PrinterJob pjob = PrinterJob.getPrinterJob();
				if (pjob.printDialog()) 
				{
					PrintService service = pjob.getPrintService();					
					DocFlavor flavor = DocFlavor.BYTE_ARRAY.AUTOSENSE;					
					for (MAttachmentEntry entry : list) 
					{
						DocPrintJob job = service.createPrintJob();
						HashDocAttributeSet as = new HashDocAttributeSet();
						as.add(new DocumentName(entry.getName(), null));
						Doc doc = new SimpleDoc(entry.getData(), flavor, as);
						job.print(doc, null);
					}					
				}
			}
		}
		return list.size() + " labels printed.";
	}

	@Override
	public String printImageLabel(MAttachment attachment, MShipperLabels labelType, String title) throws Exception
	{
		MAttachmentEntry[] entries = attachment.getEntries();
		List<BufferedImage> list = new ArrayList<BufferedImage>();
		if (entries != null && entries.length > 0) 
		{
			for (MAttachmentEntry entry : entries) 
			{
				if (entry.getName().startsWith("shipping_label") && entry.isGraphic()) 
				{
					BufferedImage image = ImageIO.read(entry.getInputStream());
					if (image != null)
						list.add(image);
				}
			}
			
			if (list.size() > 0) 
			{
				// Create Print Job
				Book book = new Book();
				PrinterJob pjob = PrinterJob.getPrinterJob();
				pjob.setJobName(title);
				
				if (pjob.printDialog()) 
				{
					PageFormat pf = pjob.pageDialog(pjob.defaultPage());
					Paper p = pf.getPaper();
					BigDecimal width = labelType.getWidth();
					BigDecimal height = labelType.getHeight();
					
					if (width != null && width.compareTo(BigDecimal.ZERO) > 0 && height != null && height.compareTo(BigDecimal.ZERO) > 0) 
					{
						BigDecimal factor = new BigDecimal(72);
						width = width.multiply(factor);
						height = height.multiply(factor);
						p.setImageableArea(p.getImageableX(), p.getImageableY(), width.doubleValue(), height.doubleValue());
						pf.setPaper(p);
					}
					
					for (BufferedImage image : list)
						book.append(new ImagePrintable(image), pf);
					
					pjob.setPageable(book);
					pjob.print();
				}
			}
		}
		return list.size() + " labels printed.";
	}

	final static class ImagePrintable implements Printable 
	{
		private BufferedImage image;

		protected ImagePrintable(BufferedImage image) 
		{
			this.image = image;
		}

		public int print(Graphics graphics, PageFormat pageFormat, int pageIndex) throws PrinterException 
		{
			if (pageIndex > 0)
				return Printable.NO_SUCH_PAGE;
			
			Graphics2D g2d = (Graphics2D) graphics;
			// Set us to the upper left corner
			g2d.translate(pageFormat.getImageableX(), pageFormat.getImageableY());
			AffineTransform at = new AffineTransform();
			at.translate(0, 0);

			// We need to scale the image properly so that it fits on one page.
			double xScale = pageFormat.getImageableWidth() / image.getWidth();
			double yScale = pageFormat.getImageableHeight() / image.getHeight();
			
			at.scale(xScale, yScale);
			g2d.drawRenderedImage(image, at);
			return Printable.PAGE_EXISTS;
		}
	}
}
