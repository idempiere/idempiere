/*******************************************************************************
 * Copyright (c) 2005, 2007 Cognos Incorporated, IBM Corporation and others.
 * All rights reserved. This program and the accompanying materials
 * are made available under the terms of the Eclipse Public License v1.0
 * which accompanies this distribution, and is available at
 * http://www.eclipse.org/legal/epl-v10.html
 * 
 * Contributors:
 *     Cognos Incorporated - initial API and implementation
 *     IBM Corporation - bug fixes and enhancements
 *******************************************************************************/
package org.eclipse.equinox.http.servlet.internal;

public abstract class Registration {

	protected int referenceCount;

	public synchronized void addReference() {
		++referenceCount;
	}

	public synchronized void removeReference() {
		--referenceCount;
		if (referenceCount == 0) {
			notifyAll();
		}
	}

	public synchronized void destroy() {
		boolean interrupted = false;
		try {
			while (referenceCount != 0) {
				try {
					wait();
				} catch (InterruptedException e) {
					// wait until the servlet is inactive but save the interrupted status
					interrupted = true;
				}
			}
		} finally {
			if (interrupted)
				Thread.currentThread().interrupt(); //restore the interrupted state
		}
	}
}
