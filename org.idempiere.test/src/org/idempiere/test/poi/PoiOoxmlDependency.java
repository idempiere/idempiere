package org.idempiere.test.poi;

import static org.junit.jupiter.api.Assertions.assertThrows;

import java.io.File;
import java.io.IOException;
import java.io.InputStream;
import java.lang.reflect.InvocationTargetException;
import java.lang.reflect.Method;

import org.apache.poi.EncryptedDocumentException;
import org.apache.poi.ss.usermodel.Workbook;
import org.apache.poi.ss.usermodel.WorkbookFactory;
import org.apache.poi.xssf.usermodel.XSSFWorkbookFactory;
import org.idempiere.test.AbstractTestCase;
import org.junit.jupiter.api.MethodOrderer;
import org.junit.jupiter.api.Order;
import org.junit.jupiter.api.Test;
import org.junit.jupiter.api.TestMethodOrder;
import org.osgi.framework.Bundle;
import org.osgi.framework.BundleException;
import org.osgi.framework.FrameworkUtil;

@TestMethodOrder(MethodOrderer.OrderAnnotation.class)
public class PoiOoxmlDependency extends AbstractTestCase{
	
	/**
	 * Open an XLSX file to verify if POI-OOXML is loaded
	 * @param bundleClassLoader Workbooks can now be opened using the WorkbookFactory class from the bundle 'bundleClassLoader'
	 * @throws EncryptedDocumentException
	 * @throws IOException
	 * @throws ClassNotFoundException
	 * @throws IllegalAccessException
	 * @throws IllegalArgumentException
	 * @throws NoSuchMethodException
	 * @throws SecurityException
	 */
	public void openWorkbook(Bundle bundleClassLoader) throws EncryptedDocumentException, IOException, ClassNotFoundException, IllegalAccessException, IllegalArgumentException, NoSuchMethodException, SecurityException {
		InputStream io = this.getClass().getClassLoader().getResourceAsStream("resources/poi-ooxml.xlsx");
		Workbook workbook = null;
		
		if (bundleClassLoader != null) {
			// Calling bundleClassLoader.loadClass not only loads the desired class, but also implicitly activates the bundleClassLoader itself.
			Method workbookFactoryCreate = bundleClassLoader.loadClass(WorkbookFactory.class.getName()).getMethod("create", InputStream.class);
			try {
				workbook = (Workbook)workbookFactoryCreate.invoke(null, io);
			}catch (InvocationTargetException e) {
				throw (IOException)e.getTargetException();
			}
			
		}else {
			workbook = WorkbookFactory.create(io);
		}
		workbook.close();
	}
	
	public void openWorkbook() throws EncryptedDocumentException, IOException, ClassNotFoundException, IllegalAccessException, IllegalArgumentException, NoSuchMethodException, SecurityException {
		openWorkbook(null);
	}
	
	/**
	 * dependency on poi-ooxml
	 * @throws IOException 
	 * @throws EncryptedDocumentException 
	 * @throws BundleException 
	 * @throws SecurityException 
	 * @throws NoSuchMethodException 
	 * @throws IllegalArgumentException 
	 * @throws IllegalAccessException 
	 * @throws ClassNotFoundException 
	 */
	@Test
	@Order(1)
	public void openXlsxNomal () throws EncryptedDocumentException, IOException, BundleException, ClassNotFoundException, IllegalAccessException, IllegalArgumentException, NoSuchMethodException, SecurityException {
		// start idempiere normal case so both poi bundle on RESOLVED state
		openWorkbook();
	}
	
	@Test
	@Order(2)
	public void openXlsxStop () throws BundleException, EncryptedDocumentException, IOException, ClassNotFoundException, IllegalAccessException, IllegalArgumentException, NoSuchMethodException, SecurityException {
		// both poi bundle on RESOLVED state
		FrameworkUtil.getBundle(WorkbookFactory.class).stop();
		openWorkbook();
	}
	
	@Test
	@Order(3)
	public void openXlsxSimpleUpdateFromActiveState () throws BundleException, EncryptedDocumentException, IOException, ClassNotFoundException, IllegalAccessException, IllegalArgumentException, NoSuchMethodException, SecurityException {
		// bundle is update (uninstall after that install) so bundle at INSTALLED state, not yet resolver or start
		FrameworkUtil.getBundle(WorkbookFactory.class).update();
		assertThrows(IOException.class, () -> {
			openWorkbook();
		});
		
		// start after manual update/install so both poi bundle on ACTIVE state
		FrameworkUtil.getBundle(WorkbookFactory.class).start();
		openWorkbook();
	}
	
	/**
	 * This test confirms that PoiBundleTracker currently does support scenarios with update POI versions installed.
	 * @throws BundleException
	 * @throws EncryptedDocumentException
	 * @throws IOException
	 * @throws ClassNotFoundException
	 * @throws IllegalAccessException
	 * @throws IllegalArgumentException
	 * @throws NoSuchMethodException
	 * @throws SecurityException
	 */
	@Test
	@Order(4)
	public void openXlsxUpdate () throws BundleException, EncryptedDocumentException, IOException, ClassNotFoundException, IllegalAccessException, IllegalArgumentException, NoSuchMethodException, SecurityException {
		// bundle is update (uninstall after that install) so bundle at installing state, not yet resolver or start
		InputStream isPoi = this.getClass().getClassLoader().getResourceAsStream("resources/poi-ooxml-5.2.3.jar");
		FrameworkUtil.getBundle(XSSFWorkbookFactory.class).update(isPoi);
		assertThrows(IOException.class, () -> {
			openWorkbook();
		});
		
		// start after manual update/install so poi-ooxml bundle on ACTIVE state
		FrameworkUtil.getBundle(XSSFWorkbookFactory.class).start();
		openWorkbook();
	}
	
	/**
	 * This test confirms that PoiBundleTracker currently does not support scenarios with multiple POI versions installed
	 * @throws BundleException
	 * @throws EncryptedDocumentException
	 * @throws IOException
	 * @throws ClassNotFoundException
	 * @throws IllegalAccessException
	 * @throws IllegalArgumentException
	 * @throws NoSuchMethodException
	 * @throws SecurityException
	 */
	@Test
	@Order(5)
	public void openXlsxMulti () throws BundleException, EncryptedDocumentException, IOException, ClassNotFoundException, IllegalAccessException, IllegalArgumentException, NoSuchMethodException, SecurityException {
		// bundle is update (uninstall after that install) so bundle at installing state, not yet resolver or start
		InputStream isPoi = this.getClass().getClassLoader().getResourceAsStream("resources/poi-5.2.3.jar");
		FrameworkUtil.getBundle(WorkbookFactory.class).start();// to make sure getBundleContext isn't null
		Bundle poi523 = FrameworkUtil.getBundle(WorkbookFactory.class).getBundleContext().installBundle("file:plugins" + File.separator + "wrapped.org.apache.poi.poi_5.2.3", isPoi);

		assertThrows(IOException.class, () -> {
			// poi523 is active on openWorkbook when call loadClass function
			openWorkbook(poi523);
		});
	}
	
	@Test
	@Order(6)
	public void openXlsxUninstall () throws BundleException, EncryptedDocumentException, IOException {
		// uninstall case, both poi bundle on UNINSTALLED state
		FrameworkUtil.getBundle(WorkbookFactory.class).uninstall();
		assertThrows(IOException.class, () -> {
			openWorkbook();
		});
	}

}
