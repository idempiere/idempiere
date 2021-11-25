/******************************************************************************
 * Product: iDempiere ERP & CRM Smart Business Solution                       *
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
package org.adempiere.base.annotation;

import static java.lang.annotation.RetentionPolicy.RUNTIME;
import static java.lang.annotation.ElementType.FIELD;

import java.lang.annotation.Retention;
import java.lang.annotation.Target;

import org.compiere.model.X_AD_Process_Para;
import org.compiere.process.SvrProcess;

/**
 * Tags a process class field as a process parameter in order to have its value set automatically. 
 * Class fields are matched against process parameters using the following heuristics: <br>
 * [1] If the parameter annotation has a name, then it must match exactly the process parameter 
 *     metadata definition. For example: <br>
 *     <code>@Parameter(name="C_BPartner_ID") int foo</code> will fill <code>foo</code> with
 *     the value of the parameter named <code>C_BPartner_ID</code>. <br>
 * [2] Class fields with the <code>p_</code> prefix will be matched automatically. Example: <br>
 *     <code>@Parameter Integer p_C_BPartner_ID</code> will match a parameter named <code>C_BPartner_ID</code>.
 * [3] Fields with their names matching metadata names after stripping the "_" character. Example:
 *     <code>@Parameter Integer cBPartnerId</code> will match a parameter named <code>C_BPartner_ID</code>.
 * [4] Fields with their names matching exactly their metadata names. Example:
 *     <code>@Parameter Integer C_BPartner_ID</code> will match a parameter named <code>C_BPartner_ID</code>.
 * @see SvrProcess
 * @author Saulo Gil
 */
@Target(FIELD)
@Retention(RUNTIME)
public @interface Parameter {

	/**
	 * Optional parameter name matching its metadata definition.
	 * @see X_AD_Process_Para#getColumnName()
	 * @return
	 */
    String name() default "";
}
