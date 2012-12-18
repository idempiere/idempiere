package fitnesse.client;

import util.CommandLine;

public class FitServerServletInvoker extends ServletInvoker {
	private int socketToken;

	public FitServerServletInvoker(String[] args) {
		super(args);
	}

	public static void main(String[] args) throws Exception {
		new FitServerServletInvoker(args).run();
	}

	@Override
	protected void args(String[] argv) {
		CommandLine commandLine = new CommandLine("url host port socketToken");
		if (commandLine.parse(argv)) {
			servletUrl = commandLine.getArgument("url");
			String host = System.getProperty("FITNESSE_HOST");
			if (host == null || host.trim().length() == 0)
				fitnesseHostAddress = commandLine.getArgument("host");
			else
				fitnesseHostAddress = host;
			fitnessePort = Integer.parseInt(commandLine.getArgument("port"));
			socketToken = Integer.parseInt(commandLine.getArgument("socketToken"));
		} else {
			usage();
		}
	}

	@Override
	protected String urlWithRequestParams() {
		return servletUrl + "?host=" + fitnesseHostAddress + "&port=" + fitnessePort + "&socketToken=" + socketToken;
	}

	private void usage() {
		System.out.println("usage: java fitnesse.FitServerServletInvoker host port socketTicket");
		exit(-1);
	}
}
