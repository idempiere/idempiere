/******************************************************************************
 * Product: ADempiereLBR - ADempiere Localization Brazil                      *
 * This program is free software; you can redistribute it and/or modify it    *
 * under the terms version 2 of the GNU General Public License as published   *
 * by the Free Software Foundation. This program is distributed in the hope   *
 * that it will be useful, but WITHOUT ANY WARRANTY; without even the implied *
 * warranty of MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.           *
 * See the GNU General Public License for more details.                       *
 * You should have received a copy of the GNU General Public License along    *
 * with this program; if not, write to the Free Software Foundation, Inc.,    *
 * 59 Temple Place, Suite 330, Boston, MA 02111-1307 USA.                     *
 *****************************************************************************/
package org.compiere.util;

import java.math.BigDecimal;
import java.math.RoundingMode;

/**
 *	Portuguese Amount in Words
 *	
 *  @author Jorg Janke - http://www.rgagnon.com/javadetails/java-0426.html
 *  @translator emontenegro, ralexsander
 *  @contributor mgrigioni - UTF-8 Code
 *  @version $Id: AmtInWords_PT.java,v 1.0 2008/01/07 00:54:36 ralexsander Exp $
 */
public class AmtInWords_PT implements AmtInWords
{
	/**
	 * 	AmtInWords_PT
	 */
	public AmtInWords_PT ()
	{
		super ();
	} //	AmtInWords_PT

	private static final String[]	centsNames	= {
		"", 
		"", 
		"",
		" D\u00e9cimo de", 
		" Cent\u00e9simo de", 
		" Mil\u00e9simo de", 
		" Milion\u00e9simo de",
		" Bilion\u00e9simo de",
		" Trilion\u00e9simo de"
		};
	
	private static final String[]	centsNamesPlural	= {
		"", 
		"", 
		"",
		" D\u00e9cimos de", 
		" Cent\u00e9simos de", 
		" Mil\u00e9simos de", 
		" Milion\u00e9simos de",
		" Bilion\u00e9simos de",
		" Trilion\u00e9simos de"
		};
	
	private static final String[]	majorNames	= {
		"", 
		" Mil", 
		" Milh\u00e3o",
		" Bilh\u00e3o", 
		" Trilh\u00e3o", 
		" Quatrilh\u00e3o", 
		" Quinquilh\u00e3o"  
		};

	private static final String[]	majorNamesPlural	= {
		"", 
		" Mil", 
		" Milh\u00f5es",
		" Bilh\u00f5es", 
		" Trilh\u00f5es", 
		" Quatrilh\u00f5es", 
		" Quinquilh\u00f5es"  
		};

	private static final String[]	tensNames	= { 
		"", 
		" Dez", 
		" Vinte",
		" Trinta", 
		" Quarenta", 
		" Cinq\u00fcenta", 
		" Sessenta", 
		" Setenta",
		" Oitenta", 
		" Noventa"
		};

	private static final String[]	numNames	= { 
		"", 
		" Um",
		" Dois",
		" Tr\u00eas", 
		" Quatro", 
		" Cinco", 
		" Seis", 
		" Sete", 
		" Oito", 
		" Nove",
		" Dez", 
		" Onze", 
		" Doze", 
		" Treze", 
		" Quatorze", 
		" Quinze",
		" Dezesseis", 
		" Dezessete", 
		" Dezoito", 
		" Dezenove"
		};

