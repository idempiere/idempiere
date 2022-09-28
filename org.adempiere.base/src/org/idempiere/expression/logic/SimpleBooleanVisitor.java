// Generated from SimpleBoolean.g4 by ANTLR 4.9.2

    package org.idempiere.expression.logic;

import org.antlr.v4.runtime.tree.ParseTreeVisitor;

/**
 * This interface defines a complete generic visitor for a parse tree produced
 * by {@link SimpleBooleanParser}.
 *
 * @param <T> The return type of the visit operation. Use {@link Void} for
 * operations with no return type.
 */
public interface SimpleBooleanVisitor<T> extends ParseTreeVisitor<T> {
	/**
	 * Visit a parse tree produced by {@link SimpleBooleanParser#parse}.
	 * @param ctx the parse tree
	 * @return the visitor result
	 */
	T visitParse(SimpleBooleanParser.ParseContext ctx);
	/**
	 * Visit a parse tree produced by the {@code binaryExpression}
	 * labeled alternative in {@link SimpleBooleanParser#expression}.
	 * @param ctx the parse tree
	 * @return the visitor result
	 */
	T visitBinaryExpression(SimpleBooleanParser.BinaryExpressionContext ctx);
	/**
	 * Visit a parse tree produced by the {@code decimalExpression}
	 * labeled alternative in {@link SimpleBooleanParser#expression}.
	 * @param ctx the parse tree
	 * @return the visitor result
	 */
	T visitDecimalExpression(SimpleBooleanParser.DecimalExpressionContext ctx);
	/**
	 * Visit a parse tree produced by the {@code boolExpression}
	 * labeled alternative in {@link SimpleBooleanParser#expression}.
	 * @param ctx the parse tree
	 * @return the visitor result
	 */
	T visitBoolExpression(SimpleBooleanParser.BoolExpressionContext ctx);
	/**
	 * Visit a parse tree produced by the {@code doubleQuotedCSVText}
	 * labeled alternative in {@link SimpleBooleanParser#expression}.
	 * @param ctx the parse tree
	 * @return the visitor result
	 */
	T visitDoubleQuotedCSVText(SimpleBooleanParser.DoubleQuotedCSVTextContext ctx);
	/**
	 * Visit a parse tree produced by the {@code contextVariables}
	 * labeled alternative in {@link SimpleBooleanParser#expression}.
	 * @param ctx the parse tree
	 * @return the visitor result
	 */
	T visitContextVariables(SimpleBooleanParser.ContextVariablesContext ctx);
	/**
	 * Visit a parse tree produced by the {@code quotedCSVText}
	 * labeled alternative in {@link SimpleBooleanParser#expression}.
	 * @param ctx the parse tree
	 * @return the visitor result
	 */
	T visitQuotedCSVText(SimpleBooleanParser.QuotedCSVTextContext ctx);
	/**
	 * Visit a parse tree produced by the {@code notExpression}
	 * labeled alternative in {@link SimpleBooleanParser#expression}.
	 * @param ctx the parse tree
	 * @return the visitor result
	 */
	T visitNotExpression(SimpleBooleanParser.NotExpressionContext ctx);
	/**
	 * Visit a parse tree produced by the {@code parenExpression}
	 * labeled alternative in {@link SimpleBooleanParser#expression}.
	 * @param ctx the parse tree
	 * @return the visitor result
	 */
	T visitParenExpression(SimpleBooleanParser.ParenExpressionContext ctx);
	/**
	 * Visit a parse tree produced by the {@code text}
	 * labeled alternative in {@link SimpleBooleanParser#expression}.
	 * @param ctx the parse tree
	 * @return the visitor result
	 */
	T visitText(SimpleBooleanParser.TextContext ctx);
	/**
	 * Visit a parse tree produced by the {@code quotedText}
	 * labeled alternative in {@link SimpleBooleanParser#expression}.
	 * @param ctx the parse tree
	 * @return the visitor result
	 */
	T visitQuotedText(SimpleBooleanParser.QuotedTextContext ctx);
	/**
	 * Visit a parse tree produced by the {@code doubleQuotedText}
	 * labeled alternative in {@link SimpleBooleanParser#expression}.
	 * @param ctx the parse tree
	 * @return the visitor result
	 */
	T visitDoubleQuotedText(SimpleBooleanParser.DoubleQuotedTextContext ctx);
	/**
	 * Visit a parse tree produced by the {@code comparatorExpression}
	 * labeled alternative in {@link SimpleBooleanParser#expression}.
	 * @param ctx the parse tree
	 * @return the visitor result
	 */
	T visitComparatorExpression(SimpleBooleanParser.ComparatorExpressionContext ctx);
	/**
	 * Visit a parse tree produced by {@link SimpleBooleanParser#comparator}.
	 * @param ctx the parse tree
	 * @return the visitor result
	 */
	T visitComparator(SimpleBooleanParser.ComparatorContext ctx);
	/**
	 * Visit a parse tree produced by {@link SimpleBooleanParser#binary}.
	 * @param ctx the parse tree
	 * @return the visitor result
	 */
	T visitBinary(SimpleBooleanParser.BinaryContext ctx);
	/**
	 * Visit a parse tree produced by {@link SimpleBooleanParser#bool}.
	 * @param ctx the parse tree
	 * @return the visitor result
	 */
	T visitBool(SimpleBooleanParser.BoolContext ctx);
}