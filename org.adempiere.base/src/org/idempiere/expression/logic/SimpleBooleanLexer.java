// Generated from SimpleBoolean.g4 by ANTLR 4.9.2

    package org.idempiere.expression.logic;

import org.antlr.v4.runtime.Lexer;
import org.antlr.v4.runtime.CharStream;
import org.antlr.v4.runtime.Token;
import org.antlr.v4.runtime.TokenStream;
import org.antlr.v4.runtime.*;
import org.antlr.v4.runtime.atn.*;
import org.antlr.v4.runtime.dfa.DFA;
import org.antlr.v4.runtime.misc.*;

@SuppressWarnings({"all", "warnings", "unchecked", "unused", "cast"})
public class SimpleBooleanLexer extends Lexer {
	static { RuntimeMetaData.checkVersion("4.9.2", RuntimeMetaData.VERSION); }

	protected static final DFA[] _decisionToDFA;
	protected static final PredictionContextCache _sharedContextCache =
		new PredictionContextCache();
	public static final int
		AND=1, OR=2, NOT=3, TRUE=4, FALSE=5, GT=6, GE=7, LT=8, LE=9, EQ=10, NE=11, 
		RE=12, LPAREN=13, RPAREN=14, DECIMAL=15, VARIABLE=16, COMMA=17, QCOMMA=18, 
		QTEXT=19, QCSVTEXT=20, DQCOMMA=21, DQTEXT=22, DQCSVTEXT=23, TEXT=24, WS=25;
	public static String[] channelNames = {
		"DEFAULT_TOKEN_CHANNEL", "HIDDEN"
	};

	public static String[] modeNames = {
		"DEFAULT_MODE"
	};

	private static String[] makeRuleNames() {
		return new String[] {
			"AND", "OR", "NOT", "TRUE", "FALSE", "GT", "GE", "LT", "LE", "EQ", "NE", 
			"RE", "LPAREN", "RPAREN", "DECIMAL", "VARIABLE", "COMMA", "QCOMMA", "QTEXT", 
			"QCSVTEXT", "DQCOMMA", "DQTEXT", "DQCSVTEXT", "TEXT", "WS"
		};
	}
	public static final String[] ruleNames = makeRuleNames();

	private static String[] makeLiteralNames() {
		return new String[] {
			null, "'&'", "'|'", "'$!'", "'true'", "'false'", "'>'", "'>='", "'<'", 
			"'<='", "'='", null, "'~'", "'('", "')'", null, null, "','", "'','", 
			null, null, "'\",'"
		};
	}
	private static final String[] _LITERAL_NAMES = makeLiteralNames();
	private static String[] makeSymbolicNames() {
		return new String[] {
			null, "AND", "OR", "NOT", "TRUE", "FALSE", "GT", "GE", "LT", "LE", "EQ", 
			"NE", "RE", "LPAREN", "RPAREN", "DECIMAL", "VARIABLE", "COMMA", "QCOMMA", 
			"QTEXT", "QCSVTEXT", "DQCOMMA", "DQTEXT", "DQCSVTEXT", "TEXT", "WS"
		};
	}
	private static final String[] _SYMBOLIC_NAMES = makeSymbolicNames();
	public static final Vocabulary VOCABULARY = new VocabularyImpl(_LITERAL_NAMES, _SYMBOLIC_NAMES);

	/**
	 * @deprecated Use {@link #VOCABULARY} instead.
	 */
	@Deprecated
	public static final String[] tokenNames;
	static {
		tokenNames = new String[_SYMBOLIC_NAMES.length];
		for (int i = 0; i < tokenNames.length; i++) {
			tokenNames[i] = VOCABULARY.getLiteralName(i);
			if (tokenNames[i] == null) {
				tokenNames[i] = VOCABULARY.getSymbolicName(i);
			}

			if (tokenNames[i] == null) {
				tokenNames[i] = "<INVALID>";
			}
		}
	}

	@Override
	@Deprecated
	public String[] getTokenNames() {
		return tokenNames;
	}

	@Override

	public Vocabulary getVocabulary() {
		return VOCABULARY;
	}


	public SimpleBooleanLexer(CharStream input) {
		super(input);
		_interp = new LexerATNSimulator(this,_ATN,_decisionToDFA,_sharedContextCache);
	}

	@Override
	public String getGrammarFileName() { return "SimpleBoolean.g4"; }

	@Override
	public String[] getRuleNames() { return ruleNames; }

	@Override
	public String getSerializedATN() { return _serializedATN; }

	@Override
	public String[] getChannelNames() { return channelNames; }

	@Override
	public String[] getModeNames() { return modeNames; }

	@Override
	public ATN getATN() { return _ATN; }

