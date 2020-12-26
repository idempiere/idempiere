package org.idempiere.test.performance;

import java.text.DecimalFormat;
import java.text.SimpleDateFormat;

import org.adempiere.base.IDisplayTypeFactory;
import org.compiere.util.Language;

public class FakeDisplayTypeFactory implements IDisplayTypeFactory {

	public final static int DISPLAY_TYPE = 9876543;
	
	public FakeDisplayTypeFactory() {
	}

	@Override
	public boolean isID(int displayType) {
		return false;
	}

	@Override
	public boolean isNumeric(int displayType) {
		return false;
	}

	@Override
	public Integer getDefaultPrecision(int displayType) {
		return null;
	}

	@Override
	public boolean isText(int displayType) {
		if (displayType == DISPLAY_TYPE)
			return true;
		return false;
	}

	@Override
	public boolean isDate(int displayType) {
		return false;
	}
	
	@Override
	public boolean isList(int displayType) {
		return false;
	}

	@Override
	public boolean isLookup(int displayType) {
		return false;
	}

	@Override
	public boolean isLOB(int displayType) {
		return false;
	}

	@Override
	public DecimalFormat getNumberFormat(int displayType, Language language, String pattern) {
		return null;
	}

	@Override
	public SimpleDateFormat getDateFormat(int displayType, Language language, String pattern) {
		return null;
	}

	@Override
	public Class<?> getClass(int displayType, boolean yesNoAsBoolean) {
		return null;
	}

	@Override
	public String getSQLDataType(int displayType, String columnName, int fieldLength) {
		return null;
	}

	@Override
	public String getDescription(int displayType) {
		return null;
	}
}