	/**
	 * 	Convert Less Than One Thousand
	 *	@param number
	 *	@return amt
	 */
	private String convertLessThanOneThousand (int number)
	{
		String soFar;
		// Esta dentro de los 1os. diecinueve?? ISCAP
		if (number % 100 < 20)
		{
			soFar = numNames[number % 100];
			number /= 100;
		}
		else
		{
			soFar = numNames[number % 10];
			number /= 10;
			String s = Double.toString (number);
			if (s.endsWith ("2") && !soFar.equals(""))
				soFar = " Vinte e " + soFar.trim ();
			else if (soFar.equals(""))
				soFar = tensNames[number % 10] + soFar;
			else
				soFar = tensNames[number % 10] + " e" + soFar;
			number /= 10;
		}
		if (number == 0)
		//return soFar;
		// Begin e-Evolution ogi-cd 		
			return tensNames[number % 10] + soFar; // e-Evolution ogi-cd
		// End e-Evolution ogi-cd
		if (number > 1)
			soFar = "s e" + soFar;
		if (number == 1 && !soFar.equals(""))
			number = 0;
			soFar = " e" + soFar;
		return numNames[number] + " Cento" + soFar;
	}	//	convertLessThanOneThousand

	/**
	 * 	Convert
	 *	@param number
	 *	@return amt
	 */
	private String convert (BigDecimal number)
	{
		/* special case */
		if (number.compareTo(Env.ZERO) == 0)
			return "";
		if (number.compareTo(Env.ONE) == 0)
			return "Um";
		if (number.compareTo(Env.ONE.negate()) == 0)
			return "Menos Um";
		String prefix = "";
		if (number.compareTo(Env.ZERO) == -1)
		{
			number = number.negate();
			prefix = "Menos";
		}
		
		/*if ((number >= 1000000 && number < 2000000)
				|| (number >= 1000000000 && number < 2000000000)){
			prefix = "Um";
		}*/
		String soFar = "";
		int place = 0;
		do
		{
			int n = number.divideAndRemainder(new BigDecimal(1000))[1].intValue();/// % 1000;
			if (n != 0)
			{
				String s = convertLessThanOneThousand (n);
				if (s.startsWith ("Um Cento e", 1))
				{
					s = s.replaceFirst ("Um Cento e", "Cem");
				}
				if (s.startsWith ("Dois Cento es", 1))
				{
					s = s.replaceFirst ("Dois Cento es", "Duzentos");
				}
				if (s.startsWith ("Tr\u00eas Cento es", 1))
				{
					s = s.replaceFirst ("Tr\u00eas Cento es", "Trezentos");
				}
				if (s.startsWith ("Quatro Cento es", 1))
				{
					s = s.replaceFirst ("Quatro Cento es", "Quatrocentos");
				}
				if (s.startsWith ("Cinco Cento es", 1))
				{
					s = s.replaceFirst ("Cinco Cento es", "Quinhentos");
				}
				if (s.startsWith ("Seis Cento es", 1))
				{
					s = s.replaceFirst ("Seis Cento es", "Seiscentos");
				}
				if (s.startsWith ("Sete Cento es", 1))
				{
					s = s.replaceFirst ("Sete Cento es", "Setecentos");
				}
				if (s.startsWith ("Oito Cento es", 1))
				{
					s = s.replaceFirst ("Oito Cento es", "Oitocentos");
				}
				if (s.startsWith ("Nove Cento es", 1))
				{
					s = s.replaceFirst ("Nove Cento es", "Novecentos");
				}
				if (s.equals(" Um"))
				{
					soFar = s + majorNames[place] + (soFar.equals("") ? "" : " e" + soFar);
				}
				else {
					if (n > 1) 
					{
						soFar = s + majorNamesPlural[place] + (soFar.equals("") ? "" : " e" + soFar);
						//soFar = s + majorNamesPlural[place] + soFar;
					} 
					else 
					{
						soFar = s + majorNames[place] + (soFar.equals("") ? "" : " e" + soFar);
					}
				}
			}
			place++;	
			number = number.divideAndRemainder(new BigDecimal(1000))[0];
		}
		while (number.compareTo(Env.ZERO) == 1);
		return (prefix + soFar)
					.replaceAll(" e Mil", " Mil")
					.trim ();	
	}	//	convert
	
