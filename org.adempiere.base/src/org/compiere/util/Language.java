/******************************************************************************
 * Product: Adempiere ERP & CRM Smart Business Solution                       *
 * Copyright (C) 1999-2006 ComPiere, Inc. All Rights Reserved.                *
 * This program is free software; you can redistribute it and/or modify it    *
 * under the terms version 2 of the GNU General Public License as published   *
 * by the Free Software Foundation. This program is distributed in the hope   *
 * that it will be useful, but WITHOUT ANY WARRANTY; without even the implied *
 * warranty of MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.           *
 * See the GNU General Public License for more details.                       *
 * You should have received a copy of the GNU General Public License along    *
 * with this program; if not, write to the Free Software Foundation, Inc.,    *
 * 59 Temple Place, Suite 330, Boston, MA 02111-1307 USA.                     *
 * For the text or an alternative of this public license, you may reach us    *
 * ComPiere, Inc., 2620 Augustine Dr. #245, Santa Clara, CA 95054, USA        *
 * or via info@compiere.org or http://www.compiere.org/license.html           *
 *****************************************************************************/
package org.compiere.util;

import java.awt.ComponentOrientation;
import java.io.Serializable;
import java.text.DateFormat;
import java.text.DecimalFormatSymbols;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Arrays;
import java.util.Locale;
import java.util.logging.Level;
import java.util.logging.Logger;

import javax.print.attribute.standard.MediaSize;

import org.compiere.model.MLanguage;
import org.compiere.print.MPrintPaper;

/**
 *  Language Management.
 *
 *  @author     Jorg Janke
 *  @version    $Id: Language.java,v 1.2 2006/07/30 00:52:23 jjanke Exp $
 */
public class Language implements Serializable
{
	/**
	 * 
	 */
	private static final long serialVersionUID = 6705748825004207885L;

	/**
	 * 
	 */
	/**************************************************************************
	 *  Languages
	 *      http://www.ics.uci.edu/pub/ietf/http/related/iso639.txt
	 *  Countries
	 *      http://www.iso.org/iso/country_codes/iso_3166_code_lists/english_country_names_and_code_elements.htm
	 *************************************************************************/

	/** Base Language               */
	private static final String  AD_Language_en_US = "en_US";
	
	/***
	 *  System Languages.
	 *  If you want to add a language, extend the array
	 *  - or use the addLanguage() method.
	 **/
	static private Language[]   s_languages = new Language[] {
		new Language ("English",
				AD_Language_en_US,  Locale.US,      null, null,
				MediaSize.NA.LETTER)
	};

	/** Base Language            */
	private static Language     s_baseLanguage = s_languages[0];

	/**	Logger			*/
	private static Logger log = Logger.getLogger(Language.class.getName());
	
	/**
	 *  Get Number of Languages
	 *  @return Language count
	 */
	public static int getLanguageCount()
	{
		return s_languages.length;
	}   //  getLanguageCount

	/**
	 *  Get Language
	 *  @param index index
	 *  @return Language
	 */
	public static Language getLanguage (int index)
	{
		if (index < 0 || index >= s_languages.length)
			return s_baseLanguage;
		return s_languages[index];
	}   //  getLanguage

	/**
	 *  Add Language to supported Languages
	 *  @param language new language
	 *  @deprecated IDEMPIERE-489 Configure the language in the database
	 */
	public static void addLanguage (Language language)
	{
		if (language == null)
			return;
		ArrayList<Language> list = new ArrayList<Language>(Arrays.asList(s_languages));
		list.add(language);
		s_languages = new Language[list.size()];
		list.toArray(s_languages);
	}   //  addLanguage

