-- IDEMPIERE-5245 Fix typos in dictionary
SELECT register_migration_script('202401151138_IDEMPIERE-5245.sql') FROM dual;

SET SQLBLANKLINES ON
SET DEFINE OFF

-- Jan 15, 2024, 11:38:38 AM CET
UPDATE AD_Element SET Description='Where the money in the cash book should be transferred to. Either a Bank Account or another Cash Book',Updated=TO_TIMESTAMP('2024-01-15 11:38:38','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Element_ID=52031
;

-- Jan 15, 2024, 11:48:38 AM CET
UPDATE AD_Element SET Help='EMail user name for requests, alerts and escalation are sent from this email address as well as delivery information if the sales rep does not have an email account. Required, if your mail server requires authentication as well as for processing incoming mails.',Updated=TO_TIMESTAMP('2024-01-15 11:48:38','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Element_ID=1700
;

-- Jan 15, 2024, 11:48:50 AM CET
UPDATE AD_Element SET Help='The user name in the mail system is usually the string before the @ of your email address.  Required if the mail server requires authentication to send emails.',Updated=TO_TIMESTAMP('2024-01-15 11:48:50','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Element_ID=1896
;

-- Jan 15, 2024, 11:49:29 AM CET
UPDATE AD_Element SET Help='Required if the mail server requires authentication to send emails.',Updated=TO_TIMESTAMP('2024-01-15 11:49:29','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Element_ID=1897
;

-- Jan 15, 2024, 11:50:41 AM CET
UPDATE AD_Element SET PO_Name='Receipt Description',Updated=TO_TIMESTAMP('2024-01-15 11:50:41','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Element_ID=2532
;

-- Jan 15, 2024, 11:51:21 AM CET
UPDATE AD_Element SET Help='This allows to have the three general situations of "not open" - "open" - "closed"',Updated=TO_TIMESTAMP('2024-01-15 11:51:21','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Element_ID=2722
;

-- Jan 15, 2024, 11:51:52 AM CET
UPDATE AD_Element SET PrintName='Unit Runtime',Updated=TO_TIMESTAMP('2024-01-15 11:51:52','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Element_ID=2778
;

-- Jan 15, 2024, 11:53:53 AM CET
UPDATE AD_Element SET Help='Reporting Hierarchy allows you to select different Hierarchies/Trees for the report.
Accounting Segments like Organization, Account, Product may have several hierarchies to accommodate different views on the business.',Updated=TO_TIMESTAMP('2024-01-15 11:53:53','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Element_ID=2868
;

-- Jan 15, 2024, 11:55:53 AM CET
UPDATE AD_Element SET Help='A user defined accounting element refers to an iDempiere table. This allows to use any table content as an accounting dimension (e.g. Project Task).  Note that User Elements are optional and are populated from the context of the document (i.e. not requested)',Updated=TO_TIMESTAMP('2024-01-15 11:55:53','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Element_ID=2877
;

-- Jan 15, 2024, 11:55:59 AM CET
UPDATE AD_Element SET Help='A user defined accounting element refers to an iDempiere table. This allows to use any table content as an accounting dimension (e.g. Project Task).  Note that User Elements are optional and are populated from the context of the document (i.e. not requested) ',Updated=TO_TIMESTAMP('2024-01-15 11:55:59','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Element_ID=2878
;

-- Jan 15, 2024, 11:56:49 AM CET
UPDATE AD_Element SET Help='Visual representation of performance by color.  The Schema has often three levels (e.g. red-yellow-green).  iDempiere supports two levels (e.g. red-green) or four levels (e.g. gray-bronce-silver-gold).  Note that Measures without a goal are represented white.  The percentages could be between 0 and unlimited (i.e. above 100%).',Updated=TO_TIMESTAMP('2024-01-15 11:56:49','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Element_ID=2903
;

-- Jan 15, 2024, 11:57:10 AM CET
UPDATE AD_Element SET Description='Next Maintenance Unit',Updated=TO_TIMESTAMP('2024-01-15 11:57:10','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Element_ID=2934
;

-- Jan 15, 2024, 11:57:40 AM CET
UPDATE AD_Element SET Description='Media Server list to which content should get transferred',Updated=TO_TIMESTAMP('2024-01-15 11:57:40','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Element_ID=3009
;

-- Jan 15, 2024, 11:58:16 AM CET
UPDATE AD_Element SET Help='A Container defines the abstract level around the content, it defines how the content gets displayed, indexed and stored.
The ID is related 1 to 1 to the container ID',Updated=TO_TIMESTAMP('2024-01-15 11:58:16','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Element_ID=3022
;

-- Jan 15, 2024, 11:58:46 AM CET
UPDATE AD_Element SET Help='If your application requires additional jar files, enter them here. The jar files must be located in the $IDEMPIERE_HOME/lib directory.',Updated=TO_TIMESTAMP('2024-01-15 11:58:46','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Element_ID=3054
;

-- Jan 15, 2024, 11:59:52 AM CET
UPDATE AD_Element SET Name='Allow Shipment Info', PrintName='Allow Shipment Info',Updated=TO_TIMESTAMP('2024-01-15 11:59:52','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Element_ID=50049
;

-- Jan 15, 2024, 12:01:48 PM CET
UPDATE AD_Element SET Description='Indicate the Quantity use in this BOM', Help='Exist two way the add a component to a BOM or Formula:

1.- Adding a Component based in quantity to use in this BOM
2.- Adding a Component based in % to use the Order Quantity of Manufacturing Order in this Formula.
',Updated=TO_TIMESTAMP('2024-01-15 12:01:48','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Element_ID=53255
;

-- Jan 15, 2024, 12:02:22 PM CET
UPDATE AD_Element SET Help='Exist two way the add a component to a BOM or Formula:

1.- Adding a Component based in quantity to use in this BOM
2.- Adding a Component based in % to use the Order Quantity of Manufacturing Order in this Formula.
',Updated=TO_TIMESTAMP('2024-01-15 12:02:22','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Element_ID=53256
;

-- Jan 15, 2024, 12:03:19 PM CET
UPDATE AD_Element SET Help='Scrap is useful to determinate a right Standard Cost and management a good supply.',Updated=TO_TIMESTAMP('2024-01-15 12:03:19','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Element_ID=53257
;

-- Jan 15, 2024, 12:04:01 PM CET
UPDATE AD_Element SET Name='Job Qty', PrintName='Job Qty',Updated=TO_TIMESTAMP('2024-01-15 12:04:01','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Element_ID=53401
;

-- Jan 15, 2024, 12:04:38 PM CET
UPDATE AD_Element SET PrintName='Ignore Processing Time',Updated=TO_TIMESTAMP('2024-01-15 12:04:38','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Element_ID=54123
;

-- Jan 15, 2024, 12:05:04 PM CET
UPDATE AD_Element SET Help='The Number of Inventory Counts indicates the number of times per year that inventory counts will be performed',Updated=TO_TIMESTAMP('2024-01-15 12:05:04','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Element_ID=1112
;

-- Jan 15, 2024, 12:07:56 PM CET
UPDATE AD_Field SET Description='Copy BOM Lines from an existing BOM', Help='Copy BOM Lines from an existing BOM. The BOM being copied to, must not have any existing BOM Lines.',Updated=TO_TIMESTAMP('2024-01-15 12:07:56','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=53480
;

-- Jan 15, 2024, 12:08:53 PM CET
UPDATE AD_Field SET Help='The Workflow field identifies a unique Workflow in the system.

The Workflow you introduce in this window will be considered the default Workflow to produce the product in this Organization-Plant-Warehouse. If you do not fill this field the default Workflow for the entity will be the Workflow with the same name as the product.',Updated=TO_TIMESTAMP('2024-01-15 12:08:53','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=53518
;

-- Jan 15, 2024, 12:09:50 PM CET
UPDATE AD_Field SET Description='Copy BOM Lines from an existing BOM', Help='Copy BOM Lines from an existing BOM. The BOM being copied to, must not have any existing BOM Lines.',Updated=TO_TIMESTAMP('2024-01-15 12:09:50','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=58101
;

-- Jan 15, 2024, 12:10:45 PM CET
UPDATE AD_Form SET Help='A configurable Bill of Material (CBOM) is used by industries that have multiple options and highly configurable products.

The CBOM is used to dynamically create "end-items" that a company sells. The benefit of using CBOM structure is it reduces the work-effort needed to maintain product structures. The configurable BOM is most frequently driven by "configurator" software, however it can be enabled manually (manual maintenance is infrequent because its unwieldy to manage the number of permutations and combinations of possible configurations) The development of the CBOM is dependent on having a Modular BOM structure in place (see Modular BOM). The Modular BOM structure provides the assemblies/sub-systems that can be selected to "configure" an end-item.',Updated=TO_TIMESTAMP('2024-01-15 12:10:45','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Form_ID=53002
;

-- Jan 15, 2024, 12:11:18 PM CET
UPDATE AD_Form SET Description='Payroll Action Notice allows to entry the events that happened with any Employee',Updated=TO_TIMESTAMP('2024-01-15 12:11:18','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Form_ID=53009
;

-- Jan 15, 2024, 12:11:55 PM CET
UPDATE AD_Form SET Help='Export/Import Translation info to/from xml for translation in external tool. Please note that the Language MUST be an enabled and verified System Language.',Updated=TO_TIMESTAMP('2024-01-15 12:11:55','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Form_ID=109
;

-- Jan 15, 2024, 12:12:27 PM CET
UPDATE AD_Form SET Help='Enter Transactions via a POS Terminal.  Automatically, scans or credit card swipes are recognized.',Updated=TO_TIMESTAMP('2024-01-15 12:12:27','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Form_ID=113
;

-- Jan 15, 2024, 12:12:53 PM CET
UPDATE AD_Form SET Help='View active workflow activities',Updated=TO_TIMESTAMP('2024-01-15 12:12:53','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Form_ID=117
;

-- Jan 15, 2024, 12:14:14 PM CET
UPDATE AD_Message SET MsgTip='Only for internal iDempiere Dictionary Maintenance - DO NOT SELECT',Updated=TO_TIMESTAMP('2024-01-15 12:14:14','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Message_ID=713
;

-- Jan 15, 2024, 12:14:43 PM CET
UPDATE AD_Message SET MsgTip='Indicates that a supply order should be released. if it is a draft order , it must also be approved.',Updated=TO_TIMESTAMP('2024-01-15 12:14:43','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Message_ID=53015
;

-- Jan 15, 2024, 12:15:11 PM CET
UPDATE AD_Message SET MsgTip='Indicates that there was an unclassified error during MRP process',Updated=TO_TIMESTAMP('2024-01-15 12:15:11','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Message_ID=53079
;

-- Jan 15, 2024, 12:15:33 PM CET
UPDATE AD_Message SET MsgTip='Indicates that there was an error during document creation',Updated=TO_TIMESTAMP('2024-01-15 12:15:33','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Message_ID=53080
;

-- Jan 15, 2024, 12:17:54 PM CET
UPDATE AD_Process SET Help='(Re)Print Dunning Letters or send them as PDF attachments to the Business Partner Contact with a valid EMail address.
',Updated=TO_TIMESTAMP('2024-01-15 12:17:54','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Process_ID=312
;

-- Jan 15, 2024, 12:19:19 PM CET
UPDATE AD_Process SET Help='This applies to the tenant defined document translations, e.g. for UoM, Payment Terms, Product Info, etc.<br>
<br>
If the current tenant has multi-lingual documents enabled, then the main record is copied to the tenant language (defined in Tenant window).  BE CAREFUL as this option can potentially damage data you modified, it is recommended to take a backup and plan carefully what you''re doing if this is the first time running this process.<br>
<br>
If the current tenant has not multi-lingual documents enabled, the translations for documents are synchronized with the main record (i.e. it copies the content of the main record to the translation records).  This process is necessary when switching to a mono-lingual environment as there the terminology is maintained not in the translation records.',Updated=TO_TIMESTAMP('2024-01-15 12:19:19','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Process_ID=321
;

-- Jan 15, 2024, 12:19:56 PM CET
UPDATE AD_Process SET Help='Be careful, this process will reindex all tables and records which are marked to get indexed. Depending on the number of documents this could take a long time. This should only be run if you have removed stop words, if this is mentioned to be run after migration.',Updated=TO_TIMESTAMP('2024-01-15 12:19:56','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Process_ID=350
;

-- Jan 15, 2024, 12:20:36 PM CET
UPDATE AD_Process SET Name='Multiple Components Change',Updated=TO_TIMESTAMP('2024-01-15 12:20:36','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Process_ID=53008
;

-- Jan 15, 2024, 12:21:10 PM CET
UPDATE AD_Process SET Description='This process calculates the demand, approved and open orders for a product.', Help='This process calculates the demand, approved and open orders for a product.',Updated=TO_TIMESTAMP('2024-01-15 12:21:10','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Process_ID=53016
;

-- Jan 15, 2024, 12:22:10 PM CET
UPDATE AD_Process SET Help='Movement for open Distribution Orders are created based on the delivery rule of the Distribution Order and the relative order priority.  If a Date Promised is selected only orders up to (including) the date are selected.<br>
If several Distribution Orders of a business partner have the same location, the Distribution orders can be consolidated into one Movement.<br>
You can also include Distribution orders who have outstanding confirmations (e.g. ordered=10 - not confirmed movements=4 - would create a new movement of 6 if available).',Updated=TO_TIMESTAMP('2024-01-15 12:22:10','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Process_ID=53046
;

-- Jan 15, 2024, 12:22:36 PM CET
UPDATE AD_Process SET Description='Used to review Assets Transferred Entry ',Updated=TO_TIMESTAMP('2024-01-15 12:22:36','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Process_ID=53099
;

-- Jan 15, 2024, 12:23:22 PM CET
UPDATE AD_Process SET Help='You can Add Missing Translation entries (required after activating an additional System Language) - Delete Translation Records - or Re-Create the translation Records (first delete and add missing entries).
Note that Adding the Missing Translation records creates them by copying the System Language (English).  You would apply the Language Pack after that process.  Run Synchronize Terminology after importing the translation.',Updated=TO_TIMESTAMP('2024-01-15 12:23:22','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Process_ID=179
;

-- Jan 15, 2024, 12:24:06 PM CET
UPDATE AD_Process SET Help='(Re)Print Invoices or send them as PDF attachments to the Business Partner Contact with a valid EMail address.
<br>
Remark: If you only enter a Document No FROM value, all invoices greater or equal that document number are printed; you can alternatively use the % character as a widcard.',Updated=TO_TIMESTAMP('2024-01-15 12:24:06','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Process_ID=200
;

-- Jan 15, 2024, 12:25:59 PM CET
UPDATE AD_Process SET Help='Invalid responses are ranked with 999 per Quantity. The Quantity Responses are ranked among each other and the RfQ Best Response updated.  The response Lines is marked as Selected winner, where the line quantity purchase quantity is selected.  A total winner is only selected, if the RfQ type is "Quote All Lines" or "Quote Total only".

Then the rankings of all Quantity Responses are added for the total ranking of the response. The response with the lowest total ranking is marked as Selected Winner.',Updated=TO_TIMESTAMP('2024-01-15 12:25:59','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Process_ID=265
;

-- Jan 15, 2024, 12:26:43 PM CET
UPDATE AD_Process SET Help='Create purchase order(s) for the response(s) and lines marked as Selected Winner using the selected Purchase Quantity (in RfQ Line Quantity) . If a Response is marked as Selected Winner, all lines are created (and Selected Winner of other responses ignored).  If there is no response marked as Selected Winner, the lines are used.',Updated=TO_TIMESTAMP('2024-01-15 12:26:43','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Process_ID=266
;

-- Jan 15, 2024, 12:27:32 PM CET
UPDATE AD_Process SET Help='Update the access rights of a role or all roles of a tenant to windows, forms, processes and workflows. Note that a role is only updated if it is not marked as manual. Note that if is executed from System tenant and role is not set, all tenants will be updated',Updated=TO_TIMESTAMP('2024-01-15 12:27:32','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Process_ID=295
;

-- Jan 15, 2024, 12:28:02 PM CET
UPDATE AD_Reference SET Description='Where money should be transferred to',Updated=TO_TIMESTAMP('2024-01-15 12:28:02','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Reference_ID=52002
;

-- Jan 15, 2024, 12:28:45 PM CET
UPDATE AD_Reference SET Help='For now we only have implicit relation types, i.e. the record pairs are defined by the rule itself. In future we would like to have explicit types also. An explicit type just defines a template, the actual pairs can be added by a user or by the system itself.',Updated=TO_TIMESTAMP('2024-01-15 12:28:45','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Reference_ID=53332
;

-- Jan 15, 2024, 12:29:30 PM CET
UPDATE AD_Reference SET Name='C_BPartner Vendors Active',Updated=TO_TIMESTAMP('2024-01-15 12:29:30','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Reference_ID=223
;

-- Jan 15, 2024, 12:32:22 PM CET
UPDATE AD_Ref_List SET Name='Time&Material max Committed',Updated=TO_TIMESTAMP('2024-01-15 12:32:22','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Ref_List_ID=894
;

-- Jan 15, 2024, 12:33:09 PM CET
UPDATE AD_Ref_List SET Description='The different Continuous Flow is that two or more products are manufactured in the same facility (long setup times the run time is hours or several days.)',Updated=TO_TIMESTAMP('2024-01-15 12:33:09','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Ref_List_ID=53251
;

-- Jan 15, 2024, 12:33:49 PM CET
UPDATE AD_Ref_List SET Description='Continuous flow usually refers to the production or processing of fluids waster powders basic metals  etc.',Updated=TO_TIMESTAMP('2024-01-15 12:33:49','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Ref_List_ID=53252
;

-- Jan 15, 2024, 12:35:21 PM CET
UPDATE AD_Ref_List SET Description='A Job Shop is characterized by the organization of similar equipment by function. As Job flow from Work Center to Work Center or Department to Department and the different type of operation is performed in each center or department',Updated=TO_TIMESTAMP('2024-01-15 12:35:21','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Ref_List_ID=53254
;

-- Jan 15, 2024, 12:36:08 PM CET
UPDATE AD_Ref_List SET Description='Revaluate each year separately',Updated=TO_TIMESTAMP('2024-01-15 12:36:08','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Ref_List_ID=53367
;

-- Jan 15, 2024, 12:36:38 PM CET
UPDATE AD_Ref_List SET Name='Date Acquired',Updated=TO_TIMESTAMP('2024-01-15 12:36:38','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Ref_List_ID=53371
;

-- Jan 15, 2024, 12:37:24 PM CET
UPDATE AD_Ref_List SET Description='Asset Transferred',Updated=TO_TIMESTAMP('2024-01-15 12:37:24','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Ref_List_ID=53409
;

-- Jan 15, 2024, 12:37:59 PM CET
UPDATE AD_Ref_List SET Description='Indicates this charge is an expense',Updated=TO_TIMESTAMP('2024-01-15 12:37:59','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Ref_List_ID=53417
;

-- Jan 15, 2024, 12:38:30 PM CET
UPDATE AD_Ref_List SET Name='Usage Variance',Updated=TO_TIMESTAMP('2024-01-15 12:38:30','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Ref_List_ID=53444
;

-- Jan 15, 2024, 12:39:05 PM CET
UPDATE AD_Ref_List SET Description='Create a Manufacturing Order, Receipt the finish product and issue the Components automatically ',Updated=TO_TIMESTAMP('2024-01-15 12:39:05','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Ref_List_ID=53450
;

-- Jan 15, 2024, 12:42:23 PM CET
UPDATE AD_Tab SET Help='Define the role and add the organizations the role has access to. You can give users access to this role and modify the access of this role to windows, forms, processes and reports as well as tasks. <br>
If the Role User Level is Manual, the assigned access rights are not automatically updated (e.g. if a role has a restricted number of Windows/Processes it can access). You need to add organizational access unless the role has access to all organizations. The SuperUser and the user creating a new role are assigned to the role automatically.  <br>
If you select an Organization Tree, the user has access to the leaves of  summary organizations.
Note: You cannot change the System Administrator role.',Updated=TO_TIMESTAMP('2024-01-15 12:42:23','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Tab_ID=119
;

-- Jan 15, 2024, 12:43:24 PM CET
UPDATE AD_Tab SET Help='Defines the columns of a table. Note that the name of the column is automatically synchronized.',Updated=TO_TIMESTAMP('2024-01-15 12:43:24','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Tab_ID=101
;

-- Jan 15, 2024, 12:44:57 PM CET
UPDATE AD_Tab SET Help='Item in the print format maintaining layout information.  The following additional variables are available when printing:
<p>@*Page@ - the current page number
<br>@*PageCount@ - the total number of pages
<br>@*MultiPageInfo@ - "Page x of y" - only printed if more than one page
<br>@*CopyInfo@ - if it is a copy of the document "Duplicate" is printed
<br>@*ReportName@ - name of the report
<br>@*Header@ - Full Header with user/tenant/org name and connection
<br>@*CurrentDate@ - the print date
<br>@*CurrentDateTime@ - the print time

<p>The layout logic for forms is: <br>
- if not printed: ignore <br>
- set New Line Position <br>
- new page <br>
- new line, if something was printed since last new line<br>
- format item<br>
- print it (if not null/empty selected)<br>
(i.e. suppress null does not prevent new line)',Updated=TO_TIMESTAMP('2024-01-15 12:44:57','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Tab_ID=426
;

-- Jan 15, 2024, 12:46:48 PM CET
UPDATE AD_Tab SET Help='If listed here, the Role can(not) access all data of this table, even if the role has access to the functionality.
<br>If you Include Access to a table and select Read Only, you can only read data (otherwise full access).
<br>If you Exclude Access to a table and select Read Only, you can only read data (otherwise no access).
<br>Please note that table access rules here are in addition to the Data Access Levels defined for a Table and the User Level defined for a Role. These rules are evaluated first and you only need to define the exceptions to these rules here.
<p>
Note that access information is cached and requires re-login or reset of cache. Be aware that if you use Include rules, then you need to include also several supporting entities. As an alternative, grant access only to functionality required.',Updated=TO_TIMESTAMP('2024-01-15 12:46:48','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Tab_ID=482
;

-- Jan 15, 2024, 12:49:12 PM CET
UPDATE AD_Tab SET Help='A new Journal Batch is created, if the Batch Document No or accounting schema are different. A new Journal is created, if the Document No, Currency, Document Type, GL Category, Posting Type or Accounting type is different. You can also force the creation of a new Batch or Journal by selecting the create new flag.<p>
Please note that there are three Organization Fields: The Document Organization is the owner of the document and set directly or per parameter default. The Organization is part of the accounting key and only required if no Valid Account Combination is specified; If not defined it is derived from the Document Organization. The Transaction Organization is part of the account combination.<br>
The optional balance check applies to the entire import, not for individual batches or journals.
<br>The document numbers will be overwritten if the document type is not set to manual sequences.',Updated=TO_TIMESTAMP('2024-01-15 12:49:12','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Tab_ID=508
;

-- Jan 15, 2024, 12:49:58 PM CET
UPDATE AD_Tab SET Help='The Data Replication Strategy determines which tables and how they are replicated. Note that the migration does not synchronize Application Dictionary items.',Updated=TO_TIMESTAMP('2024-01-15 12:49:58','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Tab_ID=524
;

-- Jan 15, 2024, 12:50:44 PM CET
UPDATE AD_Tab SET Help='Area of knowledge - A Type has multiple Topics',Updated=TO_TIMESTAMP('2024-01-15 12:50:44','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Tab_ID=541
;

-- Jan 15, 2024, 12:51:16 PM CET
UPDATE AD_Tab SET Help='Assigned Category - Value for the Knowledge Entry',Updated=TO_TIMESTAMP('2024-01-15 12:51:16','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Tab_ID=544
;

-- Jan 15, 2024, 12:52:01 PM CET
UPDATE AD_Tab SET Description='Related Knowledge Entry', Help='Related Knowledge Entry for this Knowledge Entry',Updated=TO_TIMESTAMP('2024-01-15 12:52:01','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Tab_ID=545
;

-- Jan 15, 2024, 12:52:54 PM CET
UPDATE AD_Tab SET Help='The Source of a Knowledge Entry is a pointer to the originating system. The Knowledge Entry has an additional entry (Description URL)  for more detailed info.',Updated=TO_TIMESTAMP('2024-01-15 12:52:54','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Tab_ID=547
;

-- Jan 15, 2024, 12:53:32 PM CET
UPDATE AD_Tab SET Description='Knowledge Keyword Synonym',Updated=TO_TIMESTAMP('2024-01-15 12:53:32','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Tab_ID=548
;

-- Jan 15, 2024, 12:54:21 PM CET
UPDATE AD_Tab SET Help='The Accounting Tab defines the accounting parameters used for transactions including a currency. Please note that if not defined, the default accounts of the Accounting Schema are used!',Updated=TO_TIMESTAMP('2024-01-15 12:54:21','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Tab_ID=569
;

-- Jan 15, 2024, 12:54:59 PM CET
UPDATE AD_Window SET Name='Bank/Cash', Description='Maintain Bank/Cash', Help='The Bank/Cash Window is used to define the banks and accounts associated with an organization or business partner',Updated=TO_TIMESTAMP('2024-01-15 12:54:59','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Window_ID=158
;

-- Jan 15, 2024, 12:55:06 PM CET
UPDATE AD_Tab SET Name='Bank/Cash',Updated=TO_TIMESTAMP('2024-01-15 12:55:06','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Tab_ID=227
;

-- Jan 15, 2024, 12:55:30 PM CET
UPDATE AD_Tab SET Help='The loader definition provides the parameters to load bank statements from EFT formats like SWIFT (MT940) or OFX. The required parameters depend on the actual statement loader class',Updated=TO_TIMESTAMP('2024-01-15 12:55:30','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Tab_ID=571
;

-- Jan 15, 2024, 12:56:04 PM CET
UPDATE AD_Tab SET Help='You can create a bid for a topic.  Depending on the type, the highest bidder wins the Topic - or you participate in funding for a Topic.',Updated=TO_TIMESTAMP('2024-01-15 12:56:04','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Tab_ID=595
;

-- Jan 15, 2024, 12:56:36 PM CET
UPDATE AD_Tab SET Help='Committed or Uncommitted funds for Bids',Updated=TO_TIMESTAMP('2024-01-15 12:56:36','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Tab_ID=597
;

-- Jan 15, 2024, 12:56:47 PM CET
UPDATE AD_Tab SET Help='Committed or Uncommitted funds from Offers',Updated=TO_TIMESTAMP('2024-01-15 12:56:47','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Tab_ID=598
;

-- Jan 15, 2024, 12:57:31 PM CET
UPDATE AD_Tab SET Help='Available Funds (for Payments) and Committed or Uncommitted funds from Offers',Updated=TO_TIMESTAMP('2024-01-15 12:57:31','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Tab_ID=603
;

-- Jan 15, 2024, 12:57:57 PM CET
UPDATE AD_Tab SET Help='Available Funds (Payments) and Committed or Uncommitted funds for Bids',Updated=TO_TIMESTAMP('2024-01-15 12:57:57','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Tab_ID=606
;

-- Jan 15, 2024, 12:58:28 PM CET
UPDATE AD_Tab SET Help='You can create a bid for a topic.  Depending on the type, the highest bidder wins the Topic - or you participate in funding for a Topic.',Updated=TO_TIMESTAMP('2024-01-15 12:58:28','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Tab_ID=607
;

-- Jan 15, 2024, 12:59:14 PM CET
UPDATE AD_Tab SET Description='User Assignment to Organization',Updated=TO_TIMESTAMP('2024-01-15 12:59:14','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Tab_ID=636
;

-- Jan 15, 2024, 12:59:52 PM CET
UPDATE AD_Tab SET Description='User Assignment to Organization',Updated=TO_TIMESTAMP('2024-01-15 12:59:52','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Tab_ID=637
;

-- Jan 15, 2024, 1:00:28 PM CET
UPDATE AD_Tab SET Description='Assignment of Attributes to Products',Updated=TO_TIMESTAMP('2024-01-15 13:00:28','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Tab_ID=650
;

-- Jan 15, 2024, 1:01:03 PM CET
UPDATE AD_Tab SET Help='Change requests for a Bill of Materials. They can be automatically created from Requests, if enabled in the Request Type and the Request Group refers to a Bill of Materials',Updated=TO_TIMESTAMP('2024-01-15 13:01:03','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Tab_ID=735
;

-- Jan 15, 2024, 1:01:45 PM CET
UPDATE AD_Tab SET Help='The Bill of Material Component determines what products, services and outside processing is included in producing the Product. It references the operation and determines its sequence.',Updated=TO_TIMESTAMP('2024-01-15 13:01:45','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Tab_ID=738
;

-- Jan 15, 2024, 1:02:26 PM CET
UPDATE AD_Tab SET Help='Displays all accounting related information for reconciliation with documents. It includes all revenue/expense and tax entries as a base for detail reporting',Updated=TO_TIMESTAMP('2024-01-15 13:02:26','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Tab_ID=765
;

-- Jan 15, 2024, 1:02:58 PM CET
UPDATE AD_Window SET Help='Reporting Hierarchy allows you to select different Hierarchies/Trees for the report.
Accounting Segments like Organization, Account, Product may have several hierarchies to accommodate different views on the business',Updated=TO_TIMESTAMP('2024-01-15 13:02:58','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Window_ID=360
;

-- Jan 15, 2024, 1:05:41 PM CET
UPDATE AD_Tab SET Help='Visual representation of performance by color.  The Schema has often three levels (e.g. red-yellow-green).  iDempiere supports two levels (e.g. red-green) or four levels (e.g. gray-bronce-silver-gold).  Note that Measures without a goal are represented white.  The percentages could be between 0 and unlimited (i.e. above 100%).',Updated=TO_TIMESTAMP('2024-01-15 13:05:41','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Tab_ID=779
;

-- Jan 15, 2024, 1:06:23 PM CET
UPDATE AD_Tab SET Help='Keyword not to be indexed, optional restricted to specific Document Type, Container or Request Type',Updated=TO_TIMESTAMP('2024-01-15 13:06:23','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Tab_ID=847
;

-- Jan 15, 2024, 1:07:02 PM CET
UPDATE AD_Tab SET Help='The Employee Attributes are used to define additional data for a employee',Updated=TO_TIMESTAMP('2024-01-15 13:07:02','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Tab_ID=53113
;

-- Jan 15, 2024, 1:07:05 PM CET
UPDATE AD_Tab SET Help='The Employee Attributes are used to define additional data for an employee',Updated=TO_TIMESTAMP('2024-01-15 13:07:05','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Tab_ID=53113
;

-- Jan 15, 2024, 1:07:38 PM CET
UPDATE AD_Tab SET Description='Select the asset to be transferred',Updated=TO_TIMESTAMP('2024-01-15 13:07:38','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Tab_ID=53150
;

-- Jan 15, 2024, 1:08:12 PM CET
UPDATE AD_Tab SET Help='Components of Bill of Materials',Updated=TO_TIMESTAMP('2024-01-15 13:08:12','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Tab_ID=53287
;

-- Jan 15, 2024, 1:08:45 PM CET
UPDATE AD_Tab SET Help='Table (header) definition - Note that the name of most tables is automatically synchronized.',Updated=TO_TIMESTAMP('2024-01-15 13:08:45','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Tab_ID=100
;

-- Jan 15, 2024, 1:10:27 PM CET
UPDATE AD_Window SET Help='Visual representation of performance by color.  The Schema has often three levels (e.g. red-yellow-green).  iDempiere supports two levels (e.g. red-green) or four levels (e.g. gray-bronce-silver-gold).  Note that Measures without a goal are represented white.  The percentages could be between 0 and unlimited (i.e. above 100%).',Updated=TO_TIMESTAMP('2024-01-15 13:10:27','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Window_ID=364
;

-- Jan 15, 2024, 1:10:55 PM CET
UPDATE AD_Window SET Help='Ad Management is used to create and manage advertisements in your content management',Updated=TO_TIMESTAMP('2024-01-15 13:10:55','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Window_ID=375
;

-- Jan 15, 2024, 1:11:20 PM CET
UPDATE AD_Window SET Help='You can use the tax definition information to create the logic necessary to get the tax rate to your document',Updated=TO_TIMESTAMP('2024-01-15 13:11:20','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Window_ID=53021
;

-- Jan 15, 2024, 1:11:51 PM CET
UPDATE AD_Window SET Help='The Asset Revaluation Index window allow you to setup the values of indexes or factors to be used in revaluation of assets',Updated=TO_TIMESTAMP('2024-01-15 13:11:51','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Window_ID=53045
;

-- Jan 15, 2024, 1:12:16 PM CET
UPDATE AD_Window SET Help='The Depreciation Calculation Method window allows the user to define how adjustments to the fixed asset depreciation expense are handled',Updated=TO_TIMESTAMP('2024-01-15 13:12:16','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Window_ID=53061
;

-- Jan 15, 2024, 1:13:47 PM CET
UPDATE AD_Window SET Help='Define the documents you use for this Tenant/Organization.  Note that the check format is defined in the Bank (Account) Window.<p>
The highest priority has the Print Format you define on a Document Type (example specific Export Invoice format). The next level is the set of Print Formats you defined for the organization of the document printed. The default is the set of Print Formats defines for all organizations of the Tenant (Organization=*).',Updated=TO_TIMESTAMP('2024-01-15 13:13:47','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Window_ID=224
;

-- Jan 15, 2024, 1:14:16 PM CET
UPDATE AD_Window SET Help='The Data Replication Strategy determines which tables and how they are replicated. Note that the migration does not synchronize Application Dictionary items.',Updated=TO_TIMESTAMP('2024-01-15 13:14:16','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Window_ID=285
;

-- Jan 15, 2024, 1:14:44 PM CET
UPDATE AD_Window SET Help='The Project Window is used to maintain details of Projects Lines and Issues across Phases/Tasks',Updated=TO_TIMESTAMP('2024-01-15 13:14:44','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Window_ID=286
;

-- Jan 15, 2024, 1:14:44 PM CET
UPDATE AD_WF_Node SET Name='Project (Lines/Issues)', Description='Maintain Sales Order and Work Order Details', Help='The Project Window is used to maintain details of Projects Lines and Issues across Phases/Tasks',Updated=TO_TIMESTAMP('2024-01-15 13:14:44','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_WF_Node_ID=115
;

-- Jan 15, 2024, 1:15:14 PM CET
UPDATE AD_Window SET Help='The Source of a Knowledge Entry is a pointer to the originating system. The Knowledge Entry has an additional entry (Description URL)  for more detailed info.',Updated=TO_TIMESTAMP('2024-01-15 13:15:14','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Window_ID=289
;

-- Jan 15, 2024, 1:15:40 PM CET
UPDATE AD_Window SET Description='Knowledge Keyword Synonym',Updated=TO_TIMESTAMP('2024-01-15 13:15:40','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Window_ID=290
;

-- Jan 15, 2024, 1:16:14 PM CET
UPDATE AD_Window SET Help='Manage Topics and view Bids and Offers',Updated=TO_TIMESTAMP('2024-01-15 13:16:14','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Window_ID=307
;

-- Jan 15, 2024, 1:16:53 PM CET
UPDATE AD_Workflow SET Description='(Standard Process Journal Batch)', IsValid='Y',Updated=TO_TIMESTAMP('2024-01-15 13:16:53','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Workflow_ID=122
;

-- Jan 15, 2024, 1:17:35 PM CET
UPDATE AD_Workflow SET Help='MRP is a set of techniques which uses Bills of Material, Inventory Data, and the Master Production Schedule to calculate requirements for materials. It creates planned orders to balance demand and supply for products and it issues recommendations to receipt material with the right quantities and at the right dates to satisfy the Master Production Schedule in the most efficient way.', IsValid='Y',Updated=TO_TIMESTAMP('2024-01-15 13:17:35','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Workflow_ID=50004
;

-- Jan 15, 2024, 1:18:47 PM CET
UPDATE AD_WF_Node SET Name='Import Processor', Description='Import Processor', Value='Import Processor',Updated=TO_TIMESTAMP('2024-01-15 13:18:47','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_WF_Node_ID=50064
;

-- Jan 15, 2024, 1:19:50 PM CET
UPDATE C_Currency SET Description='Portuguese Escudo',Updated=TO_TIMESTAMP('2024-01-15 13:19:50','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE C_Currency_ID=110
;

-- Jan 15, 2024, 1:22:17 PM CET
UPDATE C_UOM SET Description='(lowest unit for resource assignments)',Updated=TO_TIMESTAMP('2024-01-15 13:22:17','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE C_UOM_ID=103
;

