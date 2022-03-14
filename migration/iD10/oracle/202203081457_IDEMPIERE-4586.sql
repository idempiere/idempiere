UPDATE AD_Element SET Updated=TO_TIMESTAMP('2022-03-10 00:00:00','YYYY-MM-DD HH24:MI:SS'), Description=REPLACE(Description, 'client', 'tenant') WHERE AD_Element_ID<1000000 AND REGEXP_LIKE(Description,'(^|\W)client(\W|$)') AND Description NOT LIKE '%client-%';

UPDATE AD_Element SET Updated=TO_TIMESTAMP('2022-03-10 00:00:00','YYYY-MM-DD HH24:MI:SS'), Description=REPLACE(Description, 'clients', 'tenants') WHERE AD_Element_ID<1000000 AND REGEXP_LIKE(Description,'(^|\W)clients(\W|$)');

UPDATE AD_Element SET Updated=TO_TIMESTAMP('2022-03-10 00:00:00','YYYY-MM-DD HH24:MI:SS'), Description=REPLACE(Description, 'Client', 'Tenant') WHERE AD_Element_ID<1000000 AND REGEXP_LIKE(Description,'(^|\W)Client(\W|$)');

UPDATE AD_Element SET Updated=TO_TIMESTAMP('2022-03-10 00:00:00','YYYY-MM-DD HH24:MI:SS'), Description=REPLACE(Description, 'Clients', 'Tenants') WHERE AD_Element_ID<1000000 AND REGEXP_LIKE(Description,'(^|\W)Clients(\W|$)');

UPDATE AD_Element SET Updated=TO_TIMESTAMP('2022-03-10 00:00:00','YYYY-MM-DD HH24:MI:SS'), Description=REPLACE(Description, 'Tenant/Tenant', 'Tenant') WHERE AD_Element_ID<1000000 AND REGEXP_LIKE(Description,'(^|\W)Tenant/Tenant(\W|$)');

UPDATE AD_Element SET Updated=TO_TIMESTAMP('2022-03-10 00:00:00','YYYY-MM-DD HH24:MI:SS'), Help=REPLACE(Help, 'client', 'tenant') WHERE AD_Element_ID<1000000 AND REGEXP_LIKE(Help,'(^|\W)client(\W|$)') AND Help NOT LIKE '%client-%';

UPDATE AD_Element SET Updated=TO_TIMESTAMP('2022-03-10 00:00:00','YYYY-MM-DD HH24:MI:SS'), Help=REPLACE(Help, 'clients', 'tenants') WHERE AD_Element_ID<1000000 AND REGEXP_LIKE(Help,'(^|\W)clients(\W|$)');

UPDATE AD_Element SET Updated=TO_TIMESTAMP('2022-03-10 00:00:00','YYYY-MM-DD HH24:MI:SS'), Help=REPLACE(Help, 'Client', 'Tenant') WHERE AD_Element_ID<1000000 AND REGEXP_LIKE(Help,'(^|\W)Client(\W|$)');

UPDATE AD_Element SET Updated=TO_TIMESTAMP('2022-03-10 00:00:00','YYYY-MM-DD HH24:MI:SS'), Help=REPLACE(Help, 'Clients', 'Tenants') WHERE AD_Element_ID<1000000 AND REGEXP_LIKE(Help,'(^|\W)Clients(\W|$)');

UPDATE AD_Element SET Updated=TO_TIMESTAMP('2022-03-10 00:00:00','YYYY-MM-DD HH24:MI:SS'), Help=REPLACE(Help, ' Tenant is a synonym for Tenant.', '') WHERE AD_Element_ID<1000000 AND Help LIKE '% Tenant is a synonym for Tenant.%';

UPDATE AD_Element SET Updated=TO_TIMESTAMP('2022-03-10 00:00:00','YYYY-MM-DD HH24:MI:SS'), Name=REPLACE(Name, 'client', 'tenant') WHERE AD_Element_ID<1000000 AND REGEXP_LIKE(Name,'(^|\W)client(\W|$)') AND Name NOT LIKE '%client-%';

UPDATE AD_Element SET Updated=TO_TIMESTAMP('2022-03-10 00:00:00','YYYY-MM-DD HH24:MI:SS'), Name=REPLACE(Name, 'clients', 'tenants') WHERE AD_Element_ID<1000000 AND REGEXP_LIKE(Name,'(^|\W)clients(\W|$)');

UPDATE AD_Element SET Updated=TO_TIMESTAMP('2022-03-10 00:00:00','YYYY-MM-DD HH24:MI:SS'), Name=REPLACE(Name, 'Client', 'Tenant') WHERE AD_Element_ID<1000000 AND REGEXP_LIKE(Name,'(^|\W)Client(\W|$)');

UPDATE AD_Element SET Updated=TO_TIMESTAMP('2022-03-10 00:00:00','YYYY-MM-DD HH24:MI:SS'), Name=REPLACE(Name, 'Clients', 'Tenants') WHERE AD_Element_ID<1000000 AND REGEXP_LIKE(Name,'(^|\W)Clients(\W|$)');

UPDATE AD_Element SET Updated=TO_TIMESTAMP('2022-03-10 00:00:00','YYYY-MM-DD HH24:MI:SS'), PrintName=REPLACE(PrintName, 'client', 'tenant') WHERE AD_Element_ID<1000000 AND REGEXP_LIKE(PrintName,'(^|\W)client(\W|$)') AND PrintName NOT LIKE '%client-%';

UPDATE AD_Element SET Updated=TO_TIMESTAMP('2022-03-10 00:00:00','YYYY-MM-DD HH24:MI:SS'), PrintName=REPLACE(PrintName, 'clients', 'tenants') WHERE AD_Element_ID<1000000 AND REGEXP_LIKE(PrintName,'(^|\W)clients(\W|$)');

UPDATE AD_Element SET Updated=TO_TIMESTAMP('2022-03-10 00:00:00','YYYY-MM-DD HH24:MI:SS'), PrintName=REPLACE(PrintName, 'Client', 'Tenant') WHERE AD_Element_ID<1000000 AND REGEXP_LIKE(PrintName,'(^|\W)Client(\W|$)');

UPDATE AD_Element SET Updated=TO_TIMESTAMP('2022-03-10 00:00:00','YYYY-MM-DD HH24:MI:SS'), PrintName=REPLACE(PrintName, 'Clients', 'Tenants') WHERE AD_Element_ID<1000000 AND REGEXP_LIKE(PrintName,'(^|\W)Clients(\W|$)');

UPDATE AD_Field SET Updated=TO_TIMESTAMP('2022-03-10 00:00:00','YYYY-MM-DD HH24:MI:SS'), Help=REPLACE(Help, 'client', 'tenant') WHERE AD_Field_ID<1000000 AND REGEXP_LIKE(Help,'(^|\W)client(\W|$)') AND Help NOT LIKE '%client-%' AND IsCentrallyMaintained='N';

