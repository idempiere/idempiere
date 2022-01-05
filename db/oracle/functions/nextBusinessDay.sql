create or replace
function nextBusinessDay
(
	p_Date		in	date,
	p_AD_Client_ID	in	number
)
return date
/**
*This file is part of Adempiere ERP Bazaar
*http://www.adempiere.org
*
*Copyright (C) 2007 Teo Sarca
*
*This program is free software; you can redistribute it and/or
*modify it under the terms of the GNU General Public License
*as published by the Free Software Foundation; either version 2
*of the License, or (at your option) any later version.
*
*This program is distributed in the hope that it will be useful,
*but WITHOUT ANY WARRANTY; without even the implied warranty of
*MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE. See the
*GNU General Public License for more details.
*
*You should have received a copy of the GNU General Public License
*along with this program; if not, write to the Free Software
*Foundation, Inc., 51 Franklin Street, Fifth Floor, Boston, MA 02110-1301, USA.of
*/
as
	v_nextDate		date	:= TRUNC(p_Date);
	v_offset		number	:= 0;
	v_Saturday		number	:= TO_CHAR(TO_DATE('2000-01-01', 'YYYY-MM-DD'), 'D');
	v_Sunday		number	:= (case when v_Saturday = 7 then 1 else v_Saturday + 1 end);
	v_isHoliday		boolean	:= true;
	v_country               c_country.c_country_id%type;
	
	cursor nonBusinessDays(pp_Date date, pp_country c_country.c_country_id%type) is
		select nbd.Date1 from C_NonBusinessDay nbd
		where AD_Client_ID=p_AD_Client_ID and IsActive ='Y' and Date1>=pp_Date
		      AND COALESCE(C_Country_ID,0) IN (0, pp_country)
		order by Date1;
begin
	v_isHoliday := true;
	SELECT COALESCE(MAX(co.c_country_id), 100) 
	INTO   v_country
	FROM   ad_client cl 
	       JOIN ad_language l ON cl.ad_language = l.ad_language 
	       JOIN c_country co ON l.countrycode = co.countrycode 
	WHERE  cl.ad_client_id = p_ad_client_id;
	loop
		SELECT DECODE(TO_CHAR(v_nextDate,'D'), v_Saturday, 2, v_Sunday, 1, 0) INTO v_offset FROM DUAL;
		v_nextDate := TRUNC(v_nextDate + v_offset);
		v_isHoliday := false;
		for nbd in nonBusinessDays(v_nextDate, v_country) loop
			exit when v_nextDate <> TRUNC(nbd.Date1);
			v_nextDate := v_nextDate + 1;
			v_isHoliday := true;
		end loop;
		exit when v_isHoliday=false;
	end loop;
	--
	return v_nextDate;
end nextBusinessDay;
/
