-- missing foreign keys
ALTER TABLE AD_Column ADD CONSTRAINT PADashboardContent_ADColumn FOREIGN KEY (PA_DashboardContent_ID) REFERENCES PA_DashboardContent DEFERRABLE INITIALLY DEFERRED;

ALTER TABLE AD_WF_Node ADD CONSTRAINT ADInfoWindow_ADWFNode FOREIGN KEY (AD_InfoWindow_ID) REFERENCES AD_InfoWindow DEFERRABLE INITIALLY DEFERRED;

SELECT register_migration_script('201710312225_MissingForeignKeys.sql') FROM dual
;