UPDATE AD_Field SET Updated=TO_TIMESTAMP('2022-03-10 00:00:00','YYYY-MM-DD HH24:MI:SS'), Help=REPLACE(Help, 'clients', 'tenants') WHERE AD_Field_ID<1000000 AND REGEXP_LIKE(Help,'(^|\W)clients(\W|$)') AND IsCentrallyMaintained='N';

UPDATE AD_Field SET Updated=TO_TIMESTAMP('2022-03-10 00:00:00','YYYY-MM-DD HH24:MI:SS'), Help=REPLACE(Help, 'Client', 'Tenant') WHERE AD_Field_ID<1000000 AND REGEXP_LIKE(Help,'(^|\W)Client(\W|$)') AND IsCentrallyMaintained='N';

UPDATE AD_Field SET Updated=TO_TIMESTAMP('2022-03-10 00:00:00','YYYY-MM-DD HH24:MI:SS'), Help=REPLACE(Help, 'Clients', 'Tenants') WHERE AD_Field_ID<1000000 AND REGEXP_LIKE(Help,'(^|\W)Clients(\W|$)') AND IsCentrallyMaintained='N';

UPDATE AD_Field SET Updated=TO_TIMESTAMP('2022-03-10 00:00:00','YYYY-MM-DD HH24:MI:SS'), Name=REPLACE(Name, 'client', 'tenant') WHERE AD_Field_ID<1000000 AND REGEXP_LIKE(Name,'(^|\W)client(\W|$)') AND Name NOT LIKE '%client-%' AND IsCentrallyMaintained='N';

UPDATE AD_Field SET Updated=TO_TIMESTAMP('2022-03-10 00:00:00','YYYY-MM-DD HH24:MI:SS'), Name=REPLACE(Name, 'clients', 'tenants') WHERE AD_Field_ID<1000000 AND REGEXP_LIKE(Name,'(^|\W)clients(\W|$)') AND IsCentrallyMaintained='N';

UPDATE AD_Field SET Updated=TO_TIMESTAMP('2022-03-10 00:00:00','YYYY-MM-DD HH24:MI:SS'), Name=REPLACE(Name, 'Client', 'Tenant') WHERE AD_Field_ID<1000000 AND REGEXP_LIKE(Name,'(^|\W)Client(\W|$)') AND IsCentrallyMaintained='N';

UPDATE AD_Field SET Updated=TO_TIMESTAMP('2022-03-10 00:00:00','YYYY-MM-DD HH24:MI:SS'), Name=REPLACE(Name, 'Clients', 'Tenants') WHERE AD_Field_ID<1000000 AND REGEXP_LIKE(Name,'(^|\W)Clients(\W|$)') AND IsCentrallyMaintained='N';

UPDATE AD_Form SET Updated=TO_TIMESTAMP('2022-03-10 00:00:00','YYYY-MM-DD HH24:MI:SS'), Description=REPLACE(Description, 'client', 'tenant') WHERE AD_Form_ID<1000000 AND REGEXP_LIKE(Description,'(^|\W)client(\W|$)') AND Description NOT LIKE '%client-%';

UPDATE AD_Form SET Updated=TO_TIMESTAMP('2022-03-10 00:00:00','YYYY-MM-DD HH24:MI:SS'), Description=REPLACE(Description, 'clients', 'tenants') WHERE AD_Form_ID<1000000 AND REGEXP_LIKE(Description,'(^|\W)clients(\W|$)');

UPDATE AD_Form SET Updated=TO_TIMESTAMP('2022-03-10 00:00:00','YYYY-MM-DD HH24:MI:SS'), Description=REPLACE(Description, 'Client', 'Tenant') WHERE AD_Form_ID<1000000 AND REGEXP_LIKE(Description,'(^|\W)Client(\W|$)');

UPDATE AD_Form SET Updated=TO_TIMESTAMP('2022-03-10 00:00:00','YYYY-MM-DD HH24:MI:SS'), Description=REPLACE(Description, 'Clients', 'Tenants') WHERE AD_Form_ID<1000000 AND REGEXP_LIKE(Description,'(^|\W)Clients(\W|$)');

UPDATE AD_Form SET Updated=TO_TIMESTAMP('2022-03-10 00:00:00','YYYY-MM-DD HH24:MI:SS'), Description=REPLACE(Description, 'Tenant/Tenant', 'Tenant') WHERE AD_Form_ID<1000000 AND REGEXP_LIKE(Description,'(^|\W)Tenant/Tenant(\W|$)');

UPDATE AD_Form SET Updated=TO_TIMESTAMP('2022-03-10 00:00:00','YYYY-MM-DD HH24:MI:SS'), Help=REPLACE(Help, 'client', 'tenant') WHERE AD_Form_ID<1000000 AND REGEXP_LIKE(Help,'(^|\W)client(\W|$)') AND Help NOT LIKE '%client-%';

UPDATE AD_Form SET Updated=TO_TIMESTAMP('2022-03-10 00:00:00','YYYY-MM-DD HH24:MI:SS'), Help=REPLACE(Help, 'clients', 'tenants') WHERE AD_Form_ID<1000000 AND REGEXP_LIKE(Help,'(^|\W)clients(\W|$)');

UPDATE AD_Form SET Updated=TO_TIMESTAMP('2022-03-10 00:00:00','YYYY-MM-DD HH24:MI:SS'), Help=REPLACE(Help, 'Client', 'Tenant') WHERE AD_Form_ID<1000000 AND REGEXP_LIKE(Help,'(^|\W)Client(\W|$)');

UPDATE AD_Form SET Updated=TO_TIMESTAMP('2022-03-10 00:00:00','YYYY-MM-DD HH24:MI:SS'), Help=REPLACE(Help, 'Clients', 'Tenants') WHERE AD_Form_ID<1000000 AND REGEXP_LIKE(Help,'(^|\W)Clients(\W|$)');

UPDATE AD_Form SET Updated=TO_TIMESTAMP('2022-03-10 00:00:00','YYYY-MM-DD HH24:MI:SS'), Help=REPLACE(Help, 'Tenant/Tenant', 'Tenant') WHERE AD_Form_ID<1000000 AND REGEXP_LIKE(Help,'(^|\W)Tenant/Tenant(\W|$)');

UPDATE AD_Form SET Updated=TO_TIMESTAMP('2022-03-10 00:00:00','YYYY-MM-DD HH24:MI:SS'), Name=REPLACE(Name, 'client', 'tenant') WHERE AD_Form_ID<1000000 AND REGEXP_LIKE(Name,'(^|\W)client(\W|$)') AND Name NOT LIKE '%client-%';

