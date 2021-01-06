SET SQLBLANKLINES ON
SET DEFINE OFF

-- IDEMPIERE-4568 : Countries : Fix/Harmonize Names and Descriptions
-- 2020-12-31 08:51:55
INSERT INTO C_Currency (C_Currency_ID,ISO_Code,StdPrecision,Description,CostingPrecision,EMURate,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,CurSymbol,IsEuro,IsEMUMember,C_Currency_UU) VALUES (200000,'SSP',2,'South Sudanese pound',4,0,0,0,'Y',TO_DATE('2020-12-31 08:51:55','YYYY-MM-DD HH24:MI:SS'),0,TO_DATE('2020-12-31 08:51:55','YYYY-MM-DD HH24:MI:SS'),0,'SS£','N','N','5e17318d-16ba-403d-be9d-e0d696fe6fe8')
;

-- 2020-12-31 08:57:23
INSERT INTO C_Country (C_Country_ID,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,Name,Description,CountryCode,HasRegion,RegionName,DisplaySequence,HasPostal_Add,C_Currency_ID,AD_Language,IsAddressLinesLocalReverse,IsAddressLinesReverse,IsPostcodeLookup,AllowCitiesOutOfList,CaptureSequence,C_Country_UU) VALUES (200000,0,0,'Y',TO_DATE('2020-12-31 08:57:23','YYYY-MM-DD HH24:MI:SS'),0,TO_DATE('2020-12-31 08:57:23','YYYY-MM-DD HH24:MI:SS'),0,'Sint Maarten','Sint Maarten (Dutch part)','SX','N','State','@C@,  @P@','N',284,'nl_NL','N','N','N','Y','@CO@ @A1@ @A2@ @A3@ @A4@ @C@ @P@','0ee3199a-df07-4b07-87f4-a6cb0fab1a28')
;

-- 2020-12-31 08:58:28
INSERT INTO C_Country (C_Country_ID,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,Name,Description,CountryCode,HasRegion,RegionName,DisplaySequence,HasPostal_Add,C_Currency_ID,AD_Language,IsAddressLinesLocalReverse,IsAddressLinesReverse,IsPostcodeLookup,AllowCitiesOutOfList,CaptureSequence,C_Country_UU) VALUES (200001,0,0,'Y',TO_DATE('2020-12-31 08:58:27','YYYY-MM-DD HH24:MI:SS'),0,TO_DATE('2020-12-31 08:58:27','YYYY-MM-DD HH24:MI:SS'),0,'South Sudan','the Republic of South Sudan','SS','N','State','@C@,  @P@','N',200000,'en_US','N','N','N','Y','@CO@ @A1@ @A2@ @A3@ @A4@ @C@ @P@','c44f6dbe-b6c4-4040-8133-2eb0208bb4ba')
;

-- 2020-12-31 08:59:04
INSERT INTO C_Country (C_Country_ID,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,Name,Description,CountryCode,HasRegion,RegionName,DisplaySequence,HasPostal_Add,C_Currency_ID,AD_Language,IsAddressLinesLocalReverse,IsAddressLinesReverse,IsPostcodeLookup,AllowCitiesOutOfList,CaptureSequence,C_Country_UU) VALUES (200002,0,0,'Y',TO_DATE('2020-12-31 08:59:04','YYYY-MM-DD HH24:MI:SS'),0,TO_DATE('2020-12-31 08:59:04','YYYY-MM-DD HH24:MI:SS'),0,'Bonaire, Sint Eustatius and Saba','Bonaire, Sint Eustatius and Saba','BQ','N','State','@C@,  @P@','N',100,'en_US','N','N','N','Y','@CO@ @A1@ @A2@ @A3@ @A4@ @C@ @P@','33a7145f-9014-437f-8afa-faaa965f727f')
;

-- 2020-12-31 08:59:28
INSERT INTO C_Country (C_Country_ID,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,Name,Description,CountryCode,HasRegion,RegionName,DisplaySequence,HasPostal_Add,C_Currency_ID,AD_Language,IsAddressLinesLocalReverse,IsAddressLinesReverse,IsPostcodeLookup,AllowCitiesOutOfList,CaptureSequence,C_Country_UU) VALUES (200003,0,0,'Y',TO_DATE('2020-12-31 08:59:27','YYYY-MM-DD HH24:MI:SS'),0,TO_DATE('2020-12-31 08:59:27','YYYY-MM-DD HH24:MI:SS'),0,'Curaçao','Curaçao','CW','N','State','@C@,  @P@','N',284,'en_US','N','N','N','Y','@CO@ @A1@ @A2@ @A3@ @A4@ @C@ @P@','6e17e4ea-44d6-4169-96ff-c95584519eb9')
;

