package org.compiere.dbPort;

import java.util.ArrayList;

import org.compiere.model.SystemProperties;
import org.compiere.util.CLogger;

public class Convert_Oracle extends Convert {

	/** Logger */
	private static final CLogger log = CLogger.getCLogger(Convert_Oracle.class);

	public Convert_Oracle() {}
	
	@Override
	protected ArrayList<String> convertStatement(String sqlStatement) {
		ArrayList<String> result = new ArrayList<String>();
		result.add(sqlStatement);
		if (SystemProperties.isDBDebug()) {
			String filterOrDebug = SystemProperties.getDBDebugFilter();
			boolean print = true;
			if (filterOrDebug != null)
				print = sqlStatement.matches(filterOrDebug);
			if (print)
				log.warning("Oracle -> " + sqlStatement);
		}
		return result;
	}

	@Override
	public boolean isOracle() {
		return true;
	}

}