UPDATE AD_Form SET Updated=TO_TIMESTAMP('2022-03-10 00:00:00','YYYY-MM-DD HH24:MI:SS'), Name=REPLACE(Name, 'clients', 'tenants') WHERE AD_Form_ID<1000000 AND REGEXP_LIKE(Name,'(^|\W)clients(\W|$)');

UPDATE AD_Form SET Updated=TO_TIMESTAMP('2022-03-10 00:00:00','YYYY-MM-DD HH24:MI:SS'), Name=REPLACE(Name, 'Client', 'Tenant') WHERE AD_Form_ID<1000000 AND REGEXP_LIKE(Name,'(^|\W)Client(\W|$)');

UPDATE AD_Form SET Updated=TO_TIMESTAMP('2022-03-10 00:00:00','YYYY-MM-DD HH24:MI:SS'), Name=REPLACE(Name, 'Clients', 'Tenants') WHERE AD_Form_ID<1000000 AND REGEXP_LIKE(Name,'(^|\W)Clients(\W|$)');

UPDATE AD_Menu SET Updated=TO_TIMESTAMP('2022-03-10 00:00:00','YYYY-MM-DD HH24:MI:SS'), Description=REPLACE(Description, 'client', 'tenant') WHERE AD_Menu_ID<1000000 AND REGEXP_LIKE(Description,'(^|\W)client(\W|$)') AND Description NOT LIKE '%client-%' AND IsCentrallyMaintained='N';

UPDATE AD_Menu SET Updated=TO_TIMESTAMP('2022-03-10 00:00:00','YYYY-MM-DD HH24:MI:SS'), Description=REPLACE(Description, 'clients', 'tenants') WHERE AD_Menu_ID<1000000 AND REGEXP_LIKE(Description,'(^|\W)clients(\W|$)') AND IsCentrallyMaintained='N';

UPDATE AD_Menu SET Updated=TO_TIMESTAMP('2022-03-10 00:00:00','YYYY-MM-DD HH24:MI:SS'), Description=REPLACE(Description, 'Client', 'Tenant') WHERE AD_Menu_ID<1000000 AND REGEXP_LIKE(Description,'(^|\W)Client(\W|$)') AND IsCentrallyMaintained='N';

UPDATE AD_Menu SET Updated=TO_TIMESTAMP('2022-03-10 00:00:00','YYYY-MM-DD HH24:MI:SS'), Description=REPLACE(Description, 'Clients', 'Tenants') WHERE AD_Menu_ID<1000000 AND REGEXP_LIKE(Description,'(^|\W)Clients(\W|$)') AND IsCentrallyMaintained='N';

UPDATE AD_Menu SET Updated=TO_TIMESTAMP('2022-03-10 00:00:00','YYYY-MM-DD HH24:MI:SS'), Name=REPLACE(Name, 'client', 'tenant') WHERE AD_Menu_ID<1000000 AND REGEXP_LIKE(Name,'(^|\W)client(\W|$)') AND Name NOT LIKE '%client-%' AND IsCentrallyMaintained='N';

UPDATE AD_Menu SET Updated=TO_TIMESTAMP('2022-03-10 00:00:00','YYYY-MM-DD HH24:MI:SS'), Name=REPLACE(Name, 'clients', 'tenants') WHERE AD_Menu_ID<1000000 AND REGEXP_LIKE(Name,'(^|\W)clients(\W|$)') AND IsCentrallyMaintained='N';

UPDATE AD_Menu SET Updated=TO_TIMESTAMP('2022-03-10 00:00:00','YYYY-MM-DD HH24:MI:SS'), Name=REPLACE(Name, 'Client', 'Tenant') WHERE AD_Menu_ID<1000000 AND REGEXP_LIKE(Name,'(^|\W)Client(\W|$)') AND IsCentrallyMaintained='N';

UPDATE AD_Menu SET Updated=TO_TIMESTAMP('2022-03-10 00:00:00','YYYY-MM-DD HH24:MI:SS'), Name=REPLACE(Name, 'Clients', 'Tenants') WHERE AD_Menu_ID<1000000 AND REGEXP_LIKE(Name,'(^|\W)Clients(\W|$)') AND IsCentrallyMaintained='N';

UPDATE AD_Message SET Updated=TO_TIMESTAMP('2022-03-10 00:00:00','YYYY-MM-DD HH24:MI:SS'), MsgText=REPLACE(MsgText, 'client', 'tenant') WHERE AD_Message_ID<1000000 AND REGEXP_LIKE(MsgText,'(^|\W)client(\W|$)') AND MsgText NOT LIKE '%client-%';

UPDATE AD_Message SET Updated=TO_TIMESTAMP('2022-03-10 00:00:00','YYYY-MM-DD HH24:MI:SS'), MsgText=REPLACE(MsgText, 'clients', 'tenants') WHERE AD_Message_ID<1000000 AND REGEXP_LIKE(MsgText,'(^|\W)clients(\W|$)');

UPDATE AD_Message SET Updated=TO_TIMESTAMP('2022-03-10 00:00:00','YYYY-MM-DD HH24:MI:SS'), MsgText=REPLACE(MsgText, 'Client', 'Tenant') WHERE AD_Message_ID<1000000 AND REGEXP_LIKE(MsgText,'(^|\W)Client(\W|$)');

UPDATE AD_Message SET Updated=TO_TIMESTAMP('2022-03-10 00:00:00','YYYY-MM-DD HH24:MI:SS'), MsgText=REPLACE(MsgText, 'Clients', 'Tenants') WHERE AD_Message_ID<1000000 AND REGEXP_LIKE(MsgText,'(^|\W)Clients(\W|$)');

UPDATE AD_Message SET Updated=TO_TIMESTAMP('2022-03-10 00:00:00','YYYY-MM-DD HH24:MI:SS'), MsgTip=REPLACE(MsgTip, 'client', 'tenant') WHERE AD_Message_ID<1000000 AND REGEXP_LIKE(MsgTip,'(^|\W)client(\W|$)') AND MsgTip NOT LIKE '%client-%';

UPDATE AD_Message SET Updated=TO_TIMESTAMP('2022-03-10 00:00:00','YYYY-MM-DD HH24:MI:SS'), MsgTip=REPLACE(MsgTip, 'clients', 'tenants') WHERE AD_Message_ID<1000000 AND REGEXP_LIKE(MsgTip,'(^|\W)clients(\W|$)');

UPDATE AD_Message SET Updated=TO_TIMESTAMP('2022-03-10 00:00:00','YYYY-MM-DD HH24:MI:SS'), MsgTip=REPLACE(MsgTip, 'Client', 'Tenant') WHERE AD_Message_ID<1000000 AND REGEXP_LIKE(MsgTip,'(^|\W)Client(\W|$)');

UPDATE AD_Message SET Updated=TO_TIMESTAMP('2022-03-10 00:00:00','YYYY-MM-DD HH24:MI:SS'), MsgTip=REPLACE(MsgTip, 'Clients', 'Tenants') WHERE AD_Message_ID<1000000 AND REGEXP_LIKE(MsgTip,'(^|\W)Clients(\W|$)');

