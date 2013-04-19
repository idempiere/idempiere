/******************************************************************************
 * Copyright (C) 2013 Heng Sin Low                                            *
 * Copyright (C) 2013 Trek Global                 							  *
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
package org.idempiere.webservices.client;

import java.net.URL;
import java.util.ArrayList;
import java.util.LinkedHashMap;

import javax.xml.parsers.DocumentBuilder;
import javax.xml.parsers.DocumentBuilderFactory;
import javax.xml.soap.MessageFactory;
import javax.xml.soap.SOAPBody;
import javax.xml.soap.SOAPConnection;
import javax.xml.soap.SOAPConnectionFactory;
import javax.xml.soap.SOAPEnvelope;
import javax.xml.soap.SOAPMessage;
import javax.xml.soap.SOAPPart;

import org.apache.axis.soap.MessageFactoryImpl;
import org.apache.axis.soap.SOAPConnectionFactoryImpl;
import org.compiere.model.Lookup;
import org.compiere.util.DisplayType;
import org.compiere.util.KeyNamePair;
import org.compiere.util.NamePair;
import org.idempiere.adInterface.x10.ADLoginRequest;
import org.idempiere.adInterface.x10.DataField;
import org.idempiere.adInterface.x10.DataRow;
import org.idempiere.adInterface.x10.DataSet;
import org.idempiere.adInterface.x10.ModelCRUD;
import org.idempiere.adInterface.x10.ModelCRUDRequest;
import org.idempiere.adInterface.x10.ModelCRUDRequestDocument;
import org.idempiere.adInterface.x10.WindowTabData;
import org.idempiere.adInterface.x10.WindowTabDataDocument;
import org.w3c.dom.Document;
import org.w3c.dom.Element;
import org.w3c.dom.Node;

/**
 * @author hengsin
 *
 */
public class QueryDataLookup extends Lookup {

	/**
	 * generated serial id
	 */
	private static final long serialVersionUID = -137206840260406730L;
	private String filter;
	private String serviceType;
	private String endPoint;
	private String keyColumn;
	private String displayColumn;

	private volatile LinkedHashMap<Integer,KeyNamePair>  dataMap = new LinkedHashMap<Integer, KeyNamePair>();
	private boolean m_refreshing = false;
	private ADLoginRequest login;
	
	/**
	 * @param windowNo
	 * @param login
	 * @param keyColumn
	 * @param displayColumn
	 * @param filter
	 * @param endPoint
	 * @param serviceType
	 */
	public QueryDataLookup(int windowNo, ADLoginRequest login, String keyColumn, String displayColumn, String filter, String endPoint, String serviceType) {
		super(DisplayType.Table, windowNo);
		this.keyColumn = keyColumn;
		this.displayColumn = displayColumn;
		this.filter = filter;
		this.endPoint = endPoint;
		this.serviceType = serviceType;
		this.login = login;
	}

	/* (non-Javadoc)
	 * @see org.compiere.model.Lookup#getDisplay(java.lang.Object)
	 */
	@Override
	public String getDisplay(Object key) {
		KeyNamePair pair = dataMap.get(key);
		return pair != null ? pair.getName() : "";
	}

	/* (non-Javadoc)
	 * @see org.compiere.model.Lookup#get(java.lang.Object)
	 */
	@Override
	public NamePair get(Object key) {
		return dataMap.get(key);
	}

