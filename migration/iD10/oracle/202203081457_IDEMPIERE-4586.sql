UPDATE AD_Element SET Description=REPLACE(Description, 'client', 'tenant') WHERE AD_Element_ID<1000000 AND REGEXP_LIKE(Description,'(^|\W)client(\W|$)') AND Description NOT LIKE '%client-%';

UPDATE AD_Element SET Description=REPLACE(Description, 'clients', 'tenants') WHERE AD_Element_ID<1000000 AND REGEXP_LIKE(Description,'(^|\W)clients(\W|$)');

UPDATE AD_Element SET Description=REPLACE(Description, 'Client', 'Tenant') WHERE AD_Element_ID<1000000 AND REGEXP_LIKE(Description,'(^|\W)Client(\W|$)');

UPDATE AD_Element SET Description=REPLACE(Description, 'Clients', 'Tenants') WHERE AD_Element_ID<1000000 AND REGEXP_LIKE(Description,'(^|\W)Clients(\W|$)');

UPDATE AD_Element SET Help=REPLACE(Help, 'client', 'tenant') WHERE AD_Element_ID<1000000 AND REGEXP_LIKE(Help,'(^|\W)client(\W|$)') AND Help NOT LIKE '%client-%';

UPDATE AD_Element SET Help=REPLACE(Help, 'clients', 'tenants') WHERE AD_Element_ID<1000000 AND REGEXP_LIKE(Help,'(^|\W)clients(\W|$)');

UPDATE AD_Element SET Help=REPLACE(Help, 'Client', 'Tenant') WHERE AD_Element_ID<1000000 AND REGEXP_LIKE(Help,'(^|\W)Client(\W|$)');

UPDATE AD_Element SET Help=REPLACE(Help, 'Clients', 'Tenants') WHERE AD_Element_ID<1000000 AND REGEXP_LIKE(Help,'(^|\W)Clients(\W|$)');

UPDATE AD_Element SET Name=REPLACE(Name, 'client', 'tenant') WHERE AD_Element_ID<1000000 AND REGEXP_LIKE(Name,'(^|\W)client(\W|$)') AND Name NOT LIKE '%client-%';

UPDATE AD_Element SET Name=REPLACE(Name, 'clients', 'tenants') WHERE AD_Element_ID<1000000 AND REGEXP_LIKE(Name,'(^|\W)clients(\W|$)');

UPDATE AD_Element SET Name=REPLACE(Name, 'Client', 'Tenant') WHERE AD_Element_ID<1000000 AND REGEXP_LIKE(Name,'(^|\W)Client(\W|$)');

UPDATE AD_Element SET Name=REPLACE(Name, 'Clients', 'Tenants') WHERE AD_Element_ID<1000000 AND REGEXP_LIKE(Name,'(^|\W)Clients(\W|$)');

UPDATE AD_Element SET PrintName=REPLACE(PrintName, 'client', 'tenant') WHERE AD_Element_ID<1000000 AND REGEXP_LIKE(PrintName,'(^|\W)client(\W|$)') AND PrintName NOT LIKE '%client-%';

UPDATE AD_Element SET PrintName=REPLACE(PrintName, 'clients', 'tenants') WHERE AD_Element_ID<1000000 AND REGEXP_LIKE(PrintName,'(^|\W)clients(\W|$)');

UPDATE AD_Element SET PrintName=REPLACE(PrintName, 'Client', 'Tenant') WHERE AD_Element_ID<1000000 AND REGEXP_LIKE(PrintName,'(^|\W)Client(\W|$)');

UPDATE AD_Element SET PrintName=REPLACE(PrintName, 'Clients', 'Tenants') WHERE AD_Element_ID<1000000 AND REGEXP_LIKE(PrintName,'(^|\W)Clients(\W|$)');

UPDATE AD_Field SET Help=REPLACE(Help, 'client', 'tenant') WHERE AD_Field_ID<1000000 AND REGEXP_LIKE(Help,'(^|\W)client(\W|$)') AND Help NOT LIKE '%client-%' AND IsCentrallyMaintained='N';

