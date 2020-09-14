package org.compiere.dbPort;

import java.util.ArrayList;

import org.compiere.util.CLogger;

public class Convert_Oracle extends Convert {

	/** Logger */
	private static final CLogger log = CLogger.getCLogger(Convert_Oracle.class);

	public Convert_Oracle() {}
	
	@Override
	protected ArrayList<String> convertStatement(String sqlStatement) {
		ArrayList<String> result = new ArrayList<String>();
		result.add(sqlStatement);
		if ("true".equals(System.getProperty("org.idempiere.db.debug"))) {
			String filterOrDebug = System.getProperty("org.idempiere.db.debug.filter");
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
