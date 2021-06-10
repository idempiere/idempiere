// Generated from SimpleBoolean.g4 by ANTLR 4.4

    package org.idempiere.expression.logic;

import org.antlr.v4.runtime.misc.NotNull;
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
	 * Visit a parse tree produced by the {@code boolExpression}
	 * labeled alternative in {@link SimpleBooleanParser#expression}.
	 * @param ctx the parse tree
	 * @return the visitor result
	 */
	T visitBoolExpression(@NotNull SimpleBooleanParser.BoolExpressionContext ctx);
	/**
	 * Visit a parse tree produced by {@link SimpleBooleanParser#bool}.
	 * @param ctx the parse tree
	 * @return the visitor result
	 */
	T visitBool(@NotNull SimpleBooleanParser.BoolContext ctx);
	/**
	 * Visit a parse tree produced by the {@code notExpression}
	 * labeled alternative in {@link SimpleBooleanParser#expression}.
	 * @param ctx the parse tree
	 * @return the visitor result
	 */
	T visitNotExpression(@NotNull SimpleBooleanParser.NotExpressionContext ctx);
	/**
	 * Visit a parse tree produced by {@link SimpleBooleanParser#parse}.
	 * @param ctx the parse tree
	 * @return the visitor result
	 */
	T visitParse(@NotNull SimpleBooleanParser.ParseContext ctx);
	/**
	 * Visit a parse tree produced by the {@code parenExpression}
	 * labeled alternative in {@link SimpleBooleanParser#expression}.
	 * @param ctx the parse tree
	 * @return the visitor result
	 */
	T visitParenExpression(@NotNull SimpleBooleanParser.ParenExpressionContext ctx);
	/**
	 * Visit a parse tree produced by the {@code doubleQuotedText}
	 * labeled alternative in {@link SimpleBooleanParser#expression}.
	 * @param ctx the parse tree
	 * @return the visitor result
	 */
	T visitDoubleQuotedText(@NotNull SimpleBooleanParser.DoubleQuotedTextContext ctx);
	/**
	 * Visit a parse tree produced by the {@code binaryExpression}
	 * labeled alternative in {@link SimpleBooleanParser#expression}.
	 * @param ctx the parse tree
	 * @return the visitor result
	 */
	T visitBinaryExpression(@NotNull SimpleBooleanParser.BinaryExpressionContext ctx);
	/**
	 * Visit a parse tree produced by {@link SimpleBooleanParser#comparator}.
	 * @param ctx the parse tree
	 * @return the visitor result
	 */
	T visitComparator(@NotNull SimpleBooleanParser.ComparatorContext ctx);
	/**
	 * Visit a parse tree produced by the {@code decimalExpression}
	 * labeled alternative in {@link SimpleBooleanParser#expression}.
	 * @param ctx the parse tree
	 * @return the visitor result
	 */
	T visitDecimalExpression(@NotNull SimpleBooleanParser.DecimalExpressionContext ctx);
	/**
	 * Visit a parse tree produced by {@link SimpleBooleanParser#binary}.
	 * @param ctx the parse tree
	 * @return the visitor result
	 */
	T visitBinary(@NotNull SimpleBooleanParser.BinaryContext ctx);
	/**
	 * Visit a parse tree produced by the {@code contextVariables}
	 * labeled alternative in {@link SimpleBooleanParser#expression}.
	 * @param ctx the parse tree
	 * @return the visitor result
	 */
	T visitContextVariables(@NotNull SimpleBooleanParser.ContextVariablesContext ctx);
	/**
	 * Visit a parse tree produced by the {@code text}
	 * labeled alternative in {@link SimpleBooleanParser#expression}.
	 * @param ctx the parse tree
	 * @return the visitor result
	 */
	T visitText(@NotNull SimpleBooleanParser.TextContext ctx);
	/**
	 * Visit a parse tree produced by the {@code quotedText}
	 * labeled alternative in {@link SimpleBooleanParser#expression}.
	 * @param ctx the parse tree
	 * @return the visitor result
	 */
	T visitQuotedText(@NotNull SimpleBooleanParser.QuotedTextContext ctx);
	/**
	 * Visit a parse tree produced by the {@code comparatorExpression}
	 * labeled alternative in {@link SimpleBooleanParser#expression}.
	 * @param ctx the parse tree
	 * @return the visitor result
	 */
	T visitComparatorExpression(@NotNull SimpleBooleanParser.ComparatorExpressionContext ctx);
}