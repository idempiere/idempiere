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

import java.math.BigDecimal;
import java.util.regex.Pattern;

import org.compiere.util.Evaluatee;
import org.compiere.util.Util;
import org.idempiere.expression.logic.SimpleBooleanParser.BinaryContext;
import org.idempiere.expression.logic.SimpleBooleanParser.BoolContext;
import org.idempiere.expression.logic.SimpleBooleanParser.ComparatorContext;
import org.idempiere.expression.logic.SimpleBooleanParser.ComparatorExpressionContext;
import org.idempiere.expression.logic.SimpleBooleanParser.ContextVariablesContext;
import org.idempiere.expression.logic.SimpleBooleanParser.DoubleQuotedTextContext;
import org.idempiere.expression.logic.SimpleBooleanParser.QuotedTextContext;
import org.idempiere.expression.logic.SimpleBooleanParser.TextContext;

/**
 * 
 * @author hengsin
 *
 */
public class EvaluationVisitor extends SimpleBooleanBaseVisitor<Object> {

	private final Evaluatee evaluatee;

	public EvaluationVisitor(Evaluatee evaluatee) {
		this.evaluatee = evaluatee;
	}

	@Override
	public Object visitParse(SimpleBooleanParser.ParseContext ctx) {
		return super.visit(ctx.expression());
	}

	@Override
	public Object visitDecimalExpression(SimpleBooleanParser.DecimalExpressionContext ctx) {
		return new BigDecimal(ctx.DECIMAL().getText());
	}

	

	@Override
	public Object visitQuotedText(QuotedTextContext ctx) {
		return ctx.QTEXT().getText().replaceAll("[']", "");
	}

	@Override
	public Object visitDoubleQuotedText(DoubleQuotedTextContext ctx) {
		return ctx.DQTEXT().getText().replaceAll("[\"]", "");
	}

	@Override
	public Object visitText(TextContext ctx) {
		return ctx.TEXT().getText();
	}

	@Override
	public Object visitNotExpression(SimpleBooleanParser.NotExpressionContext ctx) {
		return !((Boolean) this.visit(ctx.expression()));
	}

	@Override
	public Object visitParenExpression(SimpleBooleanParser.ParenExpressionContext ctx) {
		return super.visit(ctx.expression());
	}

	@Override
	public Object visitComparatorExpression(SimpleBooleanParser.ComparatorExpressionContext ctx) {
		if (ctx.op.EQ() != null) {
			return isEqual(ctx);
		} else if (ctx.op.LE() != null) {
			return asBigDecimal(ctx.left).compareTo(asBigDecimal(ctx.right)) <= 0;
		} else if (ctx.op.GE() != null) {
			return asBigDecimal(ctx.left).compareTo(asBigDecimal(ctx.right)) >= 0;
		} else if (ctx.op.LT() != null) {
			return asBigDecimal(ctx.left).compareTo(asBigDecimal(ctx.right)) < 0;
		} else if (ctx.op.GT() != null) {
			return asBigDecimal(ctx.left).compareTo(asBigDecimal(ctx.right)) > 0;
		} else if (ctx.op.NE() != null) {
			return !(isEqual(ctx));
		} else if (ctx.op.RE() != null) {
			return regularExpressionMatch(ctx);
		}
		throw new RuntimeException("not implemented: comparator operator " + ctx.op.getText());
	}

	//input ~ regex
	private Boolean regularExpressionMatch(ComparatorExpressionContext ctx) {
		String left = this.visit(ctx.left).toString();
		String right = this.visit(ctx.right).toString();
		return Pattern.matches(right, left);
	}

	private Boolean isEqual(SimpleBooleanParser.ComparatorExpressionContext ctx) {
		Object left = this.visit(ctx.left);
		Object right = this.visit(ctx.right);
		if (left instanceof String && right instanceof String && !(ctx.right.getText().startsWith("'") && !(ctx.right.getText().startsWith("\"")))) {
			String rightText = (String) right;
			if (rightText.indexOf(",") > 0) {
				return isIn((String)left, rightText);
			}
		}
		if (left instanceof BigDecimal && right instanceof BigDecimal) {
			return ((BigDecimal)left).compareTo((BigDecimal) right) == 0;
		} else {
			String leftStr = left.toString();
			if (left instanceof BigDecimal) {
				if (((BigDecimal)left).stripTrailingZeros().scale() <= 0) {
					leftStr = Integer.toString(((BigDecimal)left).intValue());
				}
			}
			String rightStr = right.toString();
			if (right instanceof BigDecimal) {
				if (((BigDecimal)right).stripTrailingZeros().scale() <= 0) {
					rightStr = Integer.toString(((BigDecimal)right).intValue());
				}
			}
			return leftStr.equals(rightStr);
		}
	}

	private Boolean isIn(String left, String rightText) {
		String[] values = rightText.split("[,]");
		for(String s : values) {
			s = s.trim();
			if ((s.startsWith("'") && s.endsWith("'")) || (s.startsWith("\"") && s.endsWith("\"")))
				s = s.substring(1, s.length()-1);
			if (left.equals(s))
				return Boolean.TRUE;
		}
		return Boolean.FALSE;
	}

	@Override
	public Object visitBinaryExpression(SimpleBooleanParser.BinaryExpressionContext ctx) {
		if (ctx.op.AND() != null) {
			return asBoolean(ctx.left) && asBoolean(ctx.right);
		} else if (ctx.op.OR() != null) {
			return asBoolean(ctx.left) || asBoolean(ctx.right);
		}
		throw new RuntimeException("not implemented: binary operator " + ctx.op.getText());
	}

	@Override
	public Object visitBoolExpression(SimpleBooleanParser.BoolExpressionContext ctx) {
		return Boolean.valueOf(ctx.getText());
	}

	
	@Override
	public Object visitComparator(ComparatorContext ctx) {
		return super.visitComparator(ctx);
	}

	@Override
	public Object visitBool(BoolContext ctx) {
		return super.visitBool(ctx);
	}

	@Override
	public Object visitBinary(BinaryContext ctx) {
		return super.visitBinary(ctx);
	}

	@Override
	public Object visitContextVariables(ContextVariablesContext ctx) {
		String context = ctx.getText().substring(1, ctx.getText().length()-1);
		
		// IDEMPIERE-194 Handling null context variable
		String defaultValue = "";
		int idx = context.indexOf(":");	//	or clause
		if (idx  >=  0) 
		{
			defaultValue = context.substring(idx+1, context.length());
			context = context.substring(0, idx);
		}
		String value = evaluatee.get_ValueAsString(context);
		if (Util.isEmpty(value) && !Util.isEmpty(defaultValue)) {
			value = defaultValue;
		}
		if (value == null)
			value = "";
		
		if (Util.isEmpty(value, true) && context.endsWith("_ID"))
			return "0";
		else
			return value;
	}

	private boolean asBoolean(SimpleBooleanParser.ExpressionContext ctx) {
		return (boolean) visit(ctx);
	}

	private BigDecimal asBigDecimal(SimpleBooleanParser.ExpressionContext ctx) {
		Object value = visit(ctx);
		if (value instanceof String)
			return new BigDecimal((String)value);
		else if (value instanceof BigDecimal)
			return (BigDecimal)value;
		else
			return new BigDecimal(value.toString());
	}
}