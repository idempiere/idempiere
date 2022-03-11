UPDATE AD_Element SET Updated=TO_TIMESTAMP('2022-03-10 00:00:00','YYYY-MM-DD HH24:MI:SS'), Description=REPLACE(Description, 'client', 'tenant') WHERE AD_Element_ID<1000000 AND Description~'\mclient\M' AND Description NOT LIKE '%client-%';

UPDATE AD_Element SET Updated=TO_TIMESTAMP('2022-03-10 00:00:00','YYYY-MM-DD HH24:MI:SS'), Description=REPLACE(Description, 'clients', 'tenants') WHERE AD_Element_ID<1000000 AND Description~'\mclients\M';

UPDATE AD_Element SET Updated=TO_TIMESTAMP('2022-03-10 00:00:00','YYYY-MM-DD HH24:MI:SS'), Description=REPLACE(Description, 'Client', 'Tenant') WHERE AD_Element_ID<1000000 AND Description~'\mClient\M';

UPDATE AD_Element SET Updated=TO_TIMESTAMP('2022-03-10 00:00:00','YYYY-MM-DD HH24:MI:SS'), Description=REPLACE(Description, 'Clients', 'Tenants') WHERE AD_Element_ID<1000000 AND Description~'\mClients\M';

UPDATE AD_Element SET Updated=TO_TIMESTAMP('2022-03-10 00:00:00','YYYY-MM-DD HH24:MI:SS'), Description=REPLACE(Description, 'Tenant/Tenant', 'Tenant') WHERE AD_Element_ID<1000000 AND Description~'\mTenant/Tenant\M';

UPDATE AD_Element SET Updated=TO_TIMESTAMP('2022-03-10 00:00:00','YYYY-MM-DD HH24:MI:SS'), Help=REPLACE(Help, 'client', 'tenant') WHERE AD_Element_ID<1000000 AND Help~'\mclient\M' AND Help NOT LIKE '%client-%';

UPDATE AD_Element SET Updated=TO_TIMESTAMP('2022-03-10 00:00:00','YYYY-MM-DD HH24:MI:SS'), Help=REPLACE(Help, 'clients', 'tenants') WHERE AD_Element_ID<1000000 AND Help~'\mclients\M';

UPDATE AD_Element SET Updated=TO_TIMESTAMP('2022-03-10 00:00:00','YYYY-MM-DD HH24:MI:SS'), Help=REPLACE(Help, 'Client', 'Tenant') WHERE AD_Element_ID<1000000 AND Help~'\mClient\M';

UPDATE AD_Element SET Updated=TO_TIMESTAMP('2022-03-10 00:00:00','YYYY-MM-DD HH24:MI:SS'), Help=REPLACE(Help, 'Clients', 'Tenants') WHERE AD_Element_ID<1000000 AND Help~'\mClients\M';

UPDATE AD_Element SET Updated=TO_TIMESTAMP('2022-03-10 00:00:00','YYYY-MM-DD HH24:MI:SS'), Help=REPLACE(Help, ' Tenant is a synonym for Tenant.', '') WHERE AD_Element_ID<1000000 AND Help LIKE '% Tenant is a synonym for Tenant.%';

UPDATE AD_Element SET Updated=TO_TIMESTAMP('2022-03-10 00:00:00','YYYY-MM-DD HH24:MI:SS'), Name=REPLACE(Name, 'client', 'tenant') WHERE AD_Element_ID<1000000 AND Name~'\mclient\M' AND Name NOT LIKE '%client-%';

UPDATE AD_Element SET Updated=TO_TIMESTAMP('2022-03-10 00:00:00','YYYY-MM-DD HH24:MI:SS'), Name=REPLACE(Name, 'clients', 'tenants') WHERE AD_Element_ID<1000000 AND Name~'\mclients\M';

UPDATE AD_Element SET Updated=TO_TIMESTAMP('2022-03-10 00:00:00','YYYY-MM-DD HH24:MI:SS'), Name=REPLACE(Name, 'Client', 'Tenant') WHERE AD_Element_ID<1000000 AND Name~'\mClient\M';

UPDATE AD_Element SET Updated=TO_TIMESTAMP('2022-03-10 00:00:00','YYYY-MM-DD HH24:MI:SS'), Name=REPLACE(Name, 'Clients', 'Tenants') WHERE AD_Element_ID<1000000 AND Name~'\mClients\M';

UPDATE AD_Element SET Updated=TO_TIMESTAMP('2022-03-10 00:00:00','YYYY-MM-DD HH24:MI:SS'), PrintName=REPLACE(PrintName, 'client', 'tenant') WHERE AD_Element_ID<1000000 AND PrintName~'\mclient\M' AND PrintName NOT LIKE '%client-%';

UPDATE AD_Element SET Updated=TO_TIMESTAMP('2022-03-10 00:00:00','YYYY-MM-DD HH24:MI:SS'), PrintName=REPLACE(PrintName, 'clients', 'tenants') WHERE AD_Element_ID<1000000 AND PrintName~'\mclients\M';

UPDATE AD_Element SET Updated=TO_TIMESTAMP('2022-03-10 00:00:00','YYYY-MM-DD HH24:MI:SS'), PrintName=REPLACE(PrintName, 'Client', 'Tenant') WHERE AD_Element_ID<1000000 AND PrintName~'\mClient\M';

UPDATE AD_Element SET Updated=TO_TIMESTAMP('2022-03-10 00:00:00','YYYY-MM-DD HH24:MI:SS'), PrintName=REPLACE(PrintName, 'Clients', 'Tenants') WHERE AD_Element_ID<1000000 AND PrintName~'\mClients\M';

UPDATE AD_Field SET Updated=TO_TIMESTAMP('2022-03-10 00:00:00','YYYY-MM-DD HH24:MI:SS'), Help=REPLACE(Help, 'client', 'tenant') WHERE AD_Field_ID<1000000 AND Help~'\mclient\M' AND Help NOT LIKE '%client-%' AND IsCentrallyMaintained='N';

