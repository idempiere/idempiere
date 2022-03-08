UPDATE AD_Element SET Description=REPLACE(Description, 'client', 'tenant') WHERE AD_Element_ID<1000000 AND Description~'\mclient\M' AND Description NOT LIKE '%client-%';

UPDATE AD_Element SET Description=REPLACE(Description, 'clients', 'tenants') WHERE AD_Element_ID<1000000 AND Description~'\mclients\M';

UPDATE AD_Element SET Description=REPLACE(Description, 'Client', 'Tenant') WHERE AD_Element_ID<1000000 AND Description~'\mClient\M';

UPDATE AD_Element SET Description=REPLACE(Description, 'Clients', 'Tenants') WHERE AD_Element_ID<1000000 AND Description~'\mClients\M';

UPDATE AD_Element SET Help=REPLACE(Help, 'client', 'tenant') WHERE AD_Element_ID<1000000 AND Help~'\mclient\M' AND Help NOT LIKE '%client-%';

UPDATE AD_Element SET Help=REPLACE(Help, 'clients', 'tenants') WHERE AD_Element_ID<1000000 AND Help~'\mclients\M';

UPDATE AD_Element SET Help=REPLACE(Help, 'Client', 'Tenant') WHERE AD_Element_ID<1000000 AND Help~'\mClient\M';

UPDATE AD_Element SET Help=REPLACE(Help, 'Clients', 'Tenants') WHERE AD_Element_ID<1000000 AND Help~'\mClients\M';

UPDATE AD_Element SET Name=REPLACE(Name, 'client', 'tenant') WHERE AD_Element_ID<1000000 AND Name~'\mclient\M' AND Name NOT LIKE '%client-%';

UPDATE AD_Element SET Name=REPLACE(Name, 'clients', 'tenants') WHERE AD_Element_ID<1000000 AND Name~'\mclients\M';

UPDATE AD_Element SET Name=REPLACE(Name, 'Client', 'Tenant') WHERE AD_Element_ID<1000000 AND Name~'\mClient\M';

UPDATE AD_Element SET Name=REPLACE(Name, 'Clients', 'Tenants') WHERE AD_Element_ID<1000000 AND Name~'\mClients\M';

UPDATE AD_Element SET PrintName=REPLACE(PrintName, 'client', 'tenant') WHERE AD_Element_ID<1000000 AND PrintName~'\mclient\M' AND PrintName NOT LIKE '%client-%';

UPDATE AD_Element SET PrintName=REPLACE(PrintName, 'clients', 'tenants') WHERE AD_Element_ID<1000000 AND PrintName~'\mclients\M';

UPDATE AD_Element SET PrintName=REPLACE(PrintName, 'Client', 'Tenant') WHERE AD_Element_ID<1000000 AND PrintName~'\mClient\M';

UPDATE AD_Element SET PrintName=REPLACE(PrintName, 'Clients', 'Tenants') WHERE AD_Element_ID<1000000 AND PrintName~'\mClients\M';

UPDATE AD_Field SET Help=REPLACE(Help, 'client', 'tenant') WHERE AD_Field_ID<1000000 AND Help~'\mclient\M' AND Help NOT LIKE '%client-%' AND IsCentrallyMaintained='N';

UPDATE AD_Field SET Help=REPLACE(Help, 'clients', 'tenants') WHERE AD_Field_ID<1000000 AND Help~'\mclients\M' AND IsCentrallyMaintained='N';

UPDATE AD_Field SET Help=REPLACE(Help, 'Client', 'Tenant') WHERE AD_Field_ID<1000000 AND Help~'\mClient\M' AND IsCentrallyMaintained='N';

UPDATE AD_Field SET Help=REPLACE(Help, 'Clients', 'Tenants') WHERE AD_Field_ID<1000000 AND Help~'\mClients\M' AND IsCentrallyMaintained='N';

UPDATE AD_Field SET Name=REPLACE(Name, 'client', 'tenant') WHERE AD_Field_ID<1000000 AND Name~'\mclient\M' AND Name NOT LIKE '%client-%' AND IsCentrallyMaintained='N';

UPDATE AD_Field SET Name=REPLACE(Name, 'clients', 'tenants') WHERE AD_Field_ID<1000000 AND Name~'\mclients\M' AND IsCentrallyMaintained='N';

UPDATE AD_Field SET Name=REPLACE(Name, 'Client', 'Tenant') WHERE AD_Field_ID<1000000 AND Name~'\mClient\M' AND IsCentrallyMaintained='N';

