-- IDEMPIERE-6567
SELECT register_migration_script('202610011502_IDEMPIERE-6567.sql') FROM dual;

-- ============================================================
-- Latitude - AD_Element
-- ============================================================

DO $$
DECLARE
	v_old_id NUMERIC;
BEGIN
	SELECT AD_Element_ID
	INTO v_old_id
	FROM AD_Element
	WHERE ColumnName = 'Latitude'
	LIMIT 1;

	IF v_old_id IS NULL THEN

		INSERT INTO AD_Element (
			AD_Element_ID, AD_Client_ID, AD_Org_ID, IsActive,
			Created, CreatedBy, Updated, UpdatedBy,
			ColumnName, Name, PrintName, EntityType, AD_Element_UU
		)
		VALUES (
			204127, 0, 0, 'Y',
			TO_TIMESTAMP('2026-10-01 15:02:18','YYYY-MM-DD HH24:MI:SS'), 10,
			TO_TIMESTAMP('2026-10-01 15:02:18','YYYY-MM-DD HH24:MI:SS'), 10,
			'Latitude', 'Latitude', 'Latitude', 'D',
			'f24485a4-e6b6-4fe1-8cba-ffaf7a030c3c'
		);

	ELSIF v_old_id = 204127 THEN

		UPDATE AD_Element
		SET
			AD_Client_ID = 0,
			AD_Org_ID = 0,
			IsActive = 'Y',
			Updated = TO_TIMESTAMP('2026-10-01 15:02:18','YYYY-MM-DD HH24:MI:SS'),
			UpdatedBy = 10,
			ColumnName = 'Latitude',
			Name = 'Latitude',
			PrintName = 'Latitude',
			EntityType = 'D',
			AD_Element_UU = 'f24485a4-e6b6-4fe1-8cba-ffaf7a030c3c'
		WHERE AD_Element_ID = 204127;

	ELSE

		DELETE FROM AD_Element_Trl
		WHERE AD_Element_ID = v_old_id;

		UPDATE AD_Column
		SET AD_Element_ID = 204127
		WHERE AD_Element_ID = v_old_id;

		DELETE FROM AD_Element
		WHERE AD_Element_ID = v_old_id;

		INSERT INTO AD_Element (
			AD_Element_ID, AD_Client_ID, AD_Org_ID, IsActive,
			Created, CreatedBy, Updated, UpdatedBy,
			ColumnName, Name, PrintName, EntityType, AD_Element_UU
		)
		VALUES (
			204127, 0, 0, 'Y',
			TO_TIMESTAMP('2026-10-01 15:02:18','YYYY-MM-DD HH24:MI:SS'), 10,
			TO_TIMESTAMP('2026-10-01 15:02:18','YYYY-MM-DD HH24:MI:SS'), 10,
			'Latitude', 'Latitude', 'Latitude', 'D',
			'f24485a4-e6b6-4fe1-8cba-ffaf7a030c3c'
		);

	END IF;
END
$$;


-- ============================================================
-- Latitude - AD_Column
-- ============================================================

DO $$
DECLARE
	v_old_id NUMERIC;