	/**************************************************************************
	 *  Get Language.
	 * 	If language does not exist, create it on the fly assuming that it is valid
	 *  @param langInfo either language (en) or locale (en-US) or display name
	 *  @return Name (e.g. Deutsch)
	 */
	public static Language getLanguage (String langInfo)
	{
		int idxReplace = -1;
		String lang = langInfo;
		if (lang == null || lang.length() == 0)
			lang = System.getProperty("user.language", "");

		//	Search existing Languages
		for (int i = 0; i < s_languages.length; i++)
		{
			if 	(   lang.equals(s_languages[i].getName())
				 || lang.equals(s_languages[i].getLanguageCode())
				 || lang.equals(s_languages[i].getAD_Language())) {
				if (!s_languages[i].m_fromDB && DB.isConnected()) {
					// if language was not get from DB and now we're connected
					idxReplace = i;
					break;
				} else {
					return s_languages[i];
				}
			}
		}

		//	Create Language on the fly
		if (lang.length() == 5)		//	standard format <language>_<Country>
		{
			Language ll;
			String language = lang.substring(0,2);
			String country = lang.substring(3);
			Locale locale = new Locale(language, country);
			if (DB.isConnected()) {
				MLanguage dblang = MLanguage.get(Env.getCtx(), langInfo);
				Boolean decimalPoint = null;
				if (dblang.getIsDecimalPoint() != null)
					decimalPoint = "Y".equals(dblang.getIsDecimalPoint());
				if (!(   language.equals(dblang.getLanguageISO()) 
					  && country.equals(dblang.getCountryCode())
					 )
					) {
					locale = new Locale(dblang.getLanguageISO(), dblang.getCountryCode());
				}
				MediaSize mediaSize = MediaSize.ISO.A4;
				if (dblang.getAD_PrintPaper_ID() > 0) {
					MPrintPaper pp = MPrintPaper.get(dblang.getAD_PrintPaper_ID());
					mediaSize = pp.getMediaSize();
				}
				ll = new Language(dblang.getPrintName(), langInfo, locale, decimalPoint, dblang.getDatePattern(), mediaSize);
				ll.m_fromDB = true;
				if (dblang.isBaseLanguage()) {
					idxReplace = 0;
					s_baseLanguage = ll;
				}
			} else {
				ll = new Language (lang, lang, locale);
			}
			StringBuilder msglog = new StringBuilder("Adding Language=").append(language).append(", Country=").append(country).append(", Locale=").append(locale);			
			if (log.isLoggable(Level.INFO)) log.info (msglog.toString());
			if (idxReplace >= 0) {
				s_languages[idxReplace] = ll;
			} else {
				//	Add to Languages
				ArrayList<Language> list = new ArrayList<Language>(Arrays.asList(s_languages));
				list.add(ll);
				s_languages = new Language [list.size()];
				list.toArray(s_languages);
				//	Return Language
			}
			return ll;
		}
		//	Get the default one
		return s_baseLanguage;
	}   //  getLanguage

	/**
	 *  Is it the base language
	 *  @param langInfo either language (en) or locale (en-US) or display name
	 *  @return true if base language
	 */
	public static boolean isBaseLanguage (String langInfo)
	{
		if (langInfo == null || langInfo.length() == 0
			|| langInfo.equals(s_baseLanguage.getName())
			|| langInfo.equals(s_baseLanguage.getLanguageCode())
			|| langInfo.equals(s_baseLanguage.getAD_Language()))
			return true;
		return false;
	}   //  isBaseLanguage

	/**
	 *  Get Base Language
	 *  @return Base Language
	 */
	public static Language getBaseLanguage()
	{
		return s_baseLanguage;
	}   //  getBase

	/**
	 *  Get Base Language code. (e.g. en-US)
	 *  @return Base Language
	 */
	public static String getBaseAD_Language()
	{
		return s_baseLanguage.getAD_Language();
	}   //  getBase

	/**
	 *  Get Supported Locale
	 *  @param langInfo either language (en) or locale (en-US) or display name
	 *  @return Supported Locale
	 */
	public static Locale getLocale (String langInfo)
	{
		return getLanguage(langInfo).getLocale();
	}   //  getLocale

	/**
	 *  Get Supported Language
	 *  @param langInfo either language (en) or locale (en-US) or display name
	 *  @return AD_Language (e.g. en-US)
	 */
	public static String getAD_Language (String langInfo)
	{
		return getLanguage(langInfo).getAD_Language();
	}   //  getAD_Language