UPDATE AD_Field SET Updated=TO_TIMESTAMP('2022-03-10 00:00:00','YYYY-MM-DD HH24:MI:SS'), Help=REPLACE(Help, 'clients', 'tenants') WHERE AD_Field_ID<1000000 AND Help~'\mclients\M' AND IsCentrallyMaintained='N';

UPDATE AD_Field SET Updated=TO_TIMESTAMP('2022-03-10 00:00:00','YYYY-MM-DD HH24:MI:SS'), Help=REPLACE(Help, 'Client', 'Tenant') WHERE AD_Field_ID<1000000 AND Help~'\mClient\M' AND IsCentrallyMaintained='N';

UPDATE AD_Field SET Updated=TO_TIMESTAMP('2022-03-10 00:00:00','YYYY-MM-DD HH24:MI:SS'), Help=REPLACE(Help, 'Clients', 'Tenants') WHERE AD_Field_ID<1000000 AND Help~'\mClients\M' AND IsCentrallyMaintained='N';

UPDATE AD_Field SET Updated=TO_TIMESTAMP('2022-03-10 00:00:00','YYYY-MM-DD HH24:MI:SS'), Name=REPLACE(Name, 'client', 'tenant') WHERE AD_Field_ID<1000000 AND Name~'\mclient\M' AND Name NOT LIKE '%client-%' AND IsCentrallyMaintained='N';

UPDATE AD_Field SET Updated=TO_TIMESTAMP('2022-03-10 00:00:00','YYYY-MM-DD HH24:MI:SS'), Name=REPLACE(Name, 'clients', 'tenants') WHERE AD_Field_ID<1000000 AND Name~'\mclients\M' AND IsCentrallyMaintained='N';

UPDATE AD_Field SET Updated=TO_TIMESTAMP('2022-03-10 00:00:00','YYYY-MM-DD HH24:MI:SS'), Name=REPLACE(Name, 'Client', 'Tenant') WHERE AD_Field_ID<1000000 AND Name~'\mClient\M' AND IsCentrallyMaintained='N';

UPDATE AD_Field SET Updated=TO_TIMESTAMP('2022-03-10 00:00:00','YYYY-MM-DD HH24:MI:SS'), Name=REPLACE(Name, 'Clients', 'Tenants') WHERE AD_Field_ID<1000000 AND Name~'\mClients\M' AND IsCentrallyMaintained='N';

UPDATE AD_Form SET Updated=TO_TIMESTAMP('2022-03-10 00:00:00','YYYY-MM-DD HH24:MI:SS'), Description=REPLACE(Description, 'client', 'tenant') WHERE AD_Form_ID<1000000 AND Description~'\mclient\M' AND Description NOT LIKE '%client-%';

UPDATE AD_Form SET Updated=TO_TIMESTAMP('2022-03-10 00:00:00','YYYY-MM-DD HH24:MI:SS'), Description=REPLACE(Description, 'clients', 'tenants') WHERE AD_Form_ID<1000000 AND Description~'\mclients\M';

UPDATE AD_Form SET Updated=TO_TIMESTAMP('2022-03-10 00:00:00','YYYY-MM-DD HH24:MI:SS'), Description=REPLACE(Description, 'Client', 'Tenant') WHERE AD_Form_ID<1000000 AND Description~'\mClient\M';

UPDATE AD_Form SET Updated=TO_TIMESTAMP('2022-03-10 00:00:00','YYYY-MM-DD HH24:MI:SS'), Description=REPLACE(Description, 'Clients', 'Tenants') WHERE AD_Form_ID<1000000 AND Description~'\mClients\M';

UPDATE AD_Form SET Updated=TO_TIMESTAMP('2022-03-10 00:00:00','YYYY-MM-DD HH24:MI:SS'), Description=REPLACE(Description, 'Tenant/Tenant', 'Tenant') WHERE AD_Form_ID<1000000 AND Description~'\mTenant/Tenant\M';

UPDATE AD_Form SET Updated=TO_TIMESTAMP('2022-03-10 00:00:00','YYYY-MM-DD HH24:MI:SS'), Help=REPLACE(Help, 'client', 'tenant') WHERE AD_Form_ID<1000000 AND Help~'\mclient\M' AND Help NOT LIKE '%client-%';

UPDATE AD_Form SET Updated=TO_TIMESTAMP('2022-03-10 00:00:00','YYYY-MM-DD HH24:MI:SS'), Help=REPLACE(Help, 'clients', 'tenants') WHERE AD_Form_ID<1000000 AND Help~'\mclients\M';

UPDATE AD_Form SET Updated=TO_TIMESTAMP('2022-03-10 00:00:00','YYYY-MM-DD HH24:MI:SS'), Help=REPLACE(Help, 'Client', 'Tenant') WHERE AD_Form_ID<1000000 AND Help~'\mClient\M';

UPDATE AD_Form SET Updated=TO_TIMESTAMP('2022-03-10 00:00:00','YYYY-MM-DD HH24:MI:SS'), Help=REPLACE(Help, 'Clients', 'Tenants') WHERE AD_Form_ID<1000000 AND Help~'\mClients\M';

UPDATE AD_Form SET Updated=TO_TIMESTAMP('2022-03-10 00:00:00','YYYY-MM-DD HH24:MI:SS'), Help=REPLACE(Help, 'Tenant/Tenant', 'Tenant') WHERE AD_Form_ID<1000000 AND Help~'\mTenant/Tenant\M';

UPDATE AD_Form SET Updated=TO_TIMESTAMP('2022-03-10 00:00:00','YYYY-MM-DD HH24:MI:SS'), Name=REPLACE(Name, 'client', 'tenant') WHERE AD_Form_ID<1000000 AND Name~'\mclient\M' AND Name NOT LIKE '%client-%';

UPDATE AD_Form SET Updated=TO_TIMESTAMP('2022-03-10 00:00:00','YYYY-MM-DD HH24:MI:SS'), Name=REPLACE(Name, 'clients', 'tenants') WHERE AD_Form_ID<1000000 AND Name~'\mclients\M';