BEGIN
	SELECT AD_Column_ID
	INTO v_old_id
	FROM AD_Column
	WHERE AD_Table_ID = 162
	  AND ColumnName = 'Latitude'
	LIMIT 1;

	IF v_old_id IS NULL THEN

		INSERT INTO AD_Column (
			AD_Column_ID, Version, Name, AD_Table_ID, ColumnName,
			FieldLength, IsKey, IsParent, IsMandatory, IsTranslated,
			IsIdentifier, SeqNo, IsEncrypted, AD_Reference_ID,
			AD_Client_ID, AD_Org_ID, IsActive,
			Created, CreatedBy, Updated, UpdatedBy,
			AD_Element_ID, IsUpdateable, IsSelectionColumn,
			EntityType, IsSyncDatabase, IsAlwaysUpdateable,
			IsAutocomplete, IsAllowLogging, AD_Column_UU,
			IsAllowCopy, SeqNoSelection, IsToolbarButton,
			IsSecure, FKConstraintType
		)
		VALUES (
			217661, 0, 'Latitude', 162, 'Latitude',
			30, 'N', 'N', 'N', 'N',
			'N', 0, 'N', 10,
			0, 0, 'Y',
			TO_TIMESTAMP('2026-10-01 15:02:19','YYYY-MM-DD HH24:MI:SS'), 10,
			TO_TIMESTAMP('2026-10-01 15:02:19','YYYY-MM-DD HH24:MI:SS'), 10,
			204127, 'Y', 'N',
			'D', 'Y', 'N',
			'N', 'Y', '815f0fe4-d276-440c-bf5b-c697e6016de7',
			'Y', 0, 'N',
			'N', 'N'
		);

	ELSIF v_old_id = 217661 THEN

		UPDATE AD_Column
		SET
			Version = 0,
			Name = 'Latitude',
			FieldLength = 30,
			IsKey = 'N',
			IsParent = 'N',
			IsMandatory = 'N',
			IsTranslated = 'N',
			IsIdentifier = 'N',
			SeqNo = 0,
			IsEncrypted = 'N',
			AD_Reference_ID = 10,
			AD_Client_ID = 0,
			AD_Org_ID = 0,
			IsActive = 'Y',
			Updated = TO_TIMESTAMP('2026-10-01 15:02:19','YYYY-MM-DD HH24:MI:SS'),
			UpdatedBy = 10,
			AD_Element_ID = 204127,
			IsUpdateable = 'Y',
			IsSelectionColumn = 'N',
			EntityType = 'D',
			IsSyncDatabase = 'Y',
			IsAlwaysUpdateable = 'N',
			IsAutocomplete = 'N',
			IsAllowLogging = 'Y',
			AD_Column_UU = '815f0fe4-d276-440c-bf5b-c697e6016de7',
			IsAllowCopy = 'Y',
			SeqNoSelection = 0,
			IsToolbarButton = 'N',
			IsSecure = 'N',
			FKConstraintType = 'N'
		WHERE AD_Column_ID = 217661;

	ELSE

		DELETE FROM AD_Column_Trl
		WHERE AD_Column_ID = v_old_id;

		UPDATE AD_Field
		SET AD_Column_ID = 217661
		WHERE AD_Column_ID = v_old_id;

		DELETE FROM AD_Column
		WHERE AD_Column_ID = v_old_id;

		INSERT INTO AD_Column (
			AD_Column_ID, Version, Name, AD_Table_ID, ColumnName,
			FieldLength, IsKey, IsParent, IsMandatory, IsTranslated,
			IsIdentifier, SeqNo, IsEncrypted, AD_Reference_ID,
			AD_Client_ID, AD_Org_ID, IsActive,
			Created, CreatedBy, Updated, UpdatedBy,
			AD_Element_ID, IsUpdateable, IsSelectionColumn,
			EntityType, IsSyncDatabase, IsAlwaysUpdateable,
			IsAutocomplete, IsAllowLogging, AD_Column_UU,
			IsAllowCopy, SeqNoSelection, IsToolbarButton,
			IsSecure, FKConstraintType
		)
		VALUES (
			217661, 0, 'Latitude', 162, 'Latitude',
			30, 'N', 'N', 'N', 'N',
			'N', 0, 'N', 10,
			0, 0, 'Y',
			TO_TIMESTAMP('2026-10-01 15:02:19','YYYY-MM-DD HH24:MI:SS'), 10,
			TO_TIMESTAMP('2026-10-01 15:02:19','YYYY-MM-DD HH24:MI:SS'), 10,
			204127, 'Y', 'N',
			'D', 'Y', 'N',
			'N', 'Y', '815f0fe4-d276-440c-bf5b-c697e6016de7',
			'Y', 0, 'N',
			'N', 'N'
		);

	END IF;
END
$$;


-- ============================================================
-- Latitude - physical column C_Location
-- ============================================================

DO $$
BEGIN
	IF NOT EXISTS (
		SELECT 1
		FROM information_schema.columns
		WHERE table_schema = current_schema()
		  AND table_name = 'c_location'
		  AND column_name = 'latitude'
	) THEN

		ALTER TABLE C_Location
			ADD COLUMN Latitude VARCHAR(30) DEFAULT NULL;

	END IF;
END
$$;


-- ============================================================
-- Latitude - AD_Column
-- Realign all columns using the official AD_Element
-- ============================================================

UPDATE AD_Column
SET AD_Element_ID = 204127
WHERE AD_Table_ID = 162
  AND ColumnName = 'Latitude'
  AND AD_Column_ID <> 217661;


-- ============================================================
-- Latitude - AD_Field
-- ============================================================

DO $$
DECLARE
	v_old_id NUMERIC;
