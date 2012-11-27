package fitnesse.client;

import java.io.BufferedReader;
import java.io.IOException;
import java.io.InputStreamReader;
import java.net.HttpURLConnection;
import java.net.MalformedURLException;
import java.net.ProtocolException;
import java.net.URL;

public abstract class ServletInvoker {
	static final String EXIT_CODE_PREFIX = "Exit Code = ";
	static final int ERROR = -1;
	protected String fitnesseHostAddress;
	protected int fitnessePort;
	protected String servletUrl;

	public ServletInvoker(String[] args) {
		args(args);
	}

	public void run() throws Exception {
		int returnCode = postUrlRequest();
		exit(returnCode);
	}

	protected abstract void args(String[] args);

	protected abstract String urlWithRequestParams();

	protected void exit(int statusCode) {
		System.exit(statusCode);
	}

	private int postUrlRequest() throws Exception {
		HttpURLConnection conn = createHttpConnection();
		conn.connect();
		int errorCode = readResults(conn);
		conn.disconnect();
		return errorCode;
	}

	int readResults(HttpURLConnection conn) throws IOException {
		BufferedReader reader = new BufferedReader(new InputStreamReader(conn.getInputStream()));
		int errorCode = returnCode(reader);
		reader.close();
		return errorCode;
	}

	HttpURLConnection createHttpConnection() throws MalformedURLException, IOException, ProtocolException {
		URL url = new URL(urlWithRequestParams());
		HttpURLConnection conn = (HttpURLConnection) url.openConnection();
		conn.setRequestMethod("GET");
		return conn;
	}

	int returnCode(BufferedReader reader) throws IOException {
		String line = null;
		while ((line = reader.readLine()) != null) {
			int index = line.indexOf(EXIT_CODE_PREFIX);
			if (index != -1) {
				return Integer.parseInt(line.substring(index + EXIT_CODE_PREFIX.length()));
			}
			System.out.println(line);
		}
		return ERROR;
	}
}
