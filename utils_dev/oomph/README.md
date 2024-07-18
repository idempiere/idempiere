# oomph Import
* Run mvn verify.
* Start eclipse, choose a new and empty workspace (can be any folder).
* Configure your Eclipse, make sure Installed JREs is using jdk or jre 17.
* File > Import...
* Oomph > Projects from Catalog.
* Add user projects (the + icon).
* Catalog: select Github Projects. 
* Resource URIs: click Browse File System... and select <idempiere source folder>/utils_dev/oomph/idempiere.setup.
* Select Github Projects > <User> > iDempiere 12, click Next to proceed.
* Select Show all variables, check all the variable is fill with correct values (If there are error with setting of JDK, select a JRE installation instead).
* Click Next and then Finish to proceed
* Select Restart automatically if needed
* See also https://wiki.idempiere.org/en/NF11_OOMPH_Import_Projects
