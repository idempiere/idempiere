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
import java.math.BigDecimal;
import java.math.RoundingMode;

/**
 *	Amount in Words for Zh_CN (CNY in Simplified Chinese) 
 *  @author z5k1@qq.com
 *  @version $Id: AmtInWords_ZH.java,v1.0 2017/09/21 00:54:35 $
 *  
 *  The class is based on the AmtInWords_EN.java written by jjanke
 *	The algorithm is based on code named snhongtenzone@foxmail.com
 *
 *  Rule: 
 *  1. CNY is an currency of 10000-unit scale, dislike dollar with 1000-unit scale. 
 *  2. CNY currency accuracy is 0.01. And it's under a strict decimal number system. 
 *  3. Option of add an "zero" after "Yuan" is false. (Line 186)
 *  Reference: [1997]393 People's Bank of China "the Measures for Payment and Settlement" 
 *  \u53c2\u8003: \u4e2d\u56fd\u4eba\u6c11\u94f6\u884c \u94f6\u53d1[1997]393\u53f7 \u300a\u652f\u4ed8\u7ed3\u7b97\u529e\u6cd5\u300b\u9644\u4ef6\u300a\u6b63\u786e\u586b\u5199\u7968\u636e\u548c\u7ed3\u7b97\u51ed\u8bc1\u7684\u57fa\u672c\u89c4\u5b9a\u300b
 *
 *
 *	Results: (Rule 3 = true)
 *
 * 0.00	\u96f6\u5143\u6574	\uff08\u6d4b\u8bd5\uff1a\u91d1\u989d\u4e3a 0\uff09
 * 0.03	\u53c1\u5206	\uff08\u6d4b\u8bd5\uff1a\u89d20\u5206\u975e0\uff0c\u5916\u52a0 \u51430\uff09
 * 0.234	\u8d30\u89d2\u53c1\u5206	\uff08\u6d4b\u8bd5\uff1a\u89d2\u975e0\u5206\u975e0\uff0c\u820d4\uff09
 * 1.001	\u58f9\u5143\u6574	\uff08\u6d4b\u8bd5\uff1a\u89d20\u52060\uff0c\u52a0 \u201c \u6574 \u201d\uff0c\u820d1\uff09
 * 1.035	\u58f9\u5143\u96f6\u8086\u5206	\uff08\u89c4\u52194.4\uff1a\u89d20\u5206\u975e0\uff0c\u52a0\u96f6\uff0c\u51655\uff09
 * 1.205	\u58f9\u5143\u8d30\u89d2\u58f9\u5206	\uff08\u6d4b\u8bd5\uff1a\u89d2\u975e0\u52060\uff0c\u51655\u540e\uff0c\u89d2\u975e0\u5206\u975e0\uff09
 * 1.3345	\u58f9\u5143\u53c1\u89d2\u53c1\u5206	\uff08\u6d4b\u8bd5\uff1a\u5c0f\u6570\u70b94\u4f4d\uff09
 * 10.03	\u58f9\u62fe\u5143\u96f6\u53c1\u5206	\uff08\u89c4\u52194.4\uff1a\u89d20\u5206\u975e0\uff0c\u52a0\u96f6\uff09
 * 10.23	\u58f9\u62fe\u5143\u96f6\u8d30\u89d2\u53c1\u5206	\uff08\u89c4\u52194.3\uff1a\u51430\u89d2\u975e0\uff0c\u53ef\u9009\u52a0\u96f6\uff09
 * 23.00	\u8d30\u62fe\u53c1\u5143\u6574	\uff08\u89c4\u52192\uff1a\u52a0 \u201c \u6574 \u201d\uff09
 * 100.20	\u58f9\u4f70\u5143\u96f6\u8d30\u89d2	\uff08\u89c4\u52194.2 \u591a\u96f6\u5199\u4e00\u96f6\uff0c\u89d2\u975e0\u52060\uff09
 * 103.45	\u58f9\u4f70\u96f6\u53c1\u5143\u8086\u89d2\u4f0d\u5206	\uff08\u89c4\u52194.1\uff1a\u67090\u52a0 \u201c \u96f6 \u201d\uff0c\u89d2\u975e0\u5206\u975e0\uff09
 * 2,345	\u8d30\u4edf\u53c1\u4f70\u8086\u62fe\u4f0d\u5143\u6574	\uff08\u89c4\u52192\uff1a\u52a0 \u201c \u6574 \u201d\uff09
 * 1020.45	\u58f9\u4edf\u96f6\u8d30\u62fe\u5143\u96f6\u8086\u89d2\u4f0d\u5206	\uff08\u89c4\u52194.1+4.3\uff1a\u67090\u52a0 \u201c \u96f6 \u201d\uff1b\u51430\u89d2\u975e0\uff0c\u53ef\u9009\u52a0\u96f6\uff09
 * 1,234.56	\u58f9\u4edf\u8d30\u4f70\u53c1\u62fe\u8086\u5143\u4f0d\u89d2\u9646\u5206	\uff08\u6d4b\u8bd5\uff1a\u5343\u5206\u4f4d \u662f\u5426\u6b63\u786e\uff09
 * 12345.78	\u58f9\u4e07\u8d30\u4edf\u53c1\u4f70\u8086\u62fe\u4f0d\u5143\u67d2\u89d2\u634c\u5206	\uff08\u6d4b\u8bd5\uff1a\u5343\u5206\u4f4d \u662f\u5426\u6b63\u786e\uff09
 * 100457.89	\u58f9\u62fe\u4e07\u96f6\u8086\u4f70\u4f0d\u62fe\u67d2\u5143\u634c\u89d2\u7396\u5206	\uff08\u89c4\u52194.2\uff1a\u591a\u96f6\u5199\u4e00\u96f6\uff09
 * 103457.89	\u58f9\u62fe\u4e07\u96f6\u53c1\u4edf\u8086\u4f70\u4f0d\u62fe\u67d2\u5143\u634c\u89d2\u7396\u5206	\uff08\u89c4\u52194.3\uff1a\u4e070\u5343\u975e\u96f6\uff0c\u53ef\u9009\u52a0\u96f6\uff09
 * 107000.03	\u58f9\u62fe\u4e07\u96f6\u67d2\u4edf\u5143\u96f6\u53c1\u5206	\uff08\u89c4\u52194.3+4.4\uff1a\u4e070\u51430\u5343\u975e0\uff0c\u4e2d\u95f4\u591a0\uff0c\u89d20\uff0c\u53ef\u9009\u52a0\u96f6\uff09
 * 9,000,000.00	\u7396\u4f70\u4e07\u5143\u6574	\uff08\u89c4\u5219: 4\u4f4d\u8fdb\u5236\uff09
 * 10,000,000.00	\u58f9\u4edf\u4e07\u5143\u6574	\uff08\u6d4b\u8bd5\uff1a4\u4f4d\u8fdb\u5236\uff09
 * 10220134	\u58f9\u4edf\u96f6\u8d30\u62fe\u8d30\u4e07\u96f6\u58f9\u4f70\u53c1\u62fe\u8086\u5143\u6574	\uff08\u6d4b\u8bd5\uff1a\u65e0\u5343\u5206\u4f4d \u201c\u662f\u5426\u6b63\u786e\uff09
 * 100,234,578.90	\u58f9\u4ebf\u96f6\u8d30\u62fe\u53c1\u4e07\u8086\u4edf\u4f0d\u4f70\u67d2\u62fe\u634c\u5143\u7396\u89d2	\uff08\u6d4b\u8bd5\uff1a\u4ebf\uff09
 * 203010000.56	\u8d30\u4ebf\u96f6\u53c1\u4f70\u96f6\u58f9\u4e07\u5143\u96f6\u4f0d\u89d2\u9646\u5206	\uff08\u6d4b\u8bd5\uff1a\u4ebf\u96f6\uff0c\u4e07\u96f6\uff0c\u5143\uff09
 * 103,004,000.90	\u58f9\u4ebf\u96f6\u53c1\u4f70\u4e07\u96f6\u8086\u4edf\u5143\u96f6\u7396\u89d2	\uff08\u89c4\u52194.2+4.3\uff1a\u591a\u96f6\u5199\u4e00\u96f6\uff0c\u4e070\u5343\u975e\u96f6\uff0c\u4e2d\u95f4\u591a0\uff0c\u53ef\u9009\u52a0\u96f6\uff09
 * 1,201,034,578.90	\u58f9\u62fe\u8d30\u4ebf\u96f6\u58f9\u4f70\u96f6\u53c1\u4e07\u8086\u4edf\u4f0d\u4f70\u67d2\u62fe\u634c\u5143\u7396\u89d2	\uff08\u6d4b\u8bd5\uff1a\u5341\u4ebf\uff0c3\u4e2a\u5343\u5206\u4f4d \u662f\u5426\u6b63\u786e\uff09
 * 90,000,000,000	\u7396\u4f70\u4ebf\u5143\u6574	\uff08\u6d4b\u8bd5\uff1a4\u4f4d\u8fdb\u5236\uff09
 * 100,000,000,000	\u58f9\u4edf\u4ebf\u5143\u6574	\uff08\u6d4b\u8bd5\uff1a4\u4f4d\u8fdb\u5236\uff09
 * 1,932,110,345,780	\u58f9\u5146\u7396\u4edf\u53c1\u4f70\u8d30\u62fe\u58f9\u4ebf\u58f9\u4edf\u96f6\u53c1\u62fe\u8086\u4e07\u4f0d\u4edf\u67d2\u4f70\u634c\u62fe\u5143\u6574	\uff08\u6d4b\u8bd5\uff1a13\u4f4d\u6574\u6570\uff0c\u5146\uff0c4\u4e2a\u5343\u5206\u4f4d\uff09 
 * 10,000,000,000,000	\u9519\u8bef	\uff08\u6d4b\u8bd5\uff1a\u8d85\u8fc7\u6216\u7b49\u4e8e\u6700\u5927\u4f4d\u657010\u5146\uff0c\u6570\u5b57\u5fc5\u987b\u5c0f\u4e8e14\u4f4d\uff09
 * -1220.354	\u8d1f\u58f9\u4edf\u8d30\u4f70\u8d30\u62fe\u5143\u96f6\u53c1\u89d2\u4f0d\u5206	\uff08\u6d4b\u8bd5\uff1a\u8d1f\u6570\uff0c\u56db\u820d\u4e94\u5165\uff09
 * 1.222,33	\u9519\u8bef	\uff08\u6d4b\u8bd5\uff1a\u975e\u6cd5\u5b57\u7b26\uff09
 * 
 */

