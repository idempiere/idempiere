You can add here custom scripts for your installation to be applied when running the RUN_SyncDB utility.

Custom scripts must follow the same convention as core scripts, this is:
postgresql/yyyymmddHHMM_InformationalDescription.sql
oracle/yyyymmddHHMM_InformationalDescription.sql

This is, the scripts must be within a folder with name postgresql or oracle depending on the database to apply, and must follow the convention yyyymmddHHMM_InformationalDescription.sql

* yyyymmddHHMM : the timestamp of the SQL script, this is relevant as the files will be applied ordering by this timestamp - independently of the folder where they are located

* InformationalDescription : optional additional information

folders are applied in alphabetical order, for example:
i4.1
i4.1z
i5.1
   ... and so on until the current version ... and then
local_sql

Note it process ANY FOLDER that contains a subfolder postgresql or oracle, and at the end it process the scripts in processes_post_migration