	public static final String _serializedATN =
		"\3\u608b\ua72a\u8133\ub9ed\u417c\u3be7\u7786\u5964\2\33\u00bc\b\1\4\2"+
		"\t\2\4\3\t\3\4\4\t\4\4\5\t\5\4\6\t\6\4\7\t\7\4\b\t\b\4\t\t\t\4\n\t\n\4"+
		"\13\t\13\4\f\t\f\4\r\t\r\4\16\t\16\4\17\t\17\4\20\t\20\4\21\t\21\4\22"+
		"\t\22\4\23\t\23\4\24\t\24\4\25\t\25\4\26\t\26\4\27\t\27\4\30\t\30\4\31"+
		"\t\31\4\32\t\32\3\2\3\2\3\3\3\3\3\4\3\4\3\4\3\5\3\5\3\5\3\5\3\5\3\6\3"+
		"\6\3\6\3\6\3\6\3\6\3\7\3\7\3\b\3\b\3\b\3\t\3\t\3\n\3\n\3\n\3\13\3\13\3"+
		"\f\3\f\3\r\3\r\3\16\3\16\3\17\3\17\3\20\5\20]\n\20\3\20\6\20`\n\20\r\20"+
		"\16\20a\3\20\3\20\6\20f\n\20\r\20\16\20g\5\20j\n\20\3\21\3\21\7\21n\n"+
		"\21\f\21\16\21q\13\21\3\21\3\21\3\22\3\22\3\23\3\23\3\23\3\24\3\24\7\24"+
		"|\n\24\f\24\16\24\177\13\24\3\24\3\24\3\25\3\25\7\25\u0085\n\25\f\25\16"+
		"\25\u0088\13\25\3\25\3\25\3\25\3\25\3\25\7\25\u008f\n\25\f\25\16\25\u0092"+
		"\13\25\3\26\3\26\3\26\3\27\3\27\7\27\u0099\n\27\f\27\16\27\u009c\13\27"+
		"\3\27\3\27\3\30\3\30\7\30\u00a2\n\30\f\30\16\30\u00a5\13\30\3\30\3\30"+
		"\3\30\3\30\3\30\7\30\u00ac\n\30\f\30\16\30\u00af\13\30\3\31\6\31\u00b2"+
		"\n\31\r\31\16\31\u00b3\3\32\6\32\u00b7\n\32\r\32\16\32\u00b8\3\32\3\32"+
		"\5o}\u009a\2\33\3\3\5\4\7\5\t\6\13\7\r\b\17\t\21\n\23\13\25\f\27\r\31"+
		"\16\33\17\35\20\37\21!\22#\23%\24\'\25)\26+\27-\30/\31\61\32\63\33\3\2"+
		"\b\4\2##``\3\2\62;\3\2))\3\2$$\7\2..\62;C\\aac|\5\2\13\f\16\17\"\"\2\u00c8"+
		"\2\3\3\2\2\2\2\5\3\2\2\2\2\7\3\2\2\2\2\t\3\2\2\2\2\13\3\2\2\2\2\r\3\2"+
		"\2\2\2\17\3\2\2\2\2\21\3\2\2\2\2\23\3\2\2\2\2\25\3\2\2\2\2\27\3\2\2\2"+
		"\2\31\3\2\2\2\2\33\3\2\2\2\2\35\3\2\2\2\2\37\3\2\2\2\2!\3\2\2\2\2#\3\2"+
		"\2\2\2%\3\2\2\2\2\'\3\2\2\2\2)\3\2\2\2\2+\3\2\2\2\2-\3\2\2\2\2/\3\2\2"+
		"\2\2\61\3\2\2\2\2\63\3\2\2\2\3\65\3\2\2\2\5\67\3\2\2\2\79\3\2\2\2\t<\3"+
		"\2\2\2\13A\3\2\2\2\rG\3\2\2\2\17I\3\2\2\2\21L\3\2\2\2\23N\3\2\2\2\25Q"+
		"\3\2\2\2\27S\3\2\2\2\31U\3\2\2\2\33W\3\2\2\2\35Y\3\2\2\2\37\\\3\2\2\2"+
		"!k\3\2\2\2#t\3\2\2\2%v\3\2\2\2\'y\3\2\2\2)\u0082\3\2\2\2+\u0093\3\2\2"+
		"\2-\u0096\3\2\2\2/\u009f\3\2\2\2\61\u00b1\3\2\2\2\63\u00b6\3\2\2\2\65"+
		"\66\7(\2\2\66\4\3\2\2\2\678\7~\2\28\6\3\2\2\29:\7&\2\2:;\7#\2\2;\b\3\2"+
		"\2\2<=\7v\2\2=>\7t\2\2>?\7w\2\2?@\7g\2\2@\n\3\2\2\2AB\7h\2\2BC\7c\2\2"+
		"CD\7n\2\2DE\7u\2\2EF\7g\2\2F\f\3\2\2\2GH\7@\2\2H\16\3\2\2\2IJ\7@\2\2J"+
		"K\7?\2\2K\20\3\2\2\2LM\7>\2\2M\22\3\2\2\2NO\7>\2\2OP\7?\2\2P\24\3\2\2"+
		"\2QR\7?\2\2R\26\3\2\2\2ST\t\2\2\2T\30\3\2\2\2UV\7\u0080\2\2V\32\3\2\2"+
		"\2WX\7*\2\2X\34\3\2\2\2YZ\7+\2\2Z\36\3\2\2\2[]\7/\2\2\\[\3\2\2\2\\]\3"+
		"\2\2\2]_\3\2\2\2^`\t\3\2\2_^\3\2\2\2`a\3\2\2\2a_\3\2\2\2ab\3\2\2\2bi\3"+
		"\2\2\2ce\7\60\2\2df\t\3\2\2ed\3\2\2\2fg\3\2\2\2ge\3\2\2\2gh\3\2\2\2hj"+
		"\3\2\2\2ic\3\2\2\2ij\3\2\2\2j \3\2\2\2ko\7B\2\2ln\13\2\2\2ml\3\2\2\2n"+
		"q\3\2\2\2op\3\2\2\2om\3\2\2\2pr\3\2\2\2qo\3\2\2\2rs\7B\2\2s\"\3\2\2\2"+
		"tu\7.\2\2u$\3\2\2\2vw\7)\2\2wx\7.\2\2x&\3\2\2\2y}\t\4\2\2z|\13\2\2\2{"+
		"z\3\2\2\2|\177\3\2\2\2}~\3\2\2\2}{\3\2\2\2~\u0080\3\2\2\2\177}\3\2\2\2"+
		"\u0080\u0081\t\4\2\2\u0081(\3\2\2\2\u0082\u0086\t\4\2\2\u0083\u0085\n"+
		"\4\2\2\u0084\u0083\3\2\2\2\u0085\u0088\3\2\2\2\u0086\u0084\3\2\2\2\u0086"+
		"\u0087\3\2\2\2\u0087\u0089\3\2\2\2\u0088\u0086\3\2\2\2\u0089\u008a\5%"+
		"\23\2\u008a\u0090\5\'\24\2\u008b\u008c\5#\22\2\u008c\u008d\5\'\24\2\u008d"+
		"\u008f\3\2\2\2\u008e\u008b\3\2\2\2\u008f\u0092\3\2\2\2\u0090\u008e\3\2"+
		"\2\2\u0090\u0091\3\2\2\2\u0091*\3\2\2\2\u0092\u0090\3\2\2\2\u0093\u0094"+
		"\7$\2\2\u0094\u0095\7.\2\2\u0095,\3\2\2\2\u0096\u009a\t\5\2\2\u0097\u0099"+
		"\13\2\2\2\u0098\u0097\3\2\2\2\u0099\u009c\3\2\2\2\u009a\u009b\3\2\2\2"+
		"\u009a\u0098\3\2\2\2\u009b\u009d\3\2\2\2\u009c\u009a\3\2\2\2\u009d\u009e"+
		"\t\5\2\2\u009e.\3\2\2\2\u009f\u00a3\t\5\2\2\u00a0\u00a2\n\5\2\2\u00a1"+
		"\u00a0\3\2\2\2\u00a2\u00a5\3\2\2\2\u00a3\u00a1\3\2\2\2\u00a3\u00a4\3\2"+
		"\2\2\u00a4\u00a6\3\2\2\2\u00a5\u00a3\3\2\2\2\u00a6\u00a7\5+\26\2\u00a7"+
		"\u00ad\5-\27\2\u00a8\u00a9\5#\22\2\u00a9\u00aa\5-\27\2\u00aa\u00ac\3\2"+
		"\2\2\u00ab\u00a8\3\2\2\2\u00ac\u00af\3\2\2\2\u00ad\u00ab\3\2\2\2\u00ad"+
		"\u00ae\3\2\2\2\u00ae\60\3\2\2\2\u00af\u00ad\3\2\2\2\u00b0\u00b2\t\6\2"+
		"\2\u00b1\u00b0\3\2\2\2\u00b2\u00b3\3\2\2\2\u00b3\u00b1\3\2\2\2\u00b3\u00b4"+
		"\3\2\2\2\u00b4\62\3\2\2\2\u00b5\u00b7\t\7\2\2\u00b6\u00b5\3\2\2\2\u00b7"+
		"\u00b8\3\2\2\2\u00b8\u00b6\3\2\2\2\u00b8\u00b9\3\2\2\2\u00b9\u00ba\3\2"+
		"\2\2\u00ba\u00bb\b\32\2\2\u00bb\64\3\2\2\2\20\2\\agio}\u0086\u0090\u009a"+
		"\u00a3\u00ad\u00b3\u00b8\3\b\2\2";
	public static final ATN _ATN =
		new ATNDeserializer().deserialize(_serializedATN.toCharArray());
	static {
		_decisionToDFA = new DFA[_ATN.getNumberOfDecisions()];
		for (int i = 0; i < _ATN.getNumberOfDecisions(); i++) {
			_decisionToDFA[i] = new DFA(_ATN.getDecisionState(i), i);
		}
	}
}