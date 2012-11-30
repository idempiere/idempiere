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
package org.adempiere.base.event;

/**
 *
 * @author hengsin
 *
 */
public interface IEventTopics {

	public static final String MODEL_EVENT_PREFIX = "adempiere/po/";
	/** Model Change Type New		*/
	public static final String PO_BEFORE_NEW = MODEL_EVENT_PREFIX+"beforeNew";
	public static final String PO_AFTER_NEW = MODEL_EVENT_PREFIX+"afterNew";
	public static final String PO_AFTER_NEW_REPLICATION = MODEL_EVENT_PREFIX+"afterNewReplication";	// @Trifon
	/** Model Change Type Change	*/
	public static final String PO_BEFORE_CHANGE = MODEL_EVENT_PREFIX+"beforeChange";
	public static final String PO_AFTER_CHANGE = MODEL_EVENT_PREFIX+"afterChange";
	public static final String PO_AFTER_CHANGE_REPLICATION = MODEL_EVENT_PREFIX+"afterChangeReplication"; // @Trifon
	/** Model Change Type Delete	*/
	public static final String PO_BEFORE_DELETE = MODEL_EVENT_PREFIX+"beforeDelete";
	public static final String PO_AFTER_DELETE = MODEL_EVENT_PREFIX+"afterDelete";
	public static final String PO_BEFORE_DELETE_REPLICATION = MODEL_EVENT_PREFIX+"beforeDeleteReplication"; // @Trifon
	//asynchrous model event
	public static final String PO_POST_CREATE = MODEL_EVENT_PREFIX+"postCreate";
	public static final String PO_POST_UPADTE = MODEL_EVENT_PREFIX+"postUpdate";
	public static final String PO_POST_DELETE = MODEL_EVENT_PREFIX+"postDelete";
	public static final String PO_ALL = MODEL_EVENT_PREFIX+"*";

	public static final String DOC_EVENT_PREFIX = "adempiere/doc/";
	/** Called before document is prepared */
	public static final String DOC_BEFORE_PREPARE = DOC_EVENT_PREFIX+"beforePrepare";
	/** Called before document is void */
	public static final String DOC_BEFORE_VOID = DOC_EVENT_PREFIX+"beforeVoid";
	/** Called before document is close */
	public static final String DOC_BEFORE_CLOSE = DOC_EVENT_PREFIX+"beforeClose";
	/** Called before document is reactivate */
	public static final String DOC_BEFORE_REACTIVATE = DOC_EVENT_PREFIX+"beforeReactivate";
	/** Called before document is reversecorrect */
	public static final String DOC_BEFORE_REVERSECORRECT = DOC_EVENT_PREFIX+"beforeReverseCorrect";
	/** Called before document is reverseaccrual */
	public static final String DOC_BEFORE_REVERSEACCRUAL = DOC_EVENT_PREFIX+"beforeReverseAccrual";
	/** Called before document is completed */
	public static final String DOC_BEFORE_COMPLETE = DOC_EVENT_PREFIX+"beforeComplete";
	/** Called after document is prepared */
	public static final String DOC_AFTER_PREPARE = DOC_EVENT_PREFIX+"afterPrepare";
	/** Called after document is completed */
	public static final String DOC_AFTER_COMPLETE = DOC_EVENT_PREFIX+"afterComplete";
	/** Called after document is void */
	public static final String DOC_AFTER_VOID = DOC_EVENT_PREFIX+"afterVoid";
	/** Called after document is closed */
	public static final String DOC_AFTER_CLOSE = DOC_EVENT_PREFIX+"afterClose";
	/** Called after document is reactivated */
	public static final String DOC_AFTER_REACTIVATE = DOC_EVENT_PREFIX+"afterReactivate";
	/** Called after document is reversecorrect */
	public static final String DOC_AFTER_REVERSECORRECT = DOC_EVENT_PREFIX+"afterReverseCorrect";
	/** Called after document is reverseaccrual */
	public static final String DOC_AFTER_REVERSEACCRUAL = DOC_EVENT_PREFIX+"afterReverseAccrual";
	/** Called before document is posted */
	public static final String DOC_BEFORE_POST = DOC_EVENT_PREFIX+"beforePost";
	/** Called after document is posted */
	public static final String DOC_AFTER_POST = DOC_EVENT_PREFIX+"afterPost";
	public static final String DOC_ALL = DOC_EVENT_PREFIX+"*";

	public static final String AFTER_LOGIN = "adempiere/afterLogin";

	public static final String ACCT_FACTS_VALIDATE = "adempiere/acct/factsValidate";

	/** Import Events **/
	public static final String IMPORT_PREFIX = "adempiere/import/";
	/** Event triggered before all import records are validated */
	public static final String IMPORT_BEFORE_VALIDATE = IMPORT_PREFIX+"beforeValidate";
	/** Event triggered after all import records are validated */
	public static final String IMPORT_AFTER_VALIDATE = IMPORT_PREFIX+"afterValidate";
	/** Event triggered before an import record is processed */
	public static final String IMPORT_BEFORE_IMPORT = IMPORT_PREFIX+"beforeImport";
	/** Event triggered after an import record is processed */
	public static final String IMPORT_AFTER_IMPORT = IMPORT_PREFIX+"afterImport";

	public static final String PREF_AFTER_LOAD = "adempiere/pref/afterLoad";
	
	public static final String BROADCAST_MESSAGE = "adempiere/broadcastMsg";
}

