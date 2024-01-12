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
package org.apache.ecs;

/**
    This class defines all of the available Html Colors.

    @version $Id: HtmlColor.java,v 1.2 2006/07/30 00:54:02 jjanke Exp $
    @author <a href="mailto:snagy@servletapi.com">Stephan Nagy</a>
    @author <a href="mailto:jon@clearink.com">Jon S. Stevens</a>
*/
public abstract class HtmlColor
{

    // colors html 4.0

    /** HTML 4.0 specification for color <font color="#000000">BLACK</font>. */
    public final static String BLACK = "#000000";
    /** HTML 4.0 specification for color <font color="#C0C0C0">SILVER</font>. */
    public final static String SILVER = "#C0C0C0";
    /** HTML 4.0 specification for color <font color="#808080">GRAY</font>. */
    public final static String GRAY = "#808080";
    /** HTML 4.0 specification for color WHITE (not shown). */
    public final static String WHITE = "#FFFFFF";
    /** HTML 4.0 specification for color <font color="#800000">MAROON</font>. */
    public final static String MAROON = "#800000";
    /** HTML 4.0 specification for color <font color="#FF0000">RED</font>. */
    public final static String RED = "#FF0000";
    /** HTML 4.0 specification for color <font color="#800080">PURPLE</font>. */
    public final static String PURPLE = "#800080";
    /** HTML 4.0 specification for color <font color="#FF00FF">FUCHSIA</font>. */
    public final static String FUCHSIA = "#FF00FF";
    /** HTML 4.0 specification for color <font color="#008000">GREEN</font>. */
    public final static String GREEN = "#008000";
    /** HTML 4.0 specification for color <font color="#00FF00">LIME</font>. */
    public final static String LIME = "#00FF00";
    /** HTML 4.0 specification for color <font color="#808000">OLIVE</font>. */
    public final static String OLIVE = "#808000";
    /** HTML 4.0 specification for color <font color="#FFFF00">YELLOW</font>. */
    public final static String YELLOW = "#FFFF00";
    /** HTML 4.0 specification for color <font color="#000080">NAVY</font>. */
    public final static String NAVY = "#000080";
    /** HTML 4.0 specification for color <font color="#0000FF">BLUE</font>. */
    public final static String BLUE = "#0000FF";
    /** HTML 4.0 specification for color <font color="#008080">TEAL</font>. */
    public final static String TEAL = "#008080";
    /** HTML 4.0 specification for color <font color="#00FFFF">AQUA</font>. */
    public final static String AQUA = "#00FFFF";

    // colors html 3.0

