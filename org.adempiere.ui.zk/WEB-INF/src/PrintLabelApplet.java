import java.awt.print.PrinterJob;
import java.io.BufferedInputStream;
import java.io.ByteArrayOutputStream;
import java.io.InputStream;
import java.net.URL;
import java.net.URLConnection;
import java.util.ArrayList;

import javax.print.Doc;
import javax.print.DocFlavor;
import javax.print.DocPrintJob;
import javax.print.PrintService;
import javax.print.SimpleDoc;
import javax.print.attribute.HashDocAttributeSet;
import javax.print.attribute.standard.DocumentName;
import javax.swing.JApplet;

/**
 * 
 * @author Low Heng Sin
 *
 */
public class PrintLabelApplet extends JApplet {

	/**
	 * 
	 */
	private static final long serialVersionUID = -3107445661561669767L;
	private ArrayList<String> filepaths = new ArrayList<String>();
	private int listSize = 0;

	@Override
	public void init() {
		String s = getParameter("size");
		try {
			listSize = Integer.parseInt(s);
		} catch (Exception e) {
			System.out.println("Invalid listSize param=" + s);
			listSize = 0;
		}
		
		for (int i = 0; i < listSize; i++)
			filepaths.add(getParameter("file_" + i));
        
		super.init();
	}

	@Override
	public void start() {
		System.out.println(this.getClass().getName() + " start()");				
		PrinterJob pjob = null;
		PrintService service = null;							
		DocFlavor flavor = DocFlavor.BYTE_ARRAY.AUTOSENSE;
		
		try {
			int count = 0;
						
			while (true) {
				URL url = new URL(getCodeBase(), "labeldata.jsp?filepath=" + filepaths.get(count) + "&count=" + (count + 1));
				System.out.println("Protocol="+url.getProtocol());
				System.out.println("Host="+url.getHost());
				System.out.println("Port="+url.getPort());
				System.out.println("Default Port="+url.getDefaultPort());
				System.out.println("Path"+url.getPath());
				System.out.println("URL="+url.toString());
				URLConnection conn = url.openConnection();
				int contentLength = conn.getContentLength();
				System.out.println("ContentLength="+contentLength);
				InputStream is = conn.getInputStream();
				System.out.println("InputStream="+is.available());
				byte[] data = null;
				BufferedInputStream bis = new BufferedInputStream(is);
				System.out.println("BufferedInputStream="+bis.available());
				ByteArrayOutputStream baos = new ByteArrayOutputStream();
				while(bis.available() > 0) {
					baos.write(bis.read());
				}
				is.close();
				bis.close();
				data = baos.toByteArray();
				baos.close();
				System.out.println("ByteArrayOutputStream="+data.length);
				if (data.length > 0) {						
					count ++;
					if (pjob == null) {
						// Create Print Job
						pjob = PrinterJob.getPrinterJob();
						if (pjob.printDialog()) 
							service = pjob.getPrintService();
						else
							break;
					}
					DocPrintJob job = service.createPrintJob();
					HashDocAttributeSet as = new HashDocAttributeSet();
					as.add(new DocumentName("shipping label", null));
					Doc doc = new SimpleDoc(data, flavor, as);
					job.print(doc, null);
				} else {
					break;
				}		
				if (count >= listSize)
					break;
			}	
			this.showStatus(count + " label printed.");
		} catch (Exception e) {
			e.printStackTrace();
			this.showStatus("Failed to print label - " + e.getLocalizedMessage());
		}
	}

	@Override
	public void destroy() {
		System.out.println(this.getClass().getName() + " destroy()");
	}

	@Override
	public void stop() {
		System.out.println(this.getClass().getName() + " stop()");
	}
}
