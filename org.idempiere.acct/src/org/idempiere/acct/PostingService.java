/******************************************************************************
 * This file is part of iDempiere ERP                                         *
 * http://www.idempiere.org                                                   *
 *                                                                            *
 * Copyright (C) Contributors                                                 *
 *                                                                            *
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
package org.idempiere.acct;

import org.adempiere.util.Callback;
import org.adempiere.webui.acct.WAcctViewer;
import org.adempiere.webui.adwindow.AbstractADWindowContent;
import org.adempiere.webui.apps.AEnv;
import org.adempiere.webui.factory.IPostingService;
import org.adempiere.webui.panel.ADForm;
import org.adempiere.webui.window.Dialog;
import org.compiere.model.MProjectIssue;
import org.compiere.model.SystemIDs;
import org.compiere.process.DocAction;
import org.compiere.util.Env;
import org.idempiere.acct.doc.Doc;
import org.osgi.service.component.annotations.Component;

/**
 * OSGi service implementation of {@link IPostingService}.<br>
 * Handles the "Posted" column click in an AD Window tab:
 * validates document status, shows the accounting viewer if already posted,
 * or triggers immediate posting if not yet posted.
 *
 * <p>Registered as an OSGi service so that the accounting module is optional —
 * when this bundle is absent, the "Posted" button is silently ignored.</p>
 */
@Component(service = IPostingService.class, immediate = true)
public class PostingService implements IPostingService {

	@Override
	public void handlePostedClick(AbstractADWindowContent windowContent, int windowNo, int tableId, int recordId) {
		// Check Doc Status
		String processed = Env.getContext(Env.getCtx(), windowNo, "Processed");
		if (!processed.equals("Y")) {

			String docStatus = Env.getContext(Env.getCtx(), windowNo, "DocStatus");

			if (!(DocAction.STATUS_Completed.equals(docStatus)
					|| DocAction.STATUS_Closed.equals(docStatus)
					|| DocAction.STATUS_Reversed.equals(docStatus)
					|| DocAction.STATUS_Voided.equals(docStatus)
					|| tableId == MProjectIssue.Table_ID)) { // document without status
				Dialog.error(windowNo, "PostDocNotComplete");
				return;
			}
		}

		// Check Post Status via active grid tab
		final Object ps = windowContent.getActiveGridTab().getValue("Posted");

		if (ps != null && ps.equals("Y")) {
			// Already posted — open accounting viewer
			ADForm form = ADForm.openForm(SystemIDs.FORM_ACCOUNT_INFO,
					WAcctViewer.INITIAL_AD_TABLE_ID + "=" + tableId + "\n"
					+ WAcctViewer.INITIAL_RECORD_ID + "=" + recordId);
			AEnv.showWindow(form);
		} else {
			// Not yet posted — ask user to post immediately
			final int tableIdRef = tableId;
			final int recordIdRef = recordId;
			Dialog.ask(windowNo, "PostImmediate?", new Callback<Boolean>() {
				@Override
				public void onCallback(Boolean result) {
					if (result) {
						boolean force = ps != null && !ps.equals("N"); // force when problems
						String error = Doc.manualPosting(windowNo,
								Env.getAD_Client_ID(Env.getCtx()), tableIdRef, recordIdRef, force);

						windowContent.onRefresh(true, false);

						if (error != null) {
							if (windowContent.getActiveGridTab().isQuickForm)
								windowContent.getStatusBarQF().setStatusLine(error, true);
							else
								windowContent.getStatusBar().setStatusLine(error, true);
						}
					}
				}
			});
		}
	}
}
