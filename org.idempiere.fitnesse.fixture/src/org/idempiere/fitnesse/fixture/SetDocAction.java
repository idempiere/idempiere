/**********************************************************************
* This file is part of Adempiere ERP Bazaar                           *
* http://www.adempiere.org                                            *
*                                                                     *
* Copyright (C) Carlos Ruiz                                           *
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
* - Carlos Ruiz - globalqss                                           *
***********************************************************************/

package org.idempiere.fitnesse.fixture;

import java.util.Properties;

import org.compiere.model.MTable;
import org.compiere.model.PO;
import org.compiere.process.DocAction;
import org.compiere.process.DocumentEngine;
import org.compiere.util.CLogger;
import org.compiere.util.Trx;

import fitnesse.fixtures.TableFixture;

/**
 *	iDempiere Set Doc Action fixture for use with fitnesse framework testing
 *
 *  @author Carlos Ruiz - globalqss
 */
public class SetDocAction extends TableFixture {
	private static Instance adempiereInstance = null;
	
	@Override
	protected void doStaticTable(int rows) {
		if (adempiereInstance == null) {
			adempiereInstance = Static_iDempiereInstance.getInstance();
		}
		if (adempiereInstance.getAdempiereService() == null || ! adempiereInstance.getAdempiereService().isLoggedIn()) {
			wrong(rows-1, 1);
			getCell(rows-1, 1).addToBody("not logged in");
			return;
		}
		Properties ctx = adempiereInstance.getAdempiereService().getCtx();
		int windowNo = adempiereInstance.getAdempiereService().getWindowNo();

		PO gpo = null;
		String tableName  = new String("");
		String columnName = null;
		boolean tableOK = false;
		MTable table = null;
		int recordID = -1;
		String docAction = null;
		for (int i = 0; i < rows; i++) {
			String cell_title = getText(i, 0);
			String cell_value = getText(i, 1);
			if (cell_title.equalsIgnoreCase("*Table*")) {
				if (i > 0)
					exception(getCell(i, 1), new Exception("*Table* must be defined in first row"));
				tableName = cell_value;
				// TODO : trx
				// TODO : verify if the record already exists
				table = MTable.get(ctx, tableName);
				if (table == null || table.get_ID() <= 0) {
					wrong(i, 1);
					tableOK = false;
				} else {
					tableOK = true;
				}
			} else if (cell_title.equalsIgnoreCase("*Save*")) {
				if (i != rows-1) {
					exception(getCell(i, 1), new Exception("*Save* must be called in last row"));
					return;
				}
				if (! tableOK) {
					getCell(i, 1).addToBody("Table " + tableName + " does not exist");
					wrong(i, 1);
					return;
				}
				if (recordID == -1 || docAction == null) {
					exception(getCell(i, 1), new Exception("You need to assign " + tableName + "_ID and DocAction"));
					return;
				}

				Trx trx = Trx.get(Trx.createTrxName("FixtureSetDocAction"), true);

				gpo = table.getPO(recordID, trx.getTrxName());
				if (gpo == null) {
					exception(getCell(i, 1), new Exception("No Record " + recordID + " in " + tableName));
					return;
				}
				
				DocumentEngine engine = new DocumentEngine ((DocAction) gpo, ((DocAction)gpo).getDocStatus());
				if (! engine.isValidAction(docAction)) {
					StringBuilder msg = new StringBuilder("Not a valid action for docStatus=");
					msg.append(((DocAction)gpo).getDocStatus())
					   .append(" valid actions are:");
					for (String s : engine.getActionOptions())
						msg.append(" ").append(s);
					exception(getCell(i, 1), new Exception(msg.toString()));
					return;
				}
				
				if (! DocAction.ACTION_Post.equals(docAction)) {
					// set explicitly the column DocAction to avoid automatic process of default option - except for Post
					if (!gpo.set_ValueOfColumnReturningBoolean("DocAction", docAction)) {
						exception(getCell(i, 1), new Exception("No Record " + recordID + " in " + tableName));
						return;
					}
					if (!gpo.save()) {
						exception(getCell(i, 1), new Exception("Cannot save before setDocAction: " + CLogger.retrieveErrorString("no log message")));
						return;
					}
				}
				
				// call process it
				try {
					if (! ((DocAction) gpo).processIt(docAction)) {
						exception(getCell(i, 1), new Exception("Couldn't set docAction: " + ((DocAction) gpo).getProcessMsg()));
						return;
					}
				} catch (Exception e) {
					exception(getCell(i, 1), e);
				}

				// close the trx
				if (!gpo.save()) {
					exception(getCell(i, 1), new Exception("Cannot save after setDocAction: " + CLogger.retrieveErrorString("no log message")));
					return;
				}

				if (!trx.commit()) {
					exception(getCell(i, 1), new Exception("Cannot commit: " + CLogger.retrieveErrorString("no log message")));
					return;
				}

				trx.close();
				
				// Now validate the expected status according to DocAction

				StringBuffer expected = new StringBuffer();
				if (validateResult(docAction, ((DocAction) gpo).getDocStatus(), expected)) {
					right(i, 1);
				} else {
					wrong(i, 1);
				}
				getCell(i, 1).addToBody("DocStatus="+((DocAction) gpo).getDocStatus()+" expected " + expected.toString());

				gpo = null;
			} else {
				if (tableOK) {
					columnName = cell_title;
					String value_evaluated = Util.evaluate(ctx, windowNo, cell_value, getCell(i, 1));
					if (columnName.equalsIgnoreCase(tableName + "_ID")) {
						try {
							recordID  = Integer.parseInt(value_evaluated);
						} catch (NumberFormatException e) {
							exception(getCell(i, 1), e);
							return;
						}
					} else if (columnName.equalsIgnoreCase("DocAction")) {
						docAction = value_evaluated;
					} else {
						exception(getCell(i, 1), new Exception("Column not allowed, just assign " + tableName + "_ID or DocAction"));
						return;
					}
				}
			}
		}
	}