	/* (non-Javadoc)
	 * @see org.compiere.model.Lookup#getData(boolean, boolean, boolean, boolean, boolean)
	 */
	@Override
	public ArrayList<Object> getData(boolean mandatory, boolean onlyValidated,
			boolean onlyActive, boolean temporary, boolean shortlist) {
		ClassLoader cl = Thread.currentThread().getContextClassLoader();
		SOAPConnectionFactory cf;
		try {
			Thread.currentThread().setContextClassLoader(getClass().getClassLoader());
			dataMap = new LinkedHashMap<Integer, KeyNamePair>();
			cf = new SOAPConnectionFactoryImpl();
			SOAPConnection conn = cf.createConnection();
			// Create a SOAPMessage instance
			MessageFactory mf = new MessageFactoryImpl();
			SOAPMessage message = mf.createMessage();
			// Create a SOAP envelope and body
			SOAPPart part = message.getSOAPPart();
			SOAPEnvelope env = part.getEnvelope();
			SOAPBody body = env.getBody();
			
			ModelCRUDRequestDocument crudDocument = ModelCRUDRequestDocument.Factory.newInstance();
			ModelCRUDRequest crudRequest = crudDocument.addNewModelCRUDRequest();
			crudRequest.setADLoginRequest(login);
			
			ModelCRUD crud = crudRequest.addNewModelCRUD();
			crud.setRecordID(0);
			crud.setFilter(filter);
			crud.setAction(ModelCRUD.Action.READ);
			crud.setServiceType(serviceType);
			
			DocumentBuilderFactory factory = DocumentBuilderFactory.newInstance();
			DocumentBuilder builder = factory.newDocumentBuilder();
			Document document = builder.newDocument();
			Element element = document.createElementNS("http://idempiere.org/ADInterface/1_0", "queryData");
			Node domNode = document.importNode(crudDocument.getDomNode().getFirstChild(), true);
			document.appendChild(element);
			element.appendChild(domNode);
			
			body.addDocument(document);
			
			// Invoke the service endpoint
			URL endpoint = new URL(endPoint);
			
			SOAPMessage responseMsg = null;
			
			try {
				responseMsg = conn.call(message, endpoint);
			} finally {
				conn.close();
			}
			
			if (responseMsg != null && responseMsg.getSOAPBody() != null)
			{				
				if (responseMsg.getSOAPBody().hasFault())
				{
					throw new RuntimeException(responseMsg.getSOAPBody().getFault().getFaultString());
				}
				WindowTabDataDocument responseDoc = WindowTabDataDocument.Factory.parse(responseMsg.getSOAPBody().getFirstChild().getFirstChild());
				WindowTabData windowTabData = responseDoc.getWindowTabData();
				if (windowTabData.isSetError()) 
				{
					throw new RuntimeException(windowTabData.getError());
				}
				
				DataSet dataset = windowTabData.getDataSet();
				DataRow[] dataRows = dataset.getDataRowArray();
				for(DataRow dataRow : dataRows) 
				{
					DataField[] dataFields = dataRow.getFieldArray();
					String key = null;
					String display = null;
					for(DataField dataField : dataFields)
					{
						if (dataField.getColumn().equals(keyColumn)) 
						{
							key = dataField.getVal();
						}
						else if (dataField.getColumn().equals(displayColumn))
						{
							display = dataField.getVal();
						}
					}
					if (key != null && display != null)
					{
						Integer id = new Integer(key);
						dataMap.put(id, new KeyNamePair(id, display));
					}
				}
			}
		} catch (Exception e) {
			if (e instanceof RuntimeException)
				throw (RuntimeException)e;
			else
				throw new RuntimeException(e.getLocalizedMessage(), e);
		} finally {
			Thread.currentThread().setContextClassLoader(cl);
		}	
		return new ArrayList<Object>(dataMap.values());
	}

	/* (non-Javadoc)
	 * @see org.compiere.model.Lookup#getColumnName()
	 */
	@Override
	public String getColumnName() {
		return keyColumn;
	}

	/* (non-Javadoc)
	 * @see org.compiere.model.Lookup#containsKey(java.lang.Object)
	 */
	@Override
	public boolean containsKey(Object key) {
		return dataMap.containsKey(key);
	}

	/**
	 *	Refresh & return number of items read.
	 * 	Get get data of parent lookups
	 *  @return no of items read
	 */
	@Override
	public int refresh ()
	{
		if (m_refreshing ) return 0;
		
		try 
		{
			m_refreshing = true;
			fillComboBox(isMandatory(), true, true, false, isShortList());
			return dataMap.size();
		}
		finally
		{
			m_refreshing = false;
		}
	}	//	refresh
}