UPDATE AD_Field SET Help=REPLACE(Help, 'clients', 'tenants') WHERE AD_Field_ID<1000000 AND REGEXP_LIKE(Help,'(^|\W)clients(\W|$)') AND IsCentrallyMaintained='N';

UPDATE AD_Field SET Help=REPLACE(Help, 'Client', 'Tenant') WHERE AD_Field_ID<1000000 AND REGEXP_LIKE(Help,'(^|\W)Client(\W|$)') AND IsCentrallyMaintained='N';

UPDATE AD_Field SET Help=REPLACE(Help, 'Clients', 'Tenants') WHERE AD_Field_ID<1000000 AND REGEXP_LIKE(Help,'(^|\W)Clients(\W|$)') AND IsCentrallyMaintained='N';

UPDATE AD_Field SET Name=REPLACE(Name, 'client', 'tenant') WHERE AD_Field_ID<1000000 AND REGEXP_LIKE(Name,'(^|\W)client(\W|$)') AND Name NOT LIKE '%client-%' AND IsCentrallyMaintained='N';

UPDATE AD_Field SET Name=REPLACE(Name, 'clients', 'tenants') WHERE AD_Field_ID<1000000 AND REGEXP_LIKE(Name,'(^|\W)clients(\W|$)') AND IsCentrallyMaintained='N';

UPDATE AD_Field SET Name=REPLACE(Name, 'Client', 'Tenant') WHERE AD_Field_ID<1000000 AND REGEXP_LIKE(Name,'(^|\W)Client(\W|$)') AND IsCentrallyMaintained='N';

UPDATE AD_Field SET Name=REPLACE(Name, 'Clients', 'Tenants') WHERE AD_Field_ID<1000000 AND REGEXP_LIKE(Name,'(^|\W)Clients(\W|$)') AND IsCentrallyMaintained='N';

UPDATE AD_Form SET Description=REPLACE(Description, 'client', 'tenant') WHERE AD_Form_ID<1000000 AND REGEXP_LIKE(Description,'(^|\W)client(\W|$)') AND Description NOT LIKE '%client-%';

UPDATE AD_Form SET Description=REPLACE(Description, 'clients', 'tenants') WHERE AD_Form_ID<1000000 AND REGEXP_LIKE(Description,'(^|\W)clients(\W|$)');

UPDATE AD_Form SET Description=REPLACE(Description, 'Client', 'Tenant') WHERE AD_Form_ID<1000000 AND REGEXP_LIKE(Description,'(^|\W)Client(\W|$)');

UPDATE AD_Form SET Description=REPLACE(Description, 'Clients', 'Tenants') WHERE AD_Form_ID<1000000 AND REGEXP_LIKE(Description,'(^|\W)Clients(\W|$)');

UPDATE AD_Form SET Help=REPLACE(Help, 'client', 'tenant') WHERE AD_Form_ID<1000000 AND REGEXP_LIKE(Help,'(^|\W)client(\W|$)') AND Help NOT LIKE '%client-%';

UPDATE AD_Form SET Help=REPLACE(Help, 'clients', 'tenants') WHERE AD_Form_ID<1000000 AND REGEXP_LIKE(Help,'(^|\W)clients(\W|$)');

UPDATE AD_Form SET Help=REPLACE(Help, 'Client', 'Tenant') WHERE AD_Form_ID<1000000 AND REGEXP_LIKE(Help,'(^|\W)Client(\W|$)');

UPDATE AD_Form SET Help=REPLACE(Help, 'Clients', 'Tenants') WHERE AD_Form_ID<1000000 AND REGEXP_LIKE(Help,'(^|\W)Clients(\W|$)');

UPDATE AD_Form SET Name=REPLACE(Name, 'client', 'tenant') WHERE AD_Form_ID<1000000 AND REGEXP_LIKE(Name,'(^|\W)client(\W|$)') AND Name NOT LIKE '%client-%';

UPDATE AD_Form SET Name=REPLACE(Name, 'clients', 'tenants') WHERE AD_Form_ID<1000000 AND REGEXP_LIKE(Name,'(^|\W)clients(\W|$)');