	/**
	 *  Get Supported Language
	 *  @param locale Locale
	 *  @return AD_Language (e.g. en-US)
	 */
	public static String getAD_Language (Locale locale)
	{
		if (locale != null)
		{
			for (int i = 0; i < s_languages.length; i++)
			{
				if (locale.getLanguage().equals(s_languages[i].getLocale().getLanguage()))
					return s_languages[i].getAD_Language();
			}
		}
		return s_baseLanguage.getAD_Language();
	}   //  getLocale

	/**
	 *  Get Language Name
	 *  @param langInfo either language (en) or locale (en-US) or display name
	 *  @return Language Name (e.g. English)
	 */
	public static String getName (String langInfo)
	{
		return getLanguage(langInfo).getName();
	}   //  getAD_Language

	/**
	 *  Returns true if Decimal Point (not comma)
	 *  @param langInfo either language (en) or locale (en-US) or display name
	 *  @return use of decimal point
	 */
	public static boolean isDecimalPoint(String langInfo)
	{
		return getLanguage(langInfo).isDecimalPoint();
	}   //  getAD_Language

	/**
	 *  Get Display names of supported languages
	 *  @return Array of Language names
	 */
	public static String[] getNames()
	{
		String[] retValue = new String[s_languages.length];
		for (int i = 0; i < s_languages.length; i++)
			retValue[i] = s_languages[i].getName();
		return retValue;
	}   //  getNames

	
	/**************************************************************************
	 *  Get Current Login Language
	 *  @return login language
	 */
	public static Language getLoginLanguage ()
	{
		return Env.getLanguage(Env.getCtx());
	}   //  getLanguage

	/**
	 *  Set Current Login Language
	 *  @param language language
	 */
	public static void setLoginLanguage (Language language)
	{
		if (language != null)
		{
			Env.setContext(Env.getCtx(), Env.LANGUAGE, language.getAD_Language());
			if (log.isLoggable(Level.CONFIG)) log.config(language.toString());
		}
	}   //  setLanguage

	
	/**************************************************************************
	 *  Define Language
	 *  @param name - displayed value, e.g. English
	 *  @param AD_Language - the code of system supported language, e.g. en_US
	 *  (might be different than Locale - i.e. if the system does not support the language)
	 *  @param locale - the Locale, e.g. Locale.US
	 *  @param decimalPoint true if Decimal Point - if null, derived from Locale
	 *  @param javaDatePattern Java date pattern as not all locales are defined - if null, derived from Locale
	 *  @param mediaSize default media size
	 */
	public Language (String name, String AD_Language, Locale locale,
		Boolean decimalPoint, String javaDatePattern, MediaSize mediaSize)
	{
		if (name == null || AD_Language == null || locale == null)
			throw new IllegalArgumentException ("Language - parameter is null");
		m_name = name;
		m_AD_Language = AD_Language;
		m_locale = locale;
		//
		m_decimalPoint = decimalPoint;
		setDateFormat (javaDatePattern);
		setMediaSize (mediaSize);
	}   //  Language

	/**
	 *  Define Language with A4 and default decimal point and date format
	 *  @param name - displayed value, e.g. English
	 *  @param AD_Language - the code of system supported language, e.g. en_US
	 *  (might be different than Locale - i.e. if the system does not support the language)
	 *  @param locale - the Locale, e.g. Locale.US
	 */
	public Language (String name, String AD_Language, Locale locale)
	{
		this (name, AD_Language, locale, null, null, null);
	}	//	Language


	/**	Name					*/
	private String  m_name;
	/**	Language (key)			*/
	private String  m_AD_Language;
	/** Locale					*/
	private Locale  m_locale;
	//
	private Boolean             m_decimalPoint;
	private Boolean				m_leftToRight;
	private SimpleDateFormat    m_dateFormat;
	private MediaSize 			m_mediaSize = MediaSize.ISO.A4;
	private boolean             m_fromDB = false;

	/**
	 *  Get Language Name.
	 *  e.g. English
	 *  @return name
	 */
	public String getName()
	{
		return m_name;
	}   //  getName