UPDATE AD_Field SET Name=REPLACE(Name, 'Clients', 'Tenants') WHERE AD_Field_ID<1000000 AND Name~'\mClients\M' AND IsCentrallyMaintained='N';

UPDATE AD_Form SET Description=REPLACE(Description, 'client', 'tenant') WHERE AD_Form_ID<1000000 AND Description~'\mclient\M' AND Description NOT LIKE '%client-%';

UPDATE AD_Form SET Description=REPLACE(Description, 'clients', 'tenants') WHERE AD_Form_ID<1000000 AND Description~'\mclients\M';

UPDATE AD_Form SET Description=REPLACE(Description, 'Client', 'Tenant') WHERE AD_Form_ID<1000000 AND Description~'\mClient\M';

UPDATE AD_Form SET Description=REPLACE(Description, 'Clients', 'Tenants') WHERE AD_Form_ID<1000000 AND Description~'\mClients\M';

UPDATE AD_Form SET Help=REPLACE(Help, 'client', 'tenant') WHERE AD_Form_ID<1000000 AND Help~'\mclient\M' AND Help NOT LIKE '%client-%';

UPDATE AD_Form SET Help=REPLACE(Help, 'clients', 'tenants') WHERE AD_Form_ID<1000000 AND Help~'\mclients\M';

UPDATE AD_Form SET Help=REPLACE(Help, 'Client', 'Tenant') WHERE AD_Form_ID<1000000 AND Help~'\mClient\M';

UPDATE AD_Form SET Help=REPLACE(Help, 'Clients', 'Tenants') WHERE AD_Form_ID<1000000 AND Help~'\mClients\M';

UPDATE AD_Form SET Name=REPLACE(Name, 'client', 'tenant') WHERE AD_Form_ID<1000000 AND Name~'\mclient\M' AND Name NOT LIKE '%client-%';

UPDATE AD_Form SET Name=REPLACE(Name, 'clients', 'tenants') WHERE AD_Form_ID<1000000 AND Name~'\mclients\M';

UPDATE AD_Form SET Name=REPLACE(Name, 'Client', 'Tenant') WHERE AD_Form_ID<1000000 AND Name~'\mClient\M';

UPDATE AD_Form SET Name=REPLACE(Name, 'Clients', 'Tenants') WHERE AD_Form_ID<1000000 AND Name~'\mClients\M';

UPDATE AD_Menu SET Description=REPLACE(Description, 'client', 'tenant') WHERE AD_Menu_ID<1000000 AND Description~'\mclient\M' AND Description NOT LIKE '%client-%' AND IsCentrallyMaintained='N';

UPDATE AD_Menu SET Description=REPLACE(Description, 'clients', 'tenants') WHERE AD_Menu_ID<1000000 AND Description~'\mclients\M' AND IsCentrallyMaintained='N';

UPDATE AD_Menu SET Description=REPLACE(Description, 'Client', 'Tenant') WHERE AD_Menu_ID<1000000 AND Description~'\mClient\M' AND IsCentrallyMaintained='N';

UPDATE AD_Menu SET Description=REPLACE(Description, 'Clients', 'Tenants') WHERE AD_Menu_ID<1000000 AND Description~'\mClients\M' AND IsCentrallyMaintained='N';

UPDATE AD_Menu SET Name=REPLACE(Name, 'client', 'tenant') WHERE AD_Menu_ID<1000000 AND Name~'\mclient\M' AND Name NOT LIKE '%client-%' AND IsCentrallyMaintained='N';

UPDATE AD_Menu SET Name=REPLACE(Name, 'clients', 'tenants') WHERE AD_Menu_ID<1000000 AND Name~'\mclients\M' AND IsCentrallyMaintained='N';

UPDATE AD_Menu SET Name=REPLACE(Name, 'Client', 'Tenant') WHERE AD_Menu_ID<1000000 AND Name~'\mClient\M' AND IsCentrallyMaintained='N';

UPDATE AD_Menu SET Name=REPLACE(Name, 'Clients', 'Tenants') WHERE AD_Menu_ID<1000000 AND Name~'\mClients\M' AND IsCentrallyMaintained='N';

UPDATE AD_Message SET MsgText=REPLACE(MsgText, 'client', 'tenant') WHERE AD_Message_ID<1000000 AND MsgText~'\mclient\M' AND MsgText NOT LIKE '%client-%';