UPDATE AD_Process SET Updated=TO_TIMESTAMP('2022-03-10 00:00:00','YYYY-MM-DD HH24:MI:SS'), Description=REPLACE(Description, 'client', 'tenant') WHERE AD_Process_ID<1000000 AND REGEXP_LIKE(Description,'(^|\W)client(\W|$)') AND Description NOT LIKE '%client-%';

UPDATE AD_Process SET Updated=TO_TIMESTAMP('2022-03-10 00:00:00','YYYY-MM-DD HH24:MI:SS'), Description=REPLACE(Description, 'clients', 'tenants') WHERE AD_Process_ID<1000000 AND REGEXP_LIKE(Description,'(^|\W)clients(\W|$)');

UPDATE AD_Process SET Updated=TO_TIMESTAMP('2022-03-10 00:00:00','YYYY-MM-DD HH24:MI:SS'), Description=REPLACE(Description, 'Client', 'Tenant') WHERE AD_Process_ID<1000000 AND REGEXP_LIKE(Description,'(^|\W)Client(\W|$)');

UPDATE AD_Process SET Updated=TO_TIMESTAMP('2022-03-10 00:00:00','YYYY-MM-DD HH24:MI:SS'), Description=REPLACE(Description, 'Clients', 'Tenants') WHERE AD_Process_ID<1000000 AND REGEXP_LIKE(Description,'(^|\W)Clients(\W|$)');

UPDATE AD_Process SET Updated=TO_TIMESTAMP('2022-03-10 00:00:00','YYYY-MM-DD HH24:MI:SS'), Help=REPLACE(Help, 'client', 'tenant') WHERE AD_Process_ID<1000000 AND REGEXP_LIKE(Help,'(^|\W)client(\W|$)') AND Help NOT LIKE '%client-%';

UPDATE AD_Process SET Updated=TO_TIMESTAMP('2022-03-10 00:00:00','YYYY-MM-DD HH24:MI:SS'), Help=REPLACE(Help, 'clients', 'tenants') WHERE AD_Process_ID<1000000 AND REGEXP_LIKE(Help,'(^|\W)clients(\W|$)');

UPDATE AD_Process SET Updated=TO_TIMESTAMP('2022-03-10 00:00:00','YYYY-MM-DD HH24:MI:SS'), Help=REPLACE(Help, 'Client', 'Tenant') WHERE AD_Process_ID<1000000 AND REGEXP_LIKE(Help,'(^|\W)Client(\W|$)');

UPDATE AD_Process SET Updated=TO_TIMESTAMP('2022-03-10 00:00:00','YYYY-MM-DD HH24:MI:SS'), Help=REPLACE(Help, 'Clients', 'Tenants') WHERE AD_Process_ID<1000000 AND REGEXP_LIKE(Help,'(^|\W)Clients(\W|$)');

UPDATE AD_Process SET Updated=TO_TIMESTAMP('2022-03-10 00:00:00','YYYY-MM-DD HH24:MI:SS'), Name=REPLACE(Name, 'client', 'tenant') WHERE AD_Process_ID<1000000 AND REGEXP_LIKE(Name,'(^|\W)client(\W|$)') AND Name NOT LIKE '%client-%';

UPDATE AD_Process SET Updated=TO_TIMESTAMP('2022-03-10 00:00:00','YYYY-MM-DD HH24:MI:SS'), Name=REPLACE(Name, 'clients', 'tenants') WHERE AD_Process_ID<1000000 AND REGEXP_LIKE(Name,'(^|\W)clients(\W|$)');

UPDATE AD_Process SET Updated=TO_TIMESTAMP('2022-03-10 00:00:00','YYYY-MM-DD HH24:MI:SS'), Name=REPLACE(Name, 'Client', 'Tenant') WHERE AD_Process_ID<1000000 AND REGEXP_LIKE(Name,'(^|\W)Client(\W|$)');

UPDATE AD_Process SET Updated=TO_TIMESTAMP('2022-03-10 00:00:00','YYYY-MM-DD HH24:MI:SS'), Name=REPLACE(Name, 'Clients', 'Tenants') WHERE AD_Process_ID<1000000 AND REGEXP_LIKE(Name,'(^|\W)Clients(\W|$)');

UPDATE AD_Process_Para SET Updated=TO_TIMESTAMP('2022-03-10 00:00:00','YYYY-MM-DD HH24:MI:SS'), Description=REPLACE(Description, 'client', 'tenant') WHERE AD_Process_Para_ID<1000000 AND REGEXP_LIKE(Description,'(^|\W)client(\W|$)') AND Description NOT LIKE '%client-%' AND IsCentrallyMaintained='N';

UPDATE AD_Process_Para SET Updated=TO_TIMESTAMP('2022-03-10 00:00:00','YYYY-MM-DD HH24:MI:SS'), Description=REPLACE(Description, 'clients', 'tenants') WHERE AD_Process_Para_ID<1000000 AND REGEXP_LIKE(Description,'(^|\W)clients(\W|$)') AND IsCentrallyMaintained='N';

UPDATE AD_Process_Para SET Updated=TO_TIMESTAMP('2022-03-10 00:00:00','YYYY-MM-DD HH24:MI:SS'), Description=REPLACE(Description, 'Client', 'Tenant') WHERE AD_Process_Para_ID<1000000 AND REGEXP_LIKE(Description,'(^|\W)Client(\W|$)') AND IsCentrallyMaintained='N';

UPDATE AD_Process_Para SET Updated=TO_TIMESTAMP('2022-03-10 00:00:00','YYYY-MM-DD HH24:MI:SS'), Description=REPLACE(Description, 'Clients', 'Tenants') WHERE AD_Process_Para_ID<1000000 AND REGEXP_LIKE(Description,'(^|\W)Clients(\W|$)') AND IsCentrallyMaintained='N';

UPDATE AD_Process_Para SET Updated=TO_TIMESTAMP('2022-03-10 00:00:00','YYYY-MM-DD HH24:MI:SS'), Description=REPLACE(Description, 'Tenant/Tenant', 'Tenant') WHERE AD_Process_Para_ID<1000000 AND REGEXP_LIKE(Description,'(^|\W)Tenant/Tenant(\W|$)');

UPDATE AD_Process_Para SET Updated=TO_TIMESTAMP('2022-03-10 00:00:00','YYYY-MM-DD HH24:MI:SS'), Help=REPLACE(Help, 'client', 'tenant') WHERE AD_Process_Para_ID<1000000 AND REGEXP_LIKE(Help,'(^|\W)client(\W|$)') AND Help NOT LIKE '%client-%' AND IsCentrallyMaintained='N';