-- 2020-12-31 08:59:44
UPDATE C_Country SET AD_Language='nl_NL',Updated=TO_DATE('2020-12-31 08:59:44','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=0 WHERE C_Country_ID=200003
;

-- 2020-12-31 09:00:12
UPDATE C_Country SET AD_Language='nl_NL',Updated=TO_DATE('2020-12-31 09:00:12','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=0 WHERE C_Country_ID=200002
;

UPDATE C_Country SET Description = 'the Principality of Andorra',  Updated = TO_DATE('2020-12-31 22:22:22','YYYY-MM-DD HH24:MI:SS') WHERE C_Country_ID = 114;
UPDATE C_Country SET Description = 'the United Arab Emirates', Updated = TO_DATE('2020-12-31 22:22:22','YYYY-MM-DD HH24:MI:SS') WHERE C_Country_ID = 332;
UPDATE C_Country SET Description = 'the Islamic Republic of Afghanistan', Updated = TO_DATE('2020-12-31 22:22:22','YYYY-MM-DD HH24:MI:SS') WHERE C_Country_ID = 110;
UPDATE C_Country SET Name = 'Antigua and Barbuda',Description = 'Antigua and Barbuda', Updated = TO_DATE('2020-12-31 22:22:22','YYYY-MM-DD HH24:MI:SS') WHERE C_Country_ID = 118;

UPDATE C_Country SET Description = 'the Republic of Albania', Updated = TO_DATE('2020-12-31 22:22:22','YYYY-MM-DD HH24:MI:SS') WHERE C_Country_ID = 111;
UPDATE C_Country SET Description = 'the Republic of Armenia', Updated = TO_DATE('2020-12-31 22:22:22','YYYY-MM-DD HH24:MI:SS') WHERE C_Country_ID = 120;

UPDATE C_Country SET Description = 'the Republic of Angola', Updated = TO_DATE('2020-12-31 22:22:22','YYYY-MM-DD HH24:MI:SS') WHERE C_Country_ID = 115;

UPDATE C_Country SET Description = 'the Argentine Republic', Updated = TO_DATE('2020-12-31 22:22:22','YYYY-MM-DD HH24:MI:SS') WHERE C_Country_ID = 119;

UPDATE C_Country SET Description = 'the Republic of Austria', Updated = TO_DATE('2020-12-31 22:22:22','YYYY-MM-DD HH24:MI:SS') WHERE C_Country_ID = 108;



UPDATE C_Country SET Description = 'the Republic of Azerbaijan', Updated = TO_DATE('2020-12-31 22:22:22','YYYY-MM-DD HH24:MI:SS') WHERE C_Country_ID = 124;
UPDATE C_Country SET Name = 'Bosnia and Herzegovina',Description = 'Bosnia and Herzegovina', Updated = TO_DATE('2020-12-31 22:22:22','YYYY-MM-DD HH24:MI:SS') WHERE C_Country_ID = 136;

UPDATE C_Country SET Description = 'the People''s Republic of Bangladesh', Updated = TO_DATE('2020-12-31 22:22:22','YYYY-MM-DD HH24:MI:SS') WHERE C_Country_ID = 127;
UPDATE C_Country SET Description = 'the Kingdom of Belgium', Updated = TO_DATE('2020-12-31 22:22:22','YYYY-MM-DD HH24:MI:SS') WHERE C_Country_ID = 103;

UPDATE C_Country SET Description = 'the Republic of Bulgaria', Updated = TO_DATE('2020-12-31 22:22:22','YYYY-MM-DD HH24:MI:SS') WHERE C_Country_ID = 142;
UPDATE C_Country SET Description = 'the Kingdom of Bahrain', Updated = TO_DATE('2020-12-31 22:22:22','YYYY-MM-DD HH24:MI:SS') WHERE C_Country_ID = 126;
UPDATE C_Country SET Description = 'the Republic of Burundi', Updated = TO_DATE('2020-12-31 22:22:22','YYYY-MM-DD HH24:MI:SS') WHERE C_Country_ID = 144;
UPDATE C_Country SET Description = 'the Republic of Benin', Updated = TO_DATE('2020-12-31 22:22:22','YYYY-MM-DD HH24:MI:SS') WHERE C_Country_ID = 132;



UPDATE C_Country SET Description = 'the Plurinational State of Bolivia', Updated = TO_DATE('2020-12-31 22:22:22','YYYY-MM-DD HH24:MI:SS') WHERE C_Country_ID = 135;
UPDATE C_Country SET Description = 'the Federative Republic of Brazil', Updated = TO_DATE('2020-12-31 22:22:22','YYYY-MM-DD HH24:MI:SS') WHERE C_Country_ID = 139;
UPDATE C_Country SET Description = 'the Commonwealth of the Bahamas', Updated = TO_DATE('2020-12-31 22:22:22','YYYY-MM-DD HH24:MI:SS') WHERE C_Country_ID = 125;
UPDATE C_Country SET Description = 'the Kingdom of Bhutan', Updated = TO_DATE('2020-12-31 22:22:22','YYYY-MM-DD HH24:MI:SS') WHERE C_Country_ID = 134;

UPDATE C_Country SET Description = 'the Republic of Botswana', Updated = TO_DATE('2020-12-31 22:22:22','YYYY-MM-DD HH24:MI:SS') WHERE C_Country_ID = 137;
UPDATE C_Country SET Description = 'the Republic of Belarus', Updated = TO_DATE('2020-12-31 22:22:22','YYYY-MM-DD HH24:MI:SS') WHERE C_Country_ID = 129;

UPDATE C_Country SET Description = 'Canada', Updated = TO_DATE('2020-12-31 22:22:22','YYYY-MM-DD HH24:MI:SS') WHERE C_Country_ID = 109;
UPDATE C_Country SET Name = 'Cocos (Keeling) Islands',Description = 'the Cocos (Keeling) Islands', Updated = TO_DATE('2020-12-31 22:22:22','YYYY-MM-DD HH24:MI:SS') WHERE C_Country_ID = 155;
UPDATE C_Country SET Name = 'Congo (DRC)',Description = 'the Democratic Republic of the Congo', Updated = TO_DATE('2020-12-31 22:22:22','YYYY-MM-DD HH24:MI:SS') WHERE C_Country_ID = 159;
UPDATE C_Country SET Description = 'the Central African Republic', Updated = TO_DATE('2020-12-31 22:22:22','YYYY-MM-DD HH24:MI:SS') WHERE C_Country_ID = 150;
UPDATE C_Country SET Description = 'the Republic of the Congo', Updated = TO_DATE('2020-12-31 22:22:22','YYYY-MM-DD HH24:MI:SS') WHERE C_Country_ID = 158;
UPDATE C_Country SET Description = 'the Swiss Confederation', Updated = TO_DATE('2020-12-31 22:22:22','YYYY-MM-DD HH24:MI:SS') WHERE C_Country_ID = 107;
UPDATE C_Country SET Name = 'Côte d''Ivoire',Description = 'the Republic of Côte d''Ivoire', Updated = TO_DATE('2020-12-31 22:22:22','YYYY-MM-DD HH24:MI:SS') WHERE C_Country_ID = 162;
UPDATE C_Country SET Description = 'the Cook Islands', Updated = TO_DATE('2020-12-31 22:22:22','YYYY-MM-DD HH24:MI:SS') WHERE C_Country_ID = 160;
UPDATE C_Country SET Description = 'the Republic of Chile', Updated = TO_DATE('2020-12-31 22:22:22','YYYY-MM-DD HH24:MI:SS') WHERE C_Country_ID = 152;
UPDATE C_Country SET Description = 'the Republic of Cameroon', Updated = TO_DATE('2020-12-31 22:22:22','YYYY-MM-DD HH24:MI:SS') WHERE C_Country_ID = 146;
UPDATE C_Country SET Description = 'the People''s Republic of China', Updated = TO_DATE('2020-12-31 22:22:22','YYYY-MM-DD HH24:MI:SS') WHERE C_Country_ID = 153;
UPDATE C_Country SET Description = 'the Republic of Colombia', Updated = TO_DATE('2020-12-31 22:22:22','YYYY-MM-DD HH24:MI:SS') WHERE C_Country_ID = 156;
UPDATE C_Country SET Description = 'the Republic of Costa Rica', Updated = TO_DATE('2020-12-31 22:22:22','YYYY-MM-DD HH24:MI:SS') WHERE C_Country_ID = 161;
UPDATE C_Country SET Description = 'the Republic of Cuba', Updated = TO_DATE('2020-12-31 22:22:22','YYYY-MM-DD HH24:MI:SS') WHERE C_Country_ID = 164;
UPDATE C_Country SET Description = 'the Republic of Cabo Verde', Updated = TO_DATE('2020-12-31 22:22:22','YYYY-MM-DD HH24:MI:SS') WHERE C_Country_ID = 148;

UPDATE C_Country SET Description = 'the Republic of Cyprus', Updated = TO_DATE('2020-12-31 22:22:22','YYYY-MM-DD HH24:MI:SS') WHERE C_Country_ID = 165;
UPDATE C_Country SET Description = 'the Czech Republic', Updated = TO_DATE('2020-12-31 22:22:22','YYYY-MM-DD HH24:MI:SS') WHERE C_Country_ID = 166;
UPDATE C_Country SET Description = 'the Federal Republic of Germany', Updated = TO_DATE('2020-12-31 22:22:22','YYYY-MM-DD HH24:MI:SS') WHERE C_Country_ID = 101;
UPDATE C_Country SET Description = 'the Republic of Djibouti', Updated = TO_DATE('2020-12-31 22:22:22','YYYY-MM-DD HH24:MI:SS') WHERE C_Country_ID = 168;
UPDATE C_Country SET Description = 'the Kingdom of Denmark', Updated = TO_DATE('2020-12-31 22:22:22','YYYY-MM-DD HH24:MI:SS') WHERE C_Country_ID = 167;
UPDATE C_Country SET Description = 'the Commonwealth of Dominica', Updated = TO_DATE('2020-12-31 22:22:22','YYYY-MM-DD HH24:MI:SS') WHERE C_Country_ID = 169;
UPDATE C_Country SET Description = 'the Dominican Republic', Updated = TO_DATE('2020-12-31 22:22:22','YYYY-MM-DD HH24:MI:SS') WHERE C_Country_ID = 170;
UPDATE C_Country SET Description = 'the People''s Democratic Republic of Algeria', Updated = TO_DATE('2020-12-31 22:22:22','YYYY-MM-DD HH24:MI:SS') WHERE C_Country_ID = 112;
UPDATE C_Country SET Description = 'the Republic of Ecuador', Updated = TO_DATE('2020-12-31 22:22:22','YYYY-MM-DD HH24:MI:SS') WHERE C_Country_ID = 171;
UPDATE C_Country SET Description = 'the Republic of Estonia', Updated = TO_DATE('2020-12-31 22:22:22','YYYY-MM-DD HH24:MI:SS') WHERE C_Country_ID = 176;
UPDATE C_Country SET Description = 'the Arab Republic of Egypt', Updated = TO_DATE('2020-12-31 22:22:22','YYYY-MM-DD HH24:MI:SS') WHERE C_Country_ID = 172;
UPDATE C_Country SET Description = 'Western Sahara* (*Provisional name)', Updated = TO_DATE('2020-12-31 22:22:22','YYYY-MM-DD HH24:MI:SS') WHERE C_Country_ID = 344;
UPDATE C_Country SET Description = 'the State of Eritrea', Updated = TO_DATE('2020-12-31 22:22:22','YYYY-MM-DD HH24:MI:SS') WHERE C_Country_ID = 175;
UPDATE C_Country SET Description = 'the Kingdom of Spain', Updated = TO_DATE('2020-12-31 22:22:22','YYYY-MM-DD HH24:MI:SS') WHERE C_Country_ID = 106;
UPDATE C_Country SET Description = 'the Federal Democratic Republic of Ethiopia', Updated = TO_DATE('2020-12-31 22:22:22','YYYY-MM-DD HH24:MI:SS') WHERE C_Country_ID = 177;
UPDATE C_Country SET Description = 'the Republic of Finland', Updated = TO_DATE('2020-12-31 22:22:22','YYYY-MM-DD HH24:MI:SS') WHERE C_Country_ID = 181;
UPDATE C_Country SET Description = 'the Republic of Fiji', Updated = TO_DATE('2020-12-31 22:22:22','YYYY-MM-DD HH24:MI:SS') WHERE C_Country_ID = 180;
UPDATE C_Country SET Name = 'Falkland Islands [Malvinas]',Description = 'the Falkland Islands [Malvinas]', Updated = TO_DATE('2020-12-31 22:22:22','YYYY-MM-DD HH24:MI:SS') WHERE C_Country_ID = 178;
UPDATE C_Country SET Name = 'Micronesia',Description = 'the Federated States of Micronesia', Updated = TO_DATE('2020-12-31 22:22:22','YYYY-MM-DD HH24:MI:SS') WHERE C_Country_ID = 248;
UPDATE C_Country SET Description = 'the Faroe Islands', Updated = TO_DATE('2020-12-31 22:22:22','YYYY-MM-DD HH24:MI:SS') WHERE C_Country_ID = 179;
UPDATE C_Country SET Description = 'the French Republic', Updated = TO_DATE('2020-12-31 22:22:22','YYYY-MM-DD HH24:MI:SS') WHERE C_Country_ID = 102;
UPDATE C_Country SET Description = 'the Gabonese Republic', Updated = TO_DATE('2020-12-31 22:22:22','YYYY-MM-DD HH24:MI:SS') WHERE C_Country_ID = 186;
UPDATE C_Country SET Description = 'the United Kingdom of Great Britain and Northern Ireland', Updated = TO_DATE('2020-12-31 22:22:22','YYYY-MM-DD HH24:MI:SS') WHERE C_Country_ID = 333;



UPDATE C_Country SET Description = 'Guernsey', Updated = TO_DATE('2020-12-31 22:22:22','YYYY-MM-DD HH24:MI:SS') WHERE C_Country_ID = 50002;
UPDATE C_Country SET Description = 'the Republic of Ghana', Updated = TO_DATE('2020-12-31 22:22:22','YYYY-MM-DD HH24:MI:SS') WHERE C_Country_ID = 190;


UPDATE C_Country SET Description = 'the Republic of the Gambia', Updated = TO_DATE('2020-12-31 22:22:22','YYYY-MM-DD HH24:MI:SS') WHERE C_Country_ID = 187;
UPDATE C_Country SET Description = 'the Republic of Guinea', Updated = TO_DATE('2020-12-31 22:22:22','YYYY-MM-DD HH24:MI:SS') WHERE C_Country_ID = 198;

UPDATE C_Country SET Description = 'the Republic of Equatorial Guinea', Updated = TO_DATE('2020-12-31 22:22:22','YYYY-MM-DD HH24:MI:SS') WHERE C_Country_ID = 174;
UPDATE C_Country SET Description = 'the Hellenic Republic', Updated = TO_DATE('2020-12-31 22:22:22','YYYY-MM-DD HH24:MI:SS') WHERE C_Country_ID = 192;
UPDATE C_Country SET Name = 'South Georgia and The South Sandwich Islands',Description = 'South Georgia and the South Sandwich Islands', Updated = TO_DATE('2020-12-31 22:22:22','YYYY-MM-DD HH24:MI:SS') WHERE C_Country_ID = 306;
UPDATE C_Country SET Description = 'the Republic of Guatemala', Updated = TO_DATE('2020-12-31 22:22:22','YYYY-MM-DD HH24:MI:SS') WHERE C_Country_ID = 197;

UPDATE C_Country SET Description = 'the Republic of Guinea-Bissau', Updated = TO_DATE('2020-12-31 22:22:22','YYYY-MM-DD HH24:MI:SS') WHERE C_Country_ID = 199;
UPDATE C_Country SET Description = 'the Co-operative Republic of Guyana', Updated = TO_DATE('2020-12-31 22:22:22','YYYY-MM-DD HH24:MI:SS') WHERE C_Country_ID = 200;
UPDATE C_Country SET Description = 'the Hong Kong Special Administrative Region of China', Updated = TO_DATE('2020-12-31 22:22:22','YYYY-MM-DD HH24:MI:SS') WHERE C_Country_ID = 205;
UPDATE C_Country SET Name = 'Heard Island and Mcdonald Islands',Description = 'Heard Island and McDonald Islands', Updated = TO_DATE('2020-12-31 22:22:22','YYYY-MM-DD HH24:MI:SS') WHERE C_Country_ID = 202;
UPDATE C_Country SET Description = 'the Republic of Honduras', Updated = TO_DATE('2020-12-31 22:22:22','YYYY-MM-DD HH24:MI:SS') WHERE C_Country_ID = 204;
UPDATE C_Country SET Description = 'the Republic of Croatia', Updated = TO_DATE('2020-12-31 22:22:22','YYYY-MM-DD HH24:MI:SS') WHERE C_Country_ID = 163;
UPDATE C_Country SET Description = 'the Republic of Haiti', Updated = TO_DATE('2020-12-31 22:22:22','YYYY-MM-DD HH24:MI:SS') WHERE C_Country_ID = 201;

UPDATE C_Country SET Description = 'the Republic of Indonesia', Updated = TO_DATE('2020-12-31 22:22:22','YYYY-MM-DD HH24:MI:SS') WHERE C_Country_ID = 209;

UPDATE C_Country SET Description = 'the State of Israel', Updated = TO_DATE('2020-12-31 22:22:22','YYYY-MM-DD HH24:MI:SS') WHERE C_Country_ID = 213;

UPDATE C_Country SET Description = 'the Republic of India', Updated = TO_DATE('2020-12-31 22:22:22','YYYY-MM-DD HH24:MI:SS') WHERE C_Country_ID = 208;
UPDATE C_Country SET Description = 'the British Indian Ocean Territory', Updated = TO_DATE('2020-12-31 22:22:22','YYYY-MM-DD HH24:MI:SS') WHERE C_Country_ID = 140;
UPDATE C_Country SET Description = 'the Republic of Iraq', Updated = TO_DATE('2020-12-31 22:22:22','YYYY-MM-DD HH24:MI:SS') WHERE C_Country_ID = 211;
UPDATE C_Country SET Name = 'Iran',Description = 'the Islamic Republic of Iran', Updated = TO_DATE('2020-12-31 22:22:22','YYYY-MM-DD HH24:MI:SS') WHERE C_Country_ID = 210;
UPDATE C_Country SET Description = 'the Republic of Iceland', Updated = TO_DATE('2020-12-31 22:22:22','YYYY-MM-DD HH24:MI:SS') WHERE C_Country_ID = 207;
UPDATE C_Country SET Description = 'the Republic of Italy', Updated = TO_DATE('2020-12-31 22:22:22','YYYY-MM-DD HH24:MI:SS') WHERE C_Country_ID = 214;


UPDATE C_Country SET Description = 'the Hashemite Kingdom of Jordan', Updated = TO_DATE('2020-12-31 22:22:22','YYYY-MM-DD HH24:MI:SS') WHERE C_Country_ID = 217;

UPDATE C_Country SET Description = 'the Republic of Kenya', Updated = TO_DATE('2020-12-31 22:22:22','YYYY-MM-DD HH24:MI:SS') WHERE C_Country_ID = 219;
UPDATE C_Country SET Description = 'the Kyrgyz Republic', Updated = TO_DATE('2020-12-31 22:22:22','YYYY-MM-DD HH24:MI:SS') WHERE C_Country_ID = 224;
UPDATE C_Country SET Description = 'the Kingdom of Cambodia', Updated = TO_DATE('2020-12-31 22:22:22','YYYY-MM-DD HH24:MI:SS') WHERE C_Country_ID = 145;
UPDATE C_Country SET Description = 'the Republic of Kiribati', Updated = TO_DATE('2020-12-31 22:22:22','YYYY-MM-DD HH24:MI:SS') WHERE C_Country_ID = 220;
UPDATE C_Country SET Description = 'the Union of the Comoros', Updated = TO_DATE('2020-12-31 22:22:22','YYYY-MM-DD HH24:MI:SS') WHERE C_Country_ID = 157;
UPDATE C_Country SET Name = 'Saint Kitts and Nevis',Description = 'Saint Kitts and Nevis', Updated = TO_DATE('2020-12-31 22:22:22','YYYY-MM-DD HH24:MI:SS') WHERE C_Country_ID = 289;
UPDATE C_Country SET Name = 'Korea Democratic People''s Republic of',Description = 'the Democratic People''s Republic of Korea', Updated = TO_DATE('2020-12-31 22:22:22','YYYY-MM-DD HH24:MI:SS') WHERE C_Country_ID = 221;
UPDATE C_Country SET Name = 'Korea Republic of',Description = 'the Republic of Korea', Updated = TO_DATE('2020-12-31 22:22:22','YYYY-MM-DD HH24:MI:SS') WHERE C_Country_ID = 222;
UPDATE C_Country SET Description = 'the State of Kuwait', Updated = TO_DATE('2020-12-31 22:22:22','YYYY-MM-DD HH24:MI:SS') WHERE C_Country_ID = 223;
UPDATE C_Country SET Description = 'the Cayman Islands', Updated = TO_DATE('2020-12-31 22:22:22','YYYY-MM-DD HH24:MI:SS') WHERE C_Country_ID = 149;
UPDATE C_Country SET Description = 'the Republic of Kazakhstan', Updated = TO_DATE('2020-12-31 22:22:22','YYYY-MM-DD HH24:MI:SS') WHERE C_Country_ID = 218;
UPDATE C_Country SET Description = 'the Lao People''s Democratic Republic', Updated = TO_DATE('2020-12-31 22:22:22','YYYY-MM-DD HH24:MI:SS') WHERE C_Country_ID = 225;
UPDATE C_Country SET Description = 'the Lebanese Republic', Updated = TO_DATE('2020-12-31 22:22:22','YYYY-MM-DD HH24:MI:SS') WHERE C_Country_ID = 227;

UPDATE C_Country SET Description = 'the Principality of Liechtenstein', Updated = TO_DATE('2020-12-31 22:22:22','YYYY-MM-DD HH24:MI:SS') WHERE C_Country_ID = 231;
UPDATE C_Country SET Description = 'the Democratic Socialist Republic of Sri Lanka', Updated = TO_DATE('2020-12-31 22:22:22','YYYY-MM-DD HH24:MI:SS') WHERE C_Country_ID = 308;
UPDATE C_Country SET Description = 'the Republic of Liberia', Updated = TO_DATE('2020-12-31 22:22:22','YYYY-MM-DD HH24:MI:SS') WHERE C_Country_ID = 229;
UPDATE C_Country SET Description = 'the Kingdom of Lesotho', Updated = TO_DATE('2020-12-31 22:22:22','YYYY-MM-DD HH24:MI:SS') WHERE C_Country_ID = 228;
UPDATE C_Country SET Description = 'the Republic of Lithuania', Updated = TO_DATE('2020-12-31 22:22:22','YYYY-MM-DD HH24:MI:SS') WHERE C_Country_ID = 232;
UPDATE C_Country SET Description = 'the Grand Duchy of Luxembourg', Updated = TO_DATE('2020-12-31 22:22:22','YYYY-MM-DD HH24:MI:SS') WHERE C_Country_ID = 233;
UPDATE C_Country SET Description = 'the Republic of Latvia', Updated = TO_DATE('2020-12-31 22:22:22','YYYY-MM-DD HH24:MI:SS') WHERE C_Country_ID = 226;
UPDATE C_Country SET Name = 'Libya',Description = 'the State of Libya', Updated = TO_DATE('2020-12-31 22:22:22','YYYY-MM-DD HH24:MI:SS') WHERE C_Country_ID = 230;
UPDATE C_Country SET Description = 'the Kingdom of Morocco', Updated = TO_DATE('2020-12-31 22:22:22','YYYY-MM-DD HH24:MI:SS') WHERE C_Country_ID = 253;
UPDATE C_Country SET Description = 'the Principality of Monaco', Updated = TO_DATE('2020-12-31 22:22:22','YYYY-MM-DD HH24:MI:SS') WHERE C_Country_ID = 250;
UPDATE C_Country SET Name = 'Moldova',Description = 'the Republic of Moldova', Updated = TO_DATE('2020-12-31 22:22:22','YYYY-MM-DD HH24:MI:SS') WHERE C_Country_ID = 249;

UPDATE C_Country SET Description = 'Saint Martin (French part)', Updated = TO_DATE('2020-12-31 22:22:22','YYYY-MM-DD HH24:MI:SS') WHERE C_Country_ID = 50005;
UPDATE C_Country SET Description = 'the Republic of Madagascar', Updated = TO_DATE('2020-12-31 22:22:22','YYYY-MM-DD HH24:MI:SS') WHERE C_Country_ID = 236;
UPDATE C_Country SET Description = 'the Republic of the Marshall Islands', Updated = TO_DATE('2020-12-31 22:22:22','YYYY-MM-DD HH24:MI:SS') WHERE C_Country_ID = 242;
UPDATE C_Country SET Name = 'North Macedonia',Description = 'the Republic of North Macedonia', Updated = TO_DATE('2020-12-31 22:22:22','YYYY-MM-DD HH24:MI:SS') WHERE C_Country_ID = 235;
UPDATE C_Country SET Description = 'the Republic of Mali', Updated = TO_DATE('2020-12-31 22:22:22','YYYY-MM-DD HH24:MI:SS') WHERE C_Country_ID = 240;
UPDATE C_Country SET Description = 'the Republic of the Union of Myanmar', Updated = TO_DATE('2020-12-31 22:22:22','YYYY-MM-DD HH24:MI:SS') WHERE C_Country_ID = 255;

UPDATE C_Country SET Description = 'Macao Special Administrative Region of China', Updated = TO_DATE('2020-12-31 22:22:22','YYYY-MM-DD HH24:MI:SS') WHERE C_Country_ID = 234;
UPDATE C_Country SET Description = 'the Commonwealth of the Northern Mariana Islands', Updated = TO_DATE('2020-12-31 22:22:22','YYYY-MM-DD HH24:MI:SS') WHERE C_Country_ID = 268;

UPDATE C_Country SET Description = 'the Islamic Republic of Mauritania', Updated = TO_DATE('2020-12-31 22:22:22','YYYY-MM-DD HH24:MI:SS') WHERE C_Country_ID = 244;

UPDATE C_Country SET Description = 'the Republic of Malta', Updated = TO_DATE('2020-12-31 22:22:22','YYYY-MM-DD HH24:MI:SS') WHERE C_Country_ID = 241;
UPDATE C_Country SET Description = 'the Republic of Mauritius', Updated = TO_DATE('2020-12-31 22:22:22','YYYY-MM-DD HH24:MI:SS') WHERE C_Country_ID = 245;
UPDATE C_Country SET Description = 'the Republic of Maldives', Updated = TO_DATE('2020-12-31 22:22:22','YYYY-MM-DD HH24:MI:SS') WHERE C_Country_ID = 239;
UPDATE C_Country SET Description = 'the Republic of Malawi', Updated = TO_DATE('2020-12-31 22:22:22','YYYY-MM-DD HH24:MI:SS') WHERE C_Country_ID = 237;
UPDATE C_Country SET Description = 'the United Mexican States', Updated = TO_DATE('2020-12-31 22:22:22','YYYY-MM-DD HH24:MI:SS') WHERE C_Country_ID = 247;

UPDATE C_Country SET Description = 'the Republic of Mozambique', Updated = TO_DATE('2020-12-31 22:22:22','YYYY-MM-DD HH24:MI:SS') WHERE C_Country_ID = 254;
UPDATE C_Country SET Description = 'the Republic of Namibia', Updated = TO_DATE('2020-12-31 22:22:22','YYYY-MM-DD HH24:MI:SS') WHERE C_Country_ID = 256;

UPDATE C_Country SET Description = 'the Republic of the Niger', Updated = TO_DATE('2020-12-31 22:22:22','YYYY-MM-DD HH24:MI:SS') WHERE C_Country_ID = 264;

UPDATE C_Country SET Description = 'the Federal Republic of Nigeria', Updated = TO_DATE('2020-12-31 22:22:22','YYYY-MM-DD HH24:MI:SS') WHERE C_Country_ID = 265;
UPDATE C_Country SET Description = 'the Republic of Nicaragua', Updated = TO_DATE('2020-12-31 22:22:22','YYYY-MM-DD HH24:MI:SS') WHERE C_Country_ID = 263;
UPDATE C_Country SET Description = 'the Kingdom of the Netherlands', Updated = TO_DATE('2020-12-31 22:22:22','YYYY-MM-DD HH24:MI:SS') WHERE C_Country_ID = 105;
UPDATE C_Country SET Description = 'the Kingdom of Norway', Updated = TO_DATE('2020-12-31 22:22:22','YYYY-MM-DD HH24:MI:SS') WHERE C_Country_ID = 269;
UPDATE C_Country SET Description = 'the Federal Democratic Republic of Nepal', Updated = TO_DATE('2020-12-31 22:22:22','YYYY-MM-DD HH24:MI:SS') WHERE C_Country_ID = 258;
UPDATE C_Country SET Description = 'the Republic of Nauru', Updated = TO_DATE('2020-12-31 22:22:22','YYYY-MM-DD HH24:MI:SS') WHERE C_Country_ID = 257;


UPDATE C_Country SET Description = 'the Sultanate of Oman', Updated = TO_DATE('2020-12-31 22:22:22','YYYY-MM-DD HH24:MI:SS') WHERE C_Country_ID = 270;
UPDATE C_Country SET Description = 'the Republic of Panama', Updated = TO_DATE('2020-12-31 22:22:22','YYYY-MM-DD HH24:MI:SS') WHERE C_Country_ID = 274;
UPDATE C_Country SET Description = 'the Republic of Peru', Updated = TO_DATE('2020-12-31 22:22:22','YYYY-MM-DD HH24:MI:SS') WHERE C_Country_ID = 277;

UPDATE C_Country SET Description = 'the Independent State of Papua New Guinea', Updated = TO_DATE('2020-12-31 22:22:22','YYYY-MM-DD HH24:MI:SS') WHERE C_Country_ID = 275;
UPDATE C_Country SET Description = 'the Republic of the Philippines', Updated = TO_DATE('2020-12-31 22:22:22','YYYY-MM-DD HH24:MI:SS') WHERE C_Country_ID = 278;
UPDATE C_Country SET Description = 'the Islamic Republic of Pakistan', Updated = TO_DATE('2020-12-31 22:22:22','YYYY-MM-DD HH24:MI:SS') WHERE C_Country_ID = 271;
UPDATE C_Country SET Description = 'the Republic of Poland', Updated = TO_DATE('2020-12-31 22:22:22','YYYY-MM-DD HH24:MI:SS') WHERE C_Country_ID = 280;
UPDATE C_Country SET Name = 'Saint Pierre and Miquelon',Description = 'Saint Pierre and Miquelon', Updated = TO_DATE('2020-12-31 22:22:22','YYYY-MM-DD HH24:MI:SS') WHERE C_Country_ID = 291;


UPDATE C_Country SET Name = 'Palestinian State of',Description = 'the State of Palestine', Updated = TO_DATE('2020-12-31 22:22:22','YYYY-MM-DD HH24:MI:SS') WHERE C_Country_ID = 273;
UPDATE C_Country SET Description = 'the Portuguese Republic', Updated = TO_DATE('2020-12-31 22:22:22','YYYY-MM-DD HH24:MI:SS') WHERE C_Country_ID = 281;
UPDATE C_Country SET Description = 'the Republic of Palau', Updated = TO_DATE('2020-12-31 22:22:22','YYYY-MM-DD HH24:MI:SS') WHERE C_Country_ID = 272;
UPDATE C_Country SET Description = 'the Republic of Paraguay', Updated = TO_DATE('2020-12-31 22:22:22','YYYY-MM-DD HH24:MI:SS') WHERE C_Country_ID = 276;
UPDATE C_Country SET Description = 'the State of Qatar', Updated = TO_DATE('2020-12-31 22:22:22','YYYY-MM-DD HH24:MI:SS') WHERE C_Country_ID = 283;
UPDATE C_Country SET Description = 'Réunion', Updated = TO_DATE('2020-12-31 22:22:22','YYYY-MM-DD HH24:MI:SS') WHERE C_Country_ID = 284;

UPDATE C_Country SET Description = 'the Republic of Serbia', Updated = TO_DATE('2020-12-31 22:22:22','YYYY-MM-DD HH24:MI:SS') WHERE C_Country_ID = 349;
UPDATE C_Country SET Name = 'Russia',Description = 'the Russian Federation', Updated = TO_DATE('2020-12-31 22:22:22','YYYY-MM-DD HH24:MI:SS') WHERE C_Country_ID = 286;
UPDATE C_Country SET Description = 'the Republic of Rwanda', Updated = TO_DATE('2020-12-31 22:22:22','YYYY-MM-DD HH24:MI:SS') WHERE C_Country_ID = 287;
UPDATE C_Country SET Description = 'the Kingdom of Saudi Arabia', Updated = TO_DATE('2020-12-31 22:22:22','YYYY-MM-DD HH24:MI:SS') WHERE C_Country_ID = 296;

UPDATE C_Country SET Description = 'the Republic of Seychelles', Updated = TO_DATE('2020-12-31 22:22:22','YYYY-MM-DD HH24:MI:SS') WHERE C_Country_ID = 298;
UPDATE C_Country SET Description = 'the Republic of the Sudan', Updated = TO_DATE('2020-12-31 22:22:22','YYYY-MM-DD HH24:MI:SS') WHERE C_Country_ID = 309;
UPDATE C_Country SET Description = 'the Kingdom of Sweden', Updated = TO_DATE('2020-12-31 22:22:22','YYYY-MM-DD HH24:MI:SS') WHERE C_Country_ID = 313;
UPDATE C_Country SET Description = 'the Republic of Singapore', Updated = TO_DATE('2020-12-31 22:22:22','YYYY-MM-DD HH24:MI:SS') WHERE C_Country_ID = 300;
UPDATE C_Country SET Description = 'Saint Helena, Ascension and Tristan da Cunha', Updated = TO_DATE('2020-12-31 22:22:22','YYYY-MM-DD HH24:MI:SS') WHERE C_Country_ID = 288;
UPDATE C_Country SET Description = 'the Republic of Slovenia', Updated = TO_DATE('2020-12-31 22:22:22','YYYY-MM-DD HH24:MI:SS') WHERE C_Country_ID = 302;
UPDATE C_Country SET Name = 'Svalbard and Jan Mayen',Description = 'Svalbard and Jan Mayen', Updated = TO_DATE('2020-12-31 22:22:22','YYYY-MM-DD HH24:MI:SS') WHERE C_Country_ID = 311;
UPDATE C_Country SET Description = 'the Slovak Republic', Updated = TO_DATE('2020-12-31 22:22:22','YYYY-MM-DD HH24:MI:SS') WHERE C_Country_ID = 301;
UPDATE C_Country SET Description = 'the Republic of Sierra Leone', Updated = TO_DATE('2020-12-31 22:22:22','YYYY-MM-DD HH24:MI:SS') WHERE C_Country_ID = 299;
UPDATE C_Country SET Description = 'the Republic of San Marino', Updated = TO_DATE('2020-12-31 22:22:22','YYYY-MM-DD HH24:MI:SS') WHERE C_Country_ID = 294;
UPDATE C_Country SET Description = 'the Republic of Senegal', Updated = TO_DATE('2020-12-31 22:22:22','YYYY-MM-DD HH24:MI:SS') WHERE C_Country_ID = 297;
UPDATE C_Country SET Description = 'the Federal Republic of Somalia', Updated = TO_DATE('2020-12-31 22:22:22','YYYY-MM-DD HH24:MI:SS') WHERE C_Country_ID = 304;
UPDATE C_Country SET Description = 'the Republic of Suriname', Updated = TO_DATE('2020-12-31 22:22:22','YYYY-MM-DD HH24:MI:SS') WHERE C_Country_ID = 310;
UPDATE C_Country SET Name = 'Sao Tome and Principe',Description = 'the Democratic Republic of Sao Tome and Principe', Updated = TO_DATE('2020-12-31 22:22:22','YYYY-MM-DD HH24:MI:SS') WHERE C_Country_ID = 295;
UPDATE C_Country SET Description = 'the Republic of El Salvador', Updated = TO_DATE('2020-12-31 22:22:22','YYYY-MM-DD HH24:MI:SS') WHERE C_Country_ID = 173;
UPDATE C_Country SET Name = 'Syria',Description = 'the Syrian Arab Republic', Updated = TO_DATE('2020-12-31 22:22:22','YYYY-MM-DD HH24:MI:SS') WHERE C_Country_ID = 315;
UPDATE C_Country SET Name = 'Eswatini',Description = 'the Kingdom of Eswatini', Updated = TO_DATE('2020-12-31 22:22:22','YYYY-MM-DD HH24:MI:SS') WHERE C_Country_ID = 312;
UPDATE C_Country SET Name = 'Turks and Caicos Islands',Description = 'the Turks and Caicos Islands', Updated = TO_DATE('2020-12-31 22:22:22','YYYY-MM-DD HH24:MI:SS') WHERE C_Country_ID = 328;
UPDATE C_Country SET Description = 'the Republic of Chad', Updated = TO_DATE('2020-12-31 22:22:22','YYYY-MM-DD HH24:MI:SS') WHERE C_Country_ID = 151;
UPDATE C_Country SET Description = 'the French Southern Territories', Updated = TO_DATE('2020-12-31 22:22:22','YYYY-MM-DD HH24:MI:SS') WHERE C_Country_ID = 185;
UPDATE C_Country SET Description = 'the Togolese Republic', Updated = TO_DATE('2020-12-31 22:22:22','YYYY-MM-DD HH24:MI:SS') WHERE C_Country_ID = 321;
UPDATE C_Country SET Description = 'the Kingdom of Thailand', Updated = TO_DATE('2020-12-31 22:22:22','YYYY-MM-DD HH24:MI:SS') WHERE C_Country_ID = 319;
UPDATE C_Country SET Description = 'the Republic of Tajikistan', Updated = TO_DATE('2020-12-31 22:22:22','YYYY-MM-DD HH24:MI:SS') WHERE C_Country_ID = 317;

UPDATE C_Country SET Description = 'Timor-Leste', Updated = TO_DATE('2020-12-31 22:22:22','YYYY-MM-DD HH24:MI:SS') WHERE C_Country_ID = 320;

UPDATE C_Country SET Description = 'the Republic of Tunisia', Updated = TO_DATE('2020-12-31 22:22:22','YYYY-MM-DD HH24:MI:SS') WHERE C_Country_ID = 325;
UPDATE C_Country SET Description = 'the Kingdom of Tonga', Updated = TO_DATE('2020-12-31 22:22:22','YYYY-MM-DD HH24:MI:SS') WHERE C_Country_ID = 323;
UPDATE C_Country SET Description = 'the Republic of Turkey', Updated = TO_DATE('2020-12-31 22:22:22','YYYY-MM-DD HH24:MI:SS') WHERE C_Country_ID = 326;
UPDATE C_Country SET Name = 'Trinidad and Tobago',Description = 'the Republic of Trinidad and Tobago', Updated = TO_DATE('2020-12-31 22:22:22','YYYY-MM-DD HH24:MI:SS') WHERE C_Country_ID = 324;

UPDATE C_Country SET Description = 'Taiwan (Province of China)', Updated = TO_DATE('2020-12-31 22:22:22','YYYY-MM-DD HH24:MI:SS') WHERE C_Country_ID = 316;
UPDATE C_Country SET Name = 'Tanzania',Description = 'the United Republic of Tanzania', Updated = TO_DATE('2020-12-31 22:22:22','YYYY-MM-DD HH24:MI:SS') WHERE C_Country_ID = 318;

UPDATE C_Country SET Description = 'the Republic of Uganda', Updated = TO_DATE('2020-12-31 22:22:22','YYYY-MM-DD HH24:MI:SS') WHERE C_Country_ID = 330;
UPDATE C_Country SET Description = 'the United States Minor Outlying Islands', Updated = TO_DATE('2020-12-31 22:22:22','YYYY-MM-DD HH24:MI:SS') WHERE C_Country_ID = 335;
UPDATE C_Country SET Description = 'the United States of America', Updated = TO_DATE('2020-12-31 22:22:22','YYYY-MM-DD HH24:MI:SS') WHERE C_Country_ID = 100;
UPDATE C_Country SET Description = 'the Eastern Republic of Uruguay', Updated = TO_DATE('2020-12-31 22:22:22','YYYY-MM-DD HH24:MI:SS') WHERE C_Country_ID = 336;
UPDATE C_Country SET Description = 'the Republic of Uzbekistan', Updated = TO_DATE('2020-12-31 22:22:22','YYYY-MM-DD HH24:MI:SS') WHERE C_Country_ID = 337;
UPDATE C_Country SET Name = 'Holy See (Vatican City State)',Description = 'the Holy See', Updated = TO_DATE('2020-12-31 22:22:22','YYYY-MM-DD HH24:MI:SS') WHERE C_Country_ID = 203;
UPDATE C_Country SET Name = 'Saint Vincent and The Grenadines',Description = 'Saint Vincent and the Grenadines', Updated = TO_DATE('2020-12-31 22:22:22','YYYY-MM-DD HH24:MI:SS') WHERE C_Country_ID = 292;
UPDATE C_Country SET Description = 'the Bolivarian Republic of Venezuela', Updated = TO_DATE('2020-12-31 22:22:22','YYYY-MM-DD HH24:MI:SS') WHERE C_Country_ID = 339;
UPDATE C_Country SET Description = 'the British Virgin Islands', Updated = TO_DATE('2020-12-31 22:22:22','YYYY-MM-DD HH24:MI:SS') WHERE C_Country_ID = 341;
UPDATE C_Country SET Name = 'Virgin Islands',Description = 'the Virgin Islands of the United States', Updated = TO_DATE('2020-12-31 22:22:22','YYYY-MM-DD HH24:MI:SS') WHERE C_Country_ID = 342;
UPDATE C_Country SET Description = 'the Socialist Republic of Viet Nam', Updated = TO_DATE('2020-12-31 22:22:22','YYYY-MM-DD HH24:MI:SS') WHERE C_Country_ID = 340;
UPDATE C_Country SET Description = 'the Republic of Vanuatu', Updated = TO_DATE('2020-12-31 22:22:22','YYYY-MM-DD HH24:MI:SS') WHERE C_Country_ID = 338;
UPDATE C_Country SET Name = 'Wallis and Futuna',Description = 'Wallis and Futuna Islands', Updated = TO_DATE('2020-12-31 22:22:22','YYYY-MM-DD HH24:MI:SS') WHERE C_Country_ID = 343;
UPDATE C_Country SET Description = 'the Independent State of Samoa', Updated = TO_DATE('2020-12-31 22:22:22','YYYY-MM-DD HH24:MI:SS') WHERE C_Country_ID = 293;
UPDATE C_Country SET Description = 'the Republic of Yemen', Updated = TO_DATE('2020-12-31 22:22:22','YYYY-MM-DD HH24:MI:SS') WHERE C_Country_ID = 345;


UPDATE C_Country SET Description = 'the Republic of South Africa', Updated = TO_DATE('2020-12-31 22:22:22','YYYY-MM-DD HH24:MI:SS') WHERE C_Country_ID = 305;
UPDATE C_Country SET Description = 'the Republic of Zambia', Updated = TO_DATE('2020-12-31 22:22:22','YYYY-MM-DD HH24:MI:SS') WHERE C_Country_ID = 347;
UPDATE C_Country SET Description = 'the Republic of Zimbabwe', Updated = TO_DATE('2020-12-31 22:22:22','YYYY-MM-DD HH24:MI:SS') WHERE C_Country_ID = 348;

SELECT register_migration_script('202012310900_IDEMPIERE-4568.sql') FROM dual
;