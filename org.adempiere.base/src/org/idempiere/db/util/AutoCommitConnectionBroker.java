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
package org.idempiere.db.util;

import java.sql.Connection;
import java.sql.SQLException;

import org.compiere.util.DB;

/**
 * This class managed the sharing of non-transactional connection per thread.
 * @author hengsin
 *
 */
public class AutoCommitConnectionBroker {
	private static ThreadLocal<ConnectionReference> threadLocalConnection = new ThreadLocal<ConnectionReference>() {
        protected ConnectionReference initialValue()
        {
        	return null;
        }
    };
    
    /**
     * Retrieve non-transactional connection for current thread. 
     * If none have been allocated yet, a new one will be created from the connection pool.
     * @return Connection
     */
    public static Connection getConnection() {
    	ConnectionReference connReference = threadLocalConnection.get();
    	if (connReference != null) {
    		connReference.referenceCount++;
    		return connReference.connection;
    	} else {
    		Connection connection = DB.createConnection(true, false, Connection.TRANSACTION_READ_COMMITTED);
    		connReference = new ConnectionReference(connection);
    		threadLocalConnection.set(connReference);
    		return connection;
    	}
    }
    
    /**
     * Release connection. The connection goes back to pool if reference count is zero.
     * @param conn
     */
    public static void releaseConnection(Connection conn) {
    	ConnectionReference connReference = threadLocalConnection.get();
    	if (connReference != null && connReference.connection == conn) {
    		connReference.referenceCount--;
    		if (connReference.referenceCount <= 0) {
    			threadLocalConnection.set(null);
    			try {
					connReference.connection.close();
				} catch (SQLException e) {}
    		}
    	} else {
    		try {
				conn.close();
			} catch (SQLException e) {}
    	}
    }

	private static class ConnectionReference {
		protected Connection connection;
		protected int referenceCount;
		protected ConnectionReference(Connection conn) {
			connection = conn;
			referenceCount = 1;
		}		
	}
}
