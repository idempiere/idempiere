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
import java.util.List;
import java.util.Properties;

import org.adempiere.exceptions.AdempiereException;
import org.compiere.util.Env;
import org.compiere.util.Msg;
import org.compiere.util.Util;
import org.idempiere.util.HistoryRuleSupportHash;
import org.passay.CharacterCharacteristicsRule;
import org.passay.CharacterRule;
import org.passay.DictionarySubstringRule;
import org.passay.EnglishCharacterData;
import org.passay.EnglishSequenceData;
import org.passay.IllegalSequenceRule;
import org.passay.LengthRule;
import org.passay.MessageResolver;
import org.passay.PasswordData;
import org.passay.PasswordGenerator;
import org.passay.PasswordValidator;
import org.passay.PropertiesMessageResolver;
import org.passay.RepeatCharacterRegexRule;
import org.passay.Rule;
import org.passay.RuleResult;
import org.passay.RuleResultDetail;
import org.passay.UsernameRule;
import org.passay.WhitespaceRule;
import org.passay.dictionary.ArrayWordList;
import org.passay.dictionary.WordListDictionary;
import org.passay.dictionary.WordLists;
import org.passay.dictionary.sort.ArraysSort;


/**
 * @author juliana
 *
 */
public class MPasswordRule extends X_AD_PasswordRule {
	/**
	 * 
	 */
	private static final long serialVersionUID = 5454698615095632059L;

	private static final String passay_prefix = "PASSAY_";

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
	
	@Override
	protected boolean beforeSave (boolean newRecord)
	{
		if (isUsingDictionary()) {
			StringBuilder msg = new StringBuilder();
			if (Util.isEmpty(getPathDictionary())) {
				msg.append(Msg.getElement(getCtx(), COLUMNNAME_PathDictionary));
			}
			if (msg.length() > 0) {
				log.saveError("FillMandatory", msg.toString());
				return false;
			}
		}
		return true;
	}

	public void validate(String username, String newPassword, List<MPasswordHistory> passwordHistorys) throws AdempiereException {

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
			charRule.getRules().add(new CharacterRule(EnglishCharacterData.Digit, getDigitCharacter()));
		}
		if (getNonAlphaNumericCharacter() > 0) {
			// require at least n non-alphanumeric char
			numValidations++;
			charRule.getRules().add(new CharacterRule(EnglishCharacterData.Special, getNonAlphaNumericCharacter()));
		}
		if (getUppercaseCharacter() > 0) {
			numValidations++;
			charRule.getRules().add(new CharacterRule(EnglishCharacterData.UpperCase, getUppercaseCharacter()));	
		}
		if (getLowercaseCharacter() > 0) {
			numValidations++;
			charRule.getRules().add(new CharacterRule(EnglishCharacterData.LowerCase, getLowercaseCharacter()));
		}
		if (getAlphabeticalCharacter() > 0){
			numValidations++;
			charRule.getRules().add(new CharacterRule (EnglishCharacterData.Alphabetical, getAlphabeticalCharacter()));
		}
		if (! charRule.getRules().isEmpty()) {
			charRule.setNumberOfCharacteristics(numValidations);
			ruleList.add(charRule);
		}

		if (getAlphabeticalSequence() > 0) {
			ruleList.add(new IllegalSequenceRule (EnglishSequenceData.Alphabetical, getAlphabeticalSequence(), true));
		}

		if (getNumericalSequence() > 0) {
			ruleList.add(new IllegalSequenceRule(EnglishSequenceData.Numerical, getNumericalSequence(), true));
		}
		if (getQWERTYSequence() > 0) {
			ruleList.add(new IllegalSequenceRule(EnglishSequenceData.USQwerty, getQWERTYSequence(), true));
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

		// history password check
		List<PasswordData.Reference> historyData = new ArrayList<PasswordData.Reference>();
		for (MPasswordHistory passwordHistory : passwordHistorys){
			historyData.add(new PasswordData.HistoricalReference(passwordHistory.getSalt(), passwordHistory.getPassword()));
		}
		HistoryRuleSupportHash historyRule = new HistoryRuleSupportHash();
		ruleList.add(historyRule);
		
		// validator all rule
		if (!ruleList.isEmpty()) {
			PasswordValidator validator = new PasswordValidator(getCustomResolver(), ruleList);
			PasswordData passwordData = new PasswordData(username, newPassword); 
			passwordData.setPasswordReferences(historyData);
			RuleResult result = validator.validate(passwordData);
			if (!result.isValid()) {
				StringBuilder error = new StringBuilder(Msg.getMsg(getCtx(), "PasswordErrors"));
				error.append(": [");
				for(RuleResultDetail detail : result.getDetails()){
					error.append(" ").append(resolveMessage(detail));
				}
				error.append(" ]");
				throw new AdempiereException(error.toString());
			}
		}
	}

	/**
	 * Resolve & translate validation message returned by Passay
	 * @param detail
	 * @return error message
	 */
	private String resolveMessage(final RuleResultDetail detail)
	{
		final String key = passay_prefix + detail.getErrorCode();
		final String message = Msg.translate(Env.getAD_Language(getCtx()), key);

		String format;
		if (!message.equals(key)) {
			format = String.format(message, detail.getValues());
		} else {
			if (!detail.getParameters().isEmpty()) {
				format = String.format("%s:%s", key, detail.getParameters());
			} else {
				format = String.format("%s", key);
			}
		}
		return format;
	}

	private MessageResolver getCustomResolver() {
		Properties props = null;
		InputStream in = null;
		try {
			StringBuilder file = new StringBuilder("vtpassword_messages_").append(Env.getLoginLanguage(getCtx()).getLocale().getLanguage())
					.append(".properties");
			in = this.getClass().getResourceAsStream(file.toString());
			if (in != null) {
				props = new Properties();
				props.load(in);
			}
		} catch (Exception e) {
			props = null;
		}
		finally{
			if (in != null) {
				try {
					in.close();
				} catch (Exception e2) {}
				in = null;
			}
		}
		if (props == null)
			return new PropertiesMessageResolver();
		else
			return new PropertiesMessageResolver(props);
	}

	public String generate() {
		CharacterCharacteristicsRule charRule = new CharacterCharacteristicsRule();
		int numValidations = 0;
		if (getDigitCharacter() > 0) {
			// require at least n digit in passwords
			numValidations++;
			charRule.getRules().add(new CharacterRule(EnglishCharacterData.Digit, getDigitCharacter()));
		}
		if (getNonAlphaNumericCharacter() > 0) {
			// require at least n non-alphanumeric char
			numValidations++;
			charRule.getRules().add(new CharacterRule(EnglishCharacterData.Special, getNonAlphaNumericCharacter()));
		}
		if (getUppercaseCharacter() > 0) {
			numValidations++;
			charRule.getRules().add(new CharacterRule(EnglishCharacterData.UpperCase, getUppercaseCharacter()));	
		}
		if (getLowercaseCharacter() > 0) {
			numValidations++;
			charRule.getRules().add(new CharacterRule(EnglishCharacterData.LowerCase, getLowercaseCharacter()));
		}
		if (getAlphabeticalCharacter() > 0){
			numValidations++;
			charRule.getRules().add(new CharacterRule(EnglishCharacterData.Alphabetical, getAlphabeticalCharacter()));
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
