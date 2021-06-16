-- Table: adempiere.ad_info_customization

--

DROP TABLE adempiere.ad_wlistboxcustomization;

CREATE TABLE adempiere.ad_wlistboxcustomization
(
    ad_client_id numeric(10,0) NOT NULL,
    ad_org_id numeric(10,0) NOT NULL,
	ad_window_id numeric(10,0) DEFAULT NULL,
	ad_infowindow_id numeric(10,0) DEFAULT NULL,
	ad_form_id numeric(10,0) DEFAULT NULL,
    ad_wlistboxcustomization_id numeric(10,0) NOT NULL DEFAULT NULL::numeric,
    wlistboxname varchar(60) NOT NULL,
    ad_user_id numeric(10,0) NOT NULL,
    created timestamp without time zone NOT NULL DEFAULT statement_timestamp(),
    createdby numeric(10,0) NOT NULL,
    custom character varying(2000) COLLATE pg_catalog."default" NOT NULL,
    isactive character(1) COLLATE pg_catalog."default" NOT NULL,
    updated timestamp without time zone NOT NULL DEFAULT statement_timestamp(),
    updatedby numeric(10,0) NOT NULL,
    ad_wlistbox_customization_uu character varying(36) COLLATE pg_catalog."default" DEFAULT NULL::character varying,
    isdisplayedgrid character(1) COLLATE pg_catalog."default" DEFAULT NULL::bpchar,
    isquickform character(1) COLLATE pg_catalog."default" DEFAULT 'N'::bpchar,
    CONSTRAINT ad_wlistboxcustomization_key PRIMARY KEY (ad_wlistboxcustomization_id),

    CONSTRAINT aduser_adwlistboxcustomization FOREIGN KEY (ad_user_id)
        REFERENCES adempiere.ad_user (ad_user_id) MATCH SIMPLE
        ON UPDATE NO ACTION
        ON DELETE CASCADE
        DEFERRABLE INITIALLY DEFERRED,
    CONSTRAINT ad_wlistboxcustomization_isquickform_check CHECK (isquickform = ANY (ARRAY['Y'::bpchar, 'N'::bpchar])),
    CONSTRAINT ad_wlistboxcustomization_isactive_check CHECK (isactive = ANY (ARRAY['Y'::bpchar, 'N'::bpchar]))
)
WITH (
    OIDS = FALSE
)
TABLESPACE pg_default;

ALTER TABLE adempiere.ad_wlistboxcustomization
    OWNER to adempiere;
-- Index: ad_info_customization_uu_idx

--DROP INDEX adempiere.ad_info_customization_uu_idx;

CREATE UNIQUE INDEX ad_wlistboxcustomization_uu_idx
    ON adempiere.ad_wlistboxcustomization USING btree
    (ad_wlistbox_customization_uu COLLATE pg_catalog."default" ASC NULLS LAST)
    TABLESPACE pg_default;