	public String getAmtInWords (BigDecimal amount) throws Exception
	{	
		amount = amount.setScale(2, RoundingMode.HALF_UP);
		
		String samount = amount.toString();
		samount = samount.replaceAll("\\.", ",");
		
		return getAmtInWords(samount);
	}

	
	/**************************************************************************
	 * 	Get Amount in Words
	 * 	@param amount numeric amount (352.80)
	 * 	@return amount in words (three*five*two 80/100)
	 * 	@throws Exception
	 */
	public String getAmtInWords (String amount) throws Exception
	{
		if (amount == null)
			return amount;
		//
		StringBuilder sb = new StringBuilder ();
    	int pos = amount.lastIndexOf ('.');    // Old
	//	int pos = amount.lastIndexOf (',');  		
    	int pos2 = amount.lastIndexOf (',');   // Old		
	//	int pos2 = amount.lastIndexOf ('.');
		if (pos2 > pos)
			pos = pos2;
		String oldamt = amount;

		amount = amount.replaceAll ("\\.", "").replaceAll (",", ".");   // Old
		String vlr = amount.replaceAll (",", ".");

		int newpos = amount.lastIndexOf ('.');  // Old
	//	int newpos = amount.lastIndexOf (',');
		if (newpos == -1) newpos = amount.length();
		BigDecimal reais =  new BigDecimal(amount.substring (0, newpos));
		double valor = Double.parseDouble(vlr);
		sb.append (convert (reais));
		for (int i = 0; i < oldamt.length (); i++)
		{
			if (pos == i) //	we are done
			{
				String cents = oldamt.substring (i + 1);
				do
				{
					if(cents.endsWith("0") && cents.length() > 2)
						cents = cents.substring(0, cents.length() -1);
				}
				while (cents.endsWith("0") && cents.length() > 2);
				
				if (valor > 0 && valor < 1) 
				{
					if (Integer.parseInt(cents) > 0)
					{
						if (Integer.parseInt(cents) > 1)
						{
							sb.append (convert(new BigDecimal(cents)))
								.append(" Centavos");
						}
						else 
						{
							sb.append (convert(new BigDecimal(cents)))
								.append(" Centavo");
						}
					}
				}
				else if ((valor > 1 && valor < 2) || (valor > -2 && valor < -1))
				{
					if (Integer.parseInt(cents) > 0)
					{
						if (Integer.parseInt(cents) > 1)
						{
							sb.append (' ')
								.append("Real e ")
								.append (convert(new BigDecimal(cents)))
								.append(" Centavos");
						}
						else 
						{
							sb.append (' ')
							.append("Real e ")
							.append (convert(new BigDecimal(cents)))
							.append(" Centavo");
						}
						break;
					}
				}
				else if (valor > -1 && valor < 0)
				{
					if (Integer.parseInt(cents) > 0)
					{
						if (Integer.parseInt(cents) > 1)
						{
							sb.append ("Menos ")
								.append (convert(new BigDecimal(cents)))
								.append(centsNamesPlural[cents.length()])
								.append(centsNamesPlural[cents.length()].equals("") ? " Centavos" : " Centavo");
						}
						else 
						{
							sb.append ("Menos ")
								.append (convert(new BigDecimal(cents)))
								.append(centsNames[cents.length()])
								.append(" Centavo");
						}
						break;
					}
				}
				else 
				{
					if (!cents.equals("") && Integer.parseInt(cents) > 0)
					{
						if (Integer.parseInt(cents) > 1)
						{
							sb.append (' ')
								.append("Reais e ")
								.append (convert(new BigDecimal(cents)))
								.append(centsNamesPlural[cents.length()])
								.append(centsNamesPlural[cents.length()].equals("") ? " Centavos" : " Centavo");
						}
						else 
						{
							sb.append (' ')
								.append("Reais e ")
								.append (convert(new BigDecimal(cents)))
								.append(centsNames[cents.length()])
								.append(" Centavo");
						}
						break;
					}
					else
					{
						if (reais.abs().compareTo(Env.ONE) == 0)
							sb.append(" Real");
						else
							sb.append(" Reais");
					}
				}
			}
		}
		if (pos == -1){
			if (reais.abs().compareTo(Env.ONE) == 0)
				sb.append(" Real");
			else
				sb.append(" Reais");
		}
		
		/**	Corre\u00e7\u00f5es	*/
		String result;
		result = sb.toString ()
				.replaceAll(" e Quinquilh", " Quinquilh")
				.replaceAll(" e Quatrilh", " Quatrilh")
				.replaceAll(" e Trilh", " Trilh")
				.replaceAll(" e Bilh", " Bilh")
				.replaceAll(" e Milh", " Milh")
				.replaceAll("\u00f5es Reais", "\u00f5es de Reais")
				.replaceAll("\u00e3o Reais", "\u00e3o de Reais")
				.replaceAll(" e Reais", " Reais")
				.replaceAll(", de", " de");
		
		if (result.indexOf("Quinquilh") > 0 && result.indexOf("Quatrilh") > 0 && result.indexOf("Quatrilh\u00f5es de Rea") == -1 && result.indexOf("Quatrilh\u00e3o de Rea") == -1)
			result = result.replaceAll("Quinquilh\u00f5es e", "Quinquilh\u00f5es,").replaceAll("Quinquilh\u00e3o e", "Quinquilh\u00e3o,");
		
		if (result.indexOf("Quatrilh") > 0 && result.indexOf("Trilh") > 0 && result.indexOf("Trilh\u00f5es de Rea") == -1 && result.indexOf("Trilh\u00e3o de Rea") == -1)
			result = result.replaceAll("Quatrilh\u00f5es e", "Quatrilh\u00f5es,").replaceAll("Quatrilh\u00e3o e", "Quatrilh\u00e3o,");
		
		if (result.indexOf("Trilh") > 0 && result.indexOf("Bilh") > 0 && result.indexOf("Bilh\u00f5es de Rea") == -1 && result.indexOf("Bilh\u00e3o de Rea") == -1)
			result = result.replaceAll("Trilh\u00f5es e", "Trilh\u00f5es,").replaceAll("Trilh\u00e3o e", "Trilh\u00e3o,");
		
		if (result.indexOf("Bilh") > 0 && result.indexOf("Milh") > 0 && result.indexOf("Milh\u00f5es de Rea") == -1 && result.indexOf("Milh\u00e3o de Rea") == -1)
			result = result.replaceAll("Bilh\u00f5es e", "Bilh\u00f5es,").replaceAll("Bilh\u00e3o e", "Bilh\u00e3o,");
		
		if (result.indexOf("Milh") > 0 && result.indexOf(" de Rea") == -1 && result.indexOf("Mil e") > 0)
			result = result.replaceAll("Milh\u00f5es e", "Milh\u00f5es,").replaceAll("Milh\u00e3o e", "Milh\u00e3o,");

		return result ; 
	}	//	getAmtInWords

	public static void main(String[] args) throws Exception 
	{
		AmtInWords_PT aiw = new AmtInWords_PT();
		System.out.println(aiw.getAmtInWords("42"));
		System.out.println(aiw.getAmtInWords("0,42"));
		System.out.println(aiw.getAmtInWords("100"));
		System.out.println(aiw.getAmtInWords("100,00"));
		System.out.println(aiw.getAmtInWords("1003,00"));
		System.out.println(aiw.getAmtInWords("5715,13"));
		System.out.println(aiw.getAmtInWords("5715,11"));
		System.out.println(aiw.getAmtInWords("5715,20"));
		System.out.println(aiw.getAmtInWords("5715,30"));
		System.out.println(aiw.getAmtInWords("5715,44"));
		System.out.println(aiw.getAmtInWords("5715,55"));
		System.out.println(aiw.getAmtInWords("5715,60"));
		System.out.println(aiw.getAmtInWords("5715,79"));
		System.out.println(aiw.getAmtInWords("5715,82"));
		System.out.println(aiw.getAmtInWords("5715,90"));
		
		System.out.println(aiw.getAmtInWords(new BigDecimal(51.34)));
	}
	
}	//	AmtInWords_PT
