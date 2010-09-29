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
package org.adempiere.web.server;

import org.adempiere.web.server.command.ExecuteProcessCommand;
import org.adempiere.web.server.command.ExecuteTaskCommand;
import org.adempiere.web.server.command.ExecuteWorkflowCommand;
import org.adempiere.web.server.command.PostDocumentCommand;
import org.adempiere.web.server.command.ResetCacheCommand;
import org.adempiere.web.server.command.SendEmailCommand;
import org.adempiere.web.server.status.DatabaseResource;
import org.adempiere.web.server.status.VersionResource;
import org.restlet.Application;
import org.restlet.Restlet;
import org.restlet.data.ChallengeScheme;
import org.restlet.routing.Router;
import org.restlet.security.ChallengeAuthenticator;

/**
 * Restlet application for /command and /status service.
 * @author hengsin
 */
public class ServerApplication extends Application {

	/**
     * Creates a root Restlet that will receive all incoming calls.
     */
    @Override
    public synchronized Restlet createInboundRoot() {
        // Create a router Restlet that routes each call to a new instance of HelloWorldResource.
        Router router = new Router(getContext());
 
        // Defines command route
        // The command handler discovery can be refactor to use equinox extension in future to make this 
        // extensible
        router.attach("/command/postDocument", PostDocumentCommand.class);
        router.attach("/command/executeProcess", ExecuteProcessCommand.class);
        router.attach("/command/executeWorkflow", ExecuteWorkflowCommand.class);
        router.attach("/command/executeTask", ExecuteTaskCommand.class);
        router.attach("/command/sendEmail", SendEmailCommand.class);
        router.attach("/command/resetCache", ResetCacheCommand.class);

        // Defines config route
        router.attach("/status/version/{type}", VersionResource.class);
        router.attach("/status/database/{property}", DatabaseResource.class);
        
        
        // Authenticate the whole hierarchy of URIs
        ChallengeAuthenticator guard = new ChallengeAuthenticator(getContext(),
                ChallengeScheme.HTTP_BASIC, "adempiere realm");
        guard.setVerifier(new BasicVerifier());
        guard.setOptional(false);

        guard.setNext(router);

        return guard;
    }
}
