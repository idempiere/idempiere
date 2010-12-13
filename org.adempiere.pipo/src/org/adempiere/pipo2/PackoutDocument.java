/******************************************************************************
 * Product: Adempiere ERP & CRM Smart Business Solution                       *
 * Copyright (C) 2010 Heng Sin Low                							  *
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
package org.adempiere.pipo2;

import java.util.Date;

/**
 *
 * @author hengsin
 *
 */
public class PackoutDocument {
	private String packageName;
	private String packageVersion;
	private String adempiereVersion;
	private String databaseVersion;
	private String description;
	private String instructions;
	private String author;
	private String authorEmail;
	private Date created;
	private Date updated;

	/**
	 * @param packageName
	 * @param packageVersion
	 * @param adempiereVersion
	 * @param databaseVersion
	 * @param description
	 * @param author
	 * @param authorEmail
	 * @param created
	 * @param updated
	 */
	public PackoutDocument(String packageName, String packageVersion,
			String adempiereVersion, String databaseVersion,
			String description, String instructions, String author, String authorEmail,
			Date created, Date updated) {
		super();
		this.packageName = packageName;
		this.packageVersion = packageVersion;
		this.adempiereVersion = adempiereVersion;
		this.databaseVersion = databaseVersion;
		this.description = description;
		this.instructions = instructions;
		this.author = author;
		this.authorEmail = authorEmail;
		this.created = created;
		this.updated = updated;
	}

	/**
	 * @return the packageName
	 */
	public String getPackageName() {
		return packageName;
	}

	/**
	 * @return the packageVersion
	 */
	public String getPackageVersion() {
		return packageVersion;
	}

	/**
	 * @return the adempiereVersion
	 */
	public String getAdempiereVersion() {
		return adempiereVersion;
	}

	/**
	 * @return the databaseVersion
	 */
	public String getDatabaseVersion() {
		return databaseVersion;
	}

	/**
	 * @return the description
	 */
	public String getDescription() {
		return description;
	}

	public String getInstructions() {
		return instructions;
	}

	/**
	 * @return the author
	 */
	public String getAuthor() {
		return author;
	}

	/**
	 * @return the authorEmail
	 */
	public String getAuthorEmail() {
		return authorEmail;
	}

	/**
	 * @return the created
	 */
	public Date getCreated() {
		return created;
	}

	/**
	 * @return the updated
	 */
	public Date getUpdated() {
		return updated;
	}
}