UPDATE AD_Form SET Name=REPLACE(Name, 'Client', 'Tenant') WHERE AD_Form_ID<1000000 AND REGEXP_LIKE(Name,'(^|\W)Client(\W|$)');

UPDATE AD_Form SET Name=REPLACE(Name, 'Clients', 'Tenants') WHERE AD_Form_ID<1000000 AND REGEXP_LIKE(Name,'(^|\W)Clients(\W|$)');

UPDATE AD_Menu SET Description=REPLACE(Description, 'client', 'tenant') WHERE AD_Menu_ID<1000000 AND REGEXP_LIKE(Description,'(^|\W)client(\W|$)') AND Description NOT LIKE '%client-%' AND IsCentrallyMaintained='N';

UPDATE AD_Menu SET Description=REPLACE(Description, 'clients', 'tenants') WHERE AD_Menu_ID<1000000 AND REGEXP_LIKE(Description,'(^|\W)clients(\W|$)') AND IsCentrallyMaintained='N';

UPDATE AD_Menu SET Description=REPLACE(Description, 'Client', 'Tenant') WHERE AD_Menu_ID<1000000 AND REGEXP_LIKE(Description,'(^|\W)Client(\W|$)') AND IsCentrallyMaintained='N';

UPDATE AD_Menu SET Description=REPLACE(Description, 'Clients', 'Tenants') WHERE AD_Menu_ID<1000000 AND REGEXP_LIKE(Description,'(^|\W)Clients(\W|$)') AND IsCentrallyMaintained='N';

UPDATE AD_Menu SET Name=REPLACE(Name, 'client', 'tenant') WHERE AD_Menu_ID<1000000 AND REGEXP_LIKE(Name,'(^|\W)client(\W|$)') AND Name NOT LIKE '%client-%' AND IsCentrallyMaintained='N';

UPDATE AD_Menu SET Name=REPLACE(Name, 'clients', 'tenants') WHERE AD_Menu_ID<1000000 AND REGEXP_LIKE(Name,'(^|\W)clients(\W|$)') AND IsCentrallyMaintained='N';

UPDATE AD_Menu SET Name=REPLACE(Name, 'Client', 'Tenant') WHERE AD_Menu_ID<1000000 AND REGEXP_LIKE(Name,'(^|\W)Client(\W|$)') AND IsCentrallyMaintained='N';

UPDATE AD_Menu SET Name=REPLACE(Name, 'Clients', 'Tenants') WHERE AD_Menu_ID<1000000 AND REGEXP_LIKE(Name,'(^|\W)Clients(\W|$)') AND IsCentrallyMaintained='N';

UPDATE AD_Message SET MsgText=REPLACE(MsgText, 'client', 'tenant') WHERE AD_Message_ID<1000000 AND REGEXP_LIKE(MsgText,'(^|\W)client(\W|$)') AND MsgText NOT LIKE '%client-%';

UPDATE AD_Message SET MsgText=REPLACE(MsgText, 'clients', 'tenants') WHERE AD_Message_ID<1000000 AND REGEXP_LIKE(MsgText,'(^|\W)clients(\W|$)');

UPDATE AD_Message SET MsgText=REPLACE(MsgText, 'Client', 'Tenant') WHERE AD_Message_ID<1000000 AND REGEXP_LIKE(MsgText,'(^|\W)Client(\W|$)');

UPDATE AD_Message SET MsgText=REPLACE(MsgText, 'Clients', 'Tenants') WHERE AD_Message_ID<1000000 AND REGEXP_LIKE(MsgText,'(^|\W)Clients(\W|$)');

UPDATE AD_Message SET MsgTip=REPLACE(MsgTip, 'client', 'tenant') WHERE AD_Message_ID<1000000 AND REGEXP_LIKE(MsgTip,'(^|\W)client(\W|$)') AND MsgTip NOT LIKE '%client-%';

UPDATE AD_Message SET MsgTip=REPLACE(MsgTip, 'clients', 'tenants') WHERE AD_Message_ID<1000000 AND REGEXP_LIKE(MsgTip,'(^|\W)clients(\W|$)');