UPDATE AD_Form SET Updated=TO_TIMESTAMP('2022-03-10 00:00:00','YYYY-MM-DD HH24:MI:SS'), Name=REPLACE(Name, 'Client', 'Tenant') WHERE AD_Form_ID<1000000 AND Name~'\mClient\M';

UPDATE AD_Form SET Updated=TO_TIMESTAMP('2022-03-10 00:00:00','YYYY-MM-DD HH24:MI:SS'), Name=REPLACE(Name, 'Clients', 'Tenants') WHERE AD_Form_ID<1000000 AND Name~'\mClients\M';

UPDATE AD_Menu SET Updated=TO_TIMESTAMP('2022-03-10 00:00:00','YYYY-MM-DD HH24:MI:SS'), Description=REPLACE(Description, 'client', 'tenant') WHERE AD_Menu_ID<1000000 AND Description~'\mclient\M' AND Description NOT LIKE '%client-%' AND IsCentrallyMaintained='N';

UPDATE AD_Menu SET Updated=TO_TIMESTAMP('2022-03-10 00:00:00','YYYY-MM-DD HH24:MI:SS'), Description=REPLACE(Description, 'clients', 'tenants') WHERE AD_Menu_ID<1000000 AND Description~'\mclients\M' AND IsCentrallyMaintained='N';

UPDATE AD_Menu SET Updated=TO_TIMESTAMP('2022-03-10 00:00:00','YYYY-MM-DD HH24:MI:SS'), Description=REPLACE(Description, 'Client', 'Tenant') WHERE AD_Menu_ID<1000000 AND Description~'\mClient\M' AND IsCentrallyMaintained='N';

UPDATE AD_Menu SET Updated=TO_TIMESTAMP('2022-03-10 00:00:00','YYYY-MM-DD HH24:MI:SS'), Description=REPLACE(Description, 'Clients', 'Tenants') WHERE AD_Menu_ID<1000000 AND Description~'\mClients\M' AND IsCentrallyMaintained='N';

UPDATE AD_Menu SET Updated=TO_TIMESTAMP('2022-03-10 00:00:00','YYYY-MM-DD HH24:MI:SS'), Name=REPLACE(Name, 'client', 'tenant') WHERE AD_Menu_ID<1000000 AND Name~'\mclient\M' AND Name NOT LIKE '%client-%' AND IsCentrallyMaintained='N';

UPDATE AD_Menu SET Updated=TO_TIMESTAMP('2022-03-10 00:00:00','YYYY-MM-DD HH24:MI:SS'), Name=REPLACE(Name, 'clients', 'tenants') WHERE AD_Menu_ID<1000000 AND Name~'\mclients\M' AND IsCentrallyMaintained='N';

UPDATE AD_Menu SET Updated=TO_TIMESTAMP('2022-03-10 00:00:00','YYYY-MM-DD HH24:MI:SS'), Name=REPLACE(Name, 'Client', 'Tenant') WHERE AD_Menu_ID<1000000 AND Name~'\mClient\M' AND IsCentrallyMaintained='N';

UPDATE AD_Menu SET Updated=TO_TIMESTAMP('2022-03-10 00:00:00','YYYY-MM-DD HH24:MI:SS'), Name=REPLACE(Name, 'Clients', 'Tenants') WHERE AD_Menu_ID<1000000 AND Name~'\mClients\M' AND IsCentrallyMaintained='N';

UPDATE AD_Message SET Updated=TO_TIMESTAMP('2022-03-10 00:00:00','YYYY-MM-DD HH24:MI:SS'), MsgText=REPLACE(MsgText, 'client', 'tenant') WHERE AD_Message_ID<1000000 AND MsgText~'\mclient\M' AND MsgText NOT LIKE '%client-%';

UPDATE AD_Message SET Updated=TO_TIMESTAMP('2022-03-10 00:00:00','YYYY-MM-DD HH24:MI:SS'), MsgText=REPLACE(MsgText, 'clients', 'tenants') WHERE AD_Message_ID<1000000 AND MsgText~'\mclients\M';

UPDATE AD_Message SET Updated=TO_TIMESTAMP('2022-03-10 00:00:00','YYYY-MM-DD HH24:MI:SS'), MsgText=REPLACE(MsgText, 'Client', 'Tenant') WHERE AD_Message_ID<1000000 AND MsgText~'\mClient\M';

UPDATE AD_Message SET Updated=TO_TIMESTAMP('2022-03-10 00:00:00','YYYY-MM-DD HH24:MI:SS'), MsgText=REPLACE(MsgText, 'Clients', 'Tenants') WHERE AD_Message_ID<1000000 AND MsgText~'\mClients\M';

UPDATE AD_Message SET Updated=TO_TIMESTAMP('2022-03-10 00:00:00','YYYY-MM-DD HH24:MI:SS'), MsgTip=REPLACE(MsgTip, 'client', 'tenant') WHERE AD_Message_ID<1000000 AND MsgTip~'\mclient\M' AND MsgTip NOT LIKE '%client-%';

UPDATE AD_Message SET Updated=TO_TIMESTAMP('2022-03-10 00:00:00','YYYY-MM-DD HH24:MI:SS'), MsgTip=REPLACE(MsgTip, 'clients', 'tenants') WHERE AD_Message_ID<1000000 AND MsgTip~'\mclients\M';

UPDATE AD_Message SET Updated=TO_TIMESTAMP('2022-03-10 00:00:00','YYYY-MM-DD HH24:MI:SS'), MsgTip=REPLACE(MsgTip, 'Client', 'Tenant') WHERE AD_Message_ID<1000000 AND MsgTip~'\mClient\M';

UPDATE AD_Message SET Updated=TO_TIMESTAMP('2022-03-10 00:00:00','YYYY-MM-DD HH24:MI:SS'), MsgTip=REPLACE(MsgTip, 'Clients', 'Tenants') WHERE AD_Message_ID<1000000 AND MsgTip~'\mClients\M';