UPDATE AD_Process_Para SET Updated=TO_TIMESTAMP('2022-03-10 00:00:00','YYYY-MM-DD HH24:MI:SS'), Help=REPLACE(Help, 'clients', 'tenants') WHERE AD_Process_Para_ID<1000000 AND REGEXP_LIKE(Help,'(^|\W)clients(\W|$)') AND IsCentrallyMaintained='N';

UPDATE AD_Process_Para SET Updated=TO_TIMESTAMP('2022-03-10 00:00:00','YYYY-MM-DD HH24:MI:SS'), Help=REPLACE(Help, 'Client', 'Tenant') WHERE AD_Process_Para_ID<1000000 AND REGEXP_LIKE(Help,'(^|\W)Client(\W|$)') AND IsCentrallyMaintained='N';

UPDATE AD_Process_Para SET Updated=TO_TIMESTAMP('2022-03-10 00:00:00','YYYY-MM-DD HH24:MI:SS'), Help=REPLACE(Help, 'Clients', 'Tenants') WHERE AD_Process_Para_ID<1000000 AND REGEXP_LIKE(Help,'(^|\W)Clients(\W|$)') AND IsCentrallyMaintained='N';

UPDATE AD_Process_Para SET Updated=TO_TIMESTAMP('2022-03-10 00:00:00','YYYY-MM-DD HH24:MI:SS'), Help=REPLACE(Help, ' Tenant is a synonym for Tenant.', '') WHERE AD_Process_Para_ID<1000000 AND Help LIKE '% Tenant is a synonym for Tenant.%';

UPDATE AD_Process_Para SET Updated=TO_TIMESTAMP('2022-03-10 00:00:00','YYYY-MM-DD HH24:MI:SS'), Name=REPLACE(Name, 'client', 'tenant') WHERE AD_Process_Para_ID<1000000 AND REGEXP_LIKE(Name,'(^|\W)client(\W|$)') AND Name NOT LIKE '%client-%' AND IsCentrallyMaintained='N';

UPDATE AD_Process_Para SET Updated=TO_TIMESTAMP('2022-03-10 00:00:00','YYYY-MM-DD HH24:MI:SS'), Name=REPLACE(Name, 'clients', 'tenants') WHERE AD_Process_Para_ID<1000000 AND REGEXP_LIKE(Name,'(^|\W)clients(\W|$)') AND IsCentrallyMaintained='N';

UPDATE AD_Process_Para SET Updated=TO_TIMESTAMP('2022-03-10 00:00:00','YYYY-MM-DD HH24:MI:SS'), Name=REPLACE(Name, 'Client', 'Tenant') WHERE AD_Process_Para_ID<1000000 AND REGEXP_LIKE(Name,'(^|\W)Client(\W|$)') AND IsCentrallyMaintained='N';

UPDATE AD_Process_Para SET Updated=TO_TIMESTAMP('2022-03-10 00:00:00','YYYY-MM-DD HH24:MI:SS'), Name=REPLACE(Name, 'Clients', 'Tenants') WHERE AD_Process_Para_ID<1000000 AND REGEXP_LIKE(Name,'(^|\W)Clients(\W|$)') AND IsCentrallyMaintained='N';

UPDATE AD_Reference SET Updated=TO_TIMESTAMP('2022-03-10 00:00:00','YYYY-MM-DD HH24:MI:SS'), Description=REPLACE(Description, 'client', 'tenant') WHERE AD_Reference_ID<1000000 AND REGEXP_LIKE(Description,'(^|\W)client(\W|$)') AND Description NOT LIKE '%client-%';

UPDATE AD_Reference SET Updated=TO_TIMESTAMP('2022-03-10 00:00:00','YYYY-MM-DD HH24:MI:SS'), Description=REPLACE(Description, 'clients', 'tenants') WHERE AD_Reference_ID<1000000 AND REGEXP_LIKE(Description,'(^|\W)clients(\W|$)');

UPDATE AD_Reference SET Updated=TO_TIMESTAMP('2022-03-10 00:00:00','YYYY-MM-DD HH24:MI:SS'), Description=REPLACE(Description, 'Client', 'Tenant') WHERE AD_Reference_ID<1000000 AND REGEXP_LIKE(Description,'(^|\W)Client(\W|$)');

UPDATE AD_Reference SET Updated=TO_TIMESTAMP('2022-03-10 00:00:00','YYYY-MM-DD HH24:MI:SS'), Description=REPLACE(Description, 'Clients', 'Tenants') WHERE AD_Reference_ID<1000000 AND REGEXP_LIKE(Description,'(^|\W)Clients(\W|$)');

UPDATE AD_Reference SET Updated=TO_TIMESTAMP('2022-03-10 00:00:00','YYYY-MM-DD HH24:MI:SS'), Name=REPLACE(Name, 'client', 'tenant') WHERE AD_Reference_ID<1000000 AND REGEXP_LIKE(Name,'(^|\W)client(\W|$)') AND Name NOT LIKE '%client-%';

UPDATE AD_Reference SET Updated=TO_TIMESTAMP('2022-03-10 00:00:00','YYYY-MM-DD HH24:MI:SS'), Name=REPLACE(Name, 'clients', 'tenants') WHERE AD_Reference_ID<1000000 AND REGEXP_LIKE(Name,'(^|\W)clients(\W|$)');

UPDATE AD_Reference SET Updated=TO_TIMESTAMP('2022-03-10 00:00:00','YYYY-MM-DD HH24:MI:SS'), Name=REPLACE(Name, 'Client', 'Tenant') WHERE AD_Reference_ID<1000000 AND REGEXP_LIKE(Name,'(^|\W)Client(\W|$)');

UPDATE AD_Reference SET Updated=TO_TIMESTAMP('2022-03-10 00:00:00','YYYY-MM-DD HH24:MI:SS'), Name=REPLACE(Name, 'Clients', 'Tenants') WHERE AD_Reference_ID<1000000 AND REGEXP_LIKE(Name,'(^|\W)Clients(\W|$)');

UPDATE AD_Ref_List SET Updated=TO_TIMESTAMP('2022-03-10 00:00:00','YYYY-MM-DD HH24:MI:SS'), Description=REPLACE(Description, 'client', 'tenant') WHERE AD_Ref_List_ID<1000000 AND REGEXP_LIKE(Description,'(^|\W)client(\W|$)') AND Description NOT LIKE '%client-%';

UPDATE AD_Ref_List SET Updated=TO_TIMESTAMP('2022-03-10 00:00:00','YYYY-MM-DD HH24:MI:SS'), Description=REPLACE(Description, 'clients', 'tenants') WHERE AD_Ref_List_ID<1000000 AND REGEXP_LIKE(Description,'(^|\W)clients(\W|$)');