UPDATE AD_Message SET MsgTip=REPLACE(MsgTip, 'Client', 'Tenant') WHERE AD_Message_ID<1000000 AND REGEXP_LIKE(MsgTip,'(^|\W)Client(\W|$)');

UPDATE AD_Message SET MsgTip=REPLACE(MsgTip, 'Clients', 'Tenants') WHERE AD_Message_ID<1000000 AND REGEXP_LIKE(MsgTip,'(^|\W)Clients(\W|$)');

UPDATE AD_Process SET Description=REPLACE(Description, 'client', 'tenant') WHERE AD_Process_ID<1000000 AND REGEXP_LIKE(Description,'(^|\W)client(\W|$)') AND Description NOT LIKE '%client-%';

UPDATE AD_Process SET Description=REPLACE(Description, 'clients', 'tenants') WHERE AD_Process_ID<1000000 AND REGEXP_LIKE(Description,'(^|\W)clients(\W|$)');

UPDATE AD_Process SET Description=REPLACE(Description, 'Client', 'Tenant') WHERE AD_Process_ID<1000000 AND REGEXP_LIKE(Description,'(^|\W)Client(\W|$)');

UPDATE AD_Process SET Description=REPLACE(Description, 'Clients', 'Tenants') WHERE AD_Process_ID<1000000 AND REGEXP_LIKE(Description,'(^|\W)Clients(\W|$)');

UPDATE AD_Process SET Help=REPLACE(Help, 'client', 'tenant') WHERE AD_Process_ID<1000000 AND REGEXP_LIKE(Help,'(^|\W)client(\W|$)') AND Help NOT LIKE '%client-%';

UPDATE AD_Process SET Help=REPLACE(Help, 'clients', 'tenants') WHERE AD_Process_ID<1000000 AND REGEXP_LIKE(Help,'(^|\W)clients(\W|$)');

UPDATE AD_Process SET Help=REPLACE(Help, 'Client', 'Tenant') WHERE AD_Process_ID<1000000 AND REGEXP_LIKE(Help,'(^|\W)Client(\W|$)');

UPDATE AD_Process SET Help=REPLACE(Help, 'Clients', 'Tenants') WHERE AD_Process_ID<1000000 AND REGEXP_LIKE(Help,'(^|\W)Clients(\W|$)');

UPDATE AD_Process SET Name=REPLACE(Name, 'client', 'tenant') WHERE AD_Process_ID<1000000 AND REGEXP_LIKE(Name,'(^|\W)client(\W|$)') AND Name NOT LIKE '%client-%';

UPDATE AD_Process SET Name=REPLACE(Name, 'clients', 'tenants') WHERE AD_Process_ID<1000000 AND REGEXP_LIKE(Name,'(^|\W)clients(\W|$)');

UPDATE AD_Process SET Name=REPLACE(Name, 'Client', 'Tenant') WHERE AD_Process_ID<1000000 AND REGEXP_LIKE(Name,'(^|\W)Client(\W|$)');

UPDATE AD_Process SET Name=REPLACE(Name, 'Clients', 'Tenants') WHERE AD_Process_ID<1000000 AND REGEXP_LIKE(Name,'(^|\W)Clients(\W|$)');

UPDATE AD_Process_Para SET Description=REPLACE(Description, 'client', 'tenant') WHERE AD_Process_Para_ID<1000000 AND REGEXP_LIKE(Description,'(^|\W)client(\W|$)') AND Description NOT LIKE '%client-%' AND IsCentrallyMaintained='N';

UPDATE AD_Process_Para SET Description=REPLACE(Description, 'clients', 'tenants') WHERE AD_Process_Para_ID<1000000 AND REGEXP_LIKE(Description,'(^|\W)clients(\W|$)') AND IsCentrallyMaintained='N';

UPDATE AD_Process_Para SET Description=REPLACE(Description, 'Client', 'Tenant') WHERE AD_Process_Para_ID<1000000 AND REGEXP_LIKE(Description,'(^|\W)Client(\W|$)') AND IsCentrallyMaintained='N';

UPDATE AD_Process_Para SET Description=REPLACE(Description, 'Clients', 'Tenants') WHERE AD_Process_Para_ID<1000000 AND REGEXP_LIKE(Description,'(^|\W)Clients(\W|$)') AND IsCentrallyMaintained='N';