UPDATE AD_Message SET MsgText=REPLACE(MsgText, 'clients', 'tenants') WHERE AD_Message_ID<1000000 AND MsgText~'\mclients\M';

UPDATE AD_Message SET MsgText=REPLACE(MsgText, 'Client', 'Tenant') WHERE AD_Message_ID<1000000 AND MsgText~'\mClient\M';

UPDATE AD_Message SET MsgText=REPLACE(MsgText, 'Clients', 'Tenants') WHERE AD_Message_ID<1000000 AND MsgText~'\mClients\M';

UPDATE AD_Message SET MsgTip=REPLACE(MsgTip, 'client', 'tenant') WHERE AD_Message_ID<1000000 AND MsgTip~'\mclient\M' AND MsgTip NOT LIKE '%client-%';

UPDATE AD_Message SET MsgTip=REPLACE(MsgTip, 'clients', 'tenants') WHERE AD_Message_ID<1000000 AND MsgTip~'\mclients\M';

UPDATE AD_Message SET MsgTip=REPLACE(MsgTip, 'Client', 'Tenant') WHERE AD_Message_ID<1000000 AND MsgTip~'\mClient\M';

UPDATE AD_Message SET MsgTip=REPLACE(MsgTip, 'Clients', 'Tenants') WHERE AD_Message_ID<1000000 AND MsgTip~'\mClients\M';

UPDATE AD_Process SET Description=REPLACE(Description, 'client', 'tenant') WHERE AD_Process_ID<1000000 AND Description~'\mclient\M' AND Description NOT LIKE '%client-%';

UPDATE AD_Process SET Description=REPLACE(Description, 'clients', 'tenants') WHERE AD_Process_ID<1000000 AND Description~'\mclients\M';

UPDATE AD_Process SET Description=REPLACE(Description, 'Client', 'Tenant') WHERE AD_Process_ID<1000000 AND Description~'\mClient\M';

UPDATE AD_Process SET Description=REPLACE(Description, 'Clients', 'Tenants') WHERE AD_Process_ID<1000000 AND Description~'\mClients\M';

UPDATE AD_Process SET Help=REPLACE(Help, 'client', 'tenant') WHERE AD_Process_ID<1000000 AND Help~'\mclient\M' AND Help NOT LIKE '%client-%';

UPDATE AD_Process SET Help=REPLACE(Help, 'clients', 'tenants') WHERE AD_Process_ID<1000000 AND Help~'\mclients\M';

UPDATE AD_Process SET Help=REPLACE(Help, 'Client', 'Tenant') WHERE AD_Process_ID<1000000 AND Help~'\mClient\M';

UPDATE AD_Process SET Help=REPLACE(Help, 'Clients', 'Tenants') WHERE AD_Process_ID<1000000 AND Help~'\mClients\M';

UPDATE AD_Process SET Name=REPLACE(Name, 'client', 'tenant') WHERE AD_Process_ID<1000000 AND Name~'\mclient\M' AND Name NOT LIKE '%client-%';

UPDATE AD_Process SET Name=REPLACE(Name, 'clients', 'tenants') WHERE AD_Process_ID<1000000 AND Name~'\mclients\M';

UPDATE AD_Process SET Name=REPLACE(Name, 'Client', 'Tenant') WHERE AD_Process_ID<1000000 AND Name~'\mClient\M';

UPDATE AD_Process SET Name=REPLACE(Name, 'Clients', 'Tenants') WHERE AD_Process_ID<1000000 AND Name~'\mClients\M';

UPDATE AD_Process_Para SET Description=REPLACE(Description, 'client', 'tenant') WHERE AD_Process_Para_ID<1000000 AND Description~'\mclient\M' AND Description NOT LIKE '%client-%' AND IsCentrallyMaintained='N';

UPDATE AD_Process_Para SET Description=REPLACE(Description, 'clients', 'tenants') WHERE AD_Process_Para_ID<1000000 AND Description~'\mclients\M' AND IsCentrallyMaintained='N';

UPDATE AD_Process_Para SET Description=REPLACE(Description, 'Client', 'Tenant') WHERE AD_Process_Para_ID<1000000 AND Description~'\mClient\M' AND IsCentrallyMaintained='N';

UPDATE AD_Process_Para SET Description=REPLACE(Description, 'Clients', 'Tenants') WHERE AD_Process_Para_ID<1000000 AND Description~'\mClients\M' AND IsCentrallyMaintained='N';