    /** HTML 3.0 specification for color <font color="#EFF7FF">ALICEBLUEOC</font>. */
    public final static String ALICEBLUE = "#EFF7FF";
    /** HTML 3.0 specification for color <font color="#F9E8D2">ANTIQUEWHITE</font>. */
    public final static String ANTIQUEWHITE = "#F9E8D2";
    /** HTML 3.0 specification for color <font color="#43B7BA">AQUAMARINE</font>. */
    public final static String AQUAMARINE = "#43B7BA";
    /** HTML 3.0 specification for color <font color="#EFFFFF">AZURE</font>. */
    public final static String AZURE = "#EFFFFF";
    /** HTML 3.0 specification for color <font color="#F5F3D7">BEIGE</font>. */
    public final static String BEIGE = "#F5F3D7";
    /** HTML 3.0 specification for color <font color="#FDE0BC">BISQUE</font>. */
    public final static String BISQUE = "#FDE0BC";
    /** HTML 3.0 specification for color <font color="#FEE8C6">BLANCHEDALMOND</font>. */
    public final static String BLANCHEDALMOND = "#FEE8C6";
    /** HTML 3.0 specification for color <font color="#7931DF">BLUEVIOLET</font>. */
    public final static String BLUEVIOLET = "#7931DF";
    /** HTML 3.0 specification for color <font color="#980516">BROWN</font>. */
    public final static String BROWN = "#980516";
    /** HTML 3.0 specification for color <font color="#EABE83">BURLYWOOD</font>. */
    public final static String BURLYWOOD = "#EABE83";
    /** HTML 3.0 specification for color <font color="#578693">CADETBLUE</font>. */
    public final static String CADETBLUE = "#578693";
    /** HTML 3.0 specification for color <font color="#8AFB17">CHARTREUSE</font>. */
    public final static String CHARTREUSE = "#8AFB17";
    /** HTML 3.0 specification for color <font color="#C85A17">CHOCOLATE</font>. */
    public final static String CHOCOLATE = "#C85A17";
    /** HTML 3.0 specification for color <font color="#F76541">CORAL</font>. */
    public final static String CORAL = "#F76541";
    /** HTML 3.0 specification for color <font color="#151B8D">CORNFLOWERBLUE</font>. */
    public final static String CORNFLOWERBLUE = "#151B8D";
    /** HTML 3.0 specification for color <font color="#FFF7D7">CORNSILK</font>.*/
    public final static String CORNSILK = "#FFF7D7";
    /** HTML 3.0 specification for color <font color="#E41B17">CRIMSON</font>.
     *  RED2 couldn't find CRIMSON */
    public final static String CRIMSON = "#E41B17";
    /** HTML 3.0 specification for color <font color="#00FFFF">CYAN</font>. */
    public final static String CYAN = "#00FFFF";
    /** HTML 3.0 specification for color <font color="#2F2F4F">DARKBLUE</font>.
    *   MIDNIGHTBLUE couldn't find DARKBLUE */
    public final static String DARKBLUE = "#2F2F4F";
    /** HTML 3.0 specification for color <font color="#57FEFF">DARKCYAN</font>.
     *  CYAN1 couldn't find DARKCYAN */
    public final static String DARKCYAN = "#57FEFF";
    /** HTML 3.0 specification for color <font color="#AF7817">DARKGOLDENROD</font>. */
    public final static String DARKGOLDENROD = "#AF7817";
    /** HTML 3.0 specification for color <font color="#7A7777">DARKGRAY</font>.
     *  GRAY52 couldn't find DARKGRAY */
    public final static String DARKGRAY = "#7A7777";
    /** HTML 3.0 specification for color <font color="#254117">DARKGREEN</font>. */
    public final static String DARKGREEN = "#254117";
    /** HTML 3.0 specification for color <font color="#B7AD59">DARKKHAKI</font>. */
    public final static String DARKKHAKI = "#B7AD59";
    /** HTML 3.0 specification for color <font color="#F43EFF">DARKMAGENTA</font>.
     *  MAGENTA1 couldn't find DARKMAGENTA */
    public final static String DARKMAGENTA = "#F43EFF";
    /** HTML 3.0 specification for color <font color="#CCFB5D">DARKOLIVEGREEN</font>. */
    public final static String DARKOLIVEGREEN = "#CCFB5D";
    /** HTML 3.0 specification for color <font color="#F88017">DARKORANGE</font>. */
    public final static String DARKORANGE = "#F88017";
    /** HTML 3.0 specification for color <font color="#7D1B7E">DARKORCHID</font>. */
    public final static String DARKORCHID = "#7D1B7E";
    /** HTML 3.0 specification for color <font color="#E41B17">DARKRED</font>.
     *  RED2 couldn't find DARKRED */
    public final static String DARKRED = "#E41B17";
    /** HTML 3.0 specification for color <font color="#E18B6B">DARKSALMON</font>. */
    public final static String DARKSALMON = "#E18B6B";
    /** HTML 3.0 specification for color <font color="#8BB381">DARKSEAGREEN</font>. */
    public final static String DARKSEAGREEN = "#8BB381";
    /** HTML 3.0 specification for color <font color="#2B3856">DARKSLATEBLUE</font>. */
    public final static String DARKSLATEBLUE = "#2B3856";
    /** HTML 3.0 specification for color <font color="#253856">DARKSLATEGRAY</font>. */
    public final static String DARKSLATEGRAY = "#253856";
    /** HTML 3.0 specification for color <font color="#3B9C9C">DARKTURQUOISE</font>. */
    public final static String DARKTURQUOISE = "#3B9C9C";
    /** HTML 3.0 specification for color <font color="#842DCE">DARKVIOLET</font>. */
    public final static String DARKVIOLET = "#842DCE";
    /** HTML 3.0 specification for color <font color="#F52887">DEEPPINK</font>. */
    public final static String DEEPPINK = "#F52887";
    /** HTML 3.0 specification for color <font color="#3BB9FF">DEEPSKYBLUE</font>. */
    public final static String DEEPSKYBLUE = "#3BB9FF";
    /** HTML 3.0 specification for color <font color="#463E41">DIMGRAY</font>. */
    public final static String DIMGRAY = "#463E41";
    /** HTML 3.0 specification for color <font color="#1589FF">DODGERBLUE</font>. */
    public final static String DODGERBLUE = "#1589FF";
    /** HTML 3.0 specification for color <font color="#800517">FIREBRICK</font>. */
    public final static String FIREBRICK = "#800517";
    /** HTML 3.0 specification for color <font color="#FFF9EE">FLORALWHITE</font>. */
    public final static String FLORALWHITE = "#FFF9EE";
    /** HTML 3.0 specification for color <font color="#4E9258">FORESTGREEN</font>. */
    public final static String FORESTGREEN = "#4E9258";
    /** HTML 3.0 specification for color <font color="#D8D9D7">GAINSBORO</font>. */
    public final static String GAINSBORO = "#D8D9D7";
    /** HTML 3.0 specification for color <font color="#F7F7FF">GHOSTWHITE</font>. */
    public final static String GHOSTWHITE = "#F7F7FF";
    /** HTML 3.0 specification for color <font color="#D4A017">GOLD</font>. */
    public final static String GOLD = "#D4A017";
    /** HTML 3.0 specification for color <font color="#EDDA74">GOLDENROD</font>. */
    public final static String GOLDENROD = "#EDDA74";
    /** HTML 3.0 specification for color <font color="#B1FB17">GREENYELLOW</font>. */
    public final static String GREENYELLOW = "#B1FB17";
    /** HTML 3.0 specification for color <font color="#F0FEEE">HONEYDEW</font>. */
    public final static String HONEYDEW = "#F0FEEE";
    /** HTML 3.0 specification for color <font color="#5E2217">INDIANRED</font>. */
    public final static String INDIANRED = "#5E2217";
    /** HTML 3.0 specification for color <font color="#307D7E">INDIGO</font>.
     *  CYAN4 couldn't find INDIGO */
    public final static String INDIGO = "#307D7E";
    /** HTML 3.0 specification for color <font color="#FFFFEE">IVORY</font>. */
    public final static String IVORY = "#FFFFEE";
    /** HTML 3.0 specification for color <font color="#ADA96E">KHAKI</font>. */
    public final static String KHAKI = "#ADA96E";
    /** HTML 3.0 specification for color <font color="#E3E4FA">LAVENDER</font>. */
    public final static String LAVENDER = "#E3E4FA";
    /** HTML 3.0 specification for color <font color="#FDEEF4">LAVENDERBLUSH</font>. */
    public final static String LAVENDERBLUSH = "#FDEEF4";
    /** HTML 3.0 specification for color <font color="#87F717">LAWNGREEN</font>. */
    public final static String LAWNGREEN = "#87F717";
    /** HTML 3.0 specification for color <font color="#FFF8C6">LEMONCHIFFON</font>. */
    public final static String LEMONCHIFFON = "#FFF8C6";
    /** HTML 3.0 specification for color <font color="#ADDFFF">LIGHTBLUE</font>. */
    public final static String LIGHTBLUE = "#ADDFFF";
    /** HTML 3.0 specification for color <font color="#E77471">LIGHTCORAL</font>. */
    public final static String LIGHTCORAL = "#E77471";
    /** HTML 3.0 specification for color <font color="#E0FFFF">LIGHTCYAN</font>. */
    public final static String LIGHTCYAN = "#E0FFFF";
    /** HTML 3.0 specification for color <font color="#FAF8CC">LIGHTGOLDENROD</font>. */
    public final static String LIGHTGOLDENRODYELLOW = "#FAF8CC";
    /** HTML 3.0 specification for color <font color="#CCFFCC">LIGHTGREEN</font>.
     *  ARBITRARY SHADE OF GREEN couldnt find LIGHTGREEN */
    public final static String LIGHTGREEN = "#CCFFCC";
    /** HTML 3.0 specification for color <font color="#FAAFBA">LIGHPINK</font>. */
    public final static String LIGHTPINK = "#FAAFBA";
    /** HTML 3.0 specification for color <font color="#F9966B">LIGHTSALMON</font>. */
    public final static String LIGHTSALMON = "#F9966B";
    /** HTML 3.0 specification for color <font color="#3EA99F">LIGHTSEAGREEN</font>. */
    public final static String LIGHTSEAGREEN = "#3EA99F";
    /** HTML 3.0 specification for color <font color="#82CAFA">LIGHTSKYBLUE</font>. */
    public final static String LIGHTSKYBLUE = "#82CAFA";
    /** HTML 3.0 specification for color <font color="#6D7B8D">LIGHTSLATEGRAY</font>. */
    public final static String LIGHTSLATEGRAY = "#6D7B8D";
    /** HTML 3.0 specification for color <font color="#728FCE">LIGHTSTEELBLUE</font>. */
    public final static String LIGHTSTEELBLUE = "#728FCE";
    /** HTML 3.0 specification for color <font color="#FFFEDC">LIGHTYELLOW</font>. */
    public final static String LIGHTYELLOW = "#FFFEDC";
    /** HTML 3.0 specification for color <font color="#41A317">LIMEGREEN</font>. */
    public final static String LIMEGREEN = "#41A317";
    /** HTML 3.0 specification for color <font color="#F9EEE2">LINEN</font>. */
    public final static String LINEN = "#F9EEE2";
    /** HTML 3.0 specification for color <font color="#FF00FF">MAGENTA</font>. */
    public final static String MAGENTA = "#FF00FF";
    /** HTML 3.0 specification for color <font color="#348781">MEDIUMAQUAMARINE</font>. */
    public final static String MEDIUMAQUAMARINE = "#348781";
    /** HTML 3.0 specification for color <font color="#152DC6">MEDIUMBLUE</font>. */
    public final static String MEDIUMBLUE = "#152DC6";
    /** HTML 3.0 specification for color <font color="#B048B5">MEDIUMORCHID</font>. */
    public final static String MEDIUMORCHID = "#B048B5";
    /** HTML 3.0 specification for color <font color="#8467D7">MEDIUMPURPLE</font>. */
    public final static String MEDIUMPURPLE = "#8467D7";
    /** HTML 3.0 specification for color <font color="#306754">MEDIUMSEAGREEN</font>. */
    public final static String MEDIUMSEAGREEN = "#306754";
    /** HTML 3.0 specification for color <font color="#5E5A80">MEDIUMSLATEBLUE</font>. */
    public final static String MEDIUMSLATEBLUE = "#5E5A80";
    /** HTML 3.0 specification for color <font color="#348017">MEDIUMSPRINGGREEN</font>. */
    public final static String MEDIUMSPRINGGREEN = "#348017";
    /** HTML 3.0 specification for color <font color="#48CCCD">MEDIUMTURQUOISE</font>. */
    public final static String MEDIUMTURQUOISE = "#48CCCD";
    /** HTML 3.0 specification for color <font color="#CA226B">MEDIUMVIOLETRED</font>. */
    public final static String MEDIUMVIOLETRED = "#CA226B";
    /** HTML 3.0 specification for color <font color="#151B54">MIDNIGHTBLUE</font>. */
    public final static String MIDNIGHTBLUE = "#151B54";
    /** HTML 3.0 specification for color <font color="#F5FFF9">MINTCREAM</font>. */
    public final static String MINTCREAM = "#F5FFF9";
    /** HTML 3.0 specification for color <font color="#FDE1DD">MISTYROSE</font>. */
    public final static String MISTYROSE = "#FDE1DD";
    /** HTML 3.0 specification for color <font color="#FDE0AC">MOCCASIN</font>. */
    public final static String MOCCASIN = "#FDE0AC";
    /** HTML 3.0 specification for color <font color="#FDDAA3">NAVAJOWHITE</font>. */
    public final static String NAVAJOWHITE = "#FDDAA3";
    /** HTML 3.0 specification for color <font color="#FCF3E2">OLDLACE</font>. */
    public final static String OLDLACE = "#FCF3E2";
    /** HTML 3.0 specification for color <font color="#658017">OLIVEDRAB</font>. */
    public final static String OLIVEDRAB = "#658017";
    /** HTML 3.0 specification for color <font color="#F87A17">ORANGE</font>. */
    public final static String ORANGE = "#F87A17";
    /** HTML 3.0 specification for color <font color="#F63817">ORANGERED</font>. */
    public final static String ORANGERED = "#F63817";
    /** HTML 3.0 specification for color <font color="#E57DED">ORCHID</font>. */
    public final static String ORCHID = "#E57DED";
    /** HTML 3.0 specification for color <font color="#EDE49E">PALEGOLDENROD</font>. */
    public final static String PALEGOLDENROD = "#EDE49E";
    /** HTML 3.0 specification for color <font color="#AEEBEC">PALETURQUOISE</font>. */
    public final static String PALETURQUOISE = "#AEEBEC";
    /** HTML 3.0 specification for color <font color="#D16587">PALEVIOLETRED</font>. */
    public final static String PALEVIOLETRED = "#D16587";
    /** HTML 3.0 specification for color <font color="#FEECCF">PAPAYAWHIP</font>. */
    public final static String PAPAYAWHIP = "#FEECCF";
    /** HTML 3.0 specification for color <font color="#FCD5B0">PEACHPUFF</font>. */
    public final static String PEACHPUFF = "#FCD5B0";
    /** HTML 3.0 specification for color <font color="#C57726">PERU</font>. */
    public final static String PERU = "#C57726";
    /** HTML 3.0 specification for color <font color="#FAAFBE">PINK</font>. */
    public final static String PINK = "#FAAFBE";
    /** HTML 3.0 specification for color <font color="#B93B8F">PLUM</font>. */
    public final static String PLUM = "#B93B8F";
    /** HTML 3.0 specification for color <font color="#ADDCE3">POWDERBLUE</font>. */
    public final static String POWDERBLUE = "#ADDCE3";
    /** HTML 3.0 specification for color <font color="#B38481">ROSYBROWN</font>. */
    public final static String ROSYBROWN = "#B38481";
    /** HTML 3.0 specification for color <font color="#2B60DE">ROYALBLUE</font>. */
    public final static String ROYALBLUE = "#2B60DE";
    /** HTML 3.0 specification for color <font color="#F63526">SADDLEBROWN</font>.
     *  BROWN2 couldn't find SADDLEBROWN */
    public final static String SADDLEBROWN = "#F63526";
    /** HTML 3.0 specification for color <font color="#F88158">SALMON</font>. */
    public final static String SALMON = "#F88158";
    /** HTML 3.0 specification for color <font color="#EE9A4D">SANDYBROWN</font>. */
    public final static String SANDYBROWN = "#EE9A4D";
    /** HTML 3.0 specification for color <font color="#4E8975">SEAGREEN</font>. */
    public final static String SEAGREEN = "#4E8975";
    /** HTML 3.0 specification for color <font color="#FEF3EB">SEASHELL</font>. */
    public final static String SEASHELL = "#FEF3EB";
    /** HTML 3.0 specification for color <font color="#8A4117">SIENNA</font>. */
    public final static String SIENNA = "#8A4117";
    /** HTML 3.0 specification for color <font color="#6698FF">SKYBLUE</font>. */
    public final static String SKYBLUE = "#6698FF";
    /** HTML 3.0 specification for color <font color="#737CA1">SLATEBLUE</font>. */
    public final static String SLATEBLUE = "#737CA1";
    /** HTML 3.0 specification for color <font color="#657383">SLATEGRAY</font>. */
    public final static String SLATEGRAY = "#657383";
    /** HTML 3.0 specification for color <font color="#FFF9FA">SNOW</font>. */
    public final static String SNOW = "#FFF9FA";
    /** HTML 3.0 specification for color <font color="#4AA02C">SPRINGGREEN</font>. */
    public final static String SPRINGGREEN = "#4AA02C";
    /** HTML 3.0 specification for color <font color="#4863A0">STEELBLUE</font>. */
    public final static String STEELBLUE = "#4863A0";
    /** HTML 3.0 specification for color <font color="#D8AF79">TAN</font>. */
    public final static String TAN = "#D8AF79";
    /** HTML 3.0 specification for color <font color="#D2B9D3">THISTLE</font>. */
    public final static String THISTLE = "#D2B9D3";
    /** HTML 3.0 specification for color <font color="#F75431">TOMATO</font>. */
    public final static String TOMATO = "#F75431";
    /** HTML 3.0 specification for color <font color="#43C6DB">TURQUOISE</font>. */
    public final static String TURQUOISE = "#43C6DB";
    /** HTML 3.0 specification for color <font color="#8D38C9">VIOLET</font>. */
    public final static String VIOLET = "#8D38C9";
    /** HTML 3.0 specification for color <font color="#F3DAA9">WHEAT</font>. */
    public final static String WHEAT = "#F3DAA9";
    /** HTML 3.0 specification for color WHITESMOKE (not shown).
     *  WHITE couldn't find WHITESMOKE */
    public final static String WHITESMOKE = "#FFFFFF";
    /** HTML 3.0 specification for color <font color="#52D017"></font>. */
    public final static String YELLOWGREEN = "#52D017";