UPDATE AD_Process_Para SET Help=REPLACE(Help, 'client', 'tenant') WHERE AD_Process_Para_ID<1000000 AND REGEXP_LIKE(Help,'(^|\W)client(\W|$)') AND Help NOT LIKE '%client-%' AND IsCentrallyMaintained='N';

UPDATE AD_Process_Para SET Help=REPLACE(Help, 'clients', 'tenants') WHERE AD_Process_Para_ID<1000000 AND REGEXP_LIKE(Help,'(^|\W)clients(\W|$)') AND IsCentrallyMaintained='N';

UPDATE AD_Process_Para SET Help=REPLACE(Help, 'Client', 'Tenant') WHERE AD_Process_Para_ID<1000000 AND REGEXP_LIKE(Help,'(^|\W)Client(\W|$)') AND IsCentrallyMaintained='N';

UPDATE AD_Process_Para SET Help=REPLACE(Help, 'Clients', 'Tenants') WHERE AD_Process_Para_ID<1000000 AND REGEXP_LIKE(Help,'(^|\W)Clients(\W|$)') AND IsCentrallyMaintained='N';

UPDATE AD_Process_Para SET Name=REPLACE(Name, 'client', 'tenant') WHERE AD_Process_Para_ID<1000000 AND REGEXP_LIKE(Name,'(^|\W)client(\W|$)') AND Name NOT LIKE '%client-%' AND IsCentrallyMaintained='N';

UPDATE AD_Process_Para SET Name=REPLACE(Name, 'clients', 'tenants') WHERE AD_Process_Para_ID<1000000 AND REGEXP_LIKE(Name,'(^|\W)clients(\W|$)') AND IsCentrallyMaintained='N';

UPDATE AD_Process_Para SET Name=REPLACE(Name, 'Client', 'Tenant') WHERE AD_Process_Para_ID<1000000 AND REGEXP_LIKE(Name,'(^|\W)Client(\W|$)') AND IsCentrallyMaintained='N';

UPDATE AD_Process_Para SET Name=REPLACE(Name, 'Clients', 'Tenants') WHERE AD_Process_Para_ID<1000000 AND REGEXP_LIKE(Name,'(^|\W)Clients(\W|$)') AND IsCentrallyMaintained='N';

UPDATE AD_Reference SET Description=REPLACE(Description, 'client', 'tenant') WHERE AD_Reference_ID<1000000 AND REGEXP_LIKE(Description,'(^|\W)client(\W|$)') AND Description NOT LIKE '%client-%';

UPDATE AD_Reference SET Description=REPLACE(Description, 'clients', 'tenants') WHERE AD_Reference_ID<1000000 AND REGEXP_LIKE(Description,'(^|\W)clients(\W|$)');

UPDATE AD_Reference SET Description=REPLACE(Description, 'Client', 'Tenant') WHERE AD_Reference_ID<1000000 AND REGEXP_LIKE(Description,'(^|\W)Client(\W|$)');

UPDATE AD_Reference SET Description=REPLACE(Description, 'Clients', 'Tenants') WHERE AD_Reference_ID<1000000 AND REGEXP_LIKE(Description,'(^|\W)Clients(\W|$)');

UPDATE AD_Reference SET Name=REPLACE(Name, 'client', 'tenant') WHERE AD_Reference_ID<1000000 AND REGEXP_LIKE(Name,'(^|\W)client(\W|$)') AND Name NOT LIKE '%client-%';

UPDATE AD_Reference SET Name=REPLACE(Name, 'clients', 'tenants') WHERE AD_Reference_ID<1000000 AND REGEXP_LIKE(Name,'(^|\W)clients(\W|$)');

UPDATE AD_Reference SET Name=REPLACE(Name, 'Client', 'Tenant') WHERE AD_Reference_ID<1000000 AND REGEXP_LIKE(Name,'(^|\W)Client(\W|$)');

UPDATE AD_Reference SET Name=REPLACE(Name, 'Clients', 'Tenants') WHERE AD_Reference_ID<1000000 AND REGEXP_LIKE(Name,'(^|\W)Clients(\W|$)');