UPDATE AD_Ref_List SET Updated=TO_TIMESTAMP('2022-03-10 00:00:00','YYYY-MM-DD HH24:MI:SS'), Description=REPLACE(Description, 'Client', 'Tenant') WHERE AD_Ref_List_ID<1000000 AND REGEXP_LIKE(Description,'(^|\W)Client(\W|$)');

UPDATE AD_Ref_List SET Updated=TO_TIMESTAMP('2022-03-10 00:00:00','YYYY-MM-DD HH24:MI:SS'), Description=REPLACE(Description, 'Clients', 'Tenants') WHERE AD_Ref_List_ID<1000000 AND REGEXP_LIKE(Description,'(^|\W)Clients(\W|$)');

UPDATE AD_Tab SET Updated=TO_TIMESTAMP('2022-03-10 00:00:00','YYYY-MM-DD HH24:MI:SS'), Description=REPLACE(Description, 'client', 'tenant') WHERE AD_Tab_ID<1000000 AND REGEXP_LIKE(Description,'(^|\W)client(\W|$)') AND Description NOT LIKE '%client-%';

UPDATE AD_Tab SET Updated=TO_TIMESTAMP('2022-03-10 00:00:00','YYYY-MM-DD HH24:MI:SS'), Description=REPLACE(Description, 'clients', 'tenants') WHERE AD_Tab_ID<1000000 AND REGEXP_LIKE(Description,'(^|\W)clients(\W|$)');

UPDATE AD_Tab SET Updated=TO_TIMESTAMP('2022-03-10 00:00:00','YYYY-MM-DD HH24:MI:SS'), Description=REPLACE(Description, 'Client', 'Tenant') WHERE AD_Tab_ID<1000000 AND REGEXP_LIKE(Description,'(^|\W)Client(\W|$)');

UPDATE AD_Tab SET Updated=TO_TIMESTAMP('2022-03-10 00:00:00','YYYY-MM-DD HH24:MI:SS'), Description=REPLACE(Description, 'Clients', 'Tenants') WHERE AD_Tab_ID<1000000 AND REGEXP_LIKE(Description,'(^|\W)Clients(\W|$)');

UPDATE AD_Tab SET Updated=TO_TIMESTAMP('2022-03-10 00:00:00','YYYY-MM-DD HH24:MI:SS'), Description=REPLACE(Description, 'Tenant/Tenant', 'Tenant') WHERE AD_Tab_ID<1000000 AND REGEXP_LIKE(Description,'(^|\W)Tenant/Tenant(\W|$)');

UPDATE AD_Tab SET Updated=TO_TIMESTAMP('2022-03-10 00:00:00','YYYY-MM-DD HH24:MI:SS'), Help=REPLACE(Help, 'client', 'tenant') WHERE AD_Tab_ID<1000000 AND REGEXP_LIKE(Help,'(^|\W)client(\W|$)') AND Help NOT LIKE '%client-%';

UPDATE AD_Tab SET Updated=TO_TIMESTAMP('2022-03-10 00:00:00','YYYY-MM-DD HH24:MI:SS'), Help=REPLACE(Help, 'clients', 'tenants') WHERE AD_Tab_ID<1000000 AND REGEXP_LIKE(Help,'(^|\W)clients(\W|$)');

UPDATE AD_Tab SET Updated=TO_TIMESTAMP('2022-03-10 00:00:00','YYYY-MM-DD HH24:MI:SS'), Help=REPLACE(Help, 'Client', 'Tenant') WHERE AD_Tab_ID<1000000 AND REGEXP_LIKE(Help,'(^|\W)Client(\W|$)');

UPDATE AD_Tab SET Updated=TO_TIMESTAMP('2022-03-10 00:00:00','YYYY-MM-DD HH24:MI:SS'), Help=REPLACE(Help, 'Clients', 'Tenants') WHERE AD_Tab_ID<1000000 AND REGEXP_LIKE(Help,'(^|\W)Clients(\W|$)');

UPDATE AD_Tab SET Updated=TO_TIMESTAMP('2022-03-10 00:00:00','YYYY-MM-DD HH24:MI:SS'), Name=REPLACE(Name, 'client', 'tenant') WHERE AD_Tab_ID<1000000 AND REGEXP_LIKE(Name,'(^|\W)client(\W|$)') AND Name NOT LIKE '%client-%';

UPDATE AD_Tab SET Updated=TO_TIMESTAMP('2022-03-10 00:00:00','YYYY-MM-DD HH24:MI:SS'), Name=REPLACE(Name, 'clients', 'tenants') WHERE AD_Tab_ID<1000000 AND REGEXP_LIKE(Name,'(^|\W)clients(\W|$)');

UPDATE AD_Tab SET Updated=TO_TIMESTAMP('2022-03-10 00:00:00','YYYY-MM-DD HH24:MI:SS'), Name=REPLACE(Name, 'Client', 'Tenant') WHERE AD_Tab_ID<1000000 AND REGEXP_LIKE(Name,'(^|\W)Client(\W|$)');

UPDATE AD_Tab SET Updated=TO_TIMESTAMP('2022-03-10 00:00:00','YYYY-MM-DD HH24:MI:SS'), Name=REPLACE(Name, 'Clients', 'Tenants') WHERE AD_Tab_ID<1000000 AND REGEXP_LIKE(Name,'(^|\W)Clients(\W|$)');

UPDATE AD_Tab SET Updated=TO_TIMESTAMP('2022-03-10 00:00:00','YYYY-MM-DD HH24:MI:SS'), CommitWarning=REPLACE(CommitWarning, 'client', 'tenant') WHERE AD_Tab_ID<1000000 AND REGEXP_LIKE(CommitWarning,'(^|\W)client(\W|$)') AND CommitWarning NOT LIKE '%client-%';

UPDATE AD_Tab SET Updated=TO_TIMESTAMP('2022-03-10 00:00:00','YYYY-MM-DD HH24:MI:SS'), CommitWarning=REPLACE(CommitWarning, 'clients', 'tenants') WHERE AD_Tab_ID<1000000 AND REGEXP_LIKE(CommitWarning,'(^|\W)clients(\W|$)');

UPDATE AD_Tab SET Updated=TO_TIMESTAMP('2022-03-10 00:00:00','YYYY-MM-DD HH24:MI:SS'), CommitWarning=REPLACE(CommitWarning, 'Client', 'Tenant') WHERE AD_Tab_ID<1000000 AND REGEXP_LIKE(CommitWarning,'(^|\W)Client(\W|$)');

UPDATE AD_Tab SET Updated=TO_TIMESTAMP('2022-03-10 00:00:00','YYYY-MM-DD HH24:MI:SS'), CommitWarning=REPLACE(CommitWarning, 'Clients', 'Tenants') WHERE AD_Tab_ID<1000000 AND REGEXP_LIKE(CommitWarning,'(^|\W)Clients(\W|$)');

