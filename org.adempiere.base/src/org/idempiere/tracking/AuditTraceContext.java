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
 * - Elaine Tan                         							   *
 **********************************************************************/
package org.idempiere.tracking;

/**
 * Thread-local carrier for the ExternalTraceId used in audit changelog entries.
 */
public final class AuditTraceContext {
	private static final ThreadLocal<String> EXTERNAL_TRACE_ID = new ThreadLocal<>();
	 
    private AuditTraceContext() {}
 
    /**
     * Returns the ExternalTraceId bound to the current thread, or {@code null}
     * if none has been set. A null return is normal for non-REST code paths.
     */
    public static String getExternalTraceId() {
        return EXTERNAL_TRACE_ID.get();
    }
 
    /**
     * Binds an ExternalTraceId to the current thread.
     * @param externalTraceId
     */
    public static void setExternalTraceId(String externalTraceId) {
        if (externalTraceId == null) {
            EXTERNAL_TRACE_ID.remove();
        } else {
            EXTERNAL_TRACE_ID.set(externalTraceId);
        }
    }
 
    /**
     * Removes the ExternalTraceId bound to the current thread.
     * Must be called in a {@code finally} block at every entry point that
     * calls {@link #setExternalTraceId(String)}.
     */
    public static void clear() {
        EXTERNAL_TRACE_ID.remove();
    }

}