UPDATE AD_Ref_List SET Description=REPLACE(Description, 'client', 'tenant') WHERE AD_Ref_List_ID<1000000 AND REGEXP_LIKE(Description,'(^|\W)client(\W|$)') AND Description NOT LIKE '%client-%';

UPDATE AD_Ref_List SET Description=REPLACE(Description, 'clients', 'tenants') WHERE AD_Ref_List_ID<1000000 AND REGEXP_LIKE(Description,'(^|\W)clients(\W|$)');

UPDATE AD_Ref_List SET Description=REPLACE(Description, 'Client', 'Tenant') WHERE AD_Ref_List_ID<1000000 AND REGEXP_LIKE(Description,'(^|\W)Client(\W|$)');

UPDATE AD_Ref_List SET Description=REPLACE(Description, 'Clients', 'Tenants') WHERE AD_Ref_List_ID<1000000 AND REGEXP_LIKE(Description,'(^|\W)Clients(\W|$)');

UPDATE AD_Tab SET Description=REPLACE(Description, 'client', 'tenant') WHERE AD_Tab_ID<1000000 AND REGEXP_LIKE(Description,'(^|\W)client(\W|$)') AND Description NOT LIKE '%client-%';

UPDATE AD_Tab SET Description=REPLACE(Description, 'clients', 'tenants') WHERE AD_Tab_ID<1000000 AND REGEXP_LIKE(Description,'(^|\W)clients(\W|$)');

UPDATE AD_Tab SET Description=REPLACE(Description, 'Client', 'Tenant') WHERE AD_Tab_ID<1000000 AND REGEXP_LIKE(Description,'(^|\W)Client(\W|$)');

UPDATE AD_Tab SET Description=REPLACE(Description, 'Clients', 'Tenants') WHERE AD_Tab_ID<1000000 AND REGEXP_LIKE(Description,'(^|\W)Clients(\W|$)');

UPDATE AD_Tab SET Help=REPLACE(Help, 'client', 'tenant') WHERE AD_Tab_ID<1000000 AND REGEXP_LIKE(Help,'(^|\W)client(\W|$)') AND Help NOT LIKE '%client-%';

UPDATE AD_Tab SET Help=REPLACE(Help, 'clients', 'tenants') WHERE AD_Tab_ID<1000000 AND REGEXP_LIKE(Help,'(^|\W)clients(\W|$)');

UPDATE AD_Tab SET Help=REPLACE(Help, 'Client', 'Tenant') WHERE AD_Tab_ID<1000000 AND REGEXP_LIKE(Help,'(^|\W)Client(\W|$)');

UPDATE AD_Tab SET Help=REPLACE(Help, 'Clients', 'Tenants') WHERE AD_Tab_ID<1000000 AND REGEXP_LIKE(Help,'(^|\W)Clients(\W|$)');

UPDATE AD_Tab SET Name=REPLACE(Name, 'client', 'tenant') WHERE AD_Tab_ID<1000000 AND REGEXP_LIKE(Name,'(^|\W)client(\W|$)') AND Name NOT LIKE '%client-%';

UPDATE AD_Tab SET Name=REPLACE(Name, 'clients', 'tenants') WHERE AD_Tab_ID<1000000 AND REGEXP_LIKE(Name,'(^|\W)clients(\W|$)');

UPDATE AD_Tab SET Name=REPLACE(Name, 'Client', 'Tenant') WHERE AD_Tab_ID<1000000 AND REGEXP_LIKE(Name,'(^|\W)Client(\W|$)');

UPDATE AD_Tab SET Name=REPLACE(Name, 'Clients', 'Tenants') WHERE AD_Tab_ID<1000000 AND REGEXP_LIKE(Name,'(^|\W)Clients(\W|$)');

UPDATE AD_WF_Node SET Description=REPLACE(Description, 'client', 'tenant') WHERE AD_WF_Node_ID<1000000 AND REGEXP_LIKE(Description,'(^|\W)client(\W|$)') AND Description NOT LIKE '%client-%';

