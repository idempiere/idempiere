package org.compiere.model;

import java.util.EventObject;

public class ServerStateChangeEvent extends EventObject {

	/**
	 * 
	 */
	private static final long serialVersionUID = -7744346736197438379L;
	public final static int SERVER_START = 0;
	public final static int SERVER_STOP = 1;
	
	private int eventType;

	public ServerStateChangeEvent(Object source, int eventType) {
		super(source);
		this.eventType = eventType;
	}

	public int getEventType() {
		return eventType;
	}
	public void setEventType(int eventType) {
		this.eventType = eventType;
	}

}