BEGIN
	SELECT AD_Field_ID
	INTO v_old_id
	FROM AD_Field
	WHERE AD_Tab_ID = 154
	  AND Name = 'Latitude'
	LIMIT 1;

	IF v_old_id IS NULL THEN

		INSERT INTO AD_Field (
			AD_Field_ID, Name, AD_Tab_ID, AD_Column_ID,
			IsDisplayed, DisplayLength, SeqNo, IsSameLine,
			IsHeading, IsFieldOnly, IsEncrypted,
			AD_Client_ID, AD_Org_ID, IsActive,
			Created, CreatedBy, Updated, UpdatedBy,
			IsReadOnly, IsCentrallyMaintained, EntityType,
			AD_Field_UU, IsDisplayedGrid, SeqNoGrid,
			XPosition, ColumnSpan, NumLines,
			IsQuickEntry, IsDefaultFocus, IsAdvancedField
		)
		VALUES (
			209246, 'Latitude', 154, 217661,
			'Y', 10, 190, 'N',
			'N', 'N', 'N',
			0, 0, 'Y',
			TO_TIMESTAMP('2026-10-01 15:02:20','YYYY-MM-DD HH24:MI:SS'), 10,
			TO_TIMESTAMP('2026-10-01 15:02:20','YYYY-MM-DD HH24:MI:SS'), 10,
			'N', 'Y', 'D',
			'33c35ac4-0802-4540-82e0-68899214f9c2',
			'Y', 190, 1, 2, 1,
			'N', 'N', 'N'
		);

	ELSIF v_old_id = 209246 THEN

		UPDATE AD_Field
		SET
			Name = 'Latitude',
			AD_Column_ID = 217661,
			IsDisplayed = 'Y',
			DisplayLength = 10,
			SeqNo = 190,
			IsSameLine = 'N',
			IsHeading = 'N',
			IsFieldOnly = 'N',
			IsEncrypted = 'N',
			AD_Client_ID = 0,
			AD_Org_ID = 0,
			IsActive = 'Y',
			Updated = TO_TIMESTAMP('2026-10-01 15:02:20','YYYY-MM-DD HH24:MI:SS'),
			UpdatedBy = 10,
			IsReadOnly = 'N',
			IsCentrallyMaintained = 'Y',
			EntityType = 'D',
			AD_Field_UU = '33c35ac4-0802-4540-82e0-68899214f9c2',
			IsDisplayedGrid = 'Y',
			SeqNoGrid = 190,
			XPosition = 1,
			ColumnSpan = 2,
			NumLines = 1,
			IsQuickEntry = 'N',
			IsDefaultFocus = 'N',
			IsAdvancedField = 'N'
		WHERE AD_Field_ID = 209246;

	ELSE

		DELETE FROM AD_Field_Trl
		WHERE AD_Field_ID = v_old_id;

		DELETE FROM AD_Field
		WHERE AD_Field_ID = v_old_id;

		INSERT INTO AD_Field (
			AD_Field_ID, Name, AD_Tab_ID, AD_Column_ID,
			IsDisplayed, DisplayLength, SeqNo, IsSameLine,
			IsHeading, IsFieldOnly, IsEncrypted,
			AD_Client_ID, AD_Org_ID, IsActive,
			Created, CreatedBy, Updated, UpdatedBy,
			IsReadOnly, IsCentrallyMaintained, EntityType,
			AD_Field_UU, IsDisplayedGrid, SeqNoGrid,
			XPosition, ColumnSpan, NumLines,
			IsQuickEntry, IsDefaultFocus, IsAdvancedField
		)
		VALUES (
			209246, 'Latitude', 154, 217661,
			'Y', 10, 190, 'N',
			'N', 'N', 'N',
			0, 0, 'Y',
			TO_TIMESTAMP('2026-10-01 15:02:20','YYYY-MM-DD HH24:MI:SS'), 10,
			TO_TIMESTAMP('2026-10-01 15:02:20','YYYY-MM-DD HH24:MI:SS'), 10,
			'N', 'Y', 'D',
			'33c35ac4-0802-4540-82e0-68899214f9c2',
			'Y', 190, 1, 2, 1,
			'N', 'N', 'N'
		);

	END IF;
END
$$;


-- ============================================================
-- Latitude - AD_Field
-- Realign all fields using the official AD_Column
-- ============================================================

UPDATE AD_Field
SET AD_Column_ID = 217661
WHERE AD_Column_ID IN (
	SELECT AD_Column_ID
	FROM AD_Column
	WHERE AD_Table_ID = 162
	  AND ColumnName = 'Latitude'
)
AND AD_Field_ID <> 209246;


