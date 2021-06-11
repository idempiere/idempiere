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
		RE=12, LPAREN=13, RPAREN=14, DECIMAL=15, VARIABLE=16, QTEXT=17, DQTEXT=18, 
		TEXT=19, WS=20;
	public static String[] channelNames = {
		"DEFAULT_TOKEN_CHANNEL", "HIDDEN"
	};

	public static String[] modeNames = {
		"DEFAULT_MODE"
	};

	private static String[] makeRuleNames() {
		return new String[] {
			"AND", "OR", "NOT", "TRUE", "FALSE", "GT", "GE", "LT", "LE", "EQ", "NE", 
			"RE", "LPAREN", "RPAREN", "DECIMAL", "VARIABLE", "QTEXT", "DQTEXT", "TEXT", 
			"WS"
		};
	}
	public static final String[] ruleNames = makeRuleNames();

	private static String[] makeLiteralNames() {
		return new String[] {
			null, "'&'", "'|'", "'$!'", "'true'", "'false'", "'>'", "'>='", "'<'", 
			"'<='", "'='", null, "'~'", "'('", "')'"
		};
	}
	private static final String[] _LITERAL_NAMES = makeLiteralNames();
	private static String[] makeSymbolicNames() {
		return new String[] {
			null, "AND", "OR", "NOT", "TRUE", "FALSE", "GT", "GE", "LT", "LE", "EQ", 
			"NE", "RE", "LPAREN", "RPAREN", "DECIMAL", "VARIABLE", "QTEXT", "DQTEXT", 
			"TEXT", "WS"
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
		"\3\u608b\ua72a\u8133\ub9ed\u417c\u3be7\u7786\u5964\2\26\u0088\b\1\4\2"+
		"\t\2\4\3\t\3\4\4\t\4\4\5\t\5\4\6\t\6\4\7\t\7\4\b\t\b\4\t\t\t\4\n\t\n\4"+
		"\13\t\13\4\f\t\f\4\r\t\r\4\16\t\16\4\17\t\17\4\20\t\20\4\21\t\21\4\22"+
		"\t\22\4\23\t\23\4\24\t\24\4\25\t\25\3\2\3\2\3\3\3\3\3\4\3\4\3\4\3\5\3"+
		"\5\3\5\3\5\3\5\3\6\3\6\3\6\3\6\3\6\3\6\3\7\3\7\3\b\3\b\3\b\3\t\3\t\3\n"+
		"\3\n\3\n\3\13\3\13\3\f\3\f\3\r\3\r\3\16\3\16\3\17\3\17\3\20\5\20S\n\20"+
		"\3\20\6\20V\n\20\r\20\16\20W\3\20\3\20\6\20\\\n\20\r\20\16\20]\5\20`\n"+
		"\20\3\21\3\21\7\21d\n\21\f\21\16\21g\13\21\3\21\3\21\3\22\3\22\7\22m\n"+
		"\22\f\22\16\22p\13\22\3\22\3\22\3\23\3\23\7\23v\n\23\f\23\16\23y\13\23"+
		"\3\23\3\23\3\24\6\24~\n\24\r\24\16\24\177\3\25\6\25\u0083\n\25\r\25\16"+
		"\25\u0084\3\25\3\25\5enw\2\26\3\3\5\4\7\5\t\6\13\7\r\b\17\t\21\n\23\13"+
		"\25\f\27\r\31\16\33\17\35\20\37\21!\22#\23%\24\'\25)\26\3\2\b\4\2##``"+
		"\3\2\62;\3\2))\3\2$$\7\2..\62;C\\aac|\5\2\13\f\16\17\"\"\2\u0090\2\3\3"+
		"\2\2\2\2\5\3\2\2\2\2\7\3\2\2\2\2\t\3\2\2\2\2\13\3\2\2\2\2\r\3\2\2\2\2"+
		"\17\3\2\2\2\2\21\3\2\2\2\2\23\3\2\2\2\2\25\3\2\2\2\2\27\3\2\2\2\2\31\3"+
		"\2\2\2\2\33\3\2\2\2\2\35\3\2\2\2\2\37\3\2\2\2\2!\3\2\2\2\2#\3\2\2\2\2"+
		"%\3\2\2\2\2\'\3\2\2\2\2)\3\2\2\2\3+\3\2\2\2\5-\3\2\2\2\7/\3\2\2\2\t\62"+
		"\3\2\2\2\13\67\3\2\2\2\r=\3\2\2\2\17?\3\2\2\2\21B\3\2\2\2\23D\3\2\2\2"+
		"\25G\3\2\2\2\27I\3\2\2\2\31K\3\2\2\2\33M\3\2\2\2\35O\3\2\2\2\37R\3\2\2"+
		"\2!a\3\2\2\2#j\3\2\2\2%s\3\2\2\2\'}\3\2\2\2)\u0082\3\2\2\2+,\7(\2\2,\4"+
		"\3\2\2\2-.\7~\2\2.\6\3\2\2\2/\60\7&\2\2\60\61\7#\2\2\61\b\3\2\2\2\62\63"+
		"\7v\2\2\63\64\7t\2\2\64\65\7w\2\2\65\66\7g\2\2\66\n\3\2\2\2\678\7h\2\2"+
		"89\7c\2\29:\7n\2\2:;\7u\2\2;<\7g\2\2<\f\3\2\2\2=>\7@\2\2>\16\3\2\2\2?"+
		"@\7@\2\2@A\7?\2\2A\20\3\2\2\2BC\7>\2\2C\22\3\2\2\2DE\7>\2\2EF\7?\2\2F"+
		"\24\3\2\2\2GH\7?\2\2H\26\3\2\2\2IJ\t\2\2\2J\30\3\2\2\2KL\7\u0080\2\2L"+
		"\32\3\2\2\2MN\7*\2\2N\34\3\2\2\2OP\7+\2\2P\36\3\2\2\2QS\7/\2\2RQ\3\2\2"+
		"\2RS\3\2\2\2SU\3\2\2\2TV\t\3\2\2UT\3\2\2\2VW\3\2\2\2WU\3\2\2\2WX\3\2\2"+
		"\2X_\3\2\2\2Y[\7\60\2\2Z\\\t\3\2\2[Z\3\2\2\2\\]\3\2\2\2][\3\2\2\2]^\3"+
		"\2\2\2^`\3\2\2\2_Y\3\2\2\2_`\3\2\2\2` \3\2\2\2ae\7B\2\2bd\13\2\2\2cb\3"+
		"\2\2\2dg\3\2\2\2ef\3\2\2\2ec\3\2\2\2fh\3\2\2\2ge\3\2\2\2hi\7B\2\2i\"\3"+
		"\2\2\2jn\t\4\2\2km\13\2\2\2lk\3\2\2\2mp\3\2\2\2no\3\2\2\2nl\3\2\2\2oq"+
		"\3\2\2\2pn\3\2\2\2qr\t\4\2\2r$\3\2\2\2sw\t\5\2\2tv\13\2\2\2ut\3\2\2\2"+
		"vy\3\2\2\2wx\3\2\2\2wu\3\2\2\2xz\3\2\2\2yw\3\2\2\2z{\t\5\2\2{&\3\2\2\2"+
		"|~\t\6\2\2}|\3\2\2\2~\177\3\2\2\2\177}\3\2\2\2\177\u0080\3\2\2\2\u0080"+
		"(\3\2\2\2\u0081\u0083\t\7\2\2\u0082\u0081\3\2\2\2\u0083\u0084\3\2\2\2"+
		"\u0084\u0082\3\2\2\2\u0084\u0085\3\2\2\2\u0085\u0086\3\2\2\2\u0086\u0087"+
		"\b\25\2\2\u0087*\3\2\2\2\f\2RW]_enw\177\u0084\3\b\2\2";
	public static final ATN _ATN =
		new ATNDeserializer().deserialize(_serializedATN.toCharArray());
	static {
		_decisionToDFA = new DFA[_ATN.getNumberOfDecisions()];
		for (int i = 0; i < _ATN.getNumberOfDecisions(); i++) {
			_decisionToDFA[i] = new DFA(_ATN.getDecisionState(i), i);
		}
	}
}