UPDATE AD_Process SET Updated=TO_TIMESTAMP('2022-03-10 00:00:00','YYYY-MM-DD HH24:MI:SS'), Description=REPLACE(Description, 'client', 'tenant') WHERE AD_Process_ID<1000000 AND Description~'\mclient\M' AND Description NOT LIKE '%client-%';

UPDATE AD_Process SET Updated=TO_TIMESTAMP('2022-03-10 00:00:00','YYYY-MM-DD HH24:MI:SS'), Description=REPLACE(Description, 'clients', 'tenants') WHERE AD_Process_ID<1000000 AND Description~'\mclients\M';

UPDATE AD_Process SET Updated=TO_TIMESTAMP('2022-03-10 00:00:00','YYYY-MM-DD HH24:MI:SS'), Description=REPLACE(Description, 'Client', 'Tenant') WHERE AD_Process_ID<1000000 AND Description~'\mClient\M';

UPDATE AD_Process SET Updated=TO_TIMESTAMP('2022-03-10 00:00:00','YYYY-MM-DD HH24:MI:SS'), Description=REPLACE(Description, 'Clients', 'Tenants') WHERE AD_Process_ID<1000000 AND Description~'\mClients\M';

UPDATE AD_Process SET Updated=TO_TIMESTAMP('2022-03-10 00:00:00','YYYY-MM-DD HH24:MI:SS'), Help=REPLACE(Help, 'client', 'tenant') WHERE AD_Process_ID<1000000 AND Help~'\mclient\M' AND Help NOT LIKE '%client-%';

UPDATE AD_Process SET Updated=TO_TIMESTAMP('2022-03-10 00:00:00','YYYY-MM-DD HH24:MI:SS'), Help=REPLACE(Help, 'clients', 'tenants') WHERE AD_Process_ID<1000000 AND Help~'\mclients\M';

UPDATE AD_Process SET Updated=TO_TIMESTAMP('2022-03-10 00:00:00','YYYY-MM-DD HH24:MI:SS'), Help=REPLACE(Help, 'Client', 'Tenant') WHERE AD_Process_ID<1000000 AND Help~'\mClient\M';

UPDATE AD_Process SET Updated=TO_TIMESTAMP('2022-03-10 00:00:00','YYYY-MM-DD HH24:MI:SS'), Help=REPLACE(Help, 'Clients', 'Tenants') WHERE AD_Process_ID<1000000 AND Help~'\mClients\M';

UPDATE AD_Process SET Updated=TO_TIMESTAMP('2022-03-10 00:00:00','YYYY-MM-DD HH24:MI:SS'), Name=REPLACE(Name, 'client', 'tenant') WHERE AD_Process_ID<1000000 AND Name~'\mclient\M' AND Name NOT LIKE '%client-%';

UPDATE AD_Process SET Updated=TO_TIMESTAMP('2022-03-10 00:00:00','YYYY-MM-DD HH24:MI:SS'), Name=REPLACE(Name, 'clients', 'tenants') WHERE AD_Process_ID<1000000 AND Name~'\mclients\M';

UPDATE AD_Process SET Updated=TO_TIMESTAMP('2022-03-10 00:00:00','YYYY-MM-DD HH24:MI:SS'), Name=REPLACE(Name, 'Client', 'Tenant') WHERE AD_Process_ID<1000000 AND Name~'\mClient\M';

UPDATE AD_Process SET Updated=TO_TIMESTAMP('2022-03-10 00:00:00','YYYY-MM-DD HH24:MI:SS'), Name=REPLACE(Name, 'Clients', 'Tenants') WHERE AD_Process_ID<1000000 AND Name~'\mClients\M';

UPDATE AD_Process_Para SET Updated=TO_TIMESTAMP('2022-03-10 00:00:00','YYYY-MM-DD HH24:MI:SS'), Description=REPLACE(Description, 'client', 'tenant') WHERE AD_Process_Para_ID<1000000 AND Description~'\mclient\M' AND Description NOT LIKE '%client-%' AND IsCentrallyMaintained='N';

UPDATE AD_Process_Para SET Updated=TO_TIMESTAMP('2022-03-10 00:00:00','YYYY-MM-DD HH24:MI:SS'), Description=REPLACE(Description, 'clients', 'tenants') WHERE AD_Process_Para_ID<1000000 AND Description~'\mclients\M' AND IsCentrallyMaintained='N';

UPDATE AD_Process_Para SET Updated=TO_TIMESTAMP('2022-03-10 00:00:00','YYYY-MM-DD HH24:MI:SS'), Description=REPLACE(Description, 'Client', 'Tenant') WHERE AD_Process_Para_ID<1000000 AND Description~'\mClient\M' AND IsCentrallyMaintained='N';

UPDATE AD_Process_Para SET Updated=TO_TIMESTAMP('2022-03-10 00:00:00','YYYY-MM-DD HH24:MI:SS'), Description=REPLACE(Description, 'Clients', 'Tenants') WHERE AD_Process_Para_ID<1000000 AND Description~'\mClients\M' AND IsCentrallyMaintained='N';

UPDATE AD_Process_Para SET Updated=TO_TIMESTAMP('2022-03-10 00:00:00','YYYY-MM-DD HH24:MI:SS'), Description=REPLACE(Description, 'Tenant/Tenant', 'Tenant') WHERE AD_Process_Para_ID<1000000 AND Description~'\mTenant/Tenant\M';

UPDATE AD_Process_Para SET Updated=TO_TIMESTAMP('2022-03-10 00:00:00','YYYY-MM-DD HH24:MI:SS'), Help=REPLACE(Help, 'client', 'tenant') WHERE AD_Process_Para_ID<1000000 AND Help~'\mclient\M' AND Help NOT LIKE '%client-%' AND IsCentrallyMaintained='N';