	/**
	 *  Get Application Dictionary Language (system supported).
	 *  e.g. en-US
	 *  @return AD_Language
	 */
	public String getAD_Language()
	{
		return m_AD_Language;
	}   //  getAD_Language

	/**
	 *  Set Application Dictionary Language (system supported).
	 *  @param AD_Language e.g. en-US
	 */
	public void setAD_Language (String AD_Language)
	{
		if (AD_Language != null)
		{
			m_AD_Language = AD_Language;
			if (log.isLoggable(Level.CONFIG)) log.config(toString());
		}
	}   //  getAD_Language

	/**
	 *  Get Locale
	 *  @return locale
	 */
	public Locale getLocale()
	{
		return m_locale;
	}   //  getLocale

	/**
	 *  Overwrite Locale
	 *  @param locale locale
	 */
	public void setLocale (Locale locale)
	{
		if (locale == null)
			return;
		m_locale = locale;
		m_decimalPoint = null;  //  reset
	}   //  getLocale

	/**
	 *  Get Language Code.
	 *  e.g. en - derived from Locale
	 *  @return language code
	 */
	public String getLanguageCode()
	{
		return m_locale.getLanguage();
	}   //  getLanguageCode

	/**
	 *  Component orientation is Left To Right
	 *  @return true if left-to-right
	 */
	public boolean isLeftToRight()
	{
		if (m_leftToRight == null)
			//  returns true if language not iw, ar, fa, ur
			m_leftToRight = new Boolean(ComponentOrientation.getOrientation(m_locale).isLeftToRight());
		return m_leftToRight.booleanValue();
	}   //  isLeftToRight

	/**
	 *  Returns true if Decimal Point (not comma)
	 *  @return use of decimal point
	 */
	public boolean isDecimalPoint()
	{
		if (m_decimalPoint == null)
		{
			DecimalFormatSymbols dfs = new DecimalFormatSymbols(m_locale);
			m_decimalPoint = new Boolean(dfs.getDecimalSeparator() == '.');
		}
		return m_decimalPoint.booleanValue();
	}   //  isDecimalPoint

	/**
	 * 	Is This the Base Language
	 * 	@return true if base Language
	 */
	public boolean isBaseLanguage()
	{
		return this.equals(getBaseLanguage());
	}	//	isBaseLanguage

	/**
	 *  Set Date Pattern.
	 *  The date format is not checked for correctness
	 *  @param javaDatePattern for details see java.text.SimpleDateFormat,
	 *  format must be able to be converted to database date format by
	 *  using the upper case function.
	 *  It also must have leading zero for day and month.
	 */
	public void setDateFormat (String javaDatePattern)
	{
		if (javaDatePattern == null)
			return;
		m_dateFormat = (SimpleDateFormat)DateFormat.getDateInstance
				(DateFormat.SHORT, m_locale);
		try
		{
			m_dateFormat.applyPattern(javaDatePattern);
		}
		catch (Exception e)
		{
			log.severe(javaDatePattern + " - " + e);
			m_dateFormat = null;
		}
	}   //  setDateFormat

	/**
	 *  Get (Short) Date Format.
	 *  The date format must parseable by org.compiere.grid.ed.MDocDate
	 *  i.e. leading zero for date and month
	 *  @return date format MM/dd/yyyy - dd.MM.yyyy
	 */
	public SimpleDateFormat getDateFormat()
	{
		if (m_dateFormat == null)
		{
			m_dateFormat = (SimpleDateFormat)DateFormat.getDateInstance
				(DateFormat.SHORT, m_locale);
			String sFormat = m_dateFormat.toPattern();
			//	some short formats have only one M and/or d (e.g. ths US)
			if (sFormat.indexOf("MM") == -1 || sFormat.indexOf("dd") == -1)
				{
				sFormat = sFormat.replaceFirst("d+", "dd");
				sFormat = sFormat.replaceFirst("M+", "MM");
			//	log.finer(sFormat + " => " + nFormat);
				m_dateFormat.applyPattern(sFormat);
			}
			//	Unknown short format => use JDBC
			if (m_dateFormat.toPattern().length() != 8)
				m_dateFormat.applyPattern("yyyy-MM-dd");

			//	4 digit year
			if (m_dateFormat.toPattern().indexOf("yyyy") == -1)
			{
				sFormat = m_dateFormat.toPattern();
				StringBuilder nFormat = new StringBuilder();
				for (int i = 0; i < sFormat.length(); i++)
				{
					if (sFormat.charAt(i) == 'y')
						nFormat.append("yy");
					else
						nFormat.append(sFormat.charAt(i));
				}
				m_dateFormat.applyPattern(nFormat.toString());
			}
			m_dateFormat.setLenient(true);
		}
		return m_dateFormat;
	}   //  getDateFormat

