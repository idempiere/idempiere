-- Feb 8, 2013 1:57:14 PM SGT
-- Ticket #1002211: Create Help pane for Bizidium
UPDATE AD_Element SET Name='Context Type', PrintName='Context Type',Updated=TO_TIMESTAMP('2013-02-08 13:57:14','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Element_ID=202214
;

-- Feb 8, 2013 1:57:15 PM SGT
-- Ticket #1002211: Create Help pane for Bizidium
UPDATE AD_Element_Trl SET IsTranslated='N' WHERE AD_Element_ID=202214
;

-- Feb 8, 2013 1:57:15 PM SGT
-- Ticket #1002211: Create Help pane for Bizidium
UPDATE AD_Column SET ColumnName='CtxType', Name='Context Type', Description=NULL, Help=NULL WHERE AD_Element_ID=202214
;

-- Feb 8, 2013 1:57:15 PM SGT
-- Ticket #1002211: Create Help pane for Bizidium
UPDATE AD_Process_Para SET ColumnName='CtxType', Name='Context Type', Description=NULL, Help=NULL, AD_Element_ID=202214 WHERE UPPER(ColumnName)='CTXTYPE' AND IsCentrallyMaintained='Y' AND AD_Element_ID IS NULL
;

-- Feb 8, 2013 1:57:15 PM SGT
-- Ticket #1002211: Create Help pane for Bizidium
UPDATE AD_Process_Para SET ColumnName='CtxType', Name='Context Type', Description=NULL, Help=NULL WHERE AD_Element_ID=202214 AND IsCentrallyMaintained='Y'
;

-- Feb 8, 2013 1:57:15 PM SGT
-- Ticket #1002211: Create Help pane for Bizidium
UPDATE AD_InfoColumn SET ColumnName='CtxType', Name='Context Type', Description=NULL, Help=NULL WHERE AD_Element_ID=202214 AND IsCentrallyMaintained='Y'
;

-- Feb 8, 2013 1:57:16 PM SGT
-- Ticket #1002211: Create Help pane for Bizidium
UPDATE AD_Field SET Name='Context Type', Description=NULL, Help=NULL WHERE AD_Column_ID IN (SELECT AD_Column_ID FROM AD_Column WHERE AD_Element_ID=202214) AND IsCentrallyMaintained='Y'
;

-- Feb 8, 2013 1:57:16 PM SGT
-- Ticket #1002211: Create Help pane for Bizidium
UPDATE AD_PrintFormatItem SET PrintName='Context Type', Name='Context Type' WHERE IsCentrallyMaintained='Y' AND EXISTS (SELECT * FROM AD_Column c WHERE c.AD_Column_ID=AD_PrintFormatItem.AD_Column_ID AND c.AD_Element_ID=202214)
;

-- Feb 8, 2013 2:02:49 PM SGT
-- Ticket #1002211: Create Help pane for Bizidium
UPDATE AD_Element SET Help='The Context Type field indicates the type of context help (tab, process, form etc) this context help is defined as', Description='Type of Context Help',Updated=TO_TIMESTAMP('2013-02-08 14:02:49','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Element_ID=202214
;

-- Feb 8, 2013 2:02:49 PM SGT
-- Ticket #1002211: Create Help pane for Bizidium
UPDATE AD_Element_Trl SET IsTranslated='N' WHERE AD_Element_ID=202214
;

-- Feb 8, 2013 2:02:49 PM SGT
-- Ticket #1002211: Create Help pane for Bizidium
UPDATE AD_Column SET ColumnName='CtxType', Name='Context Type', Description='Type of Context Help', Help='The Context Type field indicates the type of context help (tab, process, form etc) this context help is defined as' WHERE AD_Element_ID=202214
;

-- Feb 8, 2013 2:02:50 PM SGT
-- Ticket #1002211: Create Help pane for Bizidium
UPDATE AD_Process_Para SET ColumnName='CtxType', Name='Context Type', Description='Type of Context Help', Help='The Context Type field indicates the type of context help (tab, process, form etc) this context help is defined as', AD_Element_ID=202214 WHERE UPPER(ColumnName)='CTXTYPE' AND IsCentrallyMaintained='Y' AND AD_Element_ID IS NULL
;

-- Feb 8, 2013 2:02:50 PM SGT
-- Ticket #1002211: Create Help pane for Bizidium
UPDATE AD_Process_Para SET ColumnName='CtxType', Name='Context Type', Description='Type of Context Help', Help='The Context Type field indicates the type of context help (tab, process, form etc) this context help is defined as' WHERE AD_Element_ID=202214 AND IsCentrallyMaintained='Y'
;

-- Feb 8, 2013 2:02:50 PM SGT
-- Ticket #1002211: Create Help pane for Bizidium
UPDATE AD_InfoColumn SET ColumnName='CtxType', Name='Context Type', Description='Type of Context Help', Help='The Context Type field indicates the type of context help (tab, process, form etc) this context help is defined as' WHERE AD_Element_ID=202214 AND IsCentrallyMaintained='Y'
;

-- Feb 8, 2013 2:02:50 PM SGT
-- Ticket #1002211: Create Help pane for Bizidium
UPDATE AD_Field SET Name='Context Type', Description='Type of Context Help', Help='The Context Type field indicates the type of context help (tab, process, form etc) this context help is defined as' WHERE AD_Column_ID IN (SELECT AD_Column_ID FROM AD_Column WHERE AD_Element_ID=202214) AND IsCentrallyMaintained='Y'
;

-- Feb 8, 2013 2:20:41 PM SGT
-- Ticket #1002211: Create Help pane for Bizidium
UPDATE AD_Window SET Help='The Context Help window defines the context help message text to display in the help pane. It is for Web UI only.', Description='Maintain Context Helps',Updated=TO_TIMESTAMP('2013-02-08 14:20:41','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Window_ID=200034
;

-- Feb 8, 2013 2:20:41 PM SGT
-- Ticket #1002211: Create Help pane for Bizidium
UPDATE AD_Window_Trl SET IsTranslated='N' WHERE AD_Window_ID=200034
;

-- Feb 8, 2013 2:20:41 PM SGT
-- Ticket #1002211: Create Help pane for Bizidium
UPDATE AD_Menu SET Name='Context Help', Description='Maintain Context Helps', IsActive='Y',Updated=TO_TIMESTAMP('2013-02-08 14:20:41','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Menu_ID=200038
;

-- Feb 8, 2013 2:20:41 PM SGT
-- Ticket #1002211: Create Help pane for Bizidium
UPDATE AD_Menu_Trl SET IsTranslated='N' WHERE AD_Menu_ID=200038
;

-- Feb 8, 2013 2:23:28 PM SGT
-- Ticket #1002211: Create Help pane for Bizidium
UPDATE AD_Tab SET Help='The Context Help tab defines the type of context help', Description='Maintain Context Helps',Updated=TO_TIMESTAMP('2013-02-08 14:23:28','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Tab_ID=200074
;

-- Feb 8, 2013 2:23:28 PM SGT
-- Ticket #1002211: Create Help pane for Bizidium
UPDATE AD_Tab_Trl SET IsTranslated='N' WHERE AD_Tab_ID=200074
;

-- Feb 8, 2013 2:24:23 PM SGT
-- Ticket #1002211: Create Help pane for Bizidium
UPDATE AD_Tab SET Help='The Message tab displays message text', Description='Context Help Messages',Updated=TO_TIMESTAMP('2013-02-08 14:24:23','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Tab_ID=200075
;

-- Feb 8, 2013 2:24:23 PM SGT
-- Ticket #1002211: Create Help pane for Bizidium
UPDATE AD_Tab_Trl SET IsTranslated='N' WHERE AD_Tab_ID=200075
;

-- Feb 8, 2013 2:24:32 PM SGT
-- Ticket #1002211: Create Help pane for Bizidium
UPDATE AD_Tab SET Description='Context Helps',Updated=TO_TIMESTAMP('2013-02-08 14:24:32','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Tab_ID=200074
;

-- Feb 8, 2013 2:24:32 PM SGT
-- Ticket #1002211: Create Help pane for Bizidium
UPDATE AD_Tab_Trl SET IsTranslated='N' WHERE AD_Tab_ID=200074
;

SELECT register_migration_script('201302081706_TICKET-1002211.sql') FROM dual
;