UPDATE AD_Process_Para SET Updated=TO_TIMESTAMP('2022-03-10 00:00:00','YYYY-MM-DD HH24:MI:SS'), Help=REPLACE(Help, 'clients', 'tenants') WHERE AD_Process_Para_ID<1000000 AND Help~'\mclients\M' AND IsCentrallyMaintained='N';

UPDATE AD_Process_Para SET Updated=TO_TIMESTAMP('2022-03-10 00:00:00','YYYY-MM-DD HH24:MI:SS'), Help=REPLACE(Help, 'Client', 'Tenant') WHERE AD_Process_Para_ID<1000000 AND Help~'\mClient\M' AND IsCentrallyMaintained='N';

UPDATE AD_Process_Para SET Updated=TO_TIMESTAMP('2022-03-10 00:00:00','YYYY-MM-DD HH24:MI:SS'), Help=REPLACE(Help, 'Clients', 'Tenants') WHERE AD_Process_Para_ID<1000000 AND Help~'\mClients\M' AND IsCentrallyMaintained='N';

UPDATE AD_Process_Para SET Updated=TO_TIMESTAMP('2022-03-10 00:00:00','YYYY-MM-DD HH24:MI:SS'), Help=REPLACE(Help, ' Tenant is a synonym for Tenant.', '') WHERE AD_Process_Para_ID<1000000 AND Help LIKE '% Tenant is a synonym for Tenant.%';

UPDATE AD_Process_Para SET Updated=TO_TIMESTAMP('2022-03-10 00:00:00','YYYY-MM-DD HH24:MI:SS'), Name=REPLACE(Name, 'client', 'tenant') WHERE AD_Process_Para_ID<1000000 AND Name~'\mclient\M' AND Name NOT LIKE '%client-%' AND IsCentrallyMaintained='N';

UPDATE AD_Process_Para SET Updated=TO_TIMESTAMP('2022-03-10 00:00:00','YYYY-MM-DD HH24:MI:SS'), Name=REPLACE(Name, 'clients', 'tenants') WHERE AD_Process_Para_ID<1000000 AND Name~'\mclients\M' AND IsCentrallyMaintained='N';

UPDATE AD_Process_Para SET Updated=TO_TIMESTAMP('2022-03-10 00:00:00','YYYY-MM-DD HH24:MI:SS'), Name=REPLACE(Name, 'Client', 'Tenant') WHERE AD_Process_Para_ID<1000000 AND Name~'\mClient\M' AND IsCentrallyMaintained='N';

UPDATE AD_Process_Para SET Updated=TO_TIMESTAMP('2022-03-10 00:00:00','YYYY-MM-DD HH24:MI:SS'), Name=REPLACE(Name, 'Clients', 'Tenants') WHERE AD_Process_Para_ID<1000000 AND Name~'\mClients\M' AND IsCentrallyMaintained='N';

UPDATE AD_Reference SET Updated=TO_TIMESTAMP('2022-03-10 00:00:00','YYYY-MM-DD HH24:MI:SS'), Description=REPLACE(Description, 'client', 'tenant') WHERE AD_Reference_ID<1000000 AND Description~'\mclient\M' AND Description NOT LIKE '%client-%';

UPDATE AD_Reference SET Updated=TO_TIMESTAMP('2022-03-10 00:00:00','YYYY-MM-DD HH24:MI:SS'), Description=REPLACE(Description, 'clients', 'tenants') WHERE AD_Reference_ID<1000000 AND Description~'\mclients\M';

UPDATE AD_Reference SET Updated=TO_TIMESTAMP('2022-03-10 00:00:00','YYYY-MM-DD HH24:MI:SS'), Description=REPLACE(Description, 'Client', 'Tenant') WHERE AD_Reference_ID<1000000 AND Description~'\mClient\M';

UPDATE AD_Reference SET Updated=TO_TIMESTAMP('2022-03-10 00:00:00','YYYY-MM-DD HH24:MI:SS'), Description=REPLACE(Description, 'Clients', 'Tenants') WHERE AD_Reference_ID<1000000 AND Description~'\mClients\M';

UPDATE AD_Reference SET Updated=TO_TIMESTAMP('2022-03-10 00:00:00','YYYY-MM-DD HH24:MI:SS'), Name=REPLACE(Name, 'client', 'tenant') WHERE AD_Reference_ID<1000000 AND Name~'\mclient\M' AND Name NOT LIKE '%client-%';

UPDATE AD_Reference SET Updated=TO_TIMESTAMP('2022-03-10 00:00:00','YYYY-MM-DD HH24:MI:SS'), Name=REPLACE(Name, 'clients', 'tenants') WHERE AD_Reference_ID<1000000 AND Name~'\mclients\M';

UPDATE AD_Reference SET Updated=TO_TIMESTAMP('2022-03-10 00:00:00','YYYY-MM-DD HH24:MI:SS'), Name=REPLACE(Name, 'Client', 'Tenant') WHERE AD_Reference_ID<1000000 AND Name~'\mClient\M';

UPDATE AD_Reference SET Updated=TO_TIMESTAMP('2022-03-10 00:00:00','YYYY-MM-DD HH24:MI:SS'), Name=REPLACE(Name, 'Clients', 'Tenants') WHERE AD_Reference_ID<1000000 AND Name~'\mClients\M';

UPDATE AD_Ref_List SET Updated=TO_TIMESTAMP('2022-03-10 00:00:00','YYYY-MM-DD HH24:MI:SS'), Description=REPLACE(Description, 'client', 'tenant') WHERE AD_Ref_List_ID<1000000 AND Description~'\mclient\M' AND Description NOT LIKE '%client-%';

UPDATE AD_Ref_List SET Updated=TO_TIMESTAMP('2022-03-10 00:00:00','YYYY-MM-DD HH24:MI:SS'), Description=REPLACE(Description, 'clients', 'tenants') WHERE AD_Ref_List_ID<1000000 AND Description~'\mclients\M';