public class AmtInWords_ZH implements AmtInWords
{
	/**
	* 	AmtInWords_ZH
	*/
	public AmtInWords_ZH ()
	{
		super ();
	}	//	AmtInWords_ZH

	/** Currency scales				*/
	private static final String[]	scaleNames = 
	{
		"\u5206",		// 0	0.01
		"\u89d2",		// 1	0.1
		"\u5143",		// 2	1				\uff0810^0\uff09
		"\u62fe",		// 3	10
		"\u4f70",		// 4	100
		"\u4edf",		// 5	1000
		"\u4e07",		// 6	10000			\uff0810^4\uff09
		"\u62fe",		// 7	10*10000
		"\u4f70",		// 8	100*10000
		"\u4edf",		// 9	1000*10000
		"\u4ebf",		// 10	100000000		\uff0810^8\uff09	\u4e07\u4e07\u4e3a\u4ebf
		"\u62fe",		// 11	10*100000000
		"\u4f70",		// 12	100*100000000
		"\u4edf",		// 13	1000*100000000
		"\u5146",		// 14	1000000000000	\uff0810^12\uff09	\u4e07\u4ebf\u4e3a\u5146

	};
	/** numbers 0 to 9				*/
	private static final String[]	numNames = 
	{ 
		"\u96f6",		// 0
		"\u58f9",		// 1
		"\u8d30",		// 2
		"\u53c1",		// 3
		"\u8086",		// 4
		"\u4f0d",		// 5
		"\u9646",		// 6
		"\u67d2",		// 7
		"\u634c",		// 8
		"\u7396"		// 9
	};