-- ============================================================
-- Longitude - AD_Element
-- ============================================================

DO $$
DECLARE
	v_old_id NUMERIC;
BEGIN
	SELECT AD_Element_ID
	INTO v_old_id
	FROM AD_Element
	WHERE ColumnName = 'Longitude'
	LIMIT 1;

	IF v_old_id IS NULL THEN

		INSERT INTO AD_Element (
			AD_Element_ID, AD_Client_ID, AD_Org_ID, IsActive,
			Created, CreatedBy, Updated, UpdatedBy,
			ColumnName, Name, PrintName, EntityType, AD_Element_UU
		)
		VALUES (
			204128, 0, 0, 'Y',
			TO_TIMESTAMP('2026-10-01 15:02:19','YYYY-MM-DD HH24:MI:SS'), 10,
			TO_TIMESTAMP('2026-10-01 15:02:19','YYYY-MM-DD HH24:MI:SS'), 10,
			'Longitude', 'Longitude', 'Longitude', 'D',
			'cebfcd7f-48e3-41a4-b9dc-b2e2262396dd'
		);

	ELSIF v_old_id = 204128 THEN

		UPDATE AD_Element
		SET
			AD_Client_ID = 0,
			AD_Org_ID = 0,
			IsActive = 'Y',
			Updated = TO_TIMESTAMP('2026-10-01 15:02:19','YYYY-MM-DD HH24:MI:SS'),
			UpdatedBy = 10,
			ColumnName = 'Longitude',
			Name = 'Longitude',
			PrintName = 'Longitude',
			EntityType = 'D',
			AD_Element_UU = 'cebfcd7f-48e3-41a4-b9dc-b2e2262396dd'
		WHERE AD_Element_ID = 204128;

	ELSE

		DELETE FROM AD_Element_Trl
		WHERE AD_Element_ID = v_old_id;

		UPDATE AD_Column
		SET AD_Element_ID = 204128
		WHERE AD_Element_ID = v_old_id;

		DELETE FROM AD_Element
		WHERE AD_Element_ID = v_old_id;

		INSERT INTO AD_Element (
			AD_Element_ID, AD_Client_ID, AD_Org_ID, IsActive,
			Created, CreatedBy, Updated, UpdatedBy,
			ColumnName, Name, PrintName, EntityType, AD_Element_UU
		)
		VALUES (
			204128, 0, 0, 'Y',
			TO_TIMESTAMP('2026-10-01 15:02:19','YYYY-MM-DD HH24:MI:SS'), 10,
			TO_TIMESTAMP('2026-10-01 15:02:19','YYYY-MM-DD HH24:MI:SS'), 10,
			'Longitude', 'Longitude', 'Longitude', 'D',
			'cebfcd7f-48e3-41a4-b9dc-b2e2262396dd'
		);

	END IF;
END
$$;


-- ============================================================
-- Longitude - AD_Column
-- ============================================================

DO $$
DECLARE
	v_old_id NUMERIC;