    // lowercase for compatibility colors HTML 4.0

    /** Lowercase for compatibility.
     *  @see #BLACK */
    public final static String black = BLACK;
    /** Lowercase for compatibility.
     *  @see #SILVER */
    public final static String silver = SILVER;
    /** Lowercase for compatibility.
     *  @see #GRAY */
    public final static String gray = GRAY;
    /** Lowercase for compatibility.
     *  @see #WHITE */
    public final static String white = WHITE;
    /** Lowercase for compatibility.
     *  @see #MAROON */
    public final static String maroon = MAROON;
    /** Lowercase for compatibility.
     *  @see #RED */
    public final static String red = RED;
    /** Lowercase for compatibility.
     *  @see #PURPLE */
    public final static String purple = PURPLE;
    /** Lowercase for compatibility.
     *  @see #FUCHSIA */
    public final static String fuchsia = FUCHSIA;
    /** Lowercase for compatibility.
     *  @see #GREEN */
    public final static String green = GREEN;
    /** Lowercase for compatibility.
     *  @see #LIME */
    public final static String lime = LIME;
    /** Lowercase for compatibility.
     *  @see #OLIVE */
    public final static String olive = OLIVE;
    /** Lowercase for compatibility.
     *  @see #YELLOW */
    public final static String yellow = YELLOW;
    /** Lowercase for compatibility.
     *  @see #NAVY */
    public final static String navy = NAVY;
    /** Lowercase for compatibility.
     *  @see #BLUE */
    public final static String blue = BLUE;
    /** Lowercase for compatibility.
     *  @see #TEAL */
    public final static String teal = TEAL;
    /** Lowercase for compatibility.
     *  @see #AQUA */
    public final static String aqua = AQUA;

