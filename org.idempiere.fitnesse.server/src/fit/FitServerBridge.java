//Modified or written by Object Mentor, Inc. for inclusion with FitNesse.
//Copyright (c) 2002 Cunningham & Cunningham, Inc.
//Released under the terms of the GNU General Public License version 2 or later.
//Copyright (C) 2003,2004 by Robert C. Martin and Micah D. Martin. All rights reserved.
//Released under the terms of the GNU General Public License version 2 or later.
//This is the same as fit.FitServer except that newFixture() has been made protected.
//Altered by Rick Mugridge, December 2005, to allow changes in a subclass.
package fit;

import java.io.ByteArrayOutputStream;
import java.io.IOException;
import java.io.OutputStream;
import java.io.OutputStreamWriter;
import java.io.PrintStream;
import java.io.PrintWriter;
import java.net.Socket;

import org.apache.log4j.Logger;

import util.StreamReader;
import fit.exception.FitParseException;
import fitlibrary.log.FitLibraryLogger;
import fitlibrary.runResults.TestResults;
import fitlibrary.runResults.TestResultsOnCounts;
import fitlibrary.suite.ReportListener;
import fitlibrary.table.Table;
import fitlibrary.table.TableFactory;

/* This is a variation of FitServer that's needed to run FitLibrary
 */
public abstract class FitServerBridge {
	static Logger logger = FitLibraryLogger.getLogger(FitServerBridge.class);
	protected ReportListener reportListener = new TableReportListener();
	protected TestResults suiteTestResults = new TestResultsOnCounts();
	protected OutputStream socketOutput;
	protected StreamReader socketReader;
	@SuppressWarnings("unused")
	private boolean verbose = false;
	private String host;
	private int port;
	private int socketToken;
	private Socket socket;
	protected boolean exit = true;
	public static String FITNESSE_URL = "";

	public boolean isExit() {
		return exit;
	}

	private void setFitNesseUrl(String host, int port) {
		this.host = host;
		this.port = port;
		FITNESSE_URL = "http://" + host + ":" + port + "/";
	}

	public void run(String argv[]) throws Exception {
		try {
			args(argv);
			establishConnection();
			validateConnection();
			process();
			exit();
		} finally {
			if (socket != null)
				socket.close();			
		}
	}

	public void process() {
		logger.trace("Ready to received pages from FitNesse");
		try {
			while (true) {
				logger.trace("Reading page size...");
				int size = FitProtocol.readSize(socketReader);
				if (size == 0)
					break;
				logger.trace("Received page of size " + size + " from FitNesse");
				try {
					String document = FitProtocol.readDocument(socketReader,size);
					TestResults storyTestResults = doTables(document);
					logger.trace("Finished running page");
					suiteTestResults.add(storyTestResults);
				} catch (FitParseException e) {
					exception(e);
				}
			}
			logger.trace("No more pages to receive from FitNesse");
		} catch (Exception e) {
			exception(e);
		}
	}

	public abstract TestResults doTables(String html);

	public String readDocument() throws Exception {
		int size = FitProtocol.readSize(socketReader);
		return FitProtocol.readDocument(socketReader, size);
	}

	public void args(String[] argv) {
		printArgs(argv);
		int i = gatherOptions(argv);
		String hostName = argv[i++];
		int portNo = Integer.parseInt(argv[i++]);
		setFitNesseUrl(hostName, portNo);
		socketToken = Integer.parseInt(argv[i++]);
	}

	private int gatherOptions(String[] argv) {
		int i = 0;
		while (argv[i].startsWith("-")) {
			String arg = argv[i];
			if ("-v".equals(arg))
				verbose = true;
			else if ("-x".equals(arg))
				exit = false;
			else
				usage();
			i++;
		}
		return i;
	}

	private void printArgs(String[] argv) {
		logger.trace("Arguments: "+mkString(argv," "));
	}

	public static String mkString(Object[] array, String separator) {
		StringBuilder s = new StringBuilder();
		boolean first = true;
		for (Object a: array) {
			if (first)
				first = false;
			else
				s.append(separator);
			s.append(a.toString());
		}
		return s.toString();
	}

