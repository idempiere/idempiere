/******************************************************************************
 * Product: iDempiere ERP & CRM Smart Business Solution                       *
 * Copyright (C) Trek Global All Rights Reserved.                             *
 * This program is free software; you can redistribute it and/or modify it    *
 * under the terms version 2 of the GNU General Public License as published   *
 * by the Free Software Foundation. This program is distributed in the hope   *
 * that it will be useful, but WITHOUT ANY WARRANTY; without even the implied *
 * warranty of MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.           *
 * See the GNU General Public License for more details.                       *
 * You should have received a copy of the GNU General Public License along    *
 * with this program; if not, write to the Free Software Foundation, Inc.,    *
 * 59 Temple Place, Suite 330, Boston, MA 02111-1307 USA.                     *
 *                                                                            *
 * @author Juliana Corredor, jcorredor@trekglobal.com                        *
 * IDEMPIERE-221 Password reset validation                                    *
 *   http://jira.idempiere.com/browse/IDEMPIERE-221                           *
 *  			                                                              *
 *****************************************************************************/
package org.compiere.model;

import java.io.FileNotFoundException;
import java.io.FileReader;
import java.io.IOException;
import java.sql.ResultSet;
import java.util.ArrayList;
import java.util.Properties;

import edu.vt.middleware.dictionary.ArrayWordList;
import edu.vt.middleware.dictionary.WordListDictionary;
import edu.vt.middleware.dictionary.WordLists;
import edu.vt.middleware.dictionary.sort.ArraysSort;
import edu.vt.middleware.password.AlphabeticalSequenceRule;
import edu.vt.middleware.password.CharacterCharacteristicsRule;
import edu.vt.middleware.password.DictionarySubstringRule;
import edu.vt.middleware.password.DigitCharacterRule;
import edu.vt.middleware.password.LengthRule;
import edu.vt.middleware.password.LowercaseCharacterRule;
import edu.vt.middleware.password.NonAlphanumericCharacterRule;
import edu.vt.middleware.password.NumericalSequenceRule;
import edu.vt.middleware.password.Password;
import edu.vt.middleware.password.PasswordData;
import edu.vt.middleware.password.PasswordValidator;
import edu.vt.middleware.password.QwertySequenceRule;
import edu.vt.middleware.password.RepeatCharacterRegexRule;
import edu.vt.middleware.password.Rule;
import edu.vt.middleware.password.RuleResult;
import edu.vt.middleware.password.UppercaseCharacterRule;
import edu.vt.middleware.password.WhitespaceRule;

/**
 * @author juliana
 *
 */
public class MPasswordRule extends X_AD_PasswordRule {
	/**
	 * 
	 */
	private static final long serialVersionUID = 6369065572886752718L;

	/**
	 * @param ctx
	 * @param AD_PasswordRule_ID
	 * @param trxName
	 */
	public MPasswordRule(Properties ctx, int AD_PasswordRule_ID, String trxName) {
		super(ctx, AD_PasswordRule_ID, trxName);
	}

	/**
	 * @param ctx
	 * @param rs
	 * @param trxName
	 */
	public MPasswordRule(Properties ctx, ResultSet rs, String trxName) {
		super(ctx, rs, trxName);
	}

	public String validate(String newPassword) {
		WhitespaceRule whitespaceRule;
		AlphabeticalSequenceRule alphaSeqRule;
		NumericalSequenceRule numSeqRule;
		QwertySequenceRule qwertySeqRule;
		RepeatCharacterRegexRule repeatRule;

		ArrayList<Rule> ruleList =  new ArrayList<Rule>();

		if (getMinLength()>0 || getMaxLength()>0) {
			LengthRule lengthRule = new LengthRule();
			if (getMinLength()>0)
				lengthRule.setMinimumLength(getMinLength());
			if (getMaxLength()>0)
				lengthRule.setMaximumLength(getMaxLength());
			ruleList.add(lengthRule);
		}  

		if (iswhitespace()) {
			whitespaceRule = new WhitespaceRule();	
			ruleList.add(whitespaceRule);
		}
		// control allowed characters
		CharacterCharacteristicsRule charRule = new CharacterCharacteristicsRule();

		if (getDigitCharacter()>0) {
			// require at least 1 digit in passwords
			charRule.getRules().add(new DigitCharacterRule(getDigitCharacter()));
		}
		if (getNonAlphaNumericCharacter()>0) {
			// require at least 1 non-alphanumeric char
			charRule.getRules().add(new NonAlphanumericCharacterRule(getNonAlphaNumericCharacter()));
		}
		if (getUppercaseCharacter()>0) {
			charRule.getRules().add(new UppercaseCharacterRule(getUppercaseCharacter()));	
		}

		if (getLowercaseCharacter()>0) {
			charRule.getRules().add(new LowercaseCharacterRule(getLowercaseCharacter()));
		}
		ruleList.add(charRule);

		if (isAlphabeticalSequence()) {
			alphaSeqRule=new AlphabeticalSequenceRule();
			ruleList.add(alphaSeqRule);
		}

		if (getNumericalSequence()>0) {
			numSeqRule = new NumericalSequenceRule(getNumericalSequence(),true);
			ruleList.add(numSeqRule);
		}
		if (isQWERTYSequence()) {
			qwertySeqRule = new QwertySequenceRule();
			ruleList.add(qwertySeqRule);
		}

		if (getRepeatCharacterRegex()>0) {
			repeatRule = new RepeatCharacterRegexRule(getRepeatCharacterRegex());
			ruleList.add(repeatRule);
		}

		if (isUsingDictionary()) {
			if (getPathDictionary().length()>0) {
				try {
					ArrayWordList awl = WordLists.createFromReader(
							new FileReader[] {new FileReader(getPathDictionary())},
							true,
							new ArraysSort());

					WordListDictionary dict = new WordListDictionary(awl);
					DictionarySubstringRule dictRule = new DictionarySubstringRule(dict);

					if (getDictWordLength()>0) {
						dictRule.setWordLength(getDictWordLength()); // size of words to check in the password						
					}
					else{
						dictRule.setWordLength(DictionarySubstringRule.DEFAULT_WORD_LENGTH);
					}

					if (isDictMatchBackwards()) {
						dictRule.setMatchBackwards(true); // match dictionary words backwards
					}
					ruleList.add(dictRule);

				} catch (FileNotFoundException e) {
					return "Could not find dictionary file: " + e.getMessage();
				} catch (IOException e) {
					return "Could not read dictionary file: " + e.getMessage();
				}

			}
		}

		if (!ruleList.isEmpty()) {
			PasswordValidator validator = new PasswordValidator(ruleList);
			PasswordData passwordData = new PasswordData(new Password(newPassword));
			RuleResult result = validator.validate(passwordData);
			if (!result.isValid()) {
				String error = null;
				for (String msg : validator.getMessages(result)) {
					error = (error == null ? "" : error) + " " + msg;
				}
				return error;
			}
		}
		return null;
	}

}