    // lowercase for compatibility colors html 3.0

    /** Lowercase for compatibility.
     *  @see #ALICEBLUE */
    public final static String aliceblue = ALICEBLUE;
    /** Lowercase for compatibility.
     *  @see #ANTIQUEWHITE */
    public final static String antiquewhite = ANTIQUEWHITE;
    /** Lowercase for compatibility.
     *  @see #AQUAMARINE */
    public final static String aquamarine = AQUAMARINE;
    /** Lowercase for compatibility.
     *  @see #AZURE */
    public final static String azure = AZURE;
    /** Lowercase for compatibility.
     *  @see #BEIGE */
    public final static String beige = BEIGE;
    /** Lowercase for compatibility.
     *  @see #BISQUE */
    public final static String bisque = BISQUE;
    /** Lowercase for compatibility.
     *  @see #BLANCHEDALMOND */
    public final static String blanchedalmond = BLANCHEDALMOND;
    /** Lowercase for compatibility.
     *  @see #BLUEVIOLET */
    public final static String blueviolet = BLUEVIOLET;
    /** Lowercase for compatibility.
     *  @see #BROWN */
    public final static String brown = BROWN;
    /** Lowercase for compatibility.
     *  @see #BURLYWOOD */
    public final static String burlywood = BURLYWOOD;
    /** Lowercase for compatibility.
     *  @see #CADETBLUE */
    public final static String cadetblue = CADETBLUE;
    /** Lowercase for compatibility.
     *  @see #CHARTREUSE */
    public final static String chartreuse = CHARTREUSE;
    /** Lowercase for compatibility.
     *  @see #CHOCOLATE */
    public final static String chocolate = CHOCOLATE;
    /** Lowercase for compatibility.
     *  @see #CORAL */
    public final static String coral = CORAL;
    /** Lowercase for compatibility.
     *  @see #CORNFLOWERBLUE */
    public final static String cornfolowerblue = CORNFLOWERBLUE;
    /** Lowercase for compatibility.
     *  @see #CORNSILK */
    public final static String cornsilk = CORNSILK;
    /** Lowercase for compatibility.
     *  @see #CRIMSON */
    public final static String crimson = CRIMSON;
    /** Lowercase for compatibility.
     *  @see #CYAN */
    public final static String cyan = CYAN;
    /** Lowercase for compatibility.
     *  @see #DARKBLUE */
    public final static String darkblue = DARKBLUE;
    /** Lowercase for compatibility.
     *  @see #DARKCYAN */
    public final static String darkcyan = DARKCYAN;
    /** Lowercase for compatibility.
     *  @see #DARKGOLDENROD */
    public final static String darkgoldenrod = DARKGOLDENROD;
    /** Lowercase for compatibility.
     *  @see #DARKGRAY */
    public final static String darkgray = DARKGRAY;
    /** Lowercase for compatibility.
     *  @see #DARKGREEN */
    public final static String darkgreen = DARKGREEN;
    /** Lowercase for compatibility.
     *  @see #DARKKHAKI */
    public final static String darkkahki = DARKKHAKI;
    /** Lowercase for compatibility.
     *  @see #DARKMAGENTA */
    public final static String darkmagenta = DARKMAGENTA;
    /** Lowercase for compatibility.
     *  @see #DARKOLIVEGREEN */
    public final static String darkolivegreen = DARKOLIVEGREEN;
    /** Lowercase for compatibility.
     *  @see #DARKORANGE */
    public final static String darkorange = DARKORANGE;
    /** Lowercase for compatibility.
     *  @see #DARKORCHID */
    public final static String darkorchid = DARKORCHID;
    /** Lowercase for compatibility.
     *  @see #DARKRED */
    public final static String darkred = DARKRED;
    /** Lowercase for compatibility.
     *  @see #DARKSALMON */
    public final static String darksalmon = DARKSALMON;
    /** Lowercase for compatibility.
     *  @see #DARKSEAGREEN */
    public final static String darkseagreen = DARKSEAGREEN;
    /** Lowercase for compatibility.
     *  @see #DARKSLATEBLUE */
    public final static String darkslateblue = DARKSLATEBLUE;
    /** Lowercase for compatibility.
     *  @see #DARKSLATEGRAY */
    public final static String darkslategray = DARKSLATEGRAY;
    /** Lowercase for compatibility.
     *  @see #DARKTURQUOISE */
    public final static String darkturquoise = DARKTURQUOISE;
    /** Lowercase for compatibility.
     *  @see #DARKVIOLET */
    public final static String darkviolet = DARKVIOLET;
    /** Lowercase for compatibility.
     *  @see #DEEPPINK */
    public final static String deeppink = DEEPPINK;
    /** Lowercase for compatibility.
     *  @see #DEEPSKYBLUE */
    public final static String deepskyblue = DEEPSKYBLUE;
    /** Lowercase for compatibility.
     *  @see #DIMGRAY */
    public final static String dimgray = DIMGRAY;
    /** Lowercase for compatibility.
     *  @see #DODGERBLUE */
    public final static String dodgerblue = DODGERBLUE;
    /** Lowercase for compatibility.
     *  @see #FIREBRICK */
    public final static String firebrick = FIREBRICK;
    /** Lowercase for compatibility.
     *  @see #FLORALWHITE */
    public final static String floralwhite = FLORALWHITE;
    /** Lowercase for compatibility.
     *  @see #FORESTGREEN */
    public final static String forestgreen = FORESTGREEN;
    /** Lowercase for compatibility.
     *  @see #GAINSBORO */
    public final static String gainsboro = GAINSBORO;
    /** Lowercase for compatibility.
     *  @see #GHOSTWHITE */
    public final static String ghostwhite = GHOSTWHITE;
    /** Lowercase for compatibility.
     *  @see #GOLD */
    public final static String gold = GOLD;
    /** Lowercase for compatibility.
     *  @see #GOLDENROD */
    public final static String goldenrod = GOLDENROD;
    /** Lowercase for compatibility.
     *  @see #GREENYELLOW */
    public final static String greenyellow = GREENYELLOW;
    /** Lowercase for compatibility.
     *  @see #HONEYDEW */
    public final static String honeydew = HONEYDEW;
    /** Lowercase for compatibility.
     *  @see #INDIANRED */
    public final static String indianred = INDIANRED;
    /** Lowercase for compatibility.
     *  @see #INDIGO */
    public final static String indigo = INDIGO;
    /** Lowercase for compatibility.
     *  @see #IVORY */
    public final static String ivory = IVORY;
    /** Lowercase for compatibility.
     *  @see #KHAKI */
    public final static String khaki = KHAKI;
    /** Lowercase for compatibility.
     *  @see #LAVENDER */
    public final static String lavender = LAVENDER;
    /** Lowercase for compatibility.
     *  @see #LAVENDERBLUSH */
    public final static String lavenderblush = LAVENDERBLUSH;
    /** Lowercase for compatibility.
     *  @see #LAWNGREEN */
    public final static String lawngreen = LAWNGREEN;
    /** Lowercase for compatibility.
     *  @see #LEMONCHIFFON */
    public final static String lemmonchiffon = LEMONCHIFFON;
    /** Lowercase for compatibility.
     *  @see #LIGHTBLUE */
    public final static String lightblue = LIGHTBLUE;
    /** Lowercase for compatibility.
     *  @see #LIGHTCORAL */
    public final static String lightcoral = LIGHTCORAL;
    /** Lowercase for compatibility.
     *  @see #LIGHTCYAN */
    public final static String lightcyan = LIGHTCYAN;
    /** Lowercase for compatibility.
     *  @see #LIGHTGOLDENRODYELLOW */
    public final static String lightgoldenrodyellow = LIGHTGOLDENRODYELLOW;
    /** Lowercase for compatibility.
     *  @see #LIGHTGREEN */
    public final static String lightgreen = LIGHTGREEN;
    /** Lowercase for compatibility.
     *  @see #LIGHTPINK */
    public final static String lightpink = LIGHTPINK;
    /** Lowercase for compatibility.
     *  @see #LIGHTSALMON */
    public final static String lightsalmon = LIGHTSALMON;
    /** Lowercase for compatibility.
     *  @see #LIGHTSEAGREEN */
    public final static String lightseagreen = LIGHTSEAGREEN;
    /** Lowercase for compatibility.
     *  @see #LIGHTSKYBLUE */
    public final static String lightskyblue = LIGHTSKYBLUE;
    /** Lowercase for compatibility.
     *  @see #LIGHTSLATEGRAY */
    public final static String lightslategray = LIGHTSLATEGRAY;
    /** Lowercase for compatibility.
     *  @see #LIGHTSTEELBLUE */
    public final static String lightsteelblue = LIGHTSTEELBLUE;
    /** Lowercase for compatibility.
     *  @see #LIGHTYELLOW */
    public final static String lightyellow = LIGHTYELLOW;
    /** Lowercase for compatibility.
     *  @see #LIMEGREEN */
    public final static String limegreen = LIMEGREEN;
    /** Lowercase for compatibility.
     *  @see #LINEN */
    public final static String linen = LINEN;
    /** Lowercase for compatibility.
     *  @see #MAGENTA */
    public final static String magenta = MAGENTA;
    /** Lowercase for compatibility.
     *  @see #MEDIUMAQUAMARINE */
    public final static String mediumaquamarine = MEDIUMAQUAMARINE;
    /** Lowercase for compatibility.
     *  @see #MEDIUMBLUE */
    public final static String mediumblue = MEDIUMBLUE;
    /** Lowercase for compatibility.
     *  @see #MEDIUMORCHID */
    public final static String mediumorchid = MEDIUMORCHID;
    /** Lowercase for compatibility.
     *  @see #MEDIUMPURPLE */
    public final static String mediumpurple = MEDIUMPURPLE;
    /** Lowercase for compatibility.
     *  @see #MEDIUMSEAGREEN */
    public final static String mediumseagreen = MEDIUMSEAGREEN;
    /** Lowercase for compatibility.
     *  @see #MEDIUMSLATEBLUE */
    public final static String mediumslateblue = MEDIUMSLATEBLUE;
    /** Lowercase for compatibility.
     *  @see #MEDIUMSPRINGGREEN */
    public final static String mediumspringgreen = MEDIUMSPRINGGREEN;
    /** Lowercase for compatibility.
     *  @see #MEDIUMTURQUOISE */
    public final static String mediumturquoise = MEDIUMTURQUOISE;
    /** Lowercase for compatibility.
     *  @see #MEDIUMVIOLETRED */
    public final static String mediumvioletred = MEDIUMVIOLETRED;
    /** Lowercase for compatibility.
     *  @see #MIDNIGHTBLUE */
    public final static String midnightblue = MIDNIGHTBLUE;
    /** Lowercase for compatibility.
     *  @see #MINTCREAM */
    public final static String mintcream = MINTCREAM;
    /** Lowercase for compatibility.
     *  @see #MISTYROSE */
    public final static String mistyrose = MISTYROSE;
    /** Lowercase for compatibility.
     *  @see #MOCCASIN */
    public final static String moccasin = MOCCASIN;
    /** Lowercase for compatibility.
     *  @see #NAVAJOWHITE */
    public final static String navajowhite = NAVAJOWHITE;
    /** Lowercase for compatibility.
     *  @see #OLDLACE */
    public final static String oldlace = OLDLACE;
    /** Lowercase for compatibility.
     *  @see #OLIVEDRAB */
    public final static String olivedrab = OLIVEDRAB;
    /** Lowercase for compatibility.
     *  @see #ORANGE */
    public final static String orange = ORANGE;
    /** Lowercase for compatibility.
     *  @see #ORANGERED */
    public final static String orangered = ORANGERED;
    /** Lowercase for compatibility.
     *  @see #ORCHID */
    public final static String orchid = ORCHID;
    /** Lowercase for compatibility.
     *  @see #PALEGOLDENROD */
    public final static String palegoldenrod = PALEGOLDENROD;
    /** Lowercase for compatibility.
     *  @see #PALETURQUOISE */
    public final static String paleturquoise = PALETURQUOISE;
    /** Lowercase for compatibility.
     *  @see #PALEVIOLETRED */
    public final static String palevioletred = PALEVIOLETRED;
    /** Lowercase for compatibility.
     *  @see #PAPAYAWHIP */
    public final static String papayawhip = PAPAYAWHIP;
    /** Lowercase for compatibility.
     *  @see #PEACHPUFF */
    public final static String peachpuff = PEACHPUFF;
    /** Lowercase for compatibility.
     *  @see #PERU */
    public final static String peru = PERU;
    /** Lowercase for compatibility.
     *  @see #PINK */
    public final static String pink = PINK;
    /** Lowercase for compatibility.
     *  @see #PLUM */
    public final static String plum = PLUM;
    /** Lowercase for compatibility.
     *  @see #POWDERBLUE */
    public final static String powderblue = POWDERBLUE;
    /** Lowercase for compatibility.
     *  @see #ROSYBROWN */
    public final static String rosybrown = ROSYBROWN;
    /** Lowercase for compatibility.
     *  @see #ROYALBLUE */
    public final static String royalblue = ROYALBLUE;
    /** Lowercase for compatibility.
     *  @see #SADDLEBROWN */
    public final static String saddlebrown = SADDLEBROWN;
    /** Lowercase for compatibility.
     *  @see #SALMON */
    public final static String salmon = SALMON;
    /** Lowercase for compatibility.
     *  @see #SANDYBROWN */
    public final static String sandybrown = SANDYBROWN;
    /** Lowercase for compatibility.
     *  @see #SEAGREEN */
    public final static String seagreen = SEAGREEN;
    /** Lowercase for compatibility.
     *  @see #SEASHELL */
    public final static String seashell = SEASHELL;
    /** Lowercase for compatibility.
     *  @see #SIENNA */
    public final static String sienna = SIENNA;
    /** Lowercase for compatibility.
     *  @see #SKYBLUE */
    public final static String skyblue = SKYBLUE;
    /** Lowercase for compatibility.
     *  @see #SLATEBLUE */
    public final static String slateblue = SLATEBLUE;
    /** Lowercase for compatibility.
     *  @see #SLATEGRAY */
    public final static String slategray = SLATEGRAY;
    /** Lowercase for compatibility.
     *  @see #SNOW */
    public final static String snow = SNOW;
    /** Lowercase for compatibility.
     *  @see #SPRINGGREEN */
    public final static String springgreen = SPRINGGREEN;
    /** Lowercase for compatibility.
     *  @see #STEELBLUE */
    public final static String steelblue = STEELBLUE;
    /** Lowercase for compatibility.
     *  @see #TAN */
    public final static String tan = TAN;
    /** Lowercase for compatibility.
     *  @see #THISTLE */
    public final static String thistle = THISTLE;
    /** Lowercase for compatibility.
     *  @see #TOMATO */
    public final static String tomato = TOMATO;
    /** Lowercase for compatibility.
     *  @see #TURQUOISE */
    public final static String turquoise = TURQUOISE;
    /** Lowercase for compatibility.
     *  @see #VIOLET */
    public final static String violet = VIOLET;
    /** Lowercase for compatibility.
     *  @see #WHEAT */
    public final static String wheat = WHEAT;
    /** Lowercase for compatibility.
     *  @see #WHITESMOKE */
    public final static String whitesmoke = WHITESMOKE;
    /** Lowercase for compatibility.
     *  @see #YELLOWGREEN */
    public final static String yellowgreen = YELLOWGREEN;
    
    /**
     * 	Convert Color.
     * 	Limited use as it assumes that color is hex string w/o #
        This method will take a string of hex values and 
        append a # to the beginning if it isn't already there.
        @param color the string to convert
	@return the converted string
    */
    public static String convertColor(String color)
    {
    	if (color == null)
    		return BLACK;
    	//	Hex 000000 w/o #
    	if (color.length() != 6)
    		return color;
        if (!color.startsWith("#"))
            return "#" + color;
        return color;
    }

     /**
       This method will take a string matching one of the colors
       defined in this class and return the string value of that
       color.
       @param color the color to get retrieve
       @return the string value of the color, if found, null otherwise
     */
     public static String getColor(String color)
     {
       Object colObject;
       try {
          colObject = Class.forName("org.apache.ecs.HtmlColor")
                 .getField(color)
                 .get(null);
         } catch (Exception e) {
             return null;
         }
         return((String)colObject);
     }
}
