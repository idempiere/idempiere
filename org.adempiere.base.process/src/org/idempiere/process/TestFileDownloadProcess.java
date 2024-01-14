package org.idempiere.process;

import java.math.BigDecimal;
import java.nio.file.Files;
import java.sql.Timestamp;
import java.time.Instant;

import org.compiere.process.ProcessInfoParameter;
import org.compiere.process.SvrProcess;

@org.adempiere.base.annotation.Process
public class TestFileDownloadProcess extends SvrProcess {

	boolean isError = false;
	boolean isHasLog = false;
	boolean isHasFile = false;
	
	@Override
	protected void prepare() {
		
		for (ProcessInfoParameter para : getParameter()) {
			if ("isError".equals(para.getParameterName()))
				isError = "Y".equals(para.getParameter());
			else if ("isHasLog".equals(para.getParameterName()))
				isHasLog = "Y".equals(para.getParameter());
			else if ("isHasFile".equals(para.getParameterName()))
				isHasFile = "Y".equals(para.getParameter());
		}

	}

	@Override
	protected String doIt() throws Exception {
		Timestamp now = Timestamp.from(Instant.now());
		addLog(getProcessInfo().getAD_Process_ID(), now, BigDecimal.valueOf(10), "1-this's log (always) go to with time", 0, 0);
		addLog(getProcessInfo().getAD_Process_ID(), now, BigDecimal.valueOf(10), "2-this's log (always) go to with time", 0, 0);
		
		if (isHasFile && processUI != null) {
			addDownloadFile(Files.createTempFile("1", null).toFile());
			addDownloadFile(Files.createTempFile("2", null).toFile());
			addDownloadFile(Files.createTempFile("3", null).toFile());
		}
		
		if (isHasLog) {
			addBufferLog(getProcessInfo().getAD_Process_ID(), now, BigDecimal.valueOf(10), "3-this's log (success only) go to with time", 0, 0);
			addBufferLog(getProcessInfo().getAD_Process_ID(), now, BigDecimal.valueOf(10), "4-this's log (success only) go to with link",  getTable_ID(), getRecord_ID());
		}
		
		if (isHasFile && processUI != null) {
			addDownloadFile(Files.createTempFile("4", null).toFile());
			addDownloadFile(Files.createTempFile("5", null).toFile());
			addDownloadFile(Files.createTempFile("6", null).toFile());
		}
		
		if (isHasLog) {
			addBufferLog(getProcessInfo().getAD_Process_ID(), now, BigDecimal.valueOf(10), "5-this's log (success only) go to with time", 0, 0);
			addBufferLog(getProcessInfo().getAD_Process_ID(), now, BigDecimal.valueOf(10), "6-this's log (success only) go to with link",  getTable_ID(), getRecord_ID());
		}
		
		
		if (isHasFile && processUI != null) {
			addDownloadFile(Files.createTempFile("7", null).toFile());
			addDownloadFile(Files.createTempFile("8", null).toFile());
			addDownloadFile(Files.createTempFile("9", null).toFile());
			addDownloadFile(Files.createTempFile("10", null).toFile());
			addDownloadFile(Files.createTempFile("11", null).toFile());
			addDownloadFile(Files.createTempFile("12", null).toFile());
		}
		
		if (isHasLog) {
			addBufferLog(getProcessInfo().getAD_Process_ID(), now, BigDecimal.valueOf(10), "7-this's log (success only) go to with time", 0, 0);
			addBufferLog(getProcessInfo().getAD_Process_ID(), now, BigDecimal.valueOf(10), "8-this's log (success only) go to with time", 0, 0);
			addBufferLog(getProcessInfo().getAD_Process_ID(), now, BigDecimal.valueOf(10), "9-this's log (success only) go to with time", 0, 0);
			addBufferLog(getProcessInfo().getAD_Process_ID(), now, BigDecimal.valueOf(10), "10-this's log (success only) go to with time", 0, 0);
			addBufferLog(getProcessInfo().getAD_Process_ID(), now, BigDecimal.valueOf(10), "11-this's log (success only) go to with time", 0, 0);
			addBufferLog(getProcessInfo().getAD_Process_ID(), now, BigDecimal.valueOf(10), "12-this's log (success only) go to with time", 0, 0);
			addBufferLog(getProcessInfo().getAD_Process_ID(), now, BigDecimal.valueOf(10), "13-this's log (success only) go to with time", 0, 0);
			addBufferLog(getProcessInfo().getAD_Process_ID(), now, BigDecimal.valueOf(10), "14-this's log (success only) go to with time", 0, 0);
			addBufferLog(getProcessInfo().getAD_Process_ID(), now, BigDecimal.valueOf(10), "15-this's log (success only) go to with time", 0, 0);
			addBufferLog(getProcessInfo().getAD_Process_ID(), now, BigDecimal.valueOf(10), "16-this's log (success only) go to with time", 0, 0);
			addBufferLog(getProcessInfo().getAD_Process_ID(), now, BigDecimal.valueOf(10), "17-this's log (success only) go to with time", 0, 0);
			addBufferLog(getProcessInfo().getAD_Process_ID(), now, BigDecimal.valueOf(10), "18-this's log (success only) go to with time", 0, 0);
		}
		
		if (isHasFile && processUI != null) {
			addDownloadFile(Files.createTempFile("13", null).toFile());
			addDownloadFile(Files.createTempFile("14", null).toFile());
			addDownloadFile(Files.createTempFile("15", null).toFile());
			addDownloadFile(Files.createTempFile("16", null).toFile());
			addDownloadFile(Files.createTempFile("17", null).toFile());
			addDownloadFile(Files.createTempFile("18", null).toFile());
		}
		
		if (isError) {
			addDownloadFile(Files.createTempFile("0", null).toFile(), false);
			return "@Error@";
		}
			
		
		return "OK";
	}

}
