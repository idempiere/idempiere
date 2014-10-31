SET SQLBLANKLINES ON
SET DEFINE OFF

-- Dec 6, 2013 10:44:52 AM CET
-- IDEMPIERE-1588 Add country on non business days table
INSERT INTO AD_Column (AD_Client_ID,AD_Column_ID,AD_Column_UU,AD_Element_ID,AD_Org_ID,AD_Reference_ID,AD_Table_ID,ColumnName,Created,CreatedBy,Description,EntityType,FieldLength,Help,IsActive,IsAllowCopy,IsAllowLogging,IsAlwaysUpdateable,IsAutocomplete,IsEncrypted,IsIdentifier,IsKey,IsMandatory,IsParent,IsSecure,IsSelectionColumn,IsSyncDatabase,IsToolbarButton,IsTranslated,IsUpdateable,Name,SeqNo,SeqNoSelection,Updated,UpdatedBy,Version) VALUES (0,210893,'b69998b5-9865-43c7-8518-2e50e8bb3bf8',192,0,19,163,'C_Country_ID',TO_DATE('2013-12-06 10:44:51','YYYY-MM-DD HH24:MI:SS'),100,'Country ','D',22,'The Country defines a Country.  Each Country must be defined before it can be used in any document.','Y','Y','Y','N','N','N','N','N','N','N','N','N','N','N','N','Y','Country',0,0,TO_DATE('2013-12-06 10:44:51','YYYY-MM-DD HH24:MI:SS'),100,0)
;

-- Dec 6, 2013 10:45:01 AM CET
UPDATE AD_Column SET FKConstraintName='CCountry_CNonBusinessDay', FKConstraintType='N',Updated=TO_DATE('2013-12-06 10:45:01','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Column_ID=210893
;

-- Dec 6, 2013 10:45:01 AM CET
ALTER TABLE C_NonBusinessDay ADD C_Country_ID NUMBER(10) DEFAULT NULL 
;

-- Dec 6, 2013 10:45:02 AM CET
ALTER TABLE C_NonBusinessDay ADD CONSTRAINT CCountry_CNonBusinessDay FOREIGN KEY (C_Country_ID) REFERENCES C_COUNTRY(C_COUNTRY_ID) DEFERRABLE INITIALLY DEFERRED
;

-- Dec 6, 2013 10:45:37 AM CET
INSERT INTO AD_Field (AD_Client_ID,AD_Column_ID,AD_Field_ID,AD_Field_UU,AD_Org_ID,AD_Tab_ID,ColumnSpan,Created,CreatedBy,DisplayLength,EntityType,IsActive,IsCentrallyMaintained,IsDisplayed,IsDisplayedGrid,IsEncrypted,IsFieldOnly,IsHeading,IsReadOnly,IsSameLine,Name,SeqNo,Updated,UpdatedBy) VALUES (0,60714,202542,'39156bc8-6f18-437d-b2de-2b4af618dc16',0,131,2,TO_DATE('2013-12-06 10:45:36','YYYY-MM-DD HH24:MI:SS'),100,36,'D','Y','Y','N','N','N','N','N','N','N','C_NonBusinessDay_UU',80,TO_DATE('2013-12-06 10:45:36','YYYY-MM-DD HH24:MI:SS'),100)
;

-- Dec 6, 2013 10:45:37 AM CET
INSERT INTO AD_Field (AD_Client_ID,AD_Column_ID,AD_Field_ID,AD_Field_UU,AD_Org_ID,AD_Tab_ID,ColumnSpan,Created,CreatedBy,Description,DisplayLength,EntityType,Help,IsActive,IsCentrallyMaintained,IsDisplayed,IsEncrypted,IsFieldOnly,IsHeading,IsReadOnly,IsSameLine,Name,SeqNo,Updated,UpdatedBy) VALUES (0,210893,202543,'142b8efa-23e4-4329-8091-97ee83964d46',0,131,2,TO_DATE('2013-12-06 10:45:37','YYYY-MM-DD HH24:MI:SS'),100,'Country ',22,'D','The Country defines a Country.  Each Country must be defined before it can be used in any document.','Y','Y','Y','N','N','N','N','N','Country',90,TO_DATE('2013-12-06 10:45:37','YYYY-MM-DD HH24:MI:SS'),100)
;

-- Dec 6, 2013 10:45:51 AM CET
UPDATE AD_Field SET SeqNo=10,Updated=TO_DATE('2013-12-06 10:45:51','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=486
;

-- Dec 6, 2013 10:45:51 AM CET
UPDATE AD_Field SET SeqNo=20,Updated=TO_DATE('2013-12-06 10:45:51','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=2013
;

-- Dec 6, 2013 10:45:51 AM CET
UPDATE AD_Field SET SeqNo=30,Updated=TO_DATE('2013-12-06 10:45:51','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=490
;

-- Dec 6, 2013 10:45:51 AM CET
UPDATE AD_Field SET SeqNo=40,Updated=TO_DATE('2013-12-06 10:45:51','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=488
;

-- Dec 6, 2013 10:45:51 AM CET
UPDATE AD_Field SET SeqNo=50,Updated=TO_DATE('2013-12-06 10:45:51','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=489
;

-- Dec 6, 2013 10:45:51 AM CET
UPDATE AD_Field SET SeqNo=60,Updated=TO_DATE('2013-12-06 10:45:51','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=1552
;

-- Dec 6, 2013 10:45:51 AM CET
UPDATE AD_Field SET SeqNo=70,Updated=TO_DATE('2013-12-06 10:45:51','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=202543
;

-- Dec 6, 2013 10:45:51 AM CET
UPDATE AD_Field SET SeqNo=0,Updated=TO_DATE('2013-12-06 10:45:51','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=202542
;

-- Dec 6, 2013 10:45:51 AM CET
UPDATE AD_Field SET SeqNo=0,Updated=TO_DATE('2013-12-06 10:45:51','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=485
;

-- Dec 6, 2013 10:46:03 AM CET
UPDATE AD_Field SET SeqNoGrid=0,IsDisplayedGrid='N' WHERE AD_Field_ID=485
;

-- Dec 6, 2013 10:46:03 AM CET
UPDATE AD_Field SET SeqNoGrid=10,IsDisplayedGrid='Y' WHERE AD_Field_ID=486
;

-- Dec 6, 2013 10:46:03 AM CET
UPDATE AD_Field SET SeqNoGrid=20,IsDisplayedGrid='Y' WHERE AD_Field_ID=2013
;

-- Dec 6, 2013 10:46:03 AM CET
UPDATE AD_Field SET SeqNoGrid=30,IsDisplayedGrid='Y' WHERE AD_Field_ID=490
;

-- Dec 6, 2013 10:46:03 AM CET
UPDATE AD_Field SET SeqNoGrid=40,IsDisplayedGrid='Y' WHERE AD_Field_ID=488
;

-- Dec 6, 2013 10:46:03 AM CET
UPDATE AD_Field SET SeqNoGrid=50,IsDisplayedGrid='Y' WHERE AD_Field_ID=489
;

-- Dec 6, 2013 10:46:03 AM CET
UPDATE AD_Field SET SeqNoGrid=60,IsDisplayedGrid='Y' WHERE AD_Field_ID=1552
;

-- Dec 6, 2013 10:46:03 AM CET
UPDATE AD_Field SET SeqNoGrid=70,IsDisplayedGrid='Y' WHERE AD_Field_ID=202543
;

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

SELECT register_migration_script('201401150958_IDEMPIERE-1588.sql') FROM dual
;