UPDATE AD_WF_Node SET Description=REPLACE(Description, 'clients', 'tenants') WHERE AD_WF_Node_ID<1000000 AND REGEXP_LIKE(Description,'(^|\W)clients(\W|$)');

UPDATE AD_WF_Node SET Description=REPLACE(Description, 'Client', 'Tenant') WHERE AD_WF_Node_ID<1000000 AND REGEXP_LIKE(Description,'(^|\W)Client(\W|$)');

UPDATE AD_WF_Node SET Description=REPLACE(Description, 'Clients', 'Tenants') WHERE AD_WF_Node_ID<1000000 AND REGEXP_LIKE(Description,'(^|\W)Clients(\W|$)');

UPDATE AD_WF_Node SET Help=REPLACE(Help, 'client', 'tenant') WHERE AD_WF_Node_ID<1000000 AND REGEXP_LIKE(Help,'(^|\W)client(\W|$)') AND Help NOT LIKE '%client-%';

UPDATE AD_WF_Node SET Help=REPLACE(Help, 'clients', 'tenants') WHERE AD_WF_Node_ID<1000000 AND REGEXP_LIKE(Help,'(^|\W)clients(\W|$)');

UPDATE AD_WF_Node SET Help=REPLACE(Help, 'Client', 'Tenant') WHERE AD_WF_Node_ID<1000000 AND REGEXP_LIKE(Help,'(^|\W)Client(\W|$)');

UPDATE AD_WF_Node SET Help=REPLACE(Help, 'Clients', 'Tenants') WHERE AD_WF_Node_ID<1000000 AND REGEXP_LIKE(Help,'(^|\W)Clients(\W|$)');

UPDATE AD_WF_Node SET Name=REPLACE(Name, 'client', 'tenant') WHERE AD_WF_Node_ID<1000000 AND REGEXP_LIKE(Name,'(^|\W)client(\W|$)') AND Name NOT LIKE '%client-%';

UPDATE AD_WF_Node SET Name=REPLACE(Name, 'clients', 'tenants') WHERE AD_WF_Node_ID<1000000 AND REGEXP_LIKE(Name,'(^|\W)clients(\W|$)');

UPDATE AD_WF_Node SET Name=REPLACE(Name, 'Client', 'Tenant') WHERE AD_WF_Node_ID<1000000 AND REGEXP_LIKE(Name,'(^|\W)Client(\W|$)');

UPDATE AD_WF_Node SET Name=REPLACE(Name, 'Clients', 'Tenants') WHERE AD_WF_Node_ID<1000000 AND REGEXP_LIKE(Name,'(^|\W)Clients(\W|$)');

UPDATE AD_Window SET Description=REPLACE(Description, 'client', 'tenant') WHERE AD_Window_ID<1000000 AND REGEXP_LIKE(Description,'(^|\W)client(\W|$)') AND Description NOT LIKE '%client-%';

UPDATE AD_Window SET Description=REPLACE(Description, 'clients', 'tenants') WHERE AD_Window_ID<1000000 AND REGEXP_LIKE(Description,'(^|\W)clients(\W|$)');

UPDATE AD_Window SET Description=REPLACE(Description, 'Client', 'Tenant') WHERE AD_Window_ID<1000000 AND REGEXP_LIKE(Description,'(^|\W)Client(\W|$)');

UPDATE AD_Window SET Description=REPLACE(Description, 'Clients', 'Tenants') WHERE AD_Window_ID<1000000 AND REGEXP_LIKE(Description,'(^|\W)Clients(\W|$)');

UPDATE AD_Window SET Help=REPLACE(Help, 'client', 'tenant') WHERE AD_Window_ID<1000000 AND REGEXP_LIKE(Help,'(^|\W)client(\W|$)') AND Help NOT LIKE '%client-%';

UPDATE AD_Window SET Help=REPLACE(Help, 'clients', 'tenants') WHERE AD_Window_ID<1000000 AND REGEXP_LIKE(Help,'(^|\W)clients(\W|$)');

UPDATE AD_Window SET Help=REPLACE(Help, 'Client', 'Tenant') WHERE AD_Window_ID<1000000 AND REGEXP_LIKE(Help,'(^|\W)Client(\W|$)');