BEGIN
	SELECT AD_Column_ID
	INTO v_old_id
	FROM AD_Column
	WHERE AD_Table_ID = 162
	  AND ColumnName = 'Longitude'
	LIMIT 1;

	IF v_old_id IS NULL THEN

		INSERT INTO AD_Column (
			AD_Column_ID, Version, Name, AD_Table_ID, ColumnName,
			FieldLength, IsKey, IsParent, IsMandatory, IsTranslated,
			IsIdentifier, SeqNo, IsEncrypted, AD_Reference_ID,
			AD_Client_ID, AD_Org_ID, IsActive,
			Created, CreatedBy, Updated, UpdatedBy,
			AD_Element_ID, IsUpdateable, IsSelectionColumn,
			EntityType, IsSyncDatabase, IsAlwaysUpdateable,
			IsAutocomplete, IsAllowLogging, AD_Column_UU,
			IsAllowCopy, SeqNoSelection, IsToolbarButton,
			IsSecure, FKConstraintType
		)
		VALUES (
			217662, 0, 'Longitude', 162, 'Longitude',
			30, 'N', 'N', 'N', 'N',
			'N', 0, 'N', 10,
			0, 0, 'Y',
			TO_TIMESTAMP('2026-10-01 15:02:19','YYYY-MM-DD HH24:MI:SS'), 10,
			TO_TIMESTAMP('2026-10-01 15:02:20','YYYY-MM-DD HH24:MI:SS'), 10,
			204128, 'Y', 'N',
			'D', 'Y', 'N',
			'N', 'Y', 'a8759c8a-a132-4e61-9d1d-25f222f463d0',
			'Y', 0, 'N',
			'N', 'N'
		);

	ELSIF v_old_id = 217662 THEN

		UPDATE AD_Column
		SET
			Version = 0,
			Name = 'Longitude',
			FieldLength = 30,
			IsKey = 'N',
			IsParent = 'N',
			IsMandatory = 'N',
			IsTranslated = 'N',
			IsIdentifier = 'N',
			SeqNo = 0,
			IsEncrypted = 'N',
			AD_Reference_ID = 10,
			AD_Client_ID = 0,
			AD_Org_ID = 0,
			IsActive = 'Y',
			Updated = TO_TIMESTAMP('2026-10-01 15:02:19','YYYY-MM-DD HH24:MI:SS'),
			UpdatedBy = 10,
			AD_Element_ID = 204128,
			IsUpdateable = 'Y',
			IsSelectionColumn = 'N',
			EntityType = 'D',
			IsSyncDatabase = 'Y',
			IsAlwaysUpdateable = 'N',
			IsAutocomplete = 'N',
			IsAllowLogging = 'Y',
			AD_Column_UU = 'a8759c8a-a132-4e61-9d1d-25f222f463d0',
			IsAllowCopy = 'Y',
			SeqNoSelection = 0,
			IsToolbarButton = 'N',
			IsSecure = 'N',
			FKConstraintType = 'N'
		WHERE AD_Column_ID = 217662;

	ELSE

		DELETE FROM AD_Column_Trl
		WHERE AD_Column_ID = v_old_id;

		UPDATE AD_Field
		SET AD_Column_ID = 217662
		WHERE AD_Column_ID = v_old_id;

		DELETE FROM AD_Column
		WHERE AD_Column_ID = v_old_id;

		INSERT INTO AD_Column (
			AD_Column_ID, Version, Name, AD_Table_ID, ColumnName,
			FieldLength, IsKey, IsParent, IsMandatory, IsTranslated,
			IsIdentifier, SeqNo, IsEncrypted, AD_Reference_ID,
			AD_Client_ID, AD_Org_ID, IsActive,
			Created, CreatedBy, Updated, UpdatedBy,
			AD_Element_ID, IsUpdateable, IsSelectionColumn,
			EntityType, IsSyncDatabase, IsAlwaysUpdateable,
			IsAutocomplete, IsAllowLogging, AD_Column_UU,
			IsAllowCopy, SeqNoSelection, IsToolbarButton,
			IsSecure, FKConstraintType
		)
		VALUES (
			217662, 0, 'Longitude', 162, 'Longitude',
			30, 'N', 'N', 'N', 'N',
			'N', 0, 'N', 10,
			0, 0, 'Y',
			TO_TIMESTAMP('2026-10-01 15:02:19','YYYY-MM-DD HH24:MI:SS'), 10,
			TO_TIMESTAMP('2026-10-01 15:02:20','YYYY-MM-DD HH24:MI:SS'), 10,
			204128, 'Y', 'N',
			'D', 'Y', 'N',
			'N', 'Y', 'a8759c8a-a132-4e61-9d1d-25f222f463d0',
			'Y', 0, 'N',
			'N', 'N'
		);

	END IF;
END
$$;


-- ============================================================
-- Longitude - physical column C_Location
-- ============================================================

DO $$
BEGIN
	IF NOT EXISTS (
		SELECT 1
		FROM information_schema.columns
		WHERE table_schema = current_schema()
		  AND table_name = 'c_location'
		  AND column_name = 'longitude'
	) THEN

		ALTER TABLE C_Location
			ADD COLUMN Longitude VARCHAR(30) DEFAULT NULL;

	END IF;
END
$$;


-- ============================================================
-- Longitude - AD_Column
-- Realign all columns using the official AD_Element
-- ============================================================

UPDATE AD_Column
SET AD_Element_ID = 204128
WHERE AD_Table_ID = 162
  AND ColumnName = 'Longitude'
  AND AD_Column_ID <> 217662;


-- ============================================================
-- Longitude - AD_Field
-- ============================================================

DO $$
DECLARE
	v_old_id NUMERIC;
