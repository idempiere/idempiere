-- IDEMPIERE-6349 Add M49 country codes to the C_Country table (FHCA-6138)
SELECT register_migration_script('202412261358_IDEMPIERE-6349.sql') FROM dual;

-- Dec 26, 2024, 1:58:54 PM CET
INSERT INTO AD_Element (AD_Element_ID,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,ColumnName,Name,Description,Help,PrintName,EntityType,AD_Element_UU) VALUES (203979,0,0,'Y',TO_TIMESTAMP('2024-12-26 13:55:26','YYYY-MM-DD HH24:MI:SS'),100,TO_TIMESTAMP('2024-12-26 13:55:26','YYYY-MM-DD HH24:MI:SS'),100,'M49Code','M49 Code','Standard country codes for statistical use (M49) defined by the United Nations','The official list can be found at https://unstats.un.org/unsd/methodology/m49/','M49 Code','D','a11c84ec-a0f5-4b8d-99bf-d5d3cbf01724')
;

-- Dec 26, 2024, 2:06:03 PM CET
INSERT INTO AD_Column (AD_Column_ID,Version,Name,Description,Help,AD_Table_ID,ColumnName,FieldLength,IsKey,IsParent,IsMandatory,IsTranslated,IsIdentifier,SeqNo,IsEncrypted,AD_Reference_ID,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,AD_Element_ID,IsUpdateable,IsSelectionColumn,EntityType,IsSyncDatabase,IsAlwaysUpdateable,IsAutocomplete,IsAllowLogging,AD_Column_UU,IsAllowCopy,SeqNoSelection,IsToolbarButton,IsSecure,IsHtml,IsPartitionKey) VALUES (217012,0,'M49 Code','Standard country codes for statistical use (M49) defined by the United Nations','The official list can be found at https://unstats.un.org/unsd/methodology/m49/',170,'M49Code',3,'N','N','N','N','N',0,'N',10,0,0,'Y',TO_TIMESTAMP('2024-12-26 14:06:03','YYYY-MM-DD HH24:MI:SS'),100,TO_TIMESTAMP('2024-12-26 14:06:03','YYYY-MM-DD HH24:MI:SS'),100,203979,'Y','N','D','N','N','N','Y','ca8f33b4-93c0-4662-a7a2-ac6b35f6962f','Y',0,'N','N','N','N')
;

-- Dec 26, 2024, 2:06:05 PM CET
ALTER TABLE C_Country ADD COLUMN M49Code VARCHAR(3) DEFAULT NULL 
;

