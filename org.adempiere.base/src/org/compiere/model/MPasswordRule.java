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
import java.io.InputStream;
import java.sql.ResultSet;
import java.util.ArrayList;
import java.util.Properties;

import org.adempiere.exceptions.AdempiereException;
import org.compiere.util.Env;
import org.compiere.util.Msg;

import edu.vt.middleware.dictionary.ArrayWordList;
import edu.vt.middleware.dictionary.WordListDictionary;
import edu.vt.middleware.dictionary.WordLists;
import edu.vt.middleware.dictionary.sort.ArraysSort;
import edu.vt.middleware.password.AlphabeticalCharacterRule;
import edu.vt.middleware.password.AlphabeticalSequenceRule;
import edu.vt.middleware.password.CharacterCharacteristicsRule;
import edu.vt.middleware.password.DictionarySubstringRule;
import edu.vt.middleware.password.DigitCharacterRule;
import edu.vt.middleware.password.LengthRule;
import edu.vt.middleware.password.LowercaseCharacterRule;
import edu.vt.middleware.password.MessageResolver;
import edu.vt.middleware.password.NonAlphanumericCharacterRule;
import edu.vt.middleware.password.NumericalSequenceRule;
import edu.vt.middleware.password.Password;
import edu.vt.middleware.password.PasswordData;
import edu.vt.middleware.password.PasswordGenerator;
import edu.vt.middleware.password.PasswordValidator;
import edu.vt.middleware.password.QwertySequenceRule;
import edu.vt.middleware.password.RepeatCharacterRegexRule;
import edu.vt.middleware.password.Rule;
import edu.vt.middleware.password.RuleResult;
import edu.vt.middleware.password.UppercaseCharacterRule;
import edu.vt.middleware.password.UsernameRule;
import edu.vt.middleware.password.WhitespaceRule;

/**
 * @author juliana
 *
 */
public class MPasswordRule extends X_AD_PasswordRule {
	/**
	 * 
	 */
	private static final long serialVersionUID = 7376091524332484101L;

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
	
	public static MPasswordRule getRules(Properties ctx, String trxName) {
		 MClient system = MClient.get(ctx, 0);
		 int pwdruleID = system.getAD_PasswordRule_ID();
		 MPasswordRule pass = null;
		 if (pwdruleID > 0)
			 pass = new MPasswordRule(ctx, pwdruleID, trxName);

		return pass;
	}