UPDATE AD_Ref_List SET Updated=TO_TIMESTAMP('2022-03-10 00:00:00','YYYY-MM-DD HH24:MI:SS'), Description=REPLACE(Description, 'Client', 'Tenant') WHERE AD_Ref_List_ID<1000000 AND Description~'\mClient\M';

UPDATE AD_Ref_List SET Updated=TO_TIMESTAMP('2022-03-10 00:00:00','YYYY-MM-DD HH24:MI:SS'), Description=REPLACE(Description, 'Clients', 'Tenants') WHERE AD_Ref_List_ID<1000000 AND Description~'\mClients\M';

UPDATE AD_Tab SET Updated=TO_TIMESTAMP('2022-03-10 00:00:00','YYYY-MM-DD HH24:MI:SS'), Description=REPLACE(Description, 'client', 'tenant') WHERE AD_Tab_ID<1000000 AND Description~'\mclient\M' AND Description NOT LIKE '%client-%';

UPDATE AD_Tab SET Updated=TO_TIMESTAMP('2022-03-10 00:00:00','YYYY-MM-DD HH24:MI:SS'), Description=REPLACE(Description, 'clients', 'tenants') WHERE AD_Tab_ID<1000000 AND Description~'\mclients\M';

UPDATE AD_Tab SET Updated=TO_TIMESTAMP('2022-03-10 00:00:00','YYYY-MM-DD HH24:MI:SS'), Description=REPLACE(Description, 'Client', 'Tenant') WHERE AD_Tab_ID<1000000 AND Description~'\mClient\M';

UPDATE AD_Tab SET Updated=TO_TIMESTAMP('2022-03-10 00:00:00','YYYY-MM-DD HH24:MI:SS'), Description=REPLACE(Description, 'Clients', 'Tenants') WHERE AD_Tab_ID<1000000 AND Description~'\mClients\M';

UPDATE AD_Tab SET Updated=TO_TIMESTAMP('2022-03-10 00:00:00','YYYY-MM-DD HH24:MI:SS'), Description=REPLACE(Description, 'Tenant/Tenant', 'Tenant') WHERE AD_Tab_ID<1000000 AND Description~'\mTenant/Tenant\M';

UPDATE AD_Tab SET Updated=TO_TIMESTAMP('2022-03-10 00:00:00','YYYY-MM-DD HH24:MI:SS'), Help=REPLACE(Help, 'client', 'tenant') WHERE AD_Tab_ID<1000000 AND Help~'\mclient\M' AND Help NOT LIKE '%client-%';

UPDATE AD_Tab SET Updated=TO_TIMESTAMP('2022-03-10 00:00:00','YYYY-MM-DD HH24:MI:SS'), Help=REPLACE(Help, 'clients', 'tenants') WHERE AD_Tab_ID<1000000 AND Help~'\mclients\M';

UPDATE AD_Tab SET Updated=TO_TIMESTAMP('2022-03-10 00:00:00','YYYY-MM-DD HH24:MI:SS'), Help=REPLACE(Help, 'Client', 'Tenant') WHERE AD_Tab_ID<1000000 AND Help~'\mClient\M';

UPDATE AD_Tab SET Updated=TO_TIMESTAMP('2022-03-10 00:00:00','YYYY-MM-DD HH24:MI:SS'), Help=REPLACE(Help, 'Clients', 'Tenants') WHERE AD_Tab_ID<1000000 AND Help~'\mClients\M';

UPDATE AD_Tab SET Updated=TO_TIMESTAMP('2022-03-10 00:00:00','YYYY-MM-DD HH24:MI:SS'), Name=REPLACE(Name, 'client', 'tenant') WHERE AD_Tab_ID<1000000 AND Name~'\mclient\M' AND Name NOT LIKE '%client-%';

UPDATE AD_Tab SET Updated=TO_TIMESTAMP('2022-03-10 00:00:00','YYYY-MM-DD HH24:MI:SS'), Name=REPLACE(Name, 'clients', 'tenants') WHERE AD_Tab_ID<1000000 AND Name~'\mclients\M';

UPDATE AD_Tab SET Updated=TO_TIMESTAMP('2022-03-10 00:00:00','YYYY-MM-DD HH24:MI:SS'), Name=REPLACE(Name, 'Client', 'Tenant') WHERE AD_Tab_ID<1000000 AND Name~'\mClient\M';

UPDATE AD_Tab SET Updated=TO_TIMESTAMP('2022-03-10 00:00:00','YYYY-MM-DD HH24:MI:SS'), Name=REPLACE(Name, 'Clients', 'Tenants') WHERE AD_Tab_ID<1000000 AND Name~'\mClients\M';

UPDATE AD_Tab SET Updated=TO_TIMESTAMP('2022-03-10 00:00:00','YYYY-MM-DD HH24:MI:SS'), CommitWarning=REPLACE(CommitWarning, 'client', 'tenant') WHERE AD_Tab_ID<1000000 AND CommitWarning~'\mclient\M' AND CommitWarning NOT LIKE '%client-%';

UPDATE AD_Tab SET Updated=TO_TIMESTAMP('2022-03-10 00:00:00','YYYY-MM-DD HH24:MI:SS'), CommitWarning=REPLACE(CommitWarning, 'clients', 'tenants') WHERE AD_Tab_ID<1000000 AND CommitWarning~'\mclients\M';

UPDATE AD_Tab SET Updated=TO_TIMESTAMP('2022-03-10 00:00:00','YYYY-MM-DD HH24:MI:SS'), CommitWarning=REPLACE(CommitWarning, 'Client', 'Tenant') WHERE AD_Tab_ID<1000000 AND CommitWarning~'\mClient\M';

UPDATE AD_Tab SET Updated=TO_TIMESTAMP('2022-03-10 00:00:00','YYYY-MM-DD HH24:MI:SS'), CommitWarning=REPLACE(CommitWarning, 'Clients', 'Tenants') WHERE AD_Tab_ID<1000000 AND CommitWarning~'\mClients\M';

