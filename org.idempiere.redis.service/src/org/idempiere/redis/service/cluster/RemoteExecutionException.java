/**********************************************************************
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
* - Norbert Bede, Cloudempiere                                        *
**********************************************************************/
package org.idempiere.redis.service.cluster;

/**
 * A callable failed on another cluster member. Only the class name and the message of the
 * original exception cross the wire, never the exception object itself.
 */
public class RemoteExecutionException extends RuntimeException {

	private static final long serialVersionUID = 1L;

	private final String memberUuid;
	private final String remoteClassName;

	public RemoteExecutionException(String memberUuid, String remoteClassName, String message) {
		super(remoteClassName + ": " + message + " (on cluster member " + memberUuid + ")");
		this.memberUuid = memberUuid;
		this.remoteClassName = remoteClassName;
	}

	/** UUID of the member the callable failed on. */
	public String getMemberUuid() {
		return memberUuid;
	}

	/** Class name of the exception thrown on that member. */
	public String getRemoteClassName() {
		return remoteClassName;
	}
}