	public void validate(String username, String newPassword) throws AdempiereException {

		ArrayList<Rule> ruleList =  new ArrayList<Rule>();

		if (getMinLength() > 0 || getMaxLength() > 0) {
			LengthRule lengthRule = new LengthRule();
			if (getMinLength() > 0)
				lengthRule.setMinimumLength(getMinLength());
			if (getMaxLength() > 0)
				lengthRule.setMaximumLength(getMaxLength());
			ruleList.add(lengthRule);
		}

		if (isWhitespace()) {
			ruleList.add(new WhitespaceRule());
		}

		// control allowed characters
		CharacterCharacteristicsRule charRule = new CharacterCharacteristicsRule();
		int numValidations = 0;
		if (getDigitCharacter() > 0) {
			// require at least n digit in passwords
			numValidations++;
			charRule.getRules().add(new DigitCharacterRule(getDigitCharacter()));
		}
		if (getNonAlphaNumericCharacter() > 0) {
			// require at least n non-alphanumeric char
			numValidations++;
			charRule.getRules().add(new NonAlphanumericCharacterRule(getNonAlphaNumericCharacter()));
		}
		if (getUppercaseCharacter() > 0) {
			numValidations++;
			charRule.getRules().add(new UppercaseCharacterRule(getUppercaseCharacter()));	
		}
		if (getLowercaseCharacter() > 0) {
			numValidations++;
			charRule.getRules().add(new LowercaseCharacterRule(getLowercaseCharacter()));
		}
		if (getAlphabeticalCharacter() > 0){
			numValidations++;
			charRule.getRules().add(new AlphabeticalCharacterRule(getAlphabeticalCharacter()));
		}
		if (! charRule.getRules().isEmpty()) {
			charRule.setNumberOfCharacteristics(numValidations);
			ruleList.add(charRule);
		}

		if (getAlphabeticalSequence() > 0) {
			ruleList.add(new AlphabeticalSequenceRule(getAlphabeticalSequence(), true));
		}

		if (getNumericalSequence() > 0) {
			ruleList.add(new NumericalSequenceRule(getNumericalSequence(), true));
		}
		if (getQWERTYSequence() > 0) {
			ruleList.add(new QwertySequenceRule(getQWERTYSequence(), true));
		}

		if (getRepeatCharacterRegex() > 0) {
			ruleList.add(new RepeatCharacterRegexRule(getRepeatCharacterRegex()));
		}

		if (isUserNameRule()) {
			ruleList.add(new UsernameRule(true, true));
		}

		if (isUsingDictionary()) {
			if (getPathDictionary().length() > 0) {
				try {
					ArrayWordList awl = WordLists.createFromReader(
							new FileReader[] {new FileReader(getPathDictionary())},
							true,
							new ArraysSort());

					WordListDictionary dict = new WordListDictionary(awl);
					DictionarySubstringRule dictRule = new DictionarySubstringRule(dict);

					if (getDictWordLength() > 0) {
						dictRule.setWordLength(getDictWordLength()); // size of words to check in the password						
					} else{
						dictRule.setWordLength(DictionarySubstringRule.DEFAULT_WORD_LENGTH);
					}

					if (isDictMatchBackwards()) {
						dictRule.setMatchBackwards(true); // match dictionary words backwards
					}
					ruleList.add(dictRule);

				} catch (FileNotFoundException e) {
					throw new AdempiereException("Could not find dictionary file: " + e.getMessage());
				} catch (IOException e) {
					throw new AdempiereException("Could not find dictionary file: " + e.getMessage());
				}

			}
		}

		if (!ruleList.isEmpty()) {
			PasswordValidator validator = new PasswordValidator(getCustomResolver(), ruleList);
			PasswordData passwordData = new PasswordData(new Password(newPassword));
			passwordData.setUsername(username);
			RuleResult result = validator.validate(passwordData);
			if (!result.isValid()) {
				String error = Msg.getMsg(getCtx(), "PasswordErrors") + ": [";
				for (String msg : validator.getMessages(result)) {
					error = error + " " + msg;
				}
				error = error + " ]";
				throw new AdempiereException(error);
			}
		}
	}

	private MessageResolver getCustomResolver() {
		Properties props = null;
		InputStream in = null;
		try {
			String file = "vtpassword_messages_" + Env.getLoginLanguage(getCtx()).getLocale().getLanguage() + ".properties";
			in = this.getClass().getResourceAsStream(file);
			if (in != null) {
				props = new Properties();
				props.load(in);
			}
		} catch (Exception e) {
			props = null;
		}
		if (props == null)
			return new MessageResolver();
		else
			return new MessageResolver(props);
	}

	public String generate() {
		CharacterCharacteristicsRule charRule = new CharacterCharacteristicsRule();
		int numValidations = 0;
		if (getDigitCharacter() > 0) {
			// require at least n digit in passwords
			numValidations++;
			charRule.getRules().add(new DigitCharacterRule(getDigitCharacter()));
		}
		if (getNonAlphaNumericCharacter() > 0) {
			// require at least n non-alphanumeric char
			numValidations++;
			charRule.getRules().add(new NonAlphanumericCharacterRule(getNonAlphaNumericCharacter()));
		}
		if (getUppercaseCharacter() > 0) {
			numValidations++;
			charRule.getRules().add(new UppercaseCharacterRule(getUppercaseCharacter()));	
		}
		if (getLowercaseCharacter() > 0) {
			numValidations++;
			charRule.getRules().add(new LowercaseCharacterRule(getLowercaseCharacter()));
		}
		if (getAlphabeticalCharacter() > 0){
			numValidations++;
			charRule.getRules().add(new AlphabeticalCharacterRule(getAlphabeticalCharacter()));
		}
		if (! charRule.getRules().isEmpty()) {
			charRule.setNumberOfCharacteristics(numValidations);
		}

		int len = 10; // suggested length to generate
		if (len < getMinLength()) {
			len = getMinLength();
		}
		if (len > getMaxLength()) {
			len = getMaxLength();
		}

		return new PasswordGenerator().generatePassword(len, charRule.getRules());
	}

}