	private static final String CNY_NEGATIVE = "\u8d1f";
	private static final String CNY_FULL = "\u6574";
	private static final String CNY_ZEOR_FULL = "\u96f6\u5143\u6574";
	
	/**
	*	Convert
	* 	@description	Convert BigDecimal number to String
	*	@param number	(-5432.135 with no period)
	*	@return amt		(amt in words of CNY)
	*/
	private String convert (BigDecimal number)
	{
		StringBuilder sb = new StringBuilder();
		int signum = number.signum();	// positive , 0 , negative
		int numUnit = 0;				// each number character
		int numIndex = 0;				// each number position
		int zeroSize = 0;				// sizes of zero

		// number = 0
		if (signum == 0){
			return CNY_ZEOR_FULL;		// zero_full
		}
		
		// round to 1/100, get long number ,eg -5432.135 = 543214
		long lnumber = number.movePointRight(2).setScale(0, RoundingMode.HALF_UP).abs().longValue();
		
		// number must less 10000000000000 (10^13)
		if (lnumber >= 1000000000000000L) {		
			return "\u4eb2\uff0c\u91d1\u989d\u8f6c\u6362\u4e0a\u9650\u4e3a10\u5146\uff0810\u4e07\u4ebf\uff09";
		}	
				
		// get the last 2 number (decimal number) ,eg 543214 = 14
		long decamt = lnumber % 100;
		boolean getZero = false; 								// sign of zero
		
		// decimal options\uff1a00 = 0, 01 = 1, 10, 11
		
		// decimal = 00
		if (!(decamt > 0)) {									//	special decimal case 00
				numIndex = 2;									//	2, begin from "Yuan"
				lnumber = lnumber / 100;						//	eg: 5432.00 = 543200 = 5432
				getZero = true;
			}
			
		// decimal = 10
		if ((decamt > 0) && (!(decamt % 10 > 0))) {				//	special decimal case 10
				numIndex = 1;									//	1, begin from "Jiao"
				lnumber = lnumber / 10;							//	eg: 5432.10 = 543210 = 54321
				getZero = true;
			}
			
		// begin foreach for all cases
		while (true) {
			if (lnumber <= 0) {									//	each character done
				break;
			}
			// get the last number each
			numUnit = (int) (lnumber % 10);
			if (numUnit > 0) {									//	Character = 1-9 ,insert (number + scale)
				if ((numIndex == 9) && (zeroSize >= 3)) {		//	special 9 (8th), eg: 10,000,000
					sb.insert(0, scaleNames[6]);				//	add "WAN"
				}
				if ((numIndex == 13) && (zeroSize >= 3)) {		//	special 13 (11st), eg: 100,000,000,000
					sb.insert(0, scaleNames[10]);				//	add "YI"
				}
				sb.insert(0, scaleNames[numIndex]);				//	first insert scale to Chinese
				sb.insert(0, numNames[numUnit]);				//	then insert number to Chinese
				getZero = false;
				zeroSize = 0;
			} else {											//	Character = 0, insert (scale + 0 )
				++zeroSize;										
				if (!(getZero) & numIndex != 2) {				//	separated zero and option of "YUAN" suffix
					sb.insert(0, numNames[numUnit]);			//	first insert 0 to Chinese
				}												//	
				if (numIndex == 2) {							//	option1: "YUAN"=0
					sb.insert(0, scaleNames[numIndex]);			//	then insert scale to Chinese											
				} 												//	option2: "WAN"|"YI"|"ZHAO" =0
				else if (((numIndex - 2) % 4 == 0) && (lnumber % 1000 > 0)) {		//	special 4th,8th, eg: 9,000,000 or 90,000,000,000
					sb.insert(0, scaleNames[numIndex]);			//	then insert scale to Chinese
				}
				getZero = true;									//	multi-zero nothing added
			}

			lnumber = lnumber / 10;								//	cut the last number off each
			++numIndex;											//	++ position of number
		}
		
		// add suffix of "zheng" when decimal = 00
		if (!(decamt > 0)) {
			sb.append(CNY_FULL);								//	add suffix CNY_full
		}
		
		//	add prefix of "fu" when negative
		if (signum == -1) {
		sb.insert(0, CNY_NEGATIVE);								//	add prefix negative
		}
	
		return sb.toString();									//	return amt string completed
	}	//	convert

