/******************************************************************************
 * Copyright (C) 2012 Heng Sin Low                                            *
 * Copyright (C) 2012 Trek Global                 							  *
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
package org.adempiere.util;

import java.io.IOException;
import java.io.InputStream;
import java.io.OutputStream;
import java.io.PrintStream;
import java.io.PrintWriter;
import java.io.Reader;
import java.io.Writer;
import java.util.Collection;
import java.util.Enumeration;
import java.util.InvalidPropertiesFormatException;
import java.util.Map;
import java.util.Properties;
import java.util.Set;

/**
 * @author hengsin
 *
 */
public class ServerContextPropertiesWrapper extends Properties {

	/**
	 * generated serial id
	 */
	private static final long serialVersionUID = 4383867755398619422L;

	/**
	 * 
	 */
	public ServerContextPropertiesWrapper() {
	}

	/* (non-Javadoc)
	 * @see java.util.Properties#setProperty(java.lang.String, java.lang.String)
	 */
	@Override
	public Object setProperty(String key, String value) {
		return ServerContext.getCurrentInstance().setProperty(key, value);
	}

	/* (non-Javadoc)
	 * @see java.util.Properties#load(java.io.Reader)
	 */
	@Override
	public void load(Reader reader) throws IOException {
		ServerContext.getCurrentInstance().load(reader);
	}

	/* (non-Javadoc)
	 * @see java.util.Properties#load(java.io.InputStream)
	 */
	@Override
	public void load(InputStream inStream) throws IOException {
		ServerContext.getCurrentInstance().load(inStream);
	}

	/* (non-Javadoc)
	 * @see java.util.Properties#save(java.io.OutputStream, java.lang.String)
	 */
	@Override
	public void save(OutputStream out, String comments) {
		ServerContext.getCurrentInstance().save(out, comments);
	}

	/* (non-Javadoc)
	 * @see java.util.Properties#store(java.io.Writer, java.lang.String)
	 */
	@Override
	public void store(Writer writer, String comments) throws IOException {
		ServerContext.getCurrentInstance().store(writer, comments);
	}

	/* (non-Javadoc)
	 * @see java.util.Properties#store(java.io.OutputStream, java.lang.String)
	 */
	@Override
	public void store(OutputStream out, String comments) throws IOException {
		ServerContext.getCurrentInstance().store(out, comments);
	}

	/* (non-Javadoc)
	 * @see java.util.Properties#loadFromXML(java.io.InputStream)
	 */
	@Override
	public void loadFromXML(InputStream in) throws IOException,
			InvalidPropertiesFormatException {
		ServerContext.getCurrentInstance().loadFromXML(in);
	}

	/* (non-Javadoc)
	 * @see java.util.Properties#storeToXML(java.io.OutputStream, java.lang.String)
	 */
	@Override
	public void storeToXML(OutputStream os, String comment)
			throws IOException {
		ServerContext.getCurrentInstance().storeToXML(os, comment);
	}

	/* (non-Javadoc)
	 * @see java.util.Properties#storeToXML(java.io.OutputStream, java.lang.String, java.lang.String)
	 */
	@Override
	public void storeToXML(OutputStream os, String comment,
			String encoding) throws IOException {
		ServerContext.getCurrentInstance().storeToXML(os, comment, encoding);
	}

	/* (non-Javadoc)
	 * @see java.util.Properties#getProperty(java.lang.String)
	 */
	@Override
	public String getProperty(String key) {
		return ServerContext.getCurrentInstance().getProperty(key);
	}

	/* (non-Javadoc)
	 * @see java.util.Properties#getProperty(java.lang.String, java.lang.String)
	 */
	@Override
	public String getProperty(String key, String defaultValue) {
		return ServerContext.getCurrentInstance().getProperty(key, defaultValue);
	}

	/* (non-Javadoc)
	 * @see java.util.Properties#propertyNames()
	 */
	@Override
	public Enumeration<?> propertyNames() {
		return ServerContext.getCurrentInstance().propertyNames();
	}

	/* (non-Javadoc)
	 * @see java.util.Properties#stringPropertyNames()
	 */
	@Override
	public Set<String> stringPropertyNames() {
		return ServerContext.getCurrentInstance().stringPropertyNames();
	}

	/* (non-Javadoc)
	 * @see java.util.Properties#list(java.io.PrintStream)
	 */
	@Override
	public void list(PrintStream out) {
		ServerContext.getCurrentInstance().list(out);
	}