	/**
	 * 	Get Date Time Format.
	 * 	Used for Display only
	 *  @return Date Time format MMM d, yyyy h:mm:ss a z -or- dd.MM.yyyy HH:mm:ss z
	 *  -or- j nnn aaaa, H' ?????? 'm' ????'
	 */
	public SimpleDateFormat getDateTimeFormat()
	{
		SimpleDateFormat retValue = (SimpleDateFormat)DateFormat.getDateTimeInstance
			(DateFormat.MEDIUM, DateFormat.LONG, m_locale);
	//	if (log.isLoggable(Level.FINER)) log.finer("Pattern=" + retValue.toLocalizedPattern() + ", Loc=" + retValue.toLocalizedPattern());
		return retValue;
	}	//	getDateTimeFormat

	/**
	 * 	Get Time Format.
	 * 	Used for Display only
	 *  @return Time format h:mm:ss z or HH:mm:ss z
	 */
	public SimpleDateFormat getTimeFormat()
	{
		return (SimpleDateFormat)DateFormat.getTimeInstance
			(DateFormat.LONG, m_locale);
	}	//	getTimeFormat

	/**
	 *  Get Database Date Pattern.
	 *  Derive from date pattern (make upper case)
	 *  @return date pattern
	 */
	public String getDBdatePattern()
	{
		return getDateFormat().toPattern().toUpperCase(m_locale);
	}   //  getDBdatePattern

	/**
	 * 	Get default MediaSize
	 * 	@return media size
	 */
	public MediaSize getMediaSize()
	{
		return m_mediaSize;
	}	//	getMediaSize

	/**
	 * 	Set default MediaSize
	 * 	@param size media size
	 */
	public void setMediaSize (MediaSize size)
	{
		if (size != null)
			m_mediaSize = size;
	}	//	setMediaSize

	/**
	 *  String Representation
	 *  @return string representation
	 */
	public String toString()
	{
		StringBuilder sb = new StringBuilder("Language=[");
		sb.append(m_name).append(",Locale=").append(m_locale.toString())
			.append(",AD_Language=").append(m_AD_Language)
			.append(",DatePattern=").append(getDBdatePattern())
			.append(",DecimalPoint=").append(isDecimalPoint())
			.append("]");
		return sb.toString();
	}   //  toString

	/**
	 * 	Hash Code
	 * 	@return hashcode
	 */
	public int hashCode()
	{
		return m_AD_Language.hashCode();
	}	//	hashcode

	/**
	 * 	Equals.
	 *  Two languages are equal, if they have the same AD_Language
	 * 	@param obj compare
	 * 	@return true if AD_Language is the same
	 */
	public boolean equals(Object obj)
	{
		if (obj instanceof Language)
		{
			Language cmp = (Language)obj;
			if (cmp.getAD_Language().equals(m_AD_Language))
				return true;
		}
		return false;
	}	//	equals

	
	/**************************************************************************
	 * 	Test
	 * 	@param args ignored
	 */
	public static void main(String[] args)
	{
		System.out.println(Locale.TRADITIONAL_CHINESE);
		System.out.println(Locale.TAIWAN);
		System.out.println(Locale.SIMPLIFIED_CHINESE);
		System.out.println(Locale.CHINESE);
		System.out.println(Locale.PRC);
	}

}   //  Language
