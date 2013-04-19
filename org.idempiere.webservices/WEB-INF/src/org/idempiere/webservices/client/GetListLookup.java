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
import org.compiere.util.NamePair;
import org.compiere.util.ValueNamePair;
import org.idempiere.adInterface.x10.ADLoginRequest;
import org.idempiere.adInterface.x10.DataField;
import org.idempiere.adInterface.x10.DataRow;
import org.idempiere.adInterface.x10.DataSet;
import org.idempiere.adInterface.x10.ModelGetList;
import org.idempiere.adInterface.x10.ModelGetListRequest;
import org.idempiere.adInterface.x10.ModelGetListRequestDocument;
import org.idempiere.adInterface.x10.WindowTabData;
import org.idempiere.adInterface.x10.WindowTabDataDocument;
import org.w3c.dom.Document;

/**
 * @author hengsin
 *
 */
public class GetListLookup extends Lookup {

	/**
	 * generated serial id
	 */
	private static final long serialVersionUID = -137206840260406730L;
	private String filter;
	private String serviceType;
	private String endPoint;
	private String keyColumn;
	private String displayColumn;

	private volatile LinkedHashMap<Object,NamePair>  dataMap = new LinkedHashMap<Object, NamePair>();
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
	public GetListLookup(int windowNo, ADLoginRequest login, String keyColumn, String displayColumn, String filter, String endPoint, String serviceType) {
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
		NamePair pair = dataMap.get(key);
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
			dataMap = new LinkedHashMap<Object, NamePair>();
			cf = new SOAPConnectionFactoryImpl();
			SOAPConnection conn = cf.createConnection();
			// Create a SOAPMessage instance
			MessageFactory mf = new MessageFactoryImpl();
			SOAPMessage message = mf.createMessage();
			// Create a SOAP envelope and body
			SOAPPart part = message.getSOAPPart();
			SOAPEnvelope env = part.getEnvelope();
			SOAPBody body = env.getBody();
			
			ModelGetListRequestDocument getListDocument = ModelGetListRequestDocument.Factory.newInstance();
			ModelGetListRequest getListRequest = getListDocument.addNewModelGetListRequest();
			
			getListRequest.setADLoginRequest(login);
			ModelGetList getList = getListRequest.addNewModelGetList();
			getList.setFilter(filter);
			getList.setServiceType(serviceType);
			
			body.addDocument((Document) getListDocument.getDomNode());
			
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
						dataMap.put(key, new ValueNamePair(key, display));
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
