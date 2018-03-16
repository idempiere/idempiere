-- IDEMPIERE-3660 Improve Packin - allow application on all tenants
-- Mar 15, 2018 4:09:45 PM BRT
INSERT INTO AD_Process (AD_Process_ID,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,Name,Description,Help,IsReport,Value,IsDirectPrint,Classname,AccessLevel,EntityType,Statistic_Count,Statistic_Seconds,IsBetaFunctionality,IsServerProcess,ShowHelp,CopyFromProcess,AD_Process_UU) VALUES (200099,0,0,'Y',TO_TIMESTAMP('2018-03-15 16:09:44','YYYY-MM-DD HH24:MI:SS'),100,TO_TIMESTAMP('2018-03-15 16:09:44','YYYY-MM-DD HH24:MI:SS'),100,'Apply Pack In from Folder','Apply all zip files from a folder following the rules and conventions of Automatic Pack In process','This process apply all the pack in files found in a folder recursively - ordered by timestamp.
The filename of the pack in files is important, it must follow the following convention:
[Timestamp]_[ClientValue][_AdditionalInformation].zip
* Timestamp: must be in the format yyyymmddHHMM
* ClientValue: case sensitive and compared against AD_Client.Value to find the tenant where the pack in must be applied
* AdditionalInformation: Any additional information to identify the zip file
NOTE that AD_Client.Value must not contain underscore in order for this process to work.
There is a special case for ClientValue, if the ClientValue is ALL-CLIENTS then the 2pack is intended to be applied in all active non-system clients.
If there is a need to apply initially in a seed tenant then the ClientValue must take the form ALL-CLIENTS-Seed.
For example:
201803151607_ALL-CLIENTS-GardenWorld_Test123.zip','N','ApplyPackInFolder','N','org.adempiere.pipo2.PackInFolder','4','D',0,0,'N','N','Y','N','670d19a4-8072-46c8-9e66-3cb3008d18f3')
;

-- Mar 15, 2018 4:10:09 PM BRT
INSERT INTO AD_Menu (AD_Menu_ID,Name,Description,"action",AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,IsSummary,AD_Process_ID,IsSOTrx,IsReadOnly,EntityType,IsCentrallyMaintained,AD_Menu_UU) VALUES (200153,'Apply Pack In from Folder','Apply all zip files from a folder following the rules and conventions of Automatic Pack In process','P',0,0,'Y',TO_TIMESTAMP('2018-03-15 16:10:09','YYYY-MM-DD HH24:MI:SS'),100,TO_TIMESTAMP('2018-03-15 16:10:09','YYYY-MM-DD HH24:MI:SS'),100,'N',200099,'Y','N','D','Y','dee67807-ff1c-45c8-94bd-5c025c3ec902')
;

-- Mar 15, 2018 4:10:09 PM BRT
INSERT INTO AD_TreeNodeMM (AD_Client_ID,AD_Org_ID, IsActive,Created,CreatedBy,Updated,UpdatedBy, AD_Tree_ID, Node_ID, Parent_ID, SeqNo, AD_TreeNodeMM_UU) SELECT t.AD_Client_ID, 0, 'Y', statement_timestamp(), 100, statement_timestamp(), 100,t.AD_Tree_ID, 200153, 0, 999, Generate_UUID() FROM AD_Tree t WHERE t.AD_Client_ID=0 AND t.IsActive='Y' AND t.IsAllNodes='Y' AND t.TreeType='MM' AND NOT EXISTS (SELECT * FROM AD_TreeNodeMM e WHERE e.AD_Tree_ID=t.AD_Tree_ID AND Node_ID=200153)
;

-- Mar 15, 2018 4:10:13 PM BRT
UPDATE AD_TreeNodeMM SET Parent_ID=50001, SeqNo=0, Updated=statement_timestamp() WHERE AD_Tree_ID=10 AND Node_ID=50004
;

-- Mar 15, 2018 4:10:13 PM BRT
UPDATE AD_TreeNodeMM SET Parent_ID=50001, SeqNo=1, Updated=statement_timestamp() WHERE AD_Tree_ID=10 AND Node_ID=50006
;

-- Mar 15, 2018 4:10:13 PM BRT
UPDATE AD_TreeNodeMM SET Parent_ID=50001, SeqNo=2, Updated=statement_timestamp() WHERE AD_Tree_ID=10 AND Node_ID=50002
;

-- Mar 15, 2018 4:10:13 PM BRT
UPDATE AD_TreeNodeMM SET Parent_ID=50001, SeqNo=3, Updated=statement_timestamp() WHERE AD_Tree_ID=10 AND Node_ID=50003
;

-- Mar 15, 2018 4:10:13 PM BRT
UPDATE AD_TreeNodeMM SET Parent_ID=50001, SeqNo=4, Updated=statement_timestamp() WHERE AD_Tree_ID=10 AND Node_ID=200153
;

-- Mar 15, 2018 4:12:47 PM BRT
INSERT INTO AD_Process_Para (AD_Process_Para_ID,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,Name,Description,AD_Process_ID,SeqNo,AD_Reference_ID,IsRange,FieldLength,IsMandatory,ColumnName,IsCentrallyMaintained,EntityType,AD_Element_ID,AD_Process_Para_UU,IsEncrypted) VALUES (200226,0,0,'Y',TO_TIMESTAMP('2018-03-15 16:12:46','YYYY-MM-DD HH24:MI:SS'),100,TO_TIMESTAMP('2018-03-15 16:12:46','YYYY-MM-DD HH24:MI:SS'),100,'Folder','Path on the server where the pack in files are located',200099,10,10,'N',1000,'Y','Folder','N','D',3012,'e0c4b099-68ba-48fe-b629-043befec7bbe','N')
;

-- Mar 15, 2018 4:43:24 PM BRT
UPDATE AD_Process SET Help='<p>This process apply all the pack in files found in a folder recursively - ordered by timestamp.<br />
The filename of the pack in files is important, it must follow the following convention:<br />
[Timestamp]_[ClientValue][_AdditionalInformation].zip</p>

<ul>
	<li><strong>Timestamp:</strong> must be in the format yyyymmddHHMM</li>
	<li><strong>ClientValue:</strong> case sensitive and compared against AD_Client.Value to find the tenant where the pack in must be applied</li>
	<li><strong>AdditionalInformation:</strong> Any additional information to identify the zip file</li>
</ul>

<p>NOTE that AD_Client.Value must not contain underscore in order for this process to work.<br />
There is a special case for ClientValue, if the ClientValue is ALL-CLIENTS then the 2pack is intended to be applied in all active non-system clients.<br />
If there is a need to apply initially in a seed tenant then the ClientValue must take the form ALL-CLIENTS-Seed.<br />
For example:<br />
201803151607_ALL-CLIENTS-GardenWorld_Test123.zip</p>
',Updated=TO_TIMESTAMP('2018-03-15 16:43:24','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Process_ID=200099
;

SELECT register_migration_script('201803151613_IDEMPIERE-3660.sql') FROM dual
;