	/**************************************************************************
	 * 	Get Amount in Words
	 * 	@param amount numeric amount (352.80)
	 * 	@return amount in words
	 * 	@throws Exception
	 */
	public String getAmtInWords (String amount) throws Exception
	{
		if (amount == null || amount.length() <= 0)				//	null string
			return amount;

		//TODO: Check string illegal character
		
		amount = amount.replaceAll (",", "");					//	fire period ","
		//TODO: 1.234,56 as comma replace period 
		
		StringBuilder sb = new StringBuilder ();
		BigDecimal cny = new BigDecimal(amount);				//	convert String to BigDecimal
		sb.append (convert (cny));								//	get result string from convert
		return sb.toString ();									//	return
	}	

	/**
	* 	Test Print
	*	@param amt amount
	*/
	private void print (String amt)
	{
		try
		{
			System.out.println(amt + " = " + getAmtInWords(amt));
		}
		catch (Exception e)
		{
			e.printStackTrace();
		}
	}	//	print
	
	/**
	* 	Test
	*	@param args ignored
	*/
	public static void main (String[] args)
	{
		AmtInWords_ZH aiw = new AmtInWords_ZH();
		aiw.print (null);
		aiw.print ("");
		aiw.print ("0.00");
		aiw.print ("0.03");
		aiw.print ("0.234");
		aiw.print ("1.001");
		aiw.print ("1.035");
		aiw.print ("1.205");
		aiw.print ("1.3345");
		aiw.print ("10.03");
		aiw.print ("10.23");
		aiw.print ("23.00");
		aiw.print ("100.20");
		aiw.print ("103.45");
		aiw.print ("2,345");
		aiw.print ("1020.45");
		aiw.print ("1,234.56");
		aiw.print ("12345.78");
		aiw.print ("100457.89");
		aiw.print ("103457.89");
		aiw.print ("107000.03");
		aiw.print ("9,000,000.00");   // Line 189
		aiw.print ("10,000,000.00");  // Line 171
		aiw.print ("10220134");
		aiw.print ("100,234,578.90");
		aiw.print ("203010000.56");
		aiw.print ("103,004,000.90");
		aiw.print ("1,201,034,578.90");
		aiw.print ("90,000,000,000");	// Line 189
		aiw.print ("100,000,000,000");	// Line 174
		aiw.print ("1,932,110,345,780");
		aiw.print ("10,000,000,000,000");
		aiw.print ("-1220.354");
//		aiw.print ("1.234,56"); ERROR		
	}	//	main
}
