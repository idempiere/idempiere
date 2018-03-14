2Pack files are processed anywhere within the migration folder, however, it is recommended to add here your custom 2Pack zip files for your installation, these 2Pack files will be applied after starting the server by the org.adempiere.plugin.utils.PackInApplicationActivator plugin.

Name of 2pack files must follow the convention:
yyyymmddHHMM_ClientValue_InformationalDescription.zip

* yyyymmddHHMM : the timestamp of the 2pack file, this is relevant as the files will be applied ordering by this timestamp - independently of the folder where they are located
* ClientValue : refers to the AD_Client.Value - this is case sensitive and it describes in which client (tenant) the 2pack is applied
* InformationalDescription : optional additional information