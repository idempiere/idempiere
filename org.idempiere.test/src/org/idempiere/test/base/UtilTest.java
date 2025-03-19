/***********************************************************************
 * This file is part of iDempiere ERP Open Source                      *
 * http://www.idempiere.org                                            *
 *                                                                     *
 * Copyright (C) Contributors                                          *
 *                                                                     *
 * This program is free software; you can redistribute it and/or       *
 * modify it under the terms of the GNU General Public License         *
 * as published by the Free Software Foundation; either version 2      *
 * of the License, or (at your option) any later version.              *
 *                                                                     *
 * This program is distributed in the hope that it will be useful,     *
 * but WITHOUT ANY WARRANTY; without even the implied warranty of      *
 * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE. See the        *
 * GNU General Public License for more details.                        *
 *                                                                     *
 * You should have received a copy of the GNU General Public License   *
 * along with this program; if not, write to the Free Software         *
 * Foundation, Inc., 51 Franklin Street, Fifth Floor, Boston,          *
 * MA 02110-1301, USA.                                                 *
 *                                                                     *
 * Contributors:                                                       *
 * - hengsin                         								   *
 **********************************************************************/
package org.idempiere.test.base;

import org.compiere.util.Util;
import org.idempiere.test.AbstractTestCase;
import org.junit.jupiter.api.Test;

import com.lowagie.text.Document;
import com.lowagie.text.DocumentException;
import com.lowagie.text.Paragraph;
import com.lowagie.text.pdf.PdfWriter;

import java.io.File;
import java.io.FileOutputStream;
import java.io.IOException;
import java.nio.file.Files;
import java.nio.file.Path;
import java.sql.Timestamp;
import java.util.Arrays;
import java.util.List;

import static org.junit.jupiter.api.Assertions.*;

public class UtilTest extends AbstractTestCase {

    @Test
    void replace() {
        assertEquals("This is a test.", Util.replace("This is a test.", "old", "new"));
        assertEquals("This is a new.", Util.replace("This is a old.", "old", "new"));
        assertEquals("This is a .", Util.replace("This is a old.", "old", ""));
        assertEquals("This is a .", Util.replace("This is a old.", "old", null));
        assertEquals("This is a old.", Util.replace("This is a old.", null, "new"));
        assertEquals("This is a old.", Util.replace("This is a old.", "", "new"));
        assertEquals("", Util.replace("", "old", "new"));
        assertNull(Util.replace(null, "old", "new"));
        assertEquals("newnewnew",Util.replace("oldoldold","old","new"));
    }

    @Test
    void removeCRLF() {
        assertEquals("Thisisatest.", Util.removeCRLF("This\nis\ra\ntest."));
        assertEquals("NoCRLF", Util.removeCRLF("NoCRLF"));
        assertEquals("", Util.removeCRLF("\n\r\n\r"));
    }

    @Test
    void cleanWhitespace() {
        assertEquals("This is a test.", Util.cleanWhitespace("This   is  a    test."));
        assertEquals(" This is a test. ", Util.cleanWhitespace("  This   is  a    test.  "));
        assertEquals("NoWhitespace", Util.cleanWhitespace("NoWhitespace"));
        assertEquals(" ", Util.cleanWhitespace("     "));
        assertEquals("",Util.cleanWhitespace(""));
    }

    @Test
    void maskHTML() {
        assertEquals("&lt;html&gt;", Util.maskHTML("<html>"));
        assertEquals("&lt;html&gt;&amp;&quot;&#039;", Util.maskHTML("<html>&\"'"));
        assertEquals("Normal", Util.maskHTML("Normal"));
        assertEquals("&lt;br&gt;", Util.maskHTML("<br>"));
        assertEquals("&#55357;&#56832;", Util.maskHTML("\uD83D\uDE00"));
        assertEquals("Line1<br>Line2", Util.maskHTML("Line1\nLine2",true));
        assertEquals("Line1Line2", Util.maskHTML("Line1\nLine2",false));
        assertNull(Util.maskHTML(null,true));
        assertNull(Util.maskHTML(null));
    }

    @Test
    void getCount() {
        assertEquals(3, Util.getCount("This is a test.", 's'));
        assertEquals(0, Util.getCount("This is a test.", 'z'));
        assertEquals(0, Util.getCount(null, 's'));
        assertEquals(0,Util.getCount("",'a'));
        assertEquals(3,Util.getCount("aaa",'a'));
    }