UPDATE AD_WF_Node SET Updated=TO_TIMESTAMP('2022-03-10 00:00:00','YYYY-MM-DD HH24:MI:SS'), Description=REPLACE(Description, 'client', 'tenant') WHERE AD_WF_Node_ID<1000000 AND Description~'\mclient\M' AND Description NOT LIKE '%client-%';

UPDATE AD_WF_Node SET Updated=TO_TIMESTAMP('2022-03-10 00:00:00','YYYY-MM-DD HH24:MI:SS'), Description=REPLACE(Description, 'clients', 'tenants') WHERE AD_WF_Node_ID<1000000 AND Description~'\mclients\M';

UPDATE AD_WF_Node SET Updated=TO_TIMESTAMP('2022-03-10 00:00:00','YYYY-MM-DD HH24:MI:SS'), Description=REPLACE(Description, 'Client', 'Tenant') WHERE AD_WF_Node_ID<1000000 AND Description~'\mClient\M';

UPDATE AD_WF_Node SET Updated=TO_TIMESTAMP('2022-03-10 00:00:00','YYYY-MM-DD HH24:MI:SS'), Description=REPLACE(Description, 'Clients', 'Tenants') WHERE AD_WF_Node_ID<1000000 AND Description~'\mClients\M';

UPDATE AD_WF_Node SET Updated=TO_TIMESTAMP('2022-03-10 00:00:00','YYYY-MM-DD HH24:MI:SS'), Description=REPLACE(Description, 'Tenants/Tenants', 'Tenants') WHERE AD_WF_Node_ID<1000000 AND Description~'\mTenants/Tenants\M';

UPDATE AD_WF_Node SET Updated=TO_TIMESTAMP('2022-03-10 00:00:00','YYYY-MM-DD HH24:MI:SS'), Help=REPLACE(Help, 'client', 'tenant') WHERE AD_WF_Node_ID<1000000 AND Help~'\mclient\M' AND Help NOT LIKE '%client-%';

UPDATE AD_WF_Node SET Updated=TO_TIMESTAMP('2022-03-10 00:00:00','YYYY-MM-DD HH24:MI:SS'), Help=REPLACE(Help, 'clients', 'tenants') WHERE AD_WF_Node_ID<1000000 AND Help~'\mclients\M';

UPDATE AD_WF_Node SET Updated=TO_TIMESTAMP('2022-03-10 00:00:00','YYYY-MM-DD HH24:MI:SS'), Help=REPLACE(Help, 'Client', 'Tenant') WHERE AD_WF_Node_ID<1000000 AND Help~'\mClient\M';

UPDATE AD_WF_Node SET Updated=TO_TIMESTAMP('2022-03-10 00:00:00','YYYY-MM-DD HH24:MI:SS'), Help=REPLACE(Help, 'Clients', 'Tenants') WHERE AD_WF_Node_ID<1000000 AND Help~'\mClients\M';

UPDATE AD_WF_Node SET Updated=TO_TIMESTAMP('2022-03-10 00:00:00','YYYY-MM-DD HH24:MI:SS'), Name=REPLACE(Name, 'client', 'tenant') WHERE AD_WF_Node_ID<1000000 AND Name~'\mclient\M' AND Name NOT LIKE '%client-%';

UPDATE AD_WF_Node SET Updated=TO_TIMESTAMP('2022-03-10 00:00:00','YYYY-MM-DD HH24:MI:SS'), Name=REPLACE(Name, 'clients', 'tenants') WHERE AD_WF_Node_ID<1000000 AND Name~'\mclients\M';

UPDATE AD_WF_Node SET Updated=TO_TIMESTAMP('2022-03-10 00:00:00','YYYY-MM-DD HH24:MI:SS'), Name=REPLACE(Name, 'Client', 'Tenant') WHERE AD_WF_Node_ID<1000000 AND Name~'\mClient\M';

UPDATE AD_WF_Node SET Updated=TO_TIMESTAMP('2022-03-10 00:00:00','YYYY-MM-DD HH24:MI:SS'), Name=REPLACE(Name, 'Clients', 'Tenants') WHERE AD_WF_Node_ID<1000000 AND Name~'\mClients\M';

UPDATE AD_Window SET Updated=TO_TIMESTAMP('2022-03-10 00:00:00','YYYY-MM-DD HH24:MI:SS'), Description=REPLACE(Description, 'client', 'tenant') WHERE AD_Window_ID<1000000 AND Description~'\mclient\M' AND Description NOT LIKE '%client-%';

UPDATE AD_Window SET Updated=TO_TIMESTAMP('2022-03-10 00:00:00','YYYY-MM-DD HH24:MI:SS'), Description=REPLACE(Description, 'clients', 'tenants') WHERE AD_Window_ID<1000000 AND Description~'\mclients\M';

UPDATE AD_Window SET Updated=TO_TIMESTAMP('2022-03-10 00:00:00','YYYY-MM-DD HH24:MI:SS'), Description=REPLACE(Description, 'Client', 'Tenant') WHERE AD_Window_ID<1000000 AND Description~'\mClient\M';

UPDATE AD_Window SET Updated=TO_TIMESTAMP('2022-03-10 00:00:00','YYYY-MM-DD HH24:MI:SS'), Description=REPLACE(Description, 'Clients', 'Tenants') WHERE AD_Window_ID<1000000 AND Description~'\mClients\M';

UPDATE AD_Window SET Updated=TO_TIMESTAMP('2022-03-10 00:00:00','YYYY-MM-DD HH24:MI:SS'), Description=REPLACE(Description, 'Tenants/Tenants', 'Tenants') WHERE AD_Window_ID<1000000 AND Description~'\mTenants/Tenants\M';

UPDATE AD_Window SET Updated=TO_TIMESTAMP('2022-03-10 00:00:00','YYYY-MM-DD HH24:MI:SS'), Help=REPLACE(Help, 'client', 'tenant') WHERE AD_Window_ID<1000000 AND Help~'\mclient\M' AND Help NOT LIKE '%client-%';