UPDATE AD_Process_Para SET Help=REPLACE(Help, 'client', 'tenant') WHERE AD_Process_Para_ID<1000000 AND Help~'\mclient\M' AND Help NOT LIKE '%client-%' AND IsCentrallyMaintained='N';

UPDATE AD_Process_Para SET Help=REPLACE(Help, 'clients', 'tenants') WHERE AD_Process_Para_ID<1000000 AND Help~'\mclients\M' AND IsCentrallyMaintained='N';

UPDATE AD_Process_Para SET Help=REPLACE(Help, 'Client', 'Tenant') WHERE AD_Process_Para_ID<1000000 AND Help~'\mClient\M' AND IsCentrallyMaintained='N';

UPDATE AD_Process_Para SET Help=REPLACE(Help, 'Clients', 'Tenants') WHERE AD_Process_Para_ID<1000000 AND Help~'\mClients\M' AND IsCentrallyMaintained='N';

UPDATE AD_Process_Para SET Name=REPLACE(Name, 'client', 'tenant') WHERE AD_Process_Para_ID<1000000 AND Name~'\mclient\M' AND Name NOT LIKE '%client-%' AND IsCentrallyMaintained='N';

UPDATE AD_Process_Para SET Name=REPLACE(Name, 'clients', 'tenants') WHERE AD_Process_Para_ID<1000000 AND Name~'\mclients\M' AND IsCentrallyMaintained='N';

UPDATE AD_Process_Para SET Name=REPLACE(Name, 'Client', 'Tenant') WHERE AD_Process_Para_ID<1000000 AND Name~'\mClient\M' AND IsCentrallyMaintained='N';

UPDATE AD_Process_Para SET Name=REPLACE(Name, 'Clients', 'Tenants') WHERE AD_Process_Para_ID<1000000 AND Name~'\mClients\M' AND IsCentrallyMaintained='N';

UPDATE AD_Reference SET Description=REPLACE(Description, 'client', 'tenant') WHERE AD_Reference_ID<1000000 AND Description~'\mclient\M' AND Description NOT LIKE '%client-%';

UPDATE AD_Reference SET Description=REPLACE(Description, 'clients', 'tenants') WHERE AD_Reference_ID<1000000 AND Description~'\mclients\M';

UPDATE AD_Reference SET Description=REPLACE(Description, 'Client', 'Tenant') WHERE AD_Reference_ID<1000000 AND Description~'\mClient\M';

UPDATE AD_Reference SET Description=REPLACE(Description, 'Clients', 'Tenants') WHERE AD_Reference_ID<1000000 AND Description~'\mClients\M';

UPDATE AD_Reference SET Name=REPLACE(Name, 'client', 'tenant') WHERE AD_Reference_ID<1000000 AND Name~'\mclient\M' AND Name NOT LIKE '%client-%';

UPDATE AD_Reference SET Name=REPLACE(Name, 'clients', 'tenants') WHERE AD_Reference_ID<1000000 AND Name~'\mclients\M';

UPDATE AD_Reference SET Name=REPLACE(Name, 'Client', 'Tenant') WHERE AD_Reference_ID<1000000 AND Name~'\mClient\M';

UPDATE AD_Reference SET Name=REPLACE(Name, 'Clients', 'Tenants') WHERE AD_Reference_ID<1000000 AND Name~'\mClients\M';

UPDATE AD_Ref_List SET Description=REPLACE(Description, 'client', 'tenant') WHERE AD_Ref_List_ID<1000000 AND Description~'\mclient\M' AND Description NOT LIKE '%client-%';

UPDATE AD_Ref_List SET Description=REPLACE(Description, 'clients', 'tenants') WHERE AD_Ref_List_ID<1000000 AND Description~'\mclients\M';

UPDATE AD_Ref_List SET Description=REPLACE(Description, 'Client', 'Tenant') WHERE AD_Ref_List_ID<1000000 AND Description~'\mClient\M';

UPDATE AD_Ref_List SET Description=REPLACE(Description, 'Clients', 'Tenants') WHERE AD_Ref_List_ID<1000000 AND Description~'\mClients\M';

UPDATE AD_Tab SET Description=REPLACE(Description, 'client', 'tenant') WHERE AD_Tab_ID<1000000 AND Description~'\mclient\M' AND Description NOT LIKE '%client-%';