UPDATE AD_WF_Node SET Updated=TO_TIMESTAMP('2022-03-10 00:00:00','YYYY-MM-DD HH24:MI:SS'), Description=REPLACE(Description, 'client', 'tenant') WHERE AD_WF_Node_ID<1000000 AND REGEXP_LIKE(Description,'(^|\W)client(\W|$)') AND Description NOT LIKE '%client-%';

UPDATE AD_WF_Node SET Updated=TO_TIMESTAMP('2022-03-10 00:00:00','YYYY-MM-DD HH24:MI:SS'), Description=REPLACE(Description, 'clients', 'tenants') WHERE AD_WF_Node_ID<1000000 AND REGEXP_LIKE(Description,'(^|\W)clients(\W|$)');

UPDATE AD_WF_Node SET Updated=TO_TIMESTAMP('2022-03-10 00:00:00','YYYY-MM-DD HH24:MI:SS'), Description=REPLACE(Description, 'Client', 'Tenant') WHERE AD_WF_Node_ID<1000000 AND REGEXP_LIKE(Description,'(^|\W)Client(\W|$)');

UPDATE AD_WF_Node SET Updated=TO_TIMESTAMP('2022-03-10 00:00:00','YYYY-MM-DD HH24:MI:SS'), Description=REPLACE(Description, 'Clients', 'Tenants') WHERE AD_WF_Node_ID<1000000 AND REGEXP_LIKE(Description,'(^|\W)Clients(\W|$)');

UPDATE AD_WF_Node SET Updated=TO_TIMESTAMP('2022-03-10 00:00:00','YYYY-MM-DD HH24:MI:SS'), Description=REPLACE(Description, 'Tenants/Tenants', 'Tenants') WHERE AD_WF_Node_ID<1000000 AND REGEXP_LIKE(Description,'(^|\W)Tenants/Tenants(\W|$)');

UPDATE AD_WF_Node SET Updated=TO_TIMESTAMP('2022-03-10 00:00:00','YYYY-MM-DD HH24:MI:SS'), Help=REPLACE(Help, 'client', 'tenant') WHERE AD_WF_Node_ID<1000000 AND REGEXP_LIKE(Help,'(^|\W)client(\W|$)') AND Help NOT LIKE '%client-%';

UPDATE AD_WF_Node SET Updated=TO_TIMESTAMP('2022-03-10 00:00:00','YYYY-MM-DD HH24:MI:SS'), Help=REPLACE(Help, 'clients', 'tenants') WHERE AD_WF_Node_ID<1000000 AND REGEXP_LIKE(Help,'(^|\W)clients(\W|$)');

UPDATE AD_WF_Node SET Updated=TO_TIMESTAMP('2022-03-10 00:00:00','YYYY-MM-DD HH24:MI:SS'), Help=REPLACE(Help, 'Client', 'Tenant') WHERE AD_WF_Node_ID<1000000 AND REGEXP_LIKE(Help,'(^|\W)Client(\W|$)');

UPDATE AD_WF_Node SET Updated=TO_TIMESTAMP('2022-03-10 00:00:00','YYYY-MM-DD HH24:MI:SS'), Help=REPLACE(Help, 'Clients', 'Tenants') WHERE AD_WF_Node_ID<1000000 AND REGEXP_LIKE(Help,'(^|\W)Clients(\W|$)');

UPDATE AD_WF_Node SET Updated=TO_TIMESTAMP('2022-03-10 00:00:00','YYYY-MM-DD HH24:MI:SS'), Name=REPLACE(Name, 'client', 'tenant') WHERE AD_WF_Node_ID<1000000 AND REGEXP_LIKE(Name,'(^|\W)client(\W|$)') AND Name NOT LIKE '%client-%';

UPDATE AD_WF_Node SET Updated=TO_TIMESTAMP('2022-03-10 00:00:00','YYYY-MM-DD HH24:MI:SS'), Name=REPLACE(Name, 'clients', 'tenants') WHERE AD_WF_Node_ID<1000000 AND REGEXP_LIKE(Name,'(^|\W)clients(\W|$)');

UPDATE AD_WF_Node SET Updated=TO_TIMESTAMP('2022-03-10 00:00:00','YYYY-MM-DD HH24:MI:SS'), Name=REPLACE(Name, 'Client', 'Tenant') WHERE AD_WF_Node_ID<1000000 AND REGEXP_LIKE(Name,'(^|\W)Client(\W|$)');

UPDATE AD_WF_Node SET Updated=TO_TIMESTAMP('2022-03-10 00:00:00','YYYY-MM-DD HH24:MI:SS'), Name=REPLACE(Name, 'Clients', 'Tenants') WHERE AD_WF_Node_ID<1000000 AND REGEXP_LIKE(Name,'(^|\W)Clients(\W|$)');

UPDATE AD_Window SET Updated=TO_TIMESTAMP('2022-03-10 00:00:00','YYYY-MM-DD HH24:MI:SS'), Description=REPLACE(Description, 'client', 'tenant') WHERE AD_Window_ID<1000000 AND REGEXP_LIKE(Description,'(^|\W)client(\W|$)') AND Description NOT LIKE '%client-%';

UPDATE AD_Window SET Updated=TO_TIMESTAMP('2022-03-10 00:00:00','YYYY-MM-DD HH24:MI:SS'), Description=REPLACE(Description, 'clients', 'tenants') WHERE AD_Window_ID<1000000 AND REGEXP_LIKE(Description,'(^|\W)clients(\W|$)');

UPDATE AD_Window SET Updated=TO_TIMESTAMP('2022-03-10 00:00:00','YYYY-MM-DD HH24:MI:SS'), Description=REPLACE(Description, 'Client', 'Tenant') WHERE AD_Window_ID<1000000 AND REGEXP_LIKE(Description,'(^|\W)Client(\W|$)');

UPDATE AD_Window SET Updated=TO_TIMESTAMP('2022-03-10 00:00:00','YYYY-MM-DD HH24:MI:SS'), Description=REPLACE(Description, 'Clients', 'Tenants') WHERE AD_Window_ID<1000000 AND REGEXP_LIKE(Description,'(^|\W)Clients(\W|$)');

UPDATE AD_Window SET Updated=TO_TIMESTAMP('2022-03-10 00:00:00','YYYY-MM-DD HH24:MI:SS'), Description=REPLACE(Description, 'Tenants/Tenants', 'Tenants') WHERE AD_Window_ID<1000000 AND REGEXP_LIKE(Description,'(^|\W)Tenants/Tenants(\W|$)');

UPDATE AD_Window SET Updated=TO_TIMESTAMP('2022-03-10 00:00:00','YYYY-MM-DD HH24:MI:SS'), Help=REPLACE(Help, 'client', 'tenant') WHERE AD_Window_ID<1000000 AND REGEXP_LIKE(Help,'(^|\W)client(\W|$)') AND Help NOT LIKE '%client-%';

