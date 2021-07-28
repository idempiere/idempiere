-- 2021-07-20 11:17:11
UPDATE C_Country SET HasRegion='Y',Updated=TO_TIMESTAMP('2021-07-20 11:17:11','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=0 WHERE C_Country_ID=108
;

-- 2021-07-20 11:17:39
INSERT INTO C_Region (C_Region_ID,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,Name,C_Country_ID,IsDefault,C_Region_UU) VALUES (200142,0,0,'Y',TO_TIMESTAMP('2021-07-20 11:17:39','YYYY-MM-DD HH24:MI:SS'),0,TO_TIMESTAMP('2021-07-20 11:17:39','YYYY-MM-DD HH24:MI:SS'),0,'Vienna',108,'N','d8b62d23-b496-4836-a18a-a4636db5e8d7')
;

-- 2021-07-20 11:17:51
INSERT INTO C_Region (C_Region_ID,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,Name,C_Country_ID,IsDefault,C_Region_UU) VALUES (200143,0,0,'Y',TO_TIMESTAMP('2021-07-20 11:17:50','YYYY-MM-DD HH24:MI:SS'),0,TO_TIMESTAMP('2021-07-20 11:17:50','YYYY-MM-DD HH24:MI:SS'),0,'Lower Austria',108,'N','03f98726-ec28-463e-95ad-73125941bbf3')
;

-- 2021-07-20 11:17:59
INSERT INTO C_Region (C_Region_ID,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,Name,C_Country_ID,IsDefault,C_Region_UU) VALUES (200144,0,0,'Y',TO_TIMESTAMP('2021-07-20 11:17:58','YYYY-MM-DD HH24:MI:SS'),0,TO_TIMESTAMP('2021-07-20 11:17:58','YYYY-MM-DD HH24:MI:SS'),0,'Upper Austria',108,'N','ef82444a-13bf-4ec3-974d-b56a917c459f')
;

-- 2021-07-20 11:18:10
INSERT INTO C_Region (C_Region_ID,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,Name,C_Country_ID,IsDefault,C_Region_UU) VALUES (200145,0,0,'Y',TO_TIMESTAMP('2021-07-20 11:18:10','YYYY-MM-DD HH24:MI:SS'),0,TO_TIMESTAMP('2021-07-20 11:18:10','YYYY-MM-DD HH24:MI:SS'),0,'Styria',108,'N','6cb4cb61-35d7-4e2b-93e3-6398c89cfbb4')
;

-- 2021-07-20 11:18:17
INSERT INTO C_Region (C_Region_ID,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,Name,C_Country_ID,IsDefault,C_Region_UU) VALUES (200146,0,0,'Y',TO_TIMESTAMP('2021-07-20 11:18:17','YYYY-MM-DD HH24:MI:SS'),0,TO_TIMESTAMP('2021-07-20 11:18:17','YYYY-MM-DD HH24:MI:SS'),0,'Tyrol',108,'N','5a5e1aef-9f7b-429c-926b-fb76d279afc2')
;

-- 2021-07-20 11:18:23
INSERT INTO C_Region (C_Region_ID,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,Name,C_Country_ID,IsDefault,C_Region_UU) VALUES (200147,0,0,'Y',TO_TIMESTAMP('2021-07-20 11:18:23','YYYY-MM-DD HH24:MI:SS'),0,TO_TIMESTAMP('2021-07-20 11:18:23','YYYY-MM-DD HH24:MI:SS'),0,'Carinthia',108,'N','9512f0a7-e2a3-41fe-9f89-0f705f2214bd')
;

-- 2021-07-20 11:18:29
INSERT INTO C_Region (C_Region_ID,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,Name,C_Country_ID,IsDefault,C_Region_UU) VALUES (200148,0,0,'Y',TO_TIMESTAMP('2021-07-20 11:18:29','YYYY-MM-DD HH24:MI:SS'),0,TO_TIMESTAMP('2021-07-20 11:18:29','YYYY-MM-DD HH24:MI:SS'),0,'Salzburg',108,'N','b1825958-a7e7-4344-bbf8-e6d7b97aa75b')
;

-- 2021-07-20 11:18:34
INSERT INTO C_Region (C_Region_ID,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,Name,C_Country_ID,IsDefault,C_Region_UU) VALUES (200149,0,0,'Y',TO_TIMESTAMP('2021-07-20 11:18:33','YYYY-MM-DD HH24:MI:SS'),0,TO_TIMESTAMP('2021-07-20 11:18:33','YYYY-MM-DD HH24:MI:SS'),0,'Vorarlberg',108,'N','cce93522-6b68-4c1c-954d-0775a12aaeba')
;

-- 2021-07-20 11:18:39
INSERT INTO C_Region (C_Region_ID,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,Name,C_Country_ID,IsDefault,C_Region_UU) VALUES (200150,0,0,'Y',TO_TIMESTAMP('2021-07-20 11:18:39','YYYY-MM-DD HH24:MI:SS'),0,TO_TIMESTAMP('2021-07-20 11:18:39','YYYY-MM-DD HH24:MI:SS'),0,'Burgenland',108,'N','642e5fab-842d-4b1f-abf8-65f408326b43')
;

SELECT register_migration_script('202107201120_IDEMPIERE-4884.sql') FROM dual
;