UPDATE AD_Tab SET Description=REPLACE(Description, 'clients', 'tenants') WHERE AD_Tab_ID<1000000 AND Description~'\mclients\M';

UPDATE AD_Tab SET Description=REPLACE(Description, 'Client', 'Tenant') WHERE AD_Tab_ID<1000000 AND Description~'\mClient\M';

UPDATE AD_Tab SET Description=REPLACE(Description, 'Clients', 'Tenants') WHERE AD_Tab_ID<1000000 AND Description~'\mClients\M';

UPDATE AD_Tab SET Help=REPLACE(Help, 'client', 'tenant') WHERE AD_Tab_ID<1000000 AND Help~'\mclient\M' AND Help NOT LIKE '%client-%';

UPDATE AD_Tab SET Help=REPLACE(Help, 'clients', 'tenants') WHERE AD_Tab_ID<1000000 AND Help~'\mclients\M';

UPDATE AD_Tab SET Help=REPLACE(Help, 'Client', 'Tenant') WHERE AD_Tab_ID<1000000 AND Help~'\mClient\M';

UPDATE AD_Tab SET Help=REPLACE(Help, 'Clients', 'Tenants') WHERE AD_Tab_ID<1000000 AND Help~'\mClients\M';

UPDATE AD_Tab SET Name=REPLACE(Name, 'client', 'tenant') WHERE AD_Tab_ID<1000000 AND Name~'\mclient\M' AND Name NOT LIKE '%client-%';

UPDATE AD_Tab SET Name=REPLACE(Name, 'clients', 'tenants') WHERE AD_Tab_ID<1000000 AND Name~'\mclients\M';

UPDATE AD_Tab SET Name=REPLACE(Name, 'Client', 'Tenant') WHERE AD_Tab_ID<1000000 AND Name~'\mClient\M';

UPDATE AD_Tab SET Name=REPLACE(Name, 'Clients', 'Tenants') WHERE AD_Tab_ID<1000000 AND Name~'\mClients\M';

UPDATE AD_WF_Node SET Description=REPLACE(Description, 'client', 'tenant') WHERE AD_WF_Node_ID<1000000 AND Description~'\mclient\M' AND Description NOT LIKE '%client-%';

UPDATE AD_WF_Node SET Description=REPLACE(Description, 'clients', 'tenants') WHERE AD_WF_Node_ID<1000000 AND Description~'\mclients\M';

UPDATE AD_WF_Node SET Description=REPLACE(Description, 'Client', 'Tenant') WHERE AD_WF_Node_ID<1000000 AND Description~'\mClient\M';

UPDATE AD_WF_Node SET Description=REPLACE(Description, 'Clients', 'Tenants') WHERE AD_WF_Node_ID<1000000 AND Description~'\mClients\M';

UPDATE AD_WF_Node SET Help=REPLACE(Help, 'client', 'tenant') WHERE AD_WF_Node_ID<1000000 AND Help~'\mclient\M' AND Help NOT LIKE '%client-%';

UPDATE AD_WF_Node SET Help=REPLACE(Help, 'clients', 'tenants') WHERE AD_WF_Node_ID<1000000 AND Help~'\mclients\M';

UPDATE AD_WF_Node SET Help=REPLACE(Help, 'Client', 'Tenant') WHERE AD_WF_Node_ID<1000000 AND Help~'\mClient\M';

UPDATE AD_WF_Node SET Help=REPLACE(Help, 'Clients', 'Tenants') WHERE AD_WF_Node_ID<1000000 AND Help~'\mClients\M';

UPDATE AD_WF_Node SET Name=REPLACE(Name, 'client', 'tenant') WHERE AD_WF_Node_ID<1000000 AND Name~'\mclient\M' AND Name NOT LIKE '%client-%';

UPDATE AD_WF_Node SET Name=REPLACE(Name, 'clients', 'tenants') WHERE AD_WF_Node_ID<1000000 AND Name~'\mclients\M';

UPDATE AD_WF_Node SET Name=REPLACE(Name, 'Client', 'Tenant') WHERE AD_WF_Node_ID<1000000 AND Name~'\mClient\M';

UPDATE AD_WF_Node SET Name=REPLACE(Name, 'Clients', 'Tenants') WHERE AD_WF_Node_ID<1000000 AND Name~'\mClients\M';