UPDATE AD_Window SET Updated=TO_TIMESTAMP('2022-03-10 00:00:00','YYYY-MM-DD HH24:MI:SS'), Help=REPLACE(Help, 'clients', 'tenants') WHERE AD_Window_ID<1000000 AND Help~'\mclients\M';

UPDATE AD_Window SET Updated=TO_TIMESTAMP('2022-03-10 00:00:00','YYYY-MM-DD HH24:MI:SS'), Help=REPLACE(Help, 'Client', 'Tenant') WHERE AD_Window_ID<1000000 AND Help~'\mClient\M';

UPDATE AD_Window SET Updated=TO_TIMESTAMP('2022-03-10 00:00:00','YYYY-MM-DD HH24:MI:SS'), Help=REPLACE(Help, 'Clients', 'Tenants') WHERE AD_Window_ID<1000000 AND Help~'\mClients\M';

UPDATE AD_Window SET Updated=TO_TIMESTAMP('2022-03-10 00:00:00','YYYY-MM-DD HH24:MI:SS'), Name=REPLACE(Name, 'client', 'tenant') WHERE AD_Window_ID<1000000 AND Name~'\mclient\M' AND Name NOT LIKE '%client-%';

UPDATE AD_Window SET Updated=TO_TIMESTAMP('2022-03-10 00:00:00','YYYY-MM-DD HH24:MI:SS'), Name=REPLACE(Name, 'clients', 'tenants') WHERE AD_Window_ID<1000000 AND Name~'\mclients\M';

UPDATE AD_Window SET Updated=TO_TIMESTAMP('2022-03-10 00:00:00','YYYY-MM-DD HH24:MI:SS'), Name=REPLACE(Name, 'Client', 'Tenant') WHERE AD_Window_ID<1000000 AND Name~'\mClient\M';

UPDATE AD_Window SET Updated=TO_TIMESTAMP('2022-03-10 00:00:00','YYYY-MM-DD HH24:MI:SS'), Name=REPLACE(Name, 'Clients', 'Tenants') WHERE AD_Window_ID<1000000 AND Name~'\mClients\M';

UPDATE AD_Workflow SET Updated=TO_TIMESTAMP('2022-03-10 00:00:00','YYYY-MM-DD HH24:MI:SS'), Description=REPLACE(Description, 'client', 'tenant') WHERE AD_Workflow_ID<1000000 AND Description~'\mclient\M' AND Description NOT LIKE '%client-%';

UPDATE AD_Workflow SET Updated=TO_TIMESTAMP('2022-03-10 00:00:00','YYYY-MM-DD HH24:MI:SS'), Description=REPLACE(Description, 'clients', 'tenants') WHERE AD_Workflow_ID<1000000 AND Description~'\mclients\M';

UPDATE AD_Workflow SET Updated=TO_TIMESTAMP('2022-03-10 00:00:00','YYYY-MM-DD HH24:MI:SS'), Description=REPLACE(Description, 'Client', 'Tenant') WHERE AD_Workflow_ID<1000000 AND Description~'\mClient\M';

UPDATE AD_Workflow SET Updated=TO_TIMESTAMP('2022-03-10 00:00:00','YYYY-MM-DD HH24:MI:SS'), Description=REPLACE(Description, 'Clients', 'Tenants') WHERE AD_Workflow_ID<1000000 AND Description~'\mClients\M';

UPDATE AD_Workflow SET Updated=TO_TIMESTAMP('2022-03-10 00:00:00','YYYY-MM-DD HH24:MI:SS'), Help=REPLACE(Help, 'client', 'tenant') WHERE AD_Workflow_ID<1000000 AND Help~'\mclient\M' AND Help NOT LIKE '%client-%';

UPDATE AD_Workflow SET Updated=TO_TIMESTAMP('2022-03-10 00:00:00','YYYY-MM-DD HH24:MI:SS'), Help=REPLACE(Help, 'clients', 'tenants') WHERE AD_Workflow_ID<1000000 AND Help~'\mclients\M';

UPDATE AD_Workflow SET Updated=TO_TIMESTAMP('2022-03-10 00:00:00','YYYY-MM-DD HH24:MI:SS'), Help=REPLACE(Help, 'Client', 'Tenant') WHERE AD_Workflow_ID<1000000 AND Help~'\mClient\M';

UPDATE AD_Workflow SET Updated=TO_TIMESTAMP('2022-03-10 00:00:00','YYYY-MM-DD HH24:MI:SS'), Help=REPLACE(Help, 'Clients', 'Tenants') WHERE AD_Workflow_ID<1000000 AND Help~'\mClients\M';

UPDATE AD_Workflow SET Updated=TO_TIMESTAMP('2022-03-10 00:00:00','YYYY-MM-DD HH24:MI:SS'), Name=REPLACE(Name, 'client', 'tenant') WHERE AD_Workflow_ID<1000000 AND Name~'\mclient\M' AND Name NOT LIKE '%client-%';

UPDATE AD_Workflow SET Updated=TO_TIMESTAMP('2022-03-10 00:00:00','YYYY-MM-DD HH24:MI:SS'), Name=REPLACE(Name, 'clients', 'tenants') WHERE AD_Workflow_ID<1000000 AND Name~'\mclients\M';

UPDATE AD_Workflow SET Updated=TO_TIMESTAMP('2022-03-10 00:00:00','YYYY-MM-DD HH24:MI:SS'), Name=REPLACE(Name, 'Client', 'Tenant') WHERE AD_Workflow_ID<1000000 AND Name~'\mClient\M';

UPDATE AD_Workflow SET Updated=TO_TIMESTAMP('2022-03-10 00:00:00','YYYY-MM-DD HH24:MI:SS'), Name=REPLACE(Name, 'Clients', 'Tenants') WHERE AD_Workflow_ID<1000000 AND Name~'\mClients\M';

SELECT register_migration_script('202203081457_IDEMPIERE-4586.sql') FROM dual
;