UPDATE AD_Window SET Help=REPLACE(Help, 'Clients', 'Tenants') WHERE AD_Window_ID<1000000 AND REGEXP_LIKE(Help,'(^|\W)Clients(\W|$)');

UPDATE AD_Window SET Name=REPLACE(Name, 'client', 'tenant') WHERE AD_Window_ID<1000000 AND REGEXP_LIKE(Name,'(^|\W)client(\W|$)') AND Name NOT LIKE '%client-%';

UPDATE AD_Window SET Name=REPLACE(Name, 'clients', 'tenants') WHERE AD_Window_ID<1000000 AND REGEXP_LIKE(Name,'(^|\W)clients(\W|$)');

UPDATE AD_Window SET Name=REPLACE(Name, 'Client', 'Tenant') WHERE AD_Window_ID<1000000 AND REGEXP_LIKE(Name,'(^|\W)Client(\W|$)');

UPDATE AD_Window SET Name=REPLACE(Name, 'Clients', 'Tenants') WHERE AD_Window_ID<1000000 AND REGEXP_LIKE(Name,'(^|\W)Clients(\W|$)');

UPDATE AD_Workflow SET Description=REPLACE(Description, 'client', 'tenant') WHERE AD_Workflow_ID<1000000 AND REGEXP_LIKE(Description,'(^|\W)client(\W|$)') AND Description NOT LIKE '%client-%';

UPDATE AD_Workflow SET Description=REPLACE(Description, 'clients', 'tenants') WHERE AD_Workflow_ID<1000000 AND REGEXP_LIKE(Description,'(^|\W)clients(\W|$)');

UPDATE AD_Workflow SET Description=REPLACE(Description, 'Client', 'Tenant') WHERE AD_Workflow_ID<1000000 AND REGEXP_LIKE(Description,'(^|\W)Client(\W|$)');

UPDATE AD_Workflow SET Description=REPLACE(Description, 'Clients', 'Tenants') WHERE AD_Workflow_ID<1000000 AND REGEXP_LIKE(Description,'(^|\W)Clients(\W|$)');

UPDATE AD_Workflow SET Help=REPLACE(Help, 'client', 'tenant') WHERE AD_Workflow_ID<1000000 AND REGEXP_LIKE(Help,'(^|\W)client(\W|$)') AND Help NOT LIKE '%client-%';

UPDATE AD_Workflow SET Help=REPLACE(Help, 'clients', 'tenants') WHERE AD_Workflow_ID<1000000 AND REGEXP_LIKE(Help,'(^|\W)clients(\W|$)');

UPDATE AD_Workflow SET Help=REPLACE(Help, 'Client', 'Tenant') WHERE AD_Workflow_ID<1000000 AND REGEXP_LIKE(Help,'(^|\W)Client(\W|$)');

UPDATE AD_Workflow SET Help=REPLACE(Help, 'Clients', 'Tenants') WHERE AD_Workflow_ID<1000000 AND REGEXP_LIKE(Help,'(^|\W)Clients(\W|$)');

UPDATE AD_Workflow SET Name=REPLACE(Name, 'client', 'tenant') WHERE AD_Workflow_ID<1000000 AND REGEXP_LIKE(Name,'(^|\W)client(\W|$)') AND Name NOT LIKE '%client-%';

UPDATE AD_Workflow SET Name=REPLACE(Name, 'clients', 'tenants') WHERE AD_Workflow_ID<1000000 AND REGEXP_LIKE(Name,'(^|\W)clients(\W|$)');

UPDATE AD_Workflow SET Name=REPLACE(Name, 'Client', 'Tenant') WHERE AD_Workflow_ID<1000000 AND REGEXP_LIKE(Name,'(^|\W)Client(\W|$)');

UPDATE AD_Workflow SET Name=REPLACE(Name, 'Clients', 'Tenants') WHERE AD_Workflow_ID<1000000 AND REGEXP_LIKE(Name,'(^|\W)Clients(\W|$)');

SELECT register_migration_script('202203081457_IDEMPIERE-4586.sql') FROM dual
;