	protected void usage() {
		System.out.println("usage: java fit.FitServer [-v] host port socketTicket");
		System.out.println("\t-v\tverbose");
	}

	protected void exception(Exception e) {
		printExceptionDetails(e);
		Table table = TableFactory.table(TableFactory.row("Exception occurred: "));
		table.at(0).at(0).error(suiteTestResults, e);
		reportListener.tableFinished(table);
		reportListener.tablesFinished(suiteTestResults);
	}

	public void printExceptionDetails(Exception e) {
		logger.trace(("Exception: " + e.getMessage()));
		ByteArrayOutputStream out = new ByteArrayOutputStream();
		e.printStackTrace(new PrintStream(out));
		logger.trace((out.toString() + "\n"));
	}

	public void exit() throws Exception {
		logger.trace(("End results: " + suiteTestResults.getCounts().toString()));
	}

	public int exitCode() {
		return suiteTestResults.getCounts().wrong
				+ suiteTestResults.getCounts().exceptions;
	}

	public void establishConnection() throws Exception {
		establishConnection(makeHttpRequest());
	}

	public void establishConnection(String httpRequest) throws Exception {
		logger.trace(("Connecting to FitNesse on " + host + " : " + port));
		socket = new Socket(host, port);
		logger.trace("Socket is connected");
		socketOutput = socket.getOutputStream();
		socketReader = new StreamReader(socket.getInputStream());
		byte[] bytes = httpRequest.getBytes("UTF-8");
		socketOutput.write(bytes);
		socketOutput.flush();
		logger.trace("Http request sent to FitNesse");
	}

	private String makeHttpRequest() {
		return "GET /?responder=socketCatcher&ticket=" + socketToken
				+ " HTTP/1.1\r\n\r\n";
	}

	public void validateConnection() throws Exception {
		int statusSize = FitProtocol.readSize(socketReader);
		if (statusSize == 0)
			logger.trace("Connection to FitNesse is ok");
		else {
			String errorMessage = FitProtocol.readDocument(socketReader,
					statusSize);
			logger.trace(("Connection to FitNesse failed because: " + errorMessage + "\n"));
			throw new RuntimeException("An error occured while connecting to FitNesse. " + errorMessage != null ? errorMessage : "");
		}
	}

	public static byte[] readTable(Parse table) throws Exception {
		ByteArrayOutputStream byteBuffer = new ByteArrayOutputStream();
		OutputStreamWriter streamWriter = new OutputStreamWriter(byteBuffer,"UTF-8");
		PrintWriter writer = new PrintWriter(streamWriter);
		Parse more = table.more;
		table.more = null;
		if (table.trailer == null)
			table.trailer = "";
		table.print(writer);
		table.more = more;
		writer.close();
		return byteBuffer.toByteArray();
	}

	public static byte[] readTable(Table table) throws Exception {
		StringBuilder builder = new StringBuilder();
		table.toHtml(builder);
		return builder.toString().getBytes("UTF-8");
	}

	public void sendTableReport(Table table) {
		logger.trace("Sending table report to FitNesse");
		try {
			byte[] bytes = readTable(table);
			if (bytes.length > 0)
				FitProtocol.writeData(bytes, socketOutput);
		} catch (Exception e) {
			e.printStackTrace();
		}
	}

	public void sendTestResults(TestResults testResults) {
		logger.trace("Sending results to FitNesse: "+testResults);
		try {
			FitProtocol.writeCounts(testResults.getCounts(), socketOutput);
		} catch (IOException e) {
			e.printStackTrace();
		}
	}

	class TableReportListener implements ReportListener {
		@Override
		public void tableFinished(Table table) {
			sendTableReport(table);
		}

		@Override
		public void tablesFinished(TestResults testResults) {
			sendTestResults(testResults);
		}
	}

	public static void setFitNesseUrl(String url) {
		// Nasty hack but (indirectly) unavoidable while SpecifyFixture is a
		// Fixture instead of a Traverse
		// See use of the global in BatchFitLibrary
		FITNESSE_URL = url;
	}
}
