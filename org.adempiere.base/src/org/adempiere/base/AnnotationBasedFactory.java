/******************************************************************************
 * Product: iDempiere ERP & CRM Smart Business Solution                       *
 * This program is free software; you can redistribute it and/or modify it    *
 * under the terms version 2 of the GNU General Public License as published   *
 * by the Free Software Foundation. This program is distributed in the hope   *
 * that it will be useful, but WITHOUT ANY WARRANTY; without even the implied *
 * warranty of MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.           *
 * See the GNU General Public License for more details.                       *
 * You should have received a copy of the GNU General Public License along    *
 * with this program; if not, write to the Free Software Foundation, Inc.,    *
 * 59 Temple Place, Suite 330, Boston, MA 02111-1307 USA.                     *
 *****************************************************************************/
package org.adempiere.base;

import java.time.Duration;
import java.time.Instant;
import java.util.Properties;
import java.util.concurrent.CompletableFuture;
import java.util.concurrent.Executor;
import java.util.concurrent.ExecutorService;
import java.util.concurrent.Executors;
import java.util.concurrent.Future;
import java.util.concurrent.atomic.AtomicBoolean;

import org.compiere.Adempiere;
import org.compiere.util.CLogger;
import org.compiere.util.Ini;

import io.github.classgraph.ClassGraph.FailureHandler;

/**
 * Base class for factories that discover their classes by means of annotation scanning.
 * @author Saulo Gil
 */
public abstract class AnnotationBasedFactory {

	private boolean scanSuccessful;

	private final AtomicBoolean scanCompleted = new AtomicBoolean(false);

	/**
	 * Bogus {@link Future} used only to block the calling thread.
	 * @see #blockWhileScanning()
	 */
	private CompletableFuture<Void> threadBlockerFuture = new CompletableFuture<>();

	/**
	 * {@link Executor} to be used for asynchronous class scanning. It never gets shut down 
	 * since there's no way to tell when it wouldn't be needed anymore. However, footprint
	 * should be minimal when unused.
	 */
	private static final ExecutorService executorService = Executors.newCachedThreadPool();

	private final static CLogger s_log = CLogger.getCLogger(AnnotationBasedFactory.class);

	private final FailureHandler defaultScanFailureHandler = throwable -> {
		s_log.severe(throwable.getMessage());
		signalScanCompletion(false);
	};

	protected void signalScanCompletion(boolean succeeded) {
		scanSuccessful = succeeded;
		scanCompleted.set(true);
		try {
			threadBlockerFuture.complete(null);
		} catch (Exception e) { }
	}

	protected void blockWhileScanning() {
		String className = this.getClass().getSimpleName();
		if(!scanCompleted.get())
			try {
				Instant start = Instant.now();
				threadBlockerFuture.get();
				s_log.fine(() -> String.format("%s waited %d(ms) for class scanning to end"
						, className, Duration.between(start, Instant.now()).toMillis()));
			} catch (Exception e) {
				e.printStackTrace();
				throw new RuntimeException(e);
			}

		if(!scanSuccessful)
			throw new RuntimeException(className + " - annotation scan unsuccessful");
	}

	protected ExecutorService getExecutorService() {
		return executorService;
	}

	/**
	 * Suggests a maximum amount of threads to be allocated to annotation scanning
	 * for each individual factory.
	 * @return suggested maximum amount of threads
	 * @see #executorService
	 * @see Adempiere#getThreadPoolExecutor()
	 */
	protected int getMaxThreads() {
		int max = Runtime.getRuntime().availableProcessors() * 5;
		int defaultMax = max;
		Properties properties = Ini.getProperties();
		String maxSize = properties.getProperty("MaxThreadPoolSize");
		if (maxSize != null) {
			try {
				max = Integer.parseInt(maxSize) / 5;
			} catch (Exception e) {}
		}
		if (max <= 0)
			max = defaultMax;
		return max;
	}

	protected FailureHandler getScanFailureHandler() {
		return defaultScanFailureHandler;
	}

}