-- Dec 26, 2024, 2:09:39 PM CET
UPDATE AD_Element SET Description='Upper-case two-letter alphanumeric ISO Country code according to ISO 3166-1', Help='The official list can be found at https://www.iso.org/obp/ui/#search',Updated=TO_TIMESTAMP('2024-12-26 14:09:39','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Element_ID=244
;

-- Dec 26, 2024, 2:09:39 PM CET
UPDATE AD_Column SET ColumnName='CountryCode', Name='ISO Country Code', Description='Upper-case two-letter alphanumeric ISO Country code according to ISO 3166-1', Help='The official list can be found at https://www.iso.org/obp/ui/#search', Placeholder=NULL WHERE AD_Element_ID=244
;

-- Dec 26, 2024, 2:09:39 PM CET
UPDATE AD_Process_Para SET ColumnName='CountryCode', Name='ISO Country Code', Description='Upper-case two-letter alphanumeric ISO Country code according to ISO 3166-1', Help='The official list can be found at https://www.iso.org/obp/ui/#search', AD_Element_ID=244 WHERE UPPER(ColumnName)='COUNTRYCODE' AND IsCentrallyMaintained='Y' AND AD_Element_ID IS NULL
;

-- Dec 26, 2024, 2:09:39 PM CET
UPDATE AD_Process_Para SET ColumnName='CountryCode', Name='ISO Country Code', Description='Upper-case two-letter alphanumeric ISO Country code according to ISO 3166-1', Help='The official list can be found at https://www.iso.org/obp/ui/#search', Placeholder=NULL WHERE AD_Element_ID=244 AND IsCentrallyMaintained='Y'
;

-- Dec 26, 2024, 2:09:39 PM CET
UPDATE AD_InfoColumn SET ColumnName='CountryCode', Name='ISO Country Code', Description='Upper-case two-letter alphanumeric ISO Country code according to ISO 3166-1', Help='The official list can be found at https://www.iso.org/obp/ui/#search', Placeholder=NULL WHERE AD_Element_ID=244 AND IsCentrallyMaintained='Y'
;

-- Dec 26, 2024, 2:09:39 PM CET
UPDATE AD_Field SET Name='ISO Country Code', Description='Upper-case two-letter alphanumeric ISO Country code according to ISO 3166-1', Help='The official list can be found at https://www.iso.org/obp/ui/#search', Placeholder=NULL WHERE AD_Column_ID IN (SELECT AD_Column_ID FROM AD_Column WHERE AD_Element_ID=244) AND IsCentrallyMaintained='Y'
;

-- Dec 26, 2024, 2:11:36 PM CET
INSERT INTO AD_Element (AD_Element_ID,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,ColumnName,Name,Description,Help,PrintName,EntityType,AD_Element_UU) VALUES (203980,0,0,'Y',TO_TIMESTAMP('2024-12-26 14:09:52','YYYY-MM-DD HH24:MI:SS'),100,TO_TIMESTAMP('2024-12-26 14:09:52','YYYY-MM-DD HH24:MI:SS'),100,'ISOCountryCodeAlpha3','ISO Alpha-3 Code','ISO Alpha-3 country code - a three-letter code that represents a country name, which is usually more closely related to the country name','The official list can be found at https://www.iso.org/obp/ui/#search','ISO Alpha-3 Code','D','6617e5c7-a038-4a91-a42b-f6c6d920de33')
;

-- Dec 26, 2024, 2:11:44 PM CET
INSERT INTO AD_Column (AD_Column_ID,Version,Name,Description,Help,AD_Table_ID,ColumnName,FieldLength,IsKey,IsParent,IsMandatory,IsTranslated,IsIdentifier,SeqNo,IsEncrypted,AD_Reference_ID,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,AD_Element_ID,IsUpdateable,IsSelectionColumn,EntityType,IsSyncDatabase,IsAlwaysUpdateable,IsAutocomplete,IsAllowLogging,AD_Column_UU,IsAllowCopy,SeqNoSelection,IsToolbarButton,IsSecure,IsHtml,IsPartitionKey) VALUES (217013,0,'ISO Alpha-3 Code','ISO Alpha-3 country code - a three-letter code that represents a country name, which is usually more closely related to the country name','The official list can be found at https://www.iso.org/obp/ui/#search',170,'ISOCountryCodeAlpha3',3,'N','N','N','N','N',0,'N',10,0,0,'Y',TO_TIMESTAMP('2024-12-26 14:11:44','YYYY-MM-DD HH24:MI:SS'),100,TO_TIMESTAMP('2024-12-26 14:11:44','YYYY-MM-DD HH24:MI:SS'),100,203980,'Y','N','D','N','N','N','Y','264d0e73-c0b5-4dbb-9173-f8da0a7f5de5','Y',0,'N','N','N','N')
;

-- Dec 26, 2024, 2:11:46 PM CET
ALTER TABLE C_Country ADD COLUMN ISOCountryCodeAlpha3 VARCHAR(3) DEFAULT NULL 
;

-- Dec 26, 2024, 2:12:48 PM CET
INSERT INTO AD_Field (AD_Field_ID,Name,Description,Help,AD_Tab_ID,AD_Column_ID,IsDisplayed,DisplayLength,SeqNo,IsSameLine,IsHeading,IsFieldOnly,IsEncrypted,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,IsReadOnly,IsCentrallyMaintained,EntityType,AD_Field_UU,IsDisplayedGrid,SeqNoGrid,ColumnSpan) VALUES (208679,'M49 Code','Standard country codes for statistical use (M49) defined by the United Nations','The official list can be found at https://unstats.un.org/unsd/methodology/m49/',135,217012,'Y',3,380,'N','N','N','N',0,0,'Y',TO_TIMESTAMP('2024-12-26 14:12:48','YYYY-MM-DD HH24:MI:SS'),100,TO_TIMESTAMP('2024-12-26 14:12:48','YYYY-MM-DD HH24:MI:SS'),100,'N','Y','D','46a1cdf3-692c-4138-aae8-dbdd82c698f3','Y',380,2)
;

-- Dec 26, 2024, 2:12:48 PM CET
INSERT INTO AD_Field (AD_Field_ID,Name,Description,Help,AD_Tab_ID,AD_Column_ID,IsDisplayed,DisplayLength,SeqNo,IsSameLine,IsHeading,IsFieldOnly,IsEncrypted,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,IsReadOnly,IsCentrallyMaintained,EntityType,AD_Field_UU,IsDisplayedGrid,SeqNoGrid,ColumnSpan) VALUES (208680,'ISO Alpha-3 Code','ISO Alpha-3 country code - a three-letter code that represents a country name, which is usually more closely related to the country name','The official list can be found at https://www.iso.org/obp/ui/#search',135,217013,'Y',3,390,'N','N','N','N',0,0,'Y',TO_TIMESTAMP('2024-12-26 14:12:48','YYYY-MM-DD HH24:MI:SS'),100,TO_TIMESTAMP('2024-12-26 14:12:48','YYYY-MM-DD HH24:MI:SS'),100,'N','Y','D','fcb7db1c-120b-4a5a-a315-44ad8a7f0b40','Y',390,2)
;

-- Dec 26, 2024, 2:15:42 PM CET
UPDATE AD_Field SET IsDisplayed='Y', SeqNo=40, XPosition=4,Updated=TO_TIMESTAMP('2024-12-26 14:15:42','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=208680
;

-- Dec 26, 2024, 2:15:42 PM CET
UPDATE AD_Field SET SeqNo=50,Updated=TO_TIMESTAMP('2024-12-26 14:15:42','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=339
;

-- Dec 26, 2024, 2:15:42 PM CET
UPDATE AD_Field SET SeqNo=60,Updated=TO_TIMESTAMP('2024-12-26 14:15:42','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=340
;

-- Dec 26, 2024, 2:15:42 PM CET
UPDATE AD_Field SET IsDisplayed='Y', SeqNo=70, XPosition=1,Updated=TO_TIMESTAMP('2024-12-26 14:15:42','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=208679
;

-- Dec 26, 2024, 2:15:42 PM CET
UPDATE AD_Field SET IsDisplayed='Y', SeqNo=80, XPosition=5,Updated=TO_TIMESTAMP('2024-12-26 14:15:42','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=57035
;

-- Dec 26, 2024, 2:15:42 PM CET
UPDATE AD_Field SET SeqNo=90,Updated=TO_TIMESTAMP('2024-12-26 14:15:42','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=342
;

-- Dec 26, 2024, 2:15:42 PM CET
UPDATE AD_Field SET SeqNo=100,Updated=TO_TIMESTAMP('2024-12-26 14:15:42','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=343
;

-- Dec 26, 2024, 2:15:42 PM CET
UPDATE AD_Field SET SeqNo=110,Updated=TO_TIMESTAMP('2024-12-26 14:15:42','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=345
;

-- Dec 26, 2024, 2:15:42 PM CET
UPDATE AD_Field SET SeqNo=120,Updated=TO_TIMESTAMP('2024-12-26 14:15:42','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=10893
;

-- Dec 26, 2024, 2:15:42 PM CET
UPDATE AD_Field SET SeqNo=130,Updated=TO_TIMESTAMP('2024-12-26 14:15:42','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=57036
;

-- Dec 26, 2024, 2:15:42 PM CET
UPDATE AD_Field SET SeqNo=140,Updated=TO_TIMESTAMP('2024-12-26 14:15:42','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=10892
;

-- Dec 26, 2024, 2:15:42 PM CET
UPDATE AD_Field SET SeqNo=150,Updated=TO_TIMESTAMP('2024-12-26 14:15:42','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=10891
;

-- Dec 26, 2024, 2:15:42 PM CET
UPDATE AD_Field SET SeqNo=160,Updated=TO_TIMESTAMP('2024-12-26 14:15:42','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=346
;

-- Dec 26, 2024, 2:15:42 PM CET
UPDATE AD_Field SET SeqNo=170,Updated=TO_TIMESTAMP('2024-12-26 14:15:42','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=347
;

-- Dec 26, 2024, 2:15:42 PM CET
UPDATE AD_Field SET SeqNo=180,Updated=TO_TIMESTAMP('2024-12-26 14:15:42','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=348
;

-- Dec 26, 2024, 2:15:42 PM CET
UPDATE AD_Field SET SeqNo=190,Updated=TO_TIMESTAMP('2024-12-26 14:15:42','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=344
;

-- Dec 26, 2024, 2:15:42 PM CET
UPDATE AD_Field SET SeqNo=200,Updated=TO_TIMESTAMP('2024-12-26 14:15:42','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=11184
;

-- Dec 26, 2024, 2:15:42 PM CET
UPDATE AD_Field SET SeqNo=210,Updated=TO_TIMESTAMP('2024-12-26 14:15:42','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=10895
;

-- Dec 26, 2024, 2:15:42 PM CET
UPDATE AD_Field SET SeqNo=220,Updated=TO_TIMESTAMP('2024-12-26 14:15:42','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=10894
;

-- Dec 26, 2024, 2:15:42 PM CET
UPDATE AD_Field SET SeqNo=230,Updated=TO_TIMESTAMP('2024-12-26 14:15:42','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=5753
;

-- Dec 26, 2024, 2:15:42 PM CET
UPDATE AD_Field SET SeqNo=240,Updated=TO_TIMESTAMP('2024-12-26 14:15:42','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=5752
;

-- Dec 26, 2024, 2:15:42 PM CET
UPDATE AD_Field SET SeqNo=250,Updated=TO_TIMESTAMP('2024-12-26 14:15:42','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=51000
;

-- Dec 26, 2024, 2:15:42 PM CET
UPDATE AD_Field SET IsDisplayed='Y', SeqNo=260, XPosition=5,Updated=TO_TIMESTAMP('2024-12-26 14:15:42','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=341
;

-- Dec 26, 2024, 2:15:42 PM CET
UPDATE AD_Field SET SeqNo=270,Updated=TO_TIMESTAMP('2024-12-26 14:15:42','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=51003
;

-- Dec 26, 2024, 2:15:42 PM CET
UPDATE AD_Field SET SeqNo=280,Updated=TO_TIMESTAMP('2024-12-26 14:15:42','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=51002
;

-- Dec 26, 2024, 2:15:42 PM CET
UPDATE AD_Field SET SeqNo=290,Updated=TO_TIMESTAMP('2024-12-26 14:15:42','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=51004
;

-- Dec 26, 2024, 2:15:42 PM CET
UPDATE AD_Field SET SeqNo=300,Updated=TO_TIMESTAMP('2024-12-26 14:15:42','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=51001
;

-- Dec 26, 2024, 2:15:42 PM CET
UPDATE AD_Field SET SeqNo=310,Updated=TO_TIMESTAMP('2024-12-26 14:15:42','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=205316
;

-- Dec 26, 2024, 2:15:42 PM CET
UPDATE AD_Field SET SeqNo=320,Updated=TO_TIMESTAMP('2024-12-26 14:15:42','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=205317
;

-- Dec 26, 2024, 2:15:42 PM CET
UPDATE AD_Field SET SeqNo=330,Updated=TO_TIMESTAMP('2024-12-26 14:15:42','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=205318
;

-- Dec 26, 2024, 2:15:42 PM CET
UPDATE AD_Field SET SeqNo=340,Updated=TO_TIMESTAMP('2024-12-26 14:15:42','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=205319
;

-- Dec 26, 2024, 2:15:42 PM CET
UPDATE AD_Field SET SeqNo=350,Updated=TO_TIMESTAMP('2024-12-26 14:15:42','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=205320
;

-- Dec 26, 2024, 2:15:42 PM CET
UPDATE AD_Field SET SeqNo=360,Updated=TO_TIMESTAMP('2024-12-26 14:15:42','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=205323
;

-- Dec 26, 2024, 2:15:42 PM CET
UPDATE AD_Field SET SeqNo=370,Updated=TO_TIMESTAMP('2024-12-26 14:15:42','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=205324
;

-- Dec 26, 2024, 2:15:42 PM CET
UPDATE AD_Field SET SeqNo=380,Updated=TO_TIMESTAMP('2024-12-26 14:15:42','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=205321
;

-- Dec 26, 2024, 2:15:42 PM CET
UPDATE AD_Field SET SeqNo=390,Updated=TO_TIMESTAMP('2024-12-26 14:15:42','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=205322
;

UPDATE C_Country SET M49Code='004', ISOCountryCodeAlpha3='AFG' WHERE C_Country_ID=110 /* Afghanistan */;

UPDATE C_Country SET M49Code='248', ISOCountryCodeAlpha3='ALA' WHERE C_Country_ID=50000 /* Åland Islands */;

UPDATE C_Country SET M49Code='008', ISOCountryCodeAlpha3='ALB' WHERE C_Country_ID=111 /* Albania */;

UPDATE C_Country SET M49Code='012', ISOCountryCodeAlpha3='DZA' WHERE C_Country_ID=112 /* Algeria */;

UPDATE C_Country SET M49Code='016', ISOCountryCodeAlpha3='ASM' WHERE C_Country_ID=113 /* American Samoa */;

UPDATE C_Country SET M49Code='020', ISOCountryCodeAlpha3='AND' WHERE C_Country_ID=114 /* Andorra */;

UPDATE C_Country SET M49Code='024', ISOCountryCodeAlpha3='AGO' WHERE C_Country_ID=115 /* Angola */;

UPDATE C_Country SET M49Code='660', ISOCountryCodeAlpha3='AIA' WHERE C_Country_ID=116 /* Anguilla */;

UPDATE C_Country SET M49Code='010', ISOCountryCodeAlpha3='ATA' WHERE C_Country_ID=117 /* Antarctica */;

UPDATE C_Country SET M49Code='028', ISOCountryCodeAlpha3='ATG' WHERE C_Country_ID=118 /* Antigua and Barbuda */;

UPDATE C_Country SET M49Code='032', ISOCountryCodeAlpha3='ARG' WHERE C_Country_ID=119 /* Argentina */;

UPDATE C_Country SET M49Code='051', ISOCountryCodeAlpha3='ARM' WHERE C_Country_ID=120 /* Armenia */;

UPDATE C_Country SET M49Code='533', ISOCountryCodeAlpha3='ABW' WHERE C_Country_ID=121 /* Aruba */;

UPDATE C_Country SET M49Code='036', ISOCountryCodeAlpha3='AUS' WHERE C_Country_ID=122 /* Australia */;

UPDATE C_Country SET M49Code='040', ISOCountryCodeAlpha3='AUT' WHERE C_Country_ID=108 /* Austria */;

UPDATE C_Country SET M49Code='031', ISOCountryCodeAlpha3='AZE' WHERE C_Country_ID=124 /* Azerbaijan */;

UPDATE C_Country SET M49Code='044', ISOCountryCodeAlpha3='BHS' WHERE C_Country_ID=125 /* Bahamas */;

UPDATE C_Country SET M49Code='048', ISOCountryCodeAlpha3='BHR' WHERE C_Country_ID=126 /* Bahrain */;

UPDATE C_Country SET M49Code='050', ISOCountryCodeAlpha3='BGD' WHERE C_Country_ID=127 /* Bangladesh */;

UPDATE C_Country SET M49Code='052', ISOCountryCodeAlpha3='BRB' WHERE C_Country_ID=128 /* Barbados */;

UPDATE C_Country SET M49Code='112', ISOCountryCodeAlpha3='BLR' WHERE C_Country_ID=129 /* Belarus */;

UPDATE C_Country SET M49Code='056', ISOCountryCodeAlpha3='BEL' WHERE C_Country_ID=103 /* Belgium */;

UPDATE C_Country SET M49Code='084', ISOCountryCodeAlpha3='BLZ' WHERE C_Country_ID=131 /* Belize */;

UPDATE C_Country SET M49Code='204', ISOCountryCodeAlpha3='BEN' WHERE C_Country_ID=132 /* Benin */;

UPDATE C_Country SET M49Code='060', ISOCountryCodeAlpha3='BMU' WHERE C_Country_ID=133 /* Bermuda */;

UPDATE C_Country SET M49Code='064', ISOCountryCodeAlpha3='BTN' WHERE C_Country_ID=134 /* Bhutan */;

UPDATE C_Country SET M49Code='068', ISOCountryCodeAlpha3='BOL' WHERE C_Country_ID=135 /* Bolivia */;

UPDATE C_Country SET M49Code='535', ISOCountryCodeAlpha3='BES' WHERE C_Country_ID=200002 /* Bonaire, Sint Eustatius and Saba */;

UPDATE C_Country SET M49Code='070', ISOCountryCodeAlpha3='BIH' WHERE C_Country_ID=136 /* Bosnia and Herzegovina */;

UPDATE C_Country SET M49Code='072', ISOCountryCodeAlpha3='BWA' WHERE C_Country_ID=137 /* Botswana */;

UPDATE C_Country SET M49Code='074', ISOCountryCodeAlpha3='BVT' WHERE C_Country_ID=138 /* Bouvet Island */;

UPDATE C_Country SET M49Code='076', ISOCountryCodeAlpha3='BRA' WHERE C_Country_ID=139 /* Brazil */;

UPDATE C_Country SET M49Code='086', ISOCountryCodeAlpha3='IOT' WHERE C_Country_ID=140 /* British Indian Ocean Territory */;

UPDATE C_Country SET M49Code='096', ISOCountryCodeAlpha3='BRN' WHERE C_Country_ID=141 /* Brunei Darussalam */;

UPDATE C_Country SET M49Code='100', ISOCountryCodeAlpha3='BGR' WHERE C_Country_ID=142 /* Bulgaria */;

UPDATE C_Country SET M49Code='854', ISOCountryCodeAlpha3='BFA' WHERE C_Country_ID=143 /* Burkina Faso */;

UPDATE C_Country SET M49Code='108', ISOCountryCodeAlpha3='BDI' WHERE C_Country_ID=144 /* Burundi */;

UPDATE C_Country SET M49Code='116', ISOCountryCodeAlpha3='KHM' WHERE C_Country_ID=145 /* Cambodia */;

UPDATE C_Country SET M49Code='120', ISOCountryCodeAlpha3='CMR' WHERE C_Country_ID=146 /* Cameroon */;

UPDATE C_Country SET M49Code='124', ISOCountryCodeAlpha3='CAN' WHERE C_Country_ID=109 /* Canada */;

UPDATE C_Country SET M49Code='132', ISOCountryCodeAlpha3='CPV' WHERE C_Country_ID=148 /* Cape Verde */;

UPDATE C_Country SET M49Code='136', ISOCountryCodeAlpha3='CYM' WHERE C_Country_ID=149 /* Cayman Islands */;

UPDATE C_Country SET M49Code='140', ISOCountryCodeAlpha3='CAF' WHERE C_Country_ID=150 /* Central African Republic */;

UPDATE C_Country SET M49Code='148', ISOCountryCodeAlpha3='TCD' WHERE C_Country_ID=151 /* Chad */;

UPDATE C_Country SET M49Code='152', ISOCountryCodeAlpha3='CHL' WHERE C_Country_ID=152 /* Chile */;

UPDATE C_Country SET M49Code='156', ISOCountryCodeAlpha3='CHN' WHERE C_Country_ID=153 /* China */;

UPDATE C_Country SET M49Code='162', ISOCountryCodeAlpha3='CXR' WHERE C_Country_ID=154 /* Christmas Island */;

UPDATE C_Country SET M49Code='166', ISOCountryCodeAlpha3='CCK' WHERE C_Country_ID=155 /* Cocos (Keeling) Islands */;

UPDATE C_Country SET M49Code='170', ISOCountryCodeAlpha3='COL' WHERE C_Country_ID=156 /* Colombia */;

UPDATE C_Country SET M49Code='174', ISOCountryCodeAlpha3='COM' WHERE C_Country_ID=157 /* Comoros */;

UPDATE C_Country SET M49Code='178', ISOCountryCodeAlpha3='COG' WHERE C_Country_ID=158 /* Congo */;

UPDATE C_Country SET M49Code='180', ISOCountryCodeAlpha3='COD' WHERE C_Country_ID=159 /* Congo (DRC) */;

UPDATE C_Country SET M49Code='184', ISOCountryCodeAlpha3='COK' WHERE C_Country_ID=160 /* Cook Islands */;

UPDATE C_Country SET M49Code='188', ISOCountryCodeAlpha3='CRI' WHERE C_Country_ID=161 /* Costa Rica */;

UPDATE C_Country SET M49Code='384', ISOCountryCodeAlpha3='CIV' WHERE C_Country_ID=162 /* Côte d'Ivoire */;

UPDATE C_Country SET M49Code='191', ISOCountryCodeAlpha3='HRV' WHERE C_Country_ID=163 /* Croatia */;

UPDATE C_Country SET M49Code='192', ISOCountryCodeAlpha3='CUB' WHERE C_Country_ID=164 /* Cuba */;

UPDATE C_Country SET M49Code='531', ISOCountryCodeAlpha3='CUW' WHERE C_Country_ID=200003 /* Curaçao */;

UPDATE C_Country SET M49Code='196', ISOCountryCodeAlpha3='CYP' WHERE C_Country_ID=165 /* Cyprus */;

UPDATE C_Country SET M49Code='203', ISOCountryCodeAlpha3='CZE' WHERE C_Country_ID=166 /* Czech Republic */;

UPDATE C_Country SET M49Code='208', ISOCountryCodeAlpha3='DNK' WHERE C_Country_ID=167 /* Denmark */;

UPDATE C_Country SET M49Code='262', ISOCountryCodeAlpha3='DJI' WHERE C_Country_ID=168 /* Djibouti */;

UPDATE C_Country SET M49Code='212', ISOCountryCodeAlpha3='DMA' WHERE C_Country_ID=169 /* Dominica */;

UPDATE C_Country SET M49Code='214', ISOCountryCodeAlpha3='DOM' WHERE C_Country_ID=170 /* Dominican Republic */;

UPDATE C_Country SET M49Code='218', ISOCountryCodeAlpha3='ECU' WHERE C_Country_ID=171 /* Ecuador */;

UPDATE C_Country SET M49Code='818', ISOCountryCodeAlpha3='EGY' WHERE C_Country_ID=172 /* Egypt */;

UPDATE C_Country SET M49Code='222', ISOCountryCodeAlpha3='SLV' WHERE C_Country_ID=173 /* El Salvador */;

UPDATE C_Country SET M49Code='226', ISOCountryCodeAlpha3='GNQ' WHERE C_Country_ID=174 /* Equatorial Guinea */;

UPDATE C_Country SET M49Code='232', ISOCountryCodeAlpha3='ERI' WHERE C_Country_ID=175 /* Eritrea */;

UPDATE C_Country SET M49Code='233', ISOCountryCodeAlpha3='EST' WHERE C_Country_ID=176 /* Estonia */;

UPDATE C_Country SET M49Code='748', ISOCountryCodeAlpha3='SWZ' WHERE C_Country_ID=312 /* Eswatini */;

UPDATE C_Country SET M49Code='231', ISOCountryCodeAlpha3='ETH' WHERE C_Country_ID=177 /* Ethiopia */;

UPDATE C_Country SET M49Code='238', ISOCountryCodeAlpha3='FLK' WHERE C_Country_ID=178 /* Falkland Islands [Malvinas] */;

UPDATE C_Country SET M49Code='234', ISOCountryCodeAlpha3='FRO' WHERE C_Country_ID=179 /* Faroe Islands */;

UPDATE C_Country SET M49Code='242', ISOCountryCodeAlpha3='FJI' WHERE C_Country_ID=180 /* Fiji */;

UPDATE C_Country SET M49Code='246', ISOCountryCodeAlpha3='FIN' WHERE C_Country_ID=181 /* Finland */;

UPDATE C_Country SET M49Code='250', ISOCountryCodeAlpha3='FRA' WHERE C_Country_ID=102 /* France */;

UPDATE C_Country SET M49Code='254', ISOCountryCodeAlpha3='GUF' WHERE C_Country_ID=183 /* French Guiana */;

UPDATE C_Country SET M49Code='258', ISOCountryCodeAlpha3='PYF' WHERE C_Country_ID=184 /* French Polynesia */;

UPDATE C_Country SET M49Code='260', ISOCountryCodeAlpha3='ATF' WHERE C_Country_ID=185 /* French Southern Territories */;

UPDATE C_Country SET M49Code='266', ISOCountryCodeAlpha3='GAB' WHERE C_Country_ID=186 /* Gabon */;

UPDATE C_Country SET M49Code='270', ISOCountryCodeAlpha3='GMB' WHERE C_Country_ID=187 /* Gambia */;

UPDATE C_Country SET M49Code='268', ISOCountryCodeAlpha3='GEO' WHERE C_Country_ID=188 /* Georgia */;

UPDATE C_Country SET M49Code='276', ISOCountryCodeAlpha3='DEU' WHERE C_Country_ID=101 /* Germany */;

UPDATE C_Country SET M49Code='288', ISOCountryCodeAlpha3='GHA' WHERE C_Country_ID=190 /* Ghana */;

UPDATE C_Country SET M49Code='292', ISOCountryCodeAlpha3='GIB' WHERE C_Country_ID=191 /* Gibraltar */;

UPDATE C_Country SET M49Code='300', ISOCountryCodeAlpha3='GRC' WHERE C_Country_ID=192 /* Greece */;

UPDATE C_Country SET M49Code='304', ISOCountryCodeAlpha3='GRL' WHERE C_Country_ID=193 /* Greenland */;

UPDATE C_Country SET M49Code='308', ISOCountryCodeAlpha3='GRD' WHERE C_Country_ID=194 /* Grenada */;

UPDATE C_Country SET M49Code='312', ISOCountryCodeAlpha3='GLP' WHERE C_Country_ID=195 /* Guadeloupe */;

UPDATE C_Country SET M49Code='316', ISOCountryCodeAlpha3='GUM' WHERE C_Country_ID=196 /* Guam */;

UPDATE C_Country SET M49Code='320', ISOCountryCodeAlpha3='GTM' WHERE C_Country_ID=197 /* Guatemala */;

UPDATE C_Country SET M49Code='831', ISOCountryCodeAlpha3='GGY' WHERE C_Country_ID=50002 /* Guernsey */;

UPDATE C_Country SET M49Code='324', ISOCountryCodeAlpha3='GIN' WHERE C_Country_ID=198 /* Guinea */;

UPDATE C_Country SET M49Code='624', ISOCountryCodeAlpha3='GNB' WHERE C_Country_ID=199 /* Guinea-bissau */;

UPDATE C_Country SET M49Code='328', ISOCountryCodeAlpha3='GUY' WHERE C_Country_ID=200 /* Guyana */;

UPDATE C_Country SET M49Code='332', ISOCountryCodeAlpha3='HTI' WHERE C_Country_ID=201 /* Haiti */;

UPDATE C_Country SET M49Code='334', ISOCountryCodeAlpha3='HMD' WHERE C_Country_ID=202 /* Heard Island and Mcdonald Islands */;

UPDATE C_Country SET M49Code='336', ISOCountryCodeAlpha3='VAT' WHERE C_Country_ID=203 /* Holy See (Vatican City State) */;

UPDATE C_Country SET M49Code='340', ISOCountryCodeAlpha3='HND' WHERE C_Country_ID=204 /* Honduras */;

UPDATE C_Country SET M49Code='344', ISOCountryCodeAlpha3='HKG' WHERE C_Country_ID=205 /* Hong Kong */;

UPDATE C_Country SET M49Code='348', ISOCountryCodeAlpha3='HUN' WHERE C_Country_ID=206 /* Hungary */;

UPDATE C_Country SET M49Code='352', ISOCountryCodeAlpha3='ISL' WHERE C_Country_ID=207 /* Iceland */;

UPDATE C_Country SET M49Code='356', ISOCountryCodeAlpha3='IND' WHERE C_Country_ID=208 /* India */;

UPDATE C_Country SET M49Code='360', ISOCountryCodeAlpha3='IDN' WHERE C_Country_ID=209 /* Indonesia */;

UPDATE C_Country SET M49Code='364', ISOCountryCodeAlpha3='IRN' WHERE C_Country_ID=210 /* Iran */;

UPDATE C_Country SET M49Code='368', ISOCountryCodeAlpha3='IRQ' WHERE C_Country_ID=211 /* Iraq */;

UPDATE C_Country SET M49Code='372', ISOCountryCodeAlpha3='IRL' WHERE C_Country_ID=212 /* Ireland */;

UPDATE C_Country SET M49Code='833', ISOCountryCodeAlpha3='IMN' WHERE C_Country_ID=50003 /* Isle of Man */;

UPDATE C_Country SET M49Code='376', ISOCountryCodeAlpha3='ISR' WHERE C_Country_ID=213 /* Israel */;

UPDATE C_Country SET M49Code='380', ISOCountryCodeAlpha3='ITA' WHERE C_Country_ID=214 /* Italy */;

UPDATE C_Country SET M49Code='388', ISOCountryCodeAlpha3='JAM' WHERE C_Country_ID=215 /* Jamaica */;

UPDATE C_Country SET M49Code='392', ISOCountryCodeAlpha3='JPN' WHERE C_Country_ID=216 /* Japan */;

UPDATE C_Country SET M49Code='832', ISOCountryCodeAlpha3='JEY' WHERE C_Country_ID=50004 /* Jersey */;

UPDATE C_Country SET M49Code='400', ISOCountryCodeAlpha3='JOR' WHERE C_Country_ID=217 /* Jordan */;

UPDATE C_Country SET M49Code='398', ISOCountryCodeAlpha3='KAZ' WHERE C_Country_ID=218 /* Kazakhstan */;

UPDATE C_Country SET M49Code='404', ISOCountryCodeAlpha3='KEN' WHERE C_Country_ID=219 /* Kenya */;

UPDATE C_Country SET M49Code='296', ISOCountryCodeAlpha3='KIR' WHERE C_Country_ID=220 /* Kiribati */;

UPDATE C_Country SET M49Code='408', ISOCountryCodeAlpha3='PRK' WHERE C_Country_ID=221 /* Korea Democratic People's Republic of */;

UPDATE C_Country SET M49Code='410', ISOCountryCodeAlpha3='KOR' WHERE C_Country_ID=222 /* Korea Republic of */;

UPDATE C_Country SET M49Code='414', ISOCountryCodeAlpha3='KWT' WHERE C_Country_ID=223 /* Kuwait */;

UPDATE C_Country SET M49Code='417', ISOCountryCodeAlpha3='KGZ' WHERE C_Country_ID=224 /* Kyrgyzstan */;

UPDATE C_Country SET M49Code='418', ISOCountryCodeAlpha3='LAO' WHERE C_Country_ID=225 /* Lao People's Democratic Republic */;

UPDATE C_Country SET M49Code='428', ISOCountryCodeAlpha3='LVA' WHERE C_Country_ID=226 /* Latvia */;

UPDATE C_Country SET M49Code='422', ISOCountryCodeAlpha3='LBN' WHERE C_Country_ID=227 /* Lebanon */;

UPDATE C_Country SET M49Code='426', ISOCountryCodeAlpha3='LSO' WHERE C_Country_ID=228 /* Lesotho */;

UPDATE C_Country SET M49Code='430', ISOCountryCodeAlpha3='LBR' WHERE C_Country_ID=229 /* Liberia */;

UPDATE C_Country SET M49Code='434', ISOCountryCodeAlpha3='LBY' WHERE C_Country_ID=230 /* Libya */;

UPDATE C_Country SET M49Code='438', ISOCountryCodeAlpha3='LIE' WHERE C_Country_ID=231 /* Liechtenstein */;

UPDATE C_Country SET M49Code='440', ISOCountryCodeAlpha3='LTU' WHERE C_Country_ID=232 /* Lithuania */;

UPDATE C_Country SET M49Code='442', ISOCountryCodeAlpha3='LUX' WHERE C_Country_ID=233 /* Luxembourg */;

UPDATE C_Country SET M49Code='446', ISOCountryCodeAlpha3='MAC' WHERE C_Country_ID=234 /* Macao */;

UPDATE C_Country SET M49Code='450', ISOCountryCodeAlpha3='MDG' WHERE C_Country_ID=236 /* Madagascar */;

UPDATE C_Country SET M49Code='454', ISOCountryCodeAlpha3='MWI' WHERE C_Country_ID=237 /* Malawi */;

UPDATE C_Country SET M49Code='458', ISOCountryCodeAlpha3='MYS' WHERE C_Country_ID=238 /* Malaysia */;

UPDATE C_Country SET M49Code='462', ISOCountryCodeAlpha3='MDV' WHERE C_Country_ID=239 /* Maldives */;

UPDATE C_Country SET M49Code='466', ISOCountryCodeAlpha3='MLI' WHERE C_Country_ID=240 /* Mali */;

UPDATE C_Country SET M49Code='470', ISOCountryCodeAlpha3='MLT' WHERE C_Country_ID=241 /* Malta */;

UPDATE C_Country SET M49Code='584', ISOCountryCodeAlpha3='MHL' WHERE C_Country_ID=242 /* Marshall Islands */;

UPDATE C_Country SET M49Code='474', ISOCountryCodeAlpha3='MTQ' WHERE C_Country_ID=243 /* Martinique */;

UPDATE C_Country SET M49Code='478', ISOCountryCodeAlpha3='MRT' WHERE C_Country_ID=244 /* Mauritania */;

UPDATE C_Country SET M49Code='480', ISOCountryCodeAlpha3='MUS' WHERE C_Country_ID=245 /* Mauritius */;

UPDATE C_Country SET M49Code='175', ISOCountryCodeAlpha3='MYT' WHERE C_Country_ID=246 /* Mayotte */;

UPDATE C_Country SET M49Code='484', ISOCountryCodeAlpha3='MEX' WHERE C_Country_ID=247 /* Mexico */;

UPDATE C_Country SET M49Code='583', ISOCountryCodeAlpha3='FSM' WHERE C_Country_ID=248 /* Micronesia */;

UPDATE C_Country SET M49Code='498', ISOCountryCodeAlpha3='MDA' WHERE C_Country_ID=249 /* Moldova */;

UPDATE C_Country SET M49Code='492', ISOCountryCodeAlpha3='MCO' WHERE C_Country_ID=250 /* Monaco */;

UPDATE C_Country SET M49Code='496', ISOCountryCodeAlpha3='MNG' WHERE C_Country_ID=251 /* Mongolia */;

UPDATE C_Country SET M49Code='499', ISOCountryCodeAlpha3='MNE' WHERE C_Country_ID=350 /* Montenegro */;

UPDATE C_Country SET M49Code='500', ISOCountryCodeAlpha3='MSR' WHERE C_Country_ID=252 /* Montserrat */;

UPDATE C_Country SET M49Code='504', ISOCountryCodeAlpha3='MAR' WHERE C_Country_ID=253 /* Morocco */;

UPDATE C_Country SET M49Code='508', ISOCountryCodeAlpha3='MOZ' WHERE C_Country_ID=254 /* Mozambique */;

UPDATE C_Country SET M49Code='104', ISOCountryCodeAlpha3='MMR' WHERE C_Country_ID=255 /* Myanmar */;

UPDATE C_Country SET M49Code='516', ISOCountryCodeAlpha3='NAM' WHERE C_Country_ID=256 /* Namibia */;

UPDATE C_Country SET M49Code='520', ISOCountryCodeAlpha3='NRU' WHERE C_Country_ID=257 /* Nauru */;

UPDATE C_Country SET M49Code='524', ISOCountryCodeAlpha3='NPL' WHERE C_Country_ID=258 /* Nepal */;

UPDATE C_Country SET M49Code='528', ISOCountryCodeAlpha3='NLD' WHERE C_Country_ID=105 /* Netherlands */;

UPDATE C_Country SET M49Code='540', ISOCountryCodeAlpha3='NCL' WHERE C_Country_ID=261 /* New Caledonia */;

UPDATE C_Country SET M49Code='554', ISOCountryCodeAlpha3='NZL' WHERE C_Country_ID=262 /* New Zealand */;

UPDATE C_Country SET M49Code='558', ISOCountryCodeAlpha3='NIC' WHERE C_Country_ID=263 /* Nicaragua */;

UPDATE C_Country SET M49Code='562', ISOCountryCodeAlpha3='NER' WHERE C_Country_ID=264 /* Niger */;

UPDATE C_Country SET M49Code='566', ISOCountryCodeAlpha3='NGA' WHERE C_Country_ID=265 /* Nigeria */;

UPDATE C_Country SET M49Code='570', ISOCountryCodeAlpha3='NIU' WHERE C_Country_ID=266 /* Niue */;

UPDATE C_Country SET M49Code='574', ISOCountryCodeAlpha3='NFK' WHERE C_Country_ID=267 /* Norfolk Island */;

UPDATE C_Country SET M49Code='807', ISOCountryCodeAlpha3='MKD' WHERE C_Country_ID=235 /* North Macedonia */;

UPDATE C_Country SET M49Code='580', ISOCountryCodeAlpha3='MNP' WHERE C_Country_ID=268 /* Northern Mariana Islands */;

UPDATE C_Country SET M49Code='578', ISOCountryCodeAlpha3='NOR' WHERE C_Country_ID=269 /* Norway */;

UPDATE C_Country SET M49Code='512', ISOCountryCodeAlpha3='OMN' WHERE C_Country_ID=270 /* Oman */;

UPDATE C_Country SET M49Code='586', ISOCountryCodeAlpha3='PAK' WHERE C_Country_ID=271 /* Pakistan */;

UPDATE C_Country SET M49Code='585', ISOCountryCodeAlpha3='PLW' WHERE C_Country_ID=272 /* Palau */;

UPDATE C_Country SET M49Code='275', ISOCountryCodeAlpha3='PSE' WHERE C_Country_ID=273 /* Palestinian State of */;

UPDATE C_Country SET M49Code='591', ISOCountryCodeAlpha3='PAN' WHERE C_Country_ID=274 /* Panama */;

UPDATE C_Country SET M49Code='598', ISOCountryCodeAlpha3='PNG' WHERE C_Country_ID=275 /* Papua New Guinea */;

UPDATE C_Country SET M49Code='600', ISOCountryCodeAlpha3='PRY' WHERE C_Country_ID=276 /* Paraguay */;

UPDATE C_Country SET M49Code='604', ISOCountryCodeAlpha3='PER' WHERE C_Country_ID=277 /* Peru */;

UPDATE C_Country SET M49Code='608', ISOCountryCodeAlpha3='PHL' WHERE C_Country_ID=278 /* Philippines */;

UPDATE C_Country SET M49Code='612', ISOCountryCodeAlpha3='PCN' WHERE C_Country_ID=279 /* Pitcairn */;

UPDATE C_Country SET M49Code='616', ISOCountryCodeAlpha3='POL' WHERE C_Country_ID=280 /* Poland */;

UPDATE C_Country SET M49Code='620', ISOCountryCodeAlpha3='PRT' WHERE C_Country_ID=281 /* Portugal */;

UPDATE C_Country SET M49Code='630', ISOCountryCodeAlpha3='PRI' WHERE C_Country_ID=282 /* Puerto Rico */;

UPDATE C_Country SET M49Code='634', ISOCountryCodeAlpha3='QAT' WHERE C_Country_ID=283 /* Qatar */;

UPDATE C_Country SET M49Code='638', ISOCountryCodeAlpha3='REU' WHERE C_Country_ID=284 /* Reunion */;

UPDATE C_Country SET M49Code='642', ISOCountryCodeAlpha3='ROU' WHERE C_Country_ID=285 /* Romania */;

UPDATE C_Country SET M49Code='643', ISOCountryCodeAlpha3='RUS' WHERE C_Country_ID=286 /* Russia */;

UPDATE C_Country SET M49Code='646', ISOCountryCodeAlpha3='RWA' WHERE C_Country_ID=287 /* Rwanda */;

UPDATE C_Country SET M49Code='652', ISOCountryCodeAlpha3='BLM' WHERE C_Country_ID=50001 /* Saint Barthélemy */;

UPDATE C_Country SET M49Code='654', ISOCountryCodeAlpha3='SHN' WHERE C_Country_ID=288 /* Saint Helena */;

UPDATE C_Country SET M49Code='659', ISOCountryCodeAlpha3='KNA' WHERE C_Country_ID=289 /* Saint Kitts and Nevis */;

UPDATE C_Country SET M49Code='662', ISOCountryCodeAlpha3='LCA' WHERE C_Country_ID=290 /* Saint Lucia */;

UPDATE C_Country SET M49Code='663', ISOCountryCodeAlpha3='MAF' WHERE C_Country_ID=50005 /* Saint Martin */;

UPDATE C_Country SET M49Code='666', ISOCountryCodeAlpha3='SPM' WHERE C_Country_ID=291 /* Saint Pierre and Miquelon */;

UPDATE C_Country SET M49Code='670', ISOCountryCodeAlpha3='VCT' WHERE C_Country_ID=292 /* Saint Vincent and The Grenadines */;

UPDATE C_Country SET M49Code='882', ISOCountryCodeAlpha3='WSM' WHERE C_Country_ID=293 /* Samoa */;

UPDATE C_Country SET M49Code='674', ISOCountryCodeAlpha3='SMR' WHERE C_Country_ID=294 /* San Marino */;

UPDATE C_Country SET M49Code='678', ISOCountryCodeAlpha3='STP' WHERE C_Country_ID=295 /* Sao Tome and Principe */;

UPDATE C_Country SET M49Code='682', ISOCountryCodeAlpha3='SAU' WHERE C_Country_ID=296 /* Saudi Arabia */;

UPDATE C_Country SET M49Code='686', ISOCountryCodeAlpha3='SEN' WHERE C_Country_ID=297 /* Senegal */;

UPDATE C_Country SET M49Code='688', ISOCountryCodeAlpha3='SRB' WHERE C_Country_ID=349 /* Serbia */;

UPDATE C_Country SET M49Code='690', ISOCountryCodeAlpha3='SYC' WHERE C_Country_ID=298 /* Seychelles */;

UPDATE C_Country SET M49Code='694', ISOCountryCodeAlpha3='SLE' WHERE C_Country_ID=299 /* Sierra Leone */;

UPDATE C_Country SET M49Code='702', ISOCountryCodeAlpha3='SGP' WHERE C_Country_ID=300 /* Singapore */;

UPDATE C_Country SET M49Code='534', ISOCountryCodeAlpha3='SXM' WHERE C_Country_ID=200000 /* Sint Maarten */;

UPDATE C_Country SET M49Code='703', ISOCountryCodeAlpha3='SVK' WHERE C_Country_ID=301 /* Slovakia */;

UPDATE C_Country SET M49Code='705', ISOCountryCodeAlpha3='SVN' WHERE C_Country_ID=302 /* Slovenia */;

UPDATE C_Country SET M49Code='090', ISOCountryCodeAlpha3='SLB' WHERE C_Country_ID=303 /* Solomon Islands */;

UPDATE C_Country SET M49Code='706', ISOCountryCodeAlpha3='SOM' WHERE C_Country_ID=304 /* Somalia */;

UPDATE C_Country SET M49Code='710', ISOCountryCodeAlpha3='ZAF' WHERE C_Country_ID=305 /* South Africa */;

UPDATE C_Country SET M49Code='239', ISOCountryCodeAlpha3='SGS' WHERE C_Country_ID=306 /* South Georgia and The South Sandwich Islands */;

UPDATE C_Country SET M49Code='728', ISOCountryCodeAlpha3='SSD' WHERE C_Country_ID=200001 /* South Sudan */;

UPDATE C_Country SET M49Code='724', ISOCountryCodeAlpha3='ESP' WHERE C_Country_ID=106 /* Spain */;

UPDATE C_Country SET M49Code='144', ISOCountryCodeAlpha3='LKA' WHERE C_Country_ID=308 /* Sri Lanka */;

UPDATE C_Country SET M49Code='729', ISOCountryCodeAlpha3='SDN' WHERE C_Country_ID=309 /* Sudan */;

UPDATE C_Country SET M49Code='740', ISOCountryCodeAlpha3='SUR' WHERE C_Country_ID=310 /* Suriname */;

UPDATE C_Country SET M49Code='744', ISOCountryCodeAlpha3='SJM' WHERE C_Country_ID=311 /* Svalbard and Jan Mayen */;

UPDATE C_Country SET M49Code='752', ISOCountryCodeAlpha3='SWE' WHERE C_Country_ID=313 /* Sweden */;

UPDATE C_Country SET M49Code='756', ISOCountryCodeAlpha3='CHE' WHERE C_Country_ID=107 /* Switzerland */;

UPDATE C_Country SET M49Code='760', ISOCountryCodeAlpha3='SYR' WHERE C_Country_ID=315 /* Syria */;

UPDATE C_Country SET M49Code='158', ISOCountryCodeAlpha3='TWN' WHERE C_Country_ID=316 /* Taiwan */;

UPDATE C_Country SET M49Code='762', ISOCountryCodeAlpha3='TJK' WHERE C_Country_ID=317 /* Tajikistan */;

UPDATE C_Country SET M49Code='834', ISOCountryCodeAlpha3='TZA' WHERE C_Country_ID=318 /* Tanzania */;

UPDATE C_Country SET M49Code='764', ISOCountryCodeAlpha3='THA' WHERE C_Country_ID=319 /* Thailand */;

UPDATE C_Country SET M49Code='626', ISOCountryCodeAlpha3='TLS' WHERE C_Country_ID=320 /* Timor-leste */;

UPDATE C_Country SET M49Code='768', ISOCountryCodeAlpha3='TGO' WHERE C_Country_ID=321 /* Togo */;

UPDATE C_Country SET M49Code='772', ISOCountryCodeAlpha3='TKL' WHERE C_Country_ID=322 /* Tokelau */;

UPDATE C_Country SET M49Code='776', ISOCountryCodeAlpha3='TON' WHERE C_Country_ID=323 /* Tonga */;

UPDATE C_Country SET M49Code='780', ISOCountryCodeAlpha3='TTO' WHERE C_Country_ID=324 /* Trinidad and Tobago */;

UPDATE C_Country SET M49Code='788', ISOCountryCodeAlpha3='TUN' WHERE C_Country_ID=325 /* Tunisia */;

UPDATE C_Country SET M49Code='792', ISOCountryCodeAlpha3='TUR' WHERE C_Country_ID=326 /* Turkey */;

UPDATE C_Country SET M49Code='795', ISOCountryCodeAlpha3='TKM' WHERE C_Country_ID=327 /* Turkmenistan */;

UPDATE C_Country SET M49Code='796', ISOCountryCodeAlpha3='TCA' WHERE C_Country_ID=328 /* Turks and Caicos Islands */;

UPDATE C_Country SET M49Code='798', ISOCountryCodeAlpha3='TUV' WHERE C_Country_ID=329 /* Tuvalu */;

UPDATE C_Country SET M49Code='800', ISOCountryCodeAlpha3='UGA' WHERE C_Country_ID=330 /* Uganda */;

UPDATE C_Country SET M49Code='804', ISOCountryCodeAlpha3='UKR' WHERE C_Country_ID=331 /* Ukraine */;

UPDATE C_Country SET M49Code='784', ISOCountryCodeAlpha3='ARE' WHERE C_Country_ID=332 /* United Arab Emirates */;

UPDATE C_Country SET M49Code='826', ISOCountryCodeAlpha3='GBR' WHERE C_Country_ID=333 /* United Kingdom */;

UPDATE C_Country SET M49Code='840', ISOCountryCodeAlpha3='USA' WHERE C_Country_ID=100 /* United States */;

UPDATE C_Country SET M49Code='581', ISOCountryCodeAlpha3='UMI' WHERE C_Country_ID=335 /* United States Minor Outlying Islands */;

UPDATE C_Country SET M49Code='858', ISOCountryCodeAlpha3='URY' WHERE C_Country_ID=336 /* Uruguay */;

UPDATE C_Country SET M49Code='860', ISOCountryCodeAlpha3='UZB' WHERE C_Country_ID=337 /* Uzbekistan */;

UPDATE C_Country SET M49Code='548', ISOCountryCodeAlpha3='VUT' WHERE C_Country_ID=338 /* Vanuatu */;

UPDATE C_Country SET M49Code='862', ISOCountryCodeAlpha3='VEN' WHERE C_Country_ID=339 /* Venezuela */;

UPDATE C_Country SET M49Code='704', ISOCountryCodeAlpha3='VNM' WHERE C_Country_ID=340 /* Viet Nam */;

UPDATE C_Country SET M49Code='850', ISOCountryCodeAlpha3='VIR' WHERE C_Country_ID=342 /* Virgin Islands */;

UPDATE C_Country SET M49Code='092', ISOCountryCodeAlpha3='VGB' WHERE C_Country_ID=341 /* Virgin Islands British */;

UPDATE C_Country SET M49Code='876', ISOCountryCodeAlpha3='WLF' WHERE C_Country_ID=343 /* Wallis and Futuna */;

UPDATE C_Country SET M49Code='732', ISOCountryCodeAlpha3='ESH' WHERE C_Country_ID=344 /* Western Sahara */;

UPDATE C_Country SET M49Code='887', ISOCountryCodeAlpha3='YEM' WHERE C_Country_ID=345 /* Yemen */;

UPDATE C_Country SET M49Code='894', ISOCountryCodeAlpha3='ZMB' WHERE C_Country_ID=347 /* Zambia */;

UPDATE C_Country SET M49Code='716', ISOCountryCodeAlpha3='ZWE' WHERE C_Country_ID=348 /* Zimbabwe */;

-- Dec 26, 2024, 3:02:02 PM CET
UPDATE C_Country SET IsActive='N',Updated=TO_TIMESTAMP('2024-12-26 15:02:02','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE C_Country_ID=260
;