    @Test
    void isEmpty() {
        assertTrue(Util.isEmpty(null));
        assertTrue(Util.isEmpty(""));
        assertFalse(Util.isEmpty(" "));
        assertFalse(Util.isEmpty("test"));
        assertTrue(Util.isEmpty(null, true));
        assertTrue(Util.isEmpty("", true));
        assertTrue(Util.isEmpty(" ", true));
        assertFalse(Util.isEmpty(" test ", true));
        assertFalse(Util.isEmpty("test", true));
    }

    @Test
    void deleteAccents() {
        assertEquals("aAaaeeiioouu", Util.deleteAccents("àÁâäèéîïöôüû"));
        assertEquals("This is a test.", Util.deleteAccents("This is a test."));
        assertEquals("",Util.deleteAccents(""));
    }

    @Test
    void findIndexOf() {
        assertEquals(-1, Util.findIndexOf("abc'd'efg", 'd'));
        assertEquals(6, Util.findIndexOf("abc'd'efg", 'd','e'));
        assertEquals(8, Util.findIndexOf("abc(def)g", 'g'));
        assertEquals(11, Util.findIndexOf("abc(def(g))h", 'h'));
        assertEquals(11, Util.findIndexOf("abc(def)(g)h", 'h'));
        assertEquals(-1, Util.findIndexOf(null, 'a'));
        assertEquals(-1,Util.findIndexOf("abc'd'efg", 'z'));
        assertEquals(11, Util.findIndexOf("abc(def)(g)h", 'h','g'));
        assertEquals(-1, Util.findIndexOf(null, 'a','b'));
        assertEquals(-1,Util.findIndexOf("abc'd'efg", 'z','d'));

    }
    @Test
    void findIndexOfString() {
        assertEquals(8, Util.findIndexOf("abc(def)ghi", "ghi"));
        assertEquals(8, Util.findIndexOf("abc'ghi'jkl", "jkl"));
        assertEquals(13, Util.findIndexOf("abc(def)(ghi)jkl", "jkl"));
        assertEquals(-1, Util.findIndexOf(null, "ghi"));
        assertEquals(-1, Util.findIndexOf("abc(def)ghi", null));
        assertEquals(-1, Util.findIndexOf("abc(def)ghi", ""));
        assertEquals(-1, Util.findIndexOf("abc'ghi'jkl", "ghi"));
        assertEquals(-1, Util.findIndexOf("abc(def)(ghi)jkl", "ghi"));
    }

    @Test
    void toHex() {
        assertEquals("00", Util.toHex((byte) 0));
        assertEquals("ff", Util.toHex((byte) 255));
        assertEquals("7f", Util.toHex((byte) 127));
        assertEquals("80", Util.toHex((byte) -128));
        assertEquals("0000", Util.toHex((char) 0));
        assertEquals("ffff", Util.toHex((char) 65535));
        assertEquals("7fff", Util.toHex((char) 32767));
    }

    @Test
    void initCap() {
        assertEquals("This Is A Test", Util.initCap("this is a test"));
        assertEquals("This", Util.initCap("this"));
        assertEquals(" ", Util.initCap(" "));
        assertEquals("This Is A Test", Util.initCap("THIS IS A TEST"));
        assertEquals("",Util.initCap(""));
        assertNull(Util.initCap(null));
    }
    
    @Test
    void is8Bit() {
        assertTrue(Util.is8Bit("abc"));
        assertTrue(Util.is8Bit(""));
        assertTrue(Util.is8Bit(null));
        assertFalse(Util.is8Bit("a\uD83D\uDE00"));
    }
    
    @Test
    void cleanAmp(){
        assertEquals("abc", Util.cleanAmp("&abc"));
        assertEquals("abc", Util.cleanAmp("abc"));
        assertEquals("abc", Util.cleanAmp("a&bc"));
        assertEquals("a&bc", Util.cleanAmp("&a&bc"));
        assertEquals("", Util.cleanAmp(""));
        assertNull(Util.cleanAmp(null));
    }

    @Test
    void trimLength() {
        assertEquals("test", Util.trimLength("test", 4));
        assertEquals("tes", Util.trimLength("test", 3));
        assertEquals("t", Util.trimLength("test", 1));
        assertEquals("test", Util.trimLength("test", 10));
        assertThrows(IllegalArgumentException.class, () -> Util.trimLength("test", 0));
        assertThrows(IllegalArgumentException.class, () -> Util.trimLength("test", -1));
        assertNull(Util.trimLength(null, 10));
    }
    
