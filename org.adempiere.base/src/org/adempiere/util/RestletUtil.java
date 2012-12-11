/******************************************************************************
 * Copyright (C) 2010 Low Heng Sin  All Rights Reserved.                      *
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

import java.io.ObjectInputStream;
import java.util.logging.Level;

import org.compiere.util.CLogger;
import org.restlet.representation.InputRepresentation;
import org.restlet.representation.ObjectRepresentation;
import org.restlet.representation.Representation;
import org.restlet.util.WrapperRepresentation;

/**
 * Utility method for restlet support.
 * @author hengsin
 *
 */
public class RestletUtil {

	public final static CLogger log = CLogger.getCLogger(RestletUtil.class);
		
	/**
	 * Convert response or request representation to java object.
	 * @param entity
	 * @return T
	 */
	@SuppressWarnings("unchecked")
	public static <T> T toObject(Representation entity) {
		ObjectInputStream ois = null;
		try {
			if (entity instanceof WrapperRepresentation) {
				entity = ((WrapperRepresentation)entity).getWrappedRepresentation();
			}
			if (entity instanceof ObjectRepresentation<?>) {
				ObjectRepresentation<?> or = (ObjectRepresentation<?>) entity;
				return (T) or.getObject();
			} else if (entity instanceof InputRepresentation) {
				InputRepresentation ir = (InputRepresentation) entity;
				ois = new ObjectInputStream(ir.getStream());
				return (T) ois.readObject();
			} else {
				return null;
			}
		} catch (Exception e) {
			log.log(Level.SEVERE, e.getLocalizedMessage(), e);
			return null;
		}
		finally{
			if (ois != null) {
				try {
					ois.close();
				} catch (Exception e2) {}
				ois = null;
			}
		}
	}
}
