package fitnesse.client;

import util.CommandLine;

/**
 * This class will invoke the SlimServlet deployed on a web container.
 */
public class SlimServerServletInvoker extends ServletInvoker {

	private String servletUrl;
	private Integer fitnessePort;

	public SlimServerServletInvoker(String[] args) {
		super(args);
	}

	public static void main(String[] args) {
		try {
			new SlimServerServletInvoker(args).run();
		} catch (Exception e) {
			e.printStackTrace();
		}
	}

	/*
	 * (non-Javadoc)
	 * @see fitnesse.client.ServletInvoker#args(java.lang.String[])
	 */
	@Override
	protected void args(String[] argv) {
		CommandLine commandLine = new CommandLine("url port");
		if (commandLine.parse(argv)) {
			servletUrl = commandLine.getArgument("url");
			fitnessePort = Integer.parseInt(commandLine.getArgument("port"));
		} else {
			usage();
		}
	}

	/*
	 * (non-Javadoc)
	 * @see fitnesse.client.ServletInvoker#urlWithRequestParams()
	 */
	@Override
	protected String urlWithRequestParams() {
		String urlString = servletUrl + "?port=" + fitnessePort;
		System.out.println(String.format("url:%s", urlString));
		return urlString;
	}

	private void usage() {
		System.out
				.println("usage: java fitnesse.client.SlimServerServletInvoker port");

		exit(-1);
	}
}