	private boolean validateResult(String docAction, String docStatus, StringBuffer expected) {

		// Now validate the expected status according to DocAction
		if (DocAction.ACTION_Unlock.equals(docAction)) {
			expected.append(DocAction.STATUS_Drafted);
			return DocAction.STATUS_Drafted.equals(docStatus);

		} else if (DocAction.ACTION_Invalidate.equals(docAction)) {
			expected.append(DocAction.STATUS_Invalid);
			return DocAction.STATUS_Invalid.equals(docStatus);

		} else if (DocAction.ACTION_Prepare.equals(docAction)) {
			expected.append(DocAction.STATUS_InProgress);
			return DocAction.STATUS_InProgress.equals(docStatus);

		} else if (DocAction.ACTION_Approve.equals(docAction)) {
			expected.append(DocAction.STATUS_Approved);
			return DocAction.STATUS_Approved.equals(docStatus);

		} else if (DocAction.ACTION_Reject.equals(docAction)) {
			expected.append(DocAction.STATUS_NotApproved);
			return DocAction.STATUS_NotApproved.equals(docStatus);

		} else if (   DocAction.ACTION_Complete.equals(docAction) 
				   || DocAction.ACTION_WaitComplete.equals(docAction)) {
			expected.append(DocAction.STATUS_Completed).append(" - ");
			expected.append(DocAction.STATUS_InProgress).append(" - ");
			expected.append(DocAction.STATUS_WaitingPayment).append(" - ");
			expected.append(DocAction.STATUS_WaitingConfirmation);
			return DocAction.STATUS_Completed.equals(docStatus) 
				|| DocAction.STATUS_InProgress.equals(docStatus)
				|| DocAction.STATUS_WaitingPayment.equals(docStatus) 
				|| DocAction.STATUS_WaitingConfirmation.equals(docStatus);

		} else if (DocAction.ACTION_ReActivate.equals(docAction)) {
			expected.append(DocAction.STATUS_InProgress);
			return DocAction.STATUS_InProgress.equals(docStatus);

		} else if (DocAction.ACTION_Reverse_Accrual.equals(docAction)) {
			expected.append(DocAction.STATUS_Reversed);
			return DocAction.STATUS_Reversed.equals(docStatus);

		} else if (DocAction.ACTION_Reverse_Correct.equals(docAction)) {
			expected.append(DocAction.STATUS_Reversed);
			return DocAction.STATUS_Reversed.equals(docStatus);

		} else if (DocAction.ACTION_Close.equals(docAction)) {
			expected.append(DocAction.STATUS_Closed);
			return DocAction.STATUS_Closed.equals(docStatus);

		} else if (DocAction.ACTION_Void.equals(docAction)) {
			expected.append(DocAction.STATUS_Voided);
			return DocAction.STATUS_Voided.equals(docStatus);

		} else if (DocAction.ACTION_Post.equals(docAction)) {
			expected.append(docStatus);
			return true;

		}

		return false;
	}

} // AdempiereSetDocAction