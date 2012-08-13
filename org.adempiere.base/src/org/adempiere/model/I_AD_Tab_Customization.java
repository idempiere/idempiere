/**********************************************************************
 * This file is part of Adempiere ERP Bazaar                          *
 * http://www.adempiere.org                                           *
 *                                                                    *
 * Copyright (C) Trifon Trifonov.                                     *
 * Copyright (C) Contributors                                         *
 *                                                                    *
 * This program is free software, you can redistribute it and/or      *
 * modify it under the terms of the GNU General Public License        *
 * as published by the Free Software Foundation, either version 2     *
 * of the License, or (at your option) any later version.             *
 *                                                                    *
 * This program is distributed in the hope that it will be useful,    *
 * but WITHOUT ANY WARRANTY, without even the implied warranty of     *
 * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE. See the       *
 * GNU General Public License for more details.                       *
 *                                                                    *
 * You should have received a copy of the GNU General Public License  *
 * along with this program, if not, write to the Free Software        *
 * Foundation, Inc., 51 Franklin Street, Fifth Floor, Boston,         *
 * MA 02110-1301, USA.                                                *
 *                                                                    *
 * Contributors:                                                      *
 * - Trifon Trifonov (trifonnt@users.sourceforge.net)                 *
 *                                                                    *
 * Sponsors:                                                          *
 * - Company (http://www.site.com)                                    *
 **********************************************************************/
package org.adempiere.model;

import java.math.BigDecimal;
import org.compiere.model.*;
import org.compiere.util.KeyNamePair;

/** Generated Interface for AD_Tab_Customization
 *  @author Adempiere (generated) 
 *  @version Release 3.5.2a
 */
public interface I_AD_Tab_Customization 
{

    /** TableName=AD_Tab_Customization */
    public static final String Table_Name = "AD_Tab_Customization";

    /** AD_Table_ID=2000077 */
    public static final int Table_ID = MTable.getTable_ID(Table_Name);

    KeyNamePair Model = new KeyNamePair(Table_ID, Table_Name);

    /** AccessLevel = 3 - Client - Org 
     */
    BigDecimal accessLevel = BigDecimal.valueOf(3);

    /** Load Meta Data */

    /** Column name AD_Tab_ID */
    public static final String COLUMNNAME_AD_Tab_ID = "AD_Tab_ID";

	/** Set Tab.
	  * Tab within a Window
	  */
	public void setAD_Tab_ID (int AD_Tab_ID);

	/** Get Tab.
	  * Tab within a Window
	  */
	public int getAD_Tab_ID();

	public I_AD_Tab getAD_Tab() throws Exception;

    /** Column name AD_Tab_Customization_ID */
    public static final String COLUMNNAME_AD_Tab_Customization_ID = "AD_Tab_Customization_ID";

	/** Set AD_Tab_Customization_ID	  */
	public void setAD_Tab_Customization_ID (int AD_Tab_Customization_ID);

	/** Get AD_Tab_Customization_ID	  */
	public int getAD_Tab_Customization_ID();

    /** Column name AD_User_ID */
    public static final String COLUMNNAME_AD_User_ID = "AD_User_ID";

	/** Set User/Contact.
	  * User within the system - Internal or Business Partner Contact
	  */
	public void setAD_User_ID (int AD_User_ID);

	/** Get User/Contact.
	  * User within the system - Internal or Business Partner Contact
	  */
	public int getAD_User_ID();

	public I_AD_User getAD_User() throws Exception;

    /** Column name Custom */
    public static final String COLUMNNAME_Custom = "Custom";

	/** Set Custom	  */
	public void setCustom (String Custom);

	/** Get Custom	  */
	public String getCustom();
}
