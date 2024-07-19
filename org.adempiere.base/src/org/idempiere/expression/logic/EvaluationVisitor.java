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
import java.sql.Timestamp;
import java.util.ArrayList;
import java.util.List;
import java.util.regex.Matcher;
import java.util.regex.Pattern;

import org.compiere.util.Evaluatee;
import org.compiere.util.Util;
import org.idempiere.expression.logic.SimpleBooleanParser.BinaryContext;
import org.idempiere.expression.logic.SimpleBooleanParser.BoolContext;
import org.idempiere.expression.logic.SimpleBooleanParser.ComparatorContext;
import org.idempiere.expression.logic.SimpleBooleanParser.ComparatorExpressionContext;
import org.idempiere.expression.logic.SimpleBooleanParser.ContextVariablesContext;
import org.idempiere.expression.logic.SimpleBooleanParser.DoubleQuotedCSVTextContext;
import org.idempiere.expression.logic.SimpleBooleanParser.DoubleQuotedTextContext;
import org.idempiere.expression.logic.SimpleBooleanParser.QuotedCSVTextContext;
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
	public Object visitQuotedCSVText(QuotedCSVTextContext ctx) {
		return ctx.QCSVTEXT().getText();
	}

	@Override
	public Object visitQuotedText(QuotedTextContext ctx) {
		return ctx.QTEXT().getText().replaceAll("[']", "");
	}

	@Override
	public Object visitDoubleQuotedCSVText(DoubleQuotedCSVTextContext ctx) {
		return ctx.DQCSVTEXT().getText();
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

	@SuppressWarnings({"unchecked", "rawtypes"})
	@Override
	public Object visitComparatorExpression(SimpleBooleanParser.ComparatorExpressionContext ctx) {
		if (ctx.op.EQ() != null) {
			return isEqual(ctx);
		} else if (ctx.op.LE() != null) {
			Comparable leftValue = asComparable(ctx.left); 
			Comparable rightValue = asComparable(ctx.right);
			if (leftValue == null || rightValue == null)
				return Boolean.FALSE;
			return leftValue.compareTo(rightValue) <= 0;
		} else if (ctx.op.GE() != null) {
			Comparable leftValue = asComparable(ctx.left); 
			Comparable rightValue = asComparable(ctx.right);
			if (leftValue == null || rightValue == null)
				return Boolean.FALSE;
			return leftValue.compareTo(rightValue) >= 0;
		} else if (ctx.op.LT() != null) {
			Comparable leftValue = asComparable(ctx.left); 
			Comparable rightValue = asComparable(ctx.right);
			if (leftValue == null || rightValue == null)
				return Boolean.FALSE;
			return leftValue.compareTo(rightValue) < 0;
		} else if (ctx.op.GT() != null) {
			Comparable leftValue = asComparable(ctx.left); 
			Comparable rightValue = asComparable(ctx.right);
			if (leftValue == null || rightValue == null)
				return Boolean.FALSE;
			return leftValue.compareTo(rightValue) > 0;
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

	@SuppressWarnings({ "rawtypes", "unchecked" })
	private Boolean isEqual(SimpleBooleanParser.ComparatorExpressionContext ctx) {
		Comparable left = asComparable(ctx.left);
		Comparable right = asComparable(ctx.right);
		if (left == null && right == null)
			return Boolean.TRUE;
		if (left == null || right == null)
			return Boolean.FALSE;
		if (left instanceof String && right instanceof String) {
			String rightText = (String) right;
			if (ctx.right.start.getType() == SimpleBooleanLexer.QCSVTEXT || ctx.right.start.getType() == SimpleBooleanLexer.DQCSVTEXT) {
				return isIn((String)left, rightText);
			} else if (ctx.right.start.getType() == SimpleBooleanLexer.TEXT && rightText.indexOf(",") > 0) {
				return isIn((String)left, rightText);
			}
		}
		
		//check string==bigdecimal or bigdecimal==string
		if (left instanceof String && !(right instanceof String)) {
			if (right instanceof BigDecimal) {
				return left.equals(((BigDecimal)right).toPlainString());
			} else {
				return left.equals(right.toString());
			}
		} else if (right instanceof String && !(left instanceof String)) {
			if (left instanceof BigDecimal) {
				return ((BigDecimal)left).toPlainString().equals(right);
			} else {
				return left.toString().equals(right.toString());
			}
		}
		
		try {
			return left.compareTo(right) == 0;
		} catch (Exception e) {
			//fall back to string
			return left.toString().equals(right.toString());
		}
	}

	private Boolean isIn(String left, String rightText) {
		List<String> values = new ArrayList<>();
		char[] chars = rightText.toCharArray();
		Character quote = null;
		StringBuilder value = new StringBuilder();
		for (char ec : chars) {
			if (quote != null && quote.charValue() == ec) {
				quote = null;
			} if (ec == '"') {
				if (quote == null) {
					quote = Character.valueOf(ec);
				} else {
					value.append(ec);
				}
			} else if (ec == '\'') {
				if (quote == null) {
					quote = Character.valueOf(ec);
				} else {
					value.append(ec);
				}
			} else if (Character.isWhitespace(ec)) {
				if (quote != null)
					value.append(ec);
			} else if (ec == ',') {
				if (value.length() > 0)
					values.add(value.toString());
				value = new StringBuilder();
			} else {
				value.append(ec);
			}
		}
		if (value.length() > 0)
			values.add(value.toString());
		for(String s : values) {
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

	private static final Pattern jdbcTimestampPattern = Pattern.compile(".*[-].*[-].*[:].*[:].*");
	
	@SuppressWarnings("rawtypes")
	private Comparable asComparable(SimpleBooleanParser.ExpressionContext ctx) {
		Object value = visit(ctx);
		if (value instanceof String) {
			String s = (String) value;
			if (Util.isEmpty(s, true))
				return null;
			 
		    Matcher matcher = jdbcTimestampPattern.matcher(s);
			if (matcher.matches()) {
				try {
					return Timestamp.valueOf(s);
				} catch (Exception e) {}
			}
			try {
				return new BigDecimal(s);
			} catch (Exception e) {}
		} else if (value instanceof BigDecimal) {
			return (BigDecimal)value;
		} else if (value instanceof Timestamp) {
			return (Timestamp)value;
		} 
		
		//fall back to comparable and string
		if (value instanceof Comparable)
			return (Comparable)value;
		else
			return value.toString();
	}
}