    @Test
    void size() {
        assertEquals(0, Util.size(null));
        assertEquals(4, Util.size("test"));
        assertEquals(2, Util.size("\u00A9")); 
        assertEquals(4, Util.size("\uD83D\uDE00"));
        assertEquals(1, Util.size("a"));
    }

    @Test
    void trimSize() {
        assertEquals("test", Util.trimSize("test", 4));
        assertEquals("tes", Util.trimSize("test", 3));
        assertEquals("t", Util.trimSize("test", 1));
        assertEquals("test", Util.trimSize("test", 10));
        assertThrows(IllegalArgumentException.class, () -> Util.trimSize("test", 0));
        assertThrows(IllegalArgumentException.class, () -> Util.trimSize("test", -1));
        assertNull(Util.trimSize(null, 10));
        assertEquals("\u00A9",Util.trimSize("\u00A9",2));
    }

    @Test
    void removeTime() {
        Timestamp ts = Timestamp.valueOf("2023-10-27 10:30:00");
        Timestamp expected = Timestamp.valueOf("2023-10-27 00:00:00");
        assertEquals(expected, Util.removeTime(ts));
        ts = Timestamp.valueOf("2023-10-27 00:00:00");
        assertEquals(expected, Util.removeTime(ts));

    }
    
    @Test
    void setFilenameCorrect() {
        assertEquals("test", Util.setFilenameCorrect("test"));
        assertEquals("test-test", Util.setFilenameCorrect("test/test"));
        assertEquals("test-test", Util.setFilenameCorrect("test:test"));
        assertEquals("test-test", Util.setFilenameCorrect("test*test"));
        assertEquals("test-test", Util.setFilenameCorrect("test<test"));
        assertEquals("test-test", Util.setFilenameCorrect("test>test"));
        assertEquals("test-test", Util.setFilenameCorrect("test%test"));
        assertEquals("test", Util.setFilenameCorrect(" test "));
        assertEquals("a",Util.setFilenameCorrect("à"));
    }
    @Test
    void isUUID()
    {
        assertTrue(Util.isUUID("123e4567-e89b-12d3-a456-426614174000"));
        assertTrue(Util.isUUID("123E4567-E89B-12D3-A456-426614174000"));
        assertFalse(Util.isUUID("123E4567-E89B-12D3-A456-42661417400"));
        assertFalse(Util.isUUID("123E4567-E89B-12D3-A456-42661417400g"));
        assertFalse(Util.isUUID(null));
    }

    @Test
    void mergePdf_ValidInput_MergesFiles() throws Exception {
        // Create dummy PDF files
        Path tempDir = Files.createTempDirectory("mergePdfTest");
        File pdf1 = createDummyPdf(tempDir, "pdf1.pdf");
        File pdf2 = createDummyPdf(tempDir, "pdf2.pdf");
        File pdf3 = createDummyPdf(tempDir, "pdf3.pdf");

        List<File> pdfList = Arrays.asList(pdf1, pdf2,pdf3);
        File mergedPdf = new File(tempDir.toFile(), "merged.pdf");

        // Call the method to test
        Util.mergePdf(pdfList, mergedPdf);

        // Assert that the merged file exists and is not empty
        assertTrue(mergedPdf.exists());
        assertTrue(mergedPdf.length() > 0);

        // Clean up the temporary files and directory
        Files.delete(pdf1.toPath());
        Files.delete(pdf2.toPath());
        Files.delete(pdf3.toPath());
        Files.delete(mergedPdf.toPath());
        Files.delete(tempDir);
    }

    @Test
    void prettifyJSONString()
    {
        String json = "{ \"name\":\"John\", \"age\":30, \"car\":null }";
        String expected = "{\n" +
                "  \"name\": \"John\",\n" +
                "  \"age\": 30,\n" +
                "  \"car\": null\n" +
                "}";
        String res = Util.prettifyJSONString(json);
        assertEquals(expected,res);
        String json2 = "invalid json";
        assertThrows(org.adempiere.exceptions.AdempiereException.class,()->Util.prettifyJSONString(json2));
    }

    private File createDummyPdf(Path tempDir, String filename) throws IOException {
        File file = new File(tempDir.toFile(), filename);
        Files.createFile(file.toPath());
        Document document = new Document();
        try {
            PdfWriter.getInstance(document, new FileOutputStream(file));
            document.open();

            // Add some content
            document.add(new Paragraph("This is a dummy PDF file created with openPDF."));
            document.close();

        } catch (DocumentException | IOException e) {
            e.printStackTrace();
        }
        return file;
    }
}