	/* (non-Javadoc)
	 * @see java.util.Properties#list(java.io.PrintWriter)
	 */
	@Override
	public void list(PrintWriter out) {
		ServerContext.getCurrentInstance().list(out);
	}

	/* (non-Javadoc)
	 * @see java.util.Hashtable#size()
	 */
	@Override
	public int size() {
		return ServerContext.getCurrentInstance().size();
	}

	/* (non-Javadoc)
	 * @see java.util.Hashtable#isEmpty()
	 */
	@Override
	public boolean isEmpty() {
		return ServerContext.getCurrentInstance().isEmpty();
	}

	/* (non-Javadoc)
	 * @see java.util.Hashtable#keys()
	 */
	@Override
	public Enumeration<Object> keys() {
		return ServerContext.getCurrentInstance().keys();
	}

	/* (non-Javadoc)
	 * @see java.util.Hashtable#elements()
	 */
	@Override
	public Enumeration<Object> elements() {
		return ServerContext.getCurrentInstance().elements();
	}

	/* (non-Javadoc)
	 * @see java.util.Hashtable#contains(java.lang.Object)
	 */
	@Override
	public boolean contains(Object value) {
		return ServerContext.getCurrentInstance().contains(value);
	}

	/* (non-Javadoc)
	 * @see java.util.Hashtable#containsValue(java.lang.Object)
	 */
	@Override
	public boolean containsValue(Object value) {
		return ServerContext.getCurrentInstance().containsValue(value);
	}

	/* (non-Javadoc)
	 * @see java.util.Hashtable#containsKey(java.lang.Object)
	 */
	@Override
	public boolean containsKey(Object key) {
		return ServerContext.getCurrentInstance().containsKey(key);
	}

	/* (non-Javadoc)
	 * @see java.util.Hashtable#get(java.lang.Object)
	 */
	@Override
	public Object get(Object key) {
		return ServerContext.getCurrentInstance().get(key);
	}

	/* (non-Javadoc)
	 * @see java.util.Hashtable#put(java.lang.Object, java.lang.Object)
	 */
	@Override
	public Object put(Object key, Object value) {
		return ServerContext.getCurrentInstance().put(key, value);
	}

	/* (non-Javadoc)
	 * @see java.util.Hashtable#remove(java.lang.Object)
	 */
	@Override
	public Object remove(Object key) {
		return ServerContext.getCurrentInstance().remove(key);
	}

	/* (non-Javadoc)
	 * @see java.util.Hashtable#putAll(java.util.Map)
	 */
	@Override
	public void putAll(Map<? extends Object, ? extends Object> t) {
		ServerContext.getCurrentInstance().putAll(t);
	}

	/* (non-Javadoc)
	 * @see java.util.Hashtable#clear()
	 */
	@Override
	public void clear() {
		ServerContext.getCurrentInstance().clear();
	}

	/* (non-Javadoc)
	 * @see java.util.Hashtable#clone()
	 */
	@Override
	public Object clone() {
		return ServerContext.getCurrentInstance().clone();
	}

	/* (non-Javadoc)
	 * @see java.util.Hashtable#toString()
	 */
	@Override
	public String toString() {
		return ServerContext.getCurrentInstance().toString();
	}

	/* (non-Javadoc)
	 * @see java.util.Hashtable#keySet()
	 */
	@Override
	public Set<Object> keySet() {
		return ServerContext.getCurrentInstance().keySet();
	}

	/* (non-Javadoc)
	 * @see java.util.Hashtable#entrySet()
	 */
	@Override
	public Set<java.util.Map.Entry<Object, Object>> entrySet() {
		return ServerContext.getCurrentInstance().entrySet();
	}

	/* (non-Javadoc)
	 * @see java.util.Hashtable#values()
	 */
	@Override
	public Collection<Object> values() {
		return ServerContext.getCurrentInstance().values();
	}

	/* (non-Javadoc)
	 * @see java.util.Hashtable#equals(java.lang.Object)
	 */
	@Override
	public boolean equals(Object o) {
		return ServerContext.getCurrentInstance().equals(o);
	}

	/* (non-Javadoc)
	 * @see java.util.Hashtable#hashCode()
	 */
	@Override
	public int hashCode() {
		return ServerContext.getCurrentInstance().hashCode();
	}

	
}
