/**********************************************************************
* This file is part of Adempiere ERP Bazaar                           *
* http://www.adempiere.org                                            *
*                                                                     *
* Copyright (C) Carlos Ruiz - globalqss                               *
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
* - Carlos Ruiz  (globalqss@users.sourceforge.net)                    *
*                                                                     * 
* Sponsors:                                                           *
* - GlobalQSS (http://www.globalqss.com)                              *
***********************************************************************/

package org.idempiere.adinterface;


import javax.jws.WebService;
import javax.jws.soap.SOAPBinding;
import javax.jws.soap.SOAPBinding.ParameterStyle;
import javax.jws.soap.SOAPBinding.Style;
import javax.jws.soap.SOAPBinding.Use;
import javax.ws.rs.Consumes;
import javax.ws.rs.POST;
import javax.ws.rs.Path;
import javax.ws.rs.Produces;

import org.idempiere.adInterface.x10.ModelCRUDRequestDocument;
import org.idempiere.adInterface.x10.ModelGetListRequestDocument;
import org.idempiere.adInterface.x10.ModelRunProcessRequestDocument;
import org.idempiere.adInterface.x10.ModelSetDocActionRequestDocument;
import org.idempiere.adInterface.x10.RunProcessResponseDocument;
import org.idempiere.adInterface.x10.StandardResponseDocument;
import org.idempiere.adInterface.x10.WindowTabDataDocument;

@Path("/model_adservice/")
@Consumes("application/xml") 
@Produces("application/xml")
@WebService(targetNamespace="http://idempiere.org/ADInterface/1_0")
@SOAPBinding(style=Style.RPC,use=Use.LITERAL,parameterStyle=ParameterStyle.WRAPPED)
public interface ModelADService {

    /* Model oriented web services */ 

    @POST
	@Path("/set_docaction") 
    public StandardResponseDocument setDocAction(ModelSetDocActionRequestDocument req);

    @POST
	@Path("/run_process") 
    public RunProcessResponseDocument runProcess(ModelRunProcessRequestDocument req);
    
    @POST
	@Path("/get_list") 
    public WindowTabDataDocument getList(ModelGetListRequestDocument req);

    @POST
	@Path("/create_data") 
    public StandardResponseDocument createData(ModelCRUDRequestDocument req);

    @POST
	@Path("/update_data") 
    public StandardResponseDocument updateData(ModelCRUDRequestDocument req);

    @POST
 	@Path("/delete_data") 
    public StandardResponseDocument deleteData(ModelCRUDRequestDocument req);

	@POST
	@Path("/read_data") 
    public WindowTabDataDocument readData(ModelCRUDRequestDocument req);
    
	@POST
	@Path("/query_data") 
    public WindowTabDataDocument queryData(ModelCRUDRequestDocument req);
    
	@POST
	@Path("/create_update_data") 
	public StandardResponseDocument createUpdateData(ModelCRUDRequestDocument req);

}
