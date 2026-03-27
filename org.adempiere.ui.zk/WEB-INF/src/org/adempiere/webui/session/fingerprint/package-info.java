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
 * - Carlos Ruiz - globalqss - bxservice                               *
 **********************************************************************/

/**
 * Extensible session fingerprinting package.
 * 
 * <p>This package provides an extensible framework for session fingerprinting
 * to protect against session hijacking and session fixation attacks.</p>
 * 
 * <h2>Key Components</h2>
 * <ul>
 *   <li>{@link org.adempiere.webui.session.fingerprint.ISessionFingerprintComponent} - 
 *       Interface for fingerprint components. Implement this to add custom fingerprinting.</li>
 *   <li>{@link org.adempiere.webui.session.fingerprint.SessionFingerprintManager} - 
 *       Manager that discovers and coordinates all fingerprint components.</li>
 *   <li>{@link org.adempiere.webui.session.fingerprint.FingerprintValidationResult} - 
 *       Result object containing validation details and actions to take.</li>
 * </ul>
 * 
 * <h2>Built-in Components</h2>
 * <p>The following components are registered as OSGi services in org.adempiere.ui.zk:</p>
 * <ul>
 *   <li>{@link org.adempiere.webui.session.fingerprint.IPAddressFingerprintComponent} - Client IP address</li>
 *   <li>{@link org.adempiere.webui.session.fingerprint.UserAgentFingerprintComponent} - Browser User-Agent</li>
 *   <li>{@link org.adempiere.webui.session.fingerprint.AcceptLanguageFingerprintComponent} - Accept-Language header</li>
 * </ul>
 * 
 * <h2>Configuration</h2>
 * <p>Each component can be enabled/disabled and its action configured via AD_SysConfig:</p>
 * <ul>
 *   <li>ZK_SESSION_FINGERPRINT_ENABLED - Global enable/disable (default: Y)</li>
 *   <li>ZK_SESSION_FINGERPRINT_CHECK_ACCEPT_LANGUAGE - Enable Accept-Language checking (default: S)</li>
 *   <li>ZK_SESSION_FINGERPRINT_CHECK_USER_AGENT - Enable User-Agent checking (default: S)</li>
 *   <li>ZK_SESSION_FINGERPRINT_CHECK_IP - Enable IP checking (default: L)</li>
 *   <li>etc.</li>
 * </ul>
 * 
 * <h2>Actions</h2>
 * <ul>
 *   <li>N - Nothing: Do not validate this component</li>
 *   <li>W - Log Warning: Log a warning message</li>
 *   <li>L - Log Severe: Log a severe message, including AD_Issue</li>
 *   <li>S - Stop: Invalidate the session and redirect to login</li>
 * </ul>
 * 
 * <h2>Extending</h2>
 * <p>To add a custom fingerprint component:</p>
 * <ol>
 *   <li>Implement {@link org.adempiere.webui.session.fingerprint.ISessionFingerprintComponent}</li>
 *   <li>Register it as an OSGi service</li>
 *   <li>Add AD_SysConfig entries for enable/action configuration</li>
 * </ol>
 */
package org.adempiere.webui.session.fingerprint;