UPDATE AD_Window SET Updated=TO_TIMESTAMP('2022-03-10 00:00:00','YYYY-MM-DD HH24:MI:SS'), Help=REPLACE(Help, 'clients', 'tenants') WHERE AD_Window_ID<1000000 AND REGEXP_LIKE(Help,'(^|\W)clients(\W|$)');

UPDATE AD_Window SET Updated=TO_TIMESTAMP('2022-03-10 00:00:00','YYYY-MM-DD HH24:MI:SS'), Help=REPLACE(Help, 'Client', 'Tenant') WHERE AD_Window_ID<1000000 AND REGEXP_LIKE(Help,'(^|\W)Client(\W|$)');

UPDATE AD_Window SET Updated=TO_TIMESTAMP('2022-03-10 00:00:00','YYYY-MM-DD HH24:MI:SS'), Help=REPLACE(Help, 'Clients', 'Tenants') WHERE AD_Window_ID<1000000 AND REGEXP_LIKE(Help,'(^|\W)Clients(\W|$)');

UPDATE AD_Window SET Updated=TO_TIMESTAMP('2022-03-10 00:00:00','YYYY-MM-DD HH24:MI:SS'), Name=REPLACE(Name, 'client', 'tenant') WHERE AD_Window_ID<1000000 AND REGEXP_LIKE(Name,'(^|\W)client(\W|$)') AND Name NOT LIKE '%client-%';

UPDATE AD_Window SET Updated=TO_TIMESTAMP('2022-03-10 00:00:00','YYYY-MM-DD HH24:MI:SS'), Name=REPLACE(Name, 'clients', 'tenants') WHERE AD_Window_ID<1000000 AND REGEXP_LIKE(Name,'(^|\W)clients(\W|$)');

UPDATE AD_Window SET Updated=TO_TIMESTAMP('2022-03-10 00:00:00','YYYY-MM-DD HH24:MI:SS'), Name=REPLACE(Name, 'Client', 'Tenant') WHERE AD_Window_ID<1000000 AND REGEXP_LIKE(Name,'(^|\W)Client(\W|$)');

UPDATE AD_Window SET Updated=TO_TIMESTAMP('2022-03-10 00:00:00','YYYY-MM-DD HH24:MI:SS'), Name=REPLACE(Name, 'Clients', 'Tenants') WHERE AD_Window_ID<1000000 AND REGEXP_LIKE(Name,'(^|\W)Clients(\W|$)');

UPDATE AD_Workflow SET Updated=TO_TIMESTAMP('2022-03-10 00:00:00','YYYY-MM-DD HH24:MI:SS'), Description=REPLACE(Description, 'client', 'tenant') WHERE AD_Workflow_ID<1000000 AND REGEXP_LIKE(Description,'(^|\W)client(\W|$)') AND Description NOT LIKE '%client-%';

UPDATE AD_Workflow SET Updated=TO_TIMESTAMP('2022-03-10 00:00:00','YYYY-MM-DD HH24:MI:SS'), Description=REPLACE(Description, 'clients', 'tenants') WHERE AD_Workflow_ID<1000000 AND REGEXP_LIKE(Description,'(^|\W)clients(\W|$)');

UPDATE AD_Workflow SET Updated=TO_TIMESTAMP('2022-03-10 00:00:00','YYYY-MM-DD HH24:MI:SS'), Description=REPLACE(Description, 'Client', 'Tenant') WHERE AD_Workflow_ID<1000000 AND REGEXP_LIKE(Description,'(^|\W)Client(\W|$)');

UPDATE AD_Workflow SET Updated=TO_TIMESTAMP('2022-03-10 00:00:00','YYYY-MM-DD HH24:MI:SS'), Description=REPLACE(Description, 'Clients', 'Tenants') WHERE AD_Workflow_ID<1000000 AND REGEXP_LIKE(Description,'(^|\W)Clients(\W|$)');

UPDATE AD_Workflow SET Updated=TO_TIMESTAMP('2022-03-10 00:00:00','YYYY-MM-DD HH24:MI:SS'), Help=REPLACE(Help, 'client', 'tenant') WHERE AD_Workflow_ID<1000000 AND REGEXP_LIKE(Help,'(^|\W)client(\W|$)') AND Help NOT LIKE '%client-%';

UPDATE AD_Workflow SET Updated=TO_TIMESTAMP('2022-03-10 00:00:00','YYYY-MM-DD HH24:MI:SS'), Help=REPLACE(Help, 'clients', 'tenants') WHERE AD_Workflow_ID<1000000 AND REGEXP_LIKE(Help,'(^|\W)clients(\W|$)');

UPDATE AD_Workflow SET Updated=TO_TIMESTAMP('2022-03-10 00:00:00','YYYY-MM-DD HH24:MI:SS'), Help=REPLACE(Help, 'Client', 'Tenant') WHERE AD_Workflow_ID<1000000 AND REGEXP_LIKE(Help,'(^|\W)Client(\W|$)');

UPDATE AD_Workflow SET Updated=TO_TIMESTAMP('2022-03-10 00:00:00','YYYY-MM-DD HH24:MI:SS'), Help=REPLACE(Help, 'Clients', 'Tenants') WHERE AD_Workflow_ID<1000000 AND REGEXP_LIKE(Help,'(^|\W)Clients(\W|$)');

UPDATE AD_Workflow SET Updated=TO_TIMESTAMP('2022-03-10 00:00:00','YYYY-MM-DD HH24:MI:SS'), Name=REPLACE(Name, 'client', 'tenant') WHERE AD_Workflow_ID<1000000 AND REGEXP_LIKE(Name,'(^|\W)client(\W|$)') AND Name NOT LIKE '%client-%';

UPDATE AD_Workflow SET Updated=TO_TIMESTAMP('2022-03-10 00:00:00','YYYY-MM-DD HH24:MI:SS'), Name=REPLACE(Name, 'clients', 'tenants') WHERE AD_Workflow_ID<1000000 AND REGEXP_LIKE(Name,'(^|\W)clients(\W|$)');

UPDATE AD_Workflow SET Updated=TO_TIMESTAMP('2022-03-10 00:00:00','YYYY-MM-DD HH24:MI:SS'), Name=REPLACE(Name, 'Client', 'Tenant') WHERE AD_Workflow_ID<1000000 AND REGEXP_LIKE(Name,'(^|\W)Client(\W|$)');

UPDATE AD_Workflow SET Updated=TO_TIMESTAMP('2022-03-10 00:00:00','YYYY-MM-DD HH24:MI:SS'), Name=REPLACE(Name, 'Clients', 'Tenants') WHERE AD_Workflow_ID<1000000 AND REGEXP_LIKE(Name,'(^|\W)Clients(\W|$)');

SELECT register_migration_script('202203081457_IDEMPIERE-4586.sql') FROM dual
;