UPDATE AD_Window SET Description=REPLACE(Description, 'client', 'tenant') WHERE AD_Window_ID<1000000 AND Description~'\mclient\M' AND Description NOT LIKE '%client-%';

UPDATE AD_Window SET Description=REPLACE(Description, 'clients', 'tenants') WHERE AD_Window_ID<1000000 AND Description~'\mclients\M';

UPDATE AD_Window SET Description=REPLACE(Description, 'Client', 'Tenant') WHERE AD_Window_ID<1000000 AND Description~'\mClient\M';

UPDATE AD_Window SET Description=REPLACE(Description, 'Clients', 'Tenants') WHERE AD_Window_ID<1000000 AND Description~'\mClients\M';

UPDATE AD_Window SET Help=REPLACE(Help, 'client', 'tenant') WHERE AD_Window_ID<1000000 AND Help~'\mclient\M' AND Help NOT LIKE '%client-%';

UPDATE AD_Window SET Help=REPLACE(Help, 'clients', 'tenants') WHERE AD_Window_ID<1000000 AND Help~'\mclients\M';

UPDATE AD_Window SET Help=REPLACE(Help, 'Client', 'Tenant') WHERE AD_Window_ID<1000000 AND Help~'\mClient\M';

UPDATE AD_Window SET Help=REPLACE(Help, 'Clients', 'Tenants') WHERE AD_Window_ID<1000000 AND Help~'\mClients\M';

UPDATE AD_Window SET Name=REPLACE(Name, 'client', 'tenant') WHERE AD_Window_ID<1000000 AND Name~'\mclient\M' AND Name NOT LIKE '%client-%';

UPDATE AD_Window SET Name=REPLACE(Name, 'clients', 'tenants') WHERE AD_Window_ID<1000000 AND Name~'\mclients\M';

UPDATE AD_Window SET Name=REPLACE(Name, 'Client', 'Tenant') WHERE AD_Window_ID<1000000 AND Name~'\mClient\M';

UPDATE AD_Window SET Name=REPLACE(Name, 'Clients', 'Tenants') WHERE AD_Window_ID<1000000 AND Name~'\mClients\M';

UPDATE AD_Workflow SET Description=REPLACE(Description, 'client', 'tenant') WHERE AD_Workflow_ID<1000000 AND Description~'\mclient\M' AND Description NOT LIKE '%client-%';

UPDATE AD_Workflow SET Description=REPLACE(Description, 'clients', 'tenants') WHERE AD_Workflow_ID<1000000 AND Description~'\mclients\M';

UPDATE AD_Workflow SET Description=REPLACE(Description, 'Client', 'Tenant') WHERE AD_Workflow_ID<1000000 AND Description~'\mClient\M';

UPDATE AD_Workflow SET Description=REPLACE(Description, 'Clients', 'Tenants') WHERE AD_Workflow_ID<1000000 AND Description~'\mClients\M';

UPDATE AD_Workflow SET Help=REPLACE(Help, 'client', 'tenant') WHERE AD_Workflow_ID<1000000 AND Help~'\mclient\M' AND Help NOT LIKE '%client-%';

UPDATE AD_Workflow SET Help=REPLACE(Help, 'clients', 'tenants') WHERE AD_Workflow_ID<1000000 AND Help~'\mclients\M';

UPDATE AD_Workflow SET Help=REPLACE(Help, 'Client', 'Tenant') WHERE AD_Workflow_ID<1000000 AND Help~'\mClient\M';

UPDATE AD_Workflow SET Help=REPLACE(Help, 'Clients', 'Tenants') WHERE AD_Workflow_ID<1000000 AND Help~'\mClients\M';

UPDATE AD_Workflow SET Name=REPLACE(Name, 'client', 'tenant') WHERE AD_Workflow_ID<1000000 AND Name~'\mclient\M' AND Name NOT LIKE '%client-%';

UPDATE AD_Workflow SET Name=REPLACE(Name, 'clients', 'tenants') WHERE AD_Workflow_ID<1000000 AND Name~'\mclients\M';

UPDATE AD_Workflow SET Name=REPLACE(Name, 'Client', 'Tenant') WHERE AD_Workflow_ID<1000000 AND Name~'\mClient\M';

UPDATE AD_Workflow SET Name=REPLACE(Name, 'Clients', 'Tenants') WHERE AD_Workflow_ID<1000000 AND Name~'\mClients\M';

SELECT register_migration_script('202203081457_IDEMPIERE-4586.sql') FROM dual
;

