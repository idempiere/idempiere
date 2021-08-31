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
 * - hengsin                         								   *
 **********************************************************************/
package org.idempiere.expression.logic;

import java.util.logging.Level;

import org.antlr.v4.runtime.CharStreams;
import org.antlr.v4.runtime.CommonTokenStream;
import org.antlr.v4.runtime.misc.ParseCancellationException;
import org.compiere.util.CLogger;
import org.compiere.util.Evaluatee;

/**
 * 
 * @author hengsin
 *
 */
public final class LogicEvaluator {

	private final static CLogger s_log = CLogger.getCLogger(LogicEvaluator.class);
	
	private LogicEvaluator() {
	}

	/**
	 *	Evaluate Logic.
	 *  {@code
	 *	format: <negate>(<expression> [<logic> <expression>]).
	 *  <negate>: $!.
	 *	<expression>: @<context>@<comparison><value>.
	 *	<logic>: | or & (Example '@AD_Table@=Test | @Language@=GERGER).
	 *  <comparison>: = | ! | ^ | < | > | <= | >= | ~ (Equal, Not Equal, Not Equal, Less Than, 
	 *  Greater Than, Less Than or Equal, Greater Than or Equal, Regular Expression Match).
	 *  <Regular Expression Match>: <input string> ~ '<regular expression>'.
	 *  <List>: value1,value2,value3 (Example '@CalculationType@=A,R,S').
	 *	<context>: any global or window context.
	 *	<value>: strings can be with ' or ".
	 *	<logic operators>: AND or OR with the previous result from left to right.
	 *  <()>: override the default left to right evaluation order (Example '@GrandTotal@=0 |(@GrandTotal@>0 & @PaymentRule@=X)").
	 *
	 *  }
	 *  @param source class implementing get_ValueAsString(variable)
	 *  @param logic logic string
	 *  @return logic result
	 */
	public static boolean evaluateLogic (Evaluatee source, String logic) {
		SimpleBooleanLexer lexer = new SimpleBooleanLexer(CharStreams.fromString(logic));
	    SimpleBooleanParser parser = new SimpleBooleanParser(new CommonTokenStream(lexer));
	    parser.removeErrorListeners();
	    parser.addErrorListener(ThrowingErrorListener.INSTANCE);
	    try {
		    Object result = new EvaluationVisitor(source).visit(parser.parse());
		    if (result != null && result instanceof Boolean) {
		    	return (boolean) result;
		    } else {
		    	s_log.severe ("Logic does not comply with format "
						+ "'<expression> [<logic> <expression>]' => " + logic);
				return false;
		    }
	    } catch (ParseCancellationException e) {
	    	s_log.log(Level.SEVERE, "Logic="+logic+" Error="+e.getMessage(), e);
	    	return false;
	    }
	}
	
	/**
	 * Throw exception if logic is not valid
	 * @param logic
	 * @throws ParseCancellationException
	 */
	public static void validate(String logic) {
		SimpleBooleanLexer lexer = new SimpleBooleanLexer(CharStreams.fromString(logic));
	    SimpleBooleanParser parser = new SimpleBooleanParser(new CommonTokenStream(lexer));
	    parser.removeErrorListeners();
	    parser.addErrorListener(ThrowingErrorListener.INSTANCE);
	    parser.parse();
	}
}