BEGIN
	SELECT AD_Field_ID
	INTO v_old_id
	FROM AD_Field
	WHERE AD_Tab_ID = 154
	  AND Name = 'Longitude'
	LIMIT 1;

	IF v_old_id IS NULL THEN

		INSERT INTO AD_Field (
			AD_Field_ID, Name, AD_Tab_ID, AD_Column_ID,
			IsDisplayed, DisplayLength, SeqNo, IsSameLine,
			IsHeading, IsFieldOnly, IsEncrypted,
			AD_Client_ID, AD_Org_ID, IsActive,
			Created, CreatedBy, Updated, UpdatedBy,
			IsReadOnly, IsCentrallyMaintained, EntityType,
			AD_Field_UU, IsDisplayedGrid, SeqNoGrid,
			XPosition, ColumnSpan, NumLines,
			IsQuickEntry, IsDefaultFocus, IsAdvancedField
		)
		VALUES (
			209247, 'Longitude', 154, 217662,
			'Y', 10, 200, 'Y',
			'N', 'N', 'N',
			0, 0, 'Y',
			TO_TIMESTAMP('2026-10-01 15:02:20','YYYY-MM-DD HH24:MI:SS'), 10,
			TO_TIMESTAMP('2026-10-01 15:02:20','YYYY-MM-DD HH24:MI:SS'), 10,
			'N', 'Y', 'D',
			'8e2881ff-bf8b-49d8-9058-10a99d229a9b',
			'Y', 200, 4, 2, 1,
			'N', 'N', 'N'
		);

	ELSIF v_old_id = 209247 THEN

		UPDATE AD_Field
		SET
			Name = 'Longitude',
			AD_Column_ID = 217662,
			IsDisplayed = 'Y',
			DisplayLength = 10,
			SeqNo = 200,
			IsSameLine = 'Y',
			IsHeading = 'N',
			IsFieldOnly = 'N',
			IsEncrypted = 'N',
			AD_Client_ID = 0,
			AD_Org_ID = 0,
			IsActive = 'Y',
			Updated = TO_TIMESTAMP('2026-10-01 15:02:20','YYYY-MM-DD HH24:MI:SS'),
			UpdatedBy = 10,
			IsReadOnly = 'N',
			IsCentrallyMaintained = 'Y',
			EntityType = 'D',
			AD_Field_UU = '8e2881ff-bf8b-49d8-9058-10a99d229a9b',
			IsDisplayedGrid = 'Y',
			SeqNoGrid = 200,
			XPosition = 4,
			ColumnSpan = 2,
			NumLines = 1,
			IsQuickEntry = 'N',
			IsDefaultFocus = 'N',
			IsAdvancedField = 'N'
		WHERE AD_Field_ID = 209247;

	ELSE

		DELETE FROM AD_Field_Trl
		WHERE AD_Field_ID = v_old_id;

		DELETE FROM AD_Field
		WHERE AD_Field_ID = v_old_id;

		INSERT INTO AD_Field (
			AD_Field_ID, Name, AD_Tab_ID, AD_Column_ID,
			IsDisplayed, DisplayLength, SeqNo, IsSameLine,
			IsHeading, IsFieldOnly, IsEncrypted,
			AD_Client_ID, AD_Org_ID, IsActive,
			Created, CreatedBy, Updated, UpdatedBy,
			IsReadOnly, IsCentrallyMaintained, EntityType,
			AD_Field_UU, IsDisplayedGrid, SeqNoGrid,
			XPosition, ColumnSpan, NumLines,
			IsQuickEntry, IsDefaultFocus, IsAdvancedField
		)
		VALUES (
			209247, 'Longitude', 154, 217662,
			'Y', 10, 200, 'Y',
			'N', 'N', 'N',
			0, 0, 'Y',
			TO_TIMESTAMP('2026-10-01 15:02:20','YYYY-MM-DD HH24:MI:SS'), 10,
			TO_TIMESTAMP('2026-10-01 15:02:20','YYYY-MM-DD HH24:MI:SS'), 10,
			'N', 'Y', 'D',
			'8e2881ff-bf8b-49d8-9058-10a99d229a9b',
			'Y', 200, 4, 2, 1,
			'N', 'N', 'N'
		);

	END IF;
END
$$;


-- ============================================================
-- Longitude - AD_Field
-- Realign all fields using the official AD_Column
-- ============================================================

UPDATE AD_Field
SET AD_Column_ID = 217662
WHERE AD_Column_ID IN (
	SELECT AD_Column_ID
	FROM AD_Column
	WHERE AD_Table_ID = 162
	  AND ColumnName = 'Longitude'
)
AND AD_Field_ID <> 209247;