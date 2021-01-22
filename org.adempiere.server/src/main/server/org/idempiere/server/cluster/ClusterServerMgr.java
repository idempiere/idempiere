/**********************************************************************
* This file is part of iDempiere ERP Open Source                      *
* http://www.idempiere.org                                            *
*                                                                     *
* Copyright (C) Contributors                                          *
*                                                                     *
* This program is free software; you can redistribute it and/or       *
* modify it under the terms of the GNU General Public License         *
* as published by the Free Software Foundation; either version 2      *
* of the License, or (at your option) any later version.              *
*                                                                     *
* This program is distributed in the hope that it will be useful,     *
* but WITHOUT ANY WARRANTY; without even the implied warranty of      *
* MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE. See the        *
* GNU General Public License for more details.                        *
*                                                                     *
* You should have received a copy of the GNU General Public License   *
* along with this program; if not, write to the Free Software         *
* Foundation, Inc., 51 Franklin Street, Fifth Floor, Boston,          *
* MA 02110-1301, USA.                                                 *
*                                                                     *
* Contributors:                                                       *
* - Trek Global Corporation                                           *
* - Heng Sin Low                                                      *
**********************************************************************/
package org.idempiere.server.cluster;

import java.sql.Timestamp;
import java.util.ArrayList;
import java.util.Arrays;
import java.util.Collection;
import java.util.List;
import java.util.Map;
import java.util.Map.Entry;
import java.util.Set;
import java.util.concurrent.ExecutionException;
import java.util.concurrent.Future;

import org.adempiere.base.Core;
import org.compiere.Adempiere;
import org.compiere.model.MScheduler;
import org.compiere.server.IServerManager;
import org.compiere.server.ServerCount;
import org.compiere.server.ServerInstance;
import org.idempiere.distributed.IClusterMember;
import org.idempiere.distributed.IClusterService;
import org.idempiere.server.cluster.callable.AddSchedulerCallable;
import org.idempiere.server.cluster.callable.GetAllCallable;
import org.idempiere.server.cluster.callable.GetServerCallable;
import org.idempiere.server.cluster.callable.GetServerCountCallable;
import org.idempiere.server.cluster.callable.GetStartTimeCallable;
import org.idempiere.server.cluster.callable.ReloadCallable;
import org.idempiere.server.cluster.callable.RemoveSchedulerCallable;
import org.idempiere.server.cluster.callable.Response;
import org.idempiere.server.cluster.callable.RunNowCallable;
import org.idempiere.server.cluster.callable.StartAllCallable;
import org.idempiere.server.cluster.callable.StartCallable;
import org.idempiere.server.cluster.callable.StopAllCallable;
import org.idempiere.server.cluster.callable.StopCallable;

/**
 * 
 * @author hengsin
 *
 */
public class ClusterServerMgr implements IServerManager {

	private final static ClusterServerMgr INSTANCE = new ClusterServerMgr();
	
	/**
	 * 
	 * @return share instance
	 */
	public static ClusterServerMgr getInstance() {
		return INSTANCE;
	}
	
	private ClusterServerMgr() {
	}

	/**
	 * 
	 * @return cluster service
	 */
	public static IClusterService getClusterService() {
		return Core.getClusterService();
	}
	
	/**
	 * 
	 * @param nodeId
	 * @return cluster member node
	 */
	public static IClusterMember getClusterMember(String nodeId) {
		IClusterService service = getClusterService();
		if (service != null) {
			Collection<IClusterMember> members = service.getMembers();
			for(IClusterMember member : members) {
				if (member.getId().equals(nodeId))
					return member;
			}
		}
		return null;
	}
	
	@Override
	public ServerInstance getServerInstance(String serverId) {
		IClusterService service = getClusterService();
		if (service == null)
			return null;
		
		GetServerCallable callable = new GetServerCallable(serverId);
		Map<IClusterMember, Future<ServerInstance>> futureMap = service.execute(callable, service.getMembers());
		if (futureMap != null) {
			try {
				Set<Entry<IClusterMember, Future<ServerInstance>>> results = futureMap.entrySet();
				for(Entry<IClusterMember, Future<ServerInstance>> f : results) {
					ServerInstance i = f.getValue().get();
					if (i != null) {
						i.setClusterMember(f.getKey());
						return i;
					}
				}
			} catch (InterruptedException e) {
				throw new RuntimeException(e.getMessage(), e);
			} catch (ExecutionException e) {
				throw new RuntimeException(e.getMessage(), e);
			}
		}
		return null;
	}
	
	@Override
	public String runNow(String serverId) {
		IClusterService service = getClusterService();
		if (service == null)
			return "Cluster service not available";
		
		RunNowCallable callable = new RunNowCallable(serverId);
		Map<IClusterMember, Future<Response>> futureMap = service.execute(callable, service.getMembers());
		if (futureMap != null) {
			try {
				Collection<Future<Response>> results = futureMap.values();
				for(Future<Response> f : results) {
					Response response = f.get();
					if (response.getServerId() != null) {
						return response.getError();
					}
				}
			} catch (InterruptedException e) {
				throw new RuntimeException(e.getMessage(), e);
			} catch (ExecutionException e) {
				throw new RuntimeException(e.getMessage(), e);
			}
			return "Server " + serverId + " not found";
		}
		return null;
		
	}
	
	@Override
	public String start(String serverId) {
		IClusterService service = getClusterService();
		if (service == null)
			return "Cluster service not available";
		
		StartCallable callable = new StartCallable(serverId);
		Map<IClusterMember, Future<Response>> futureMap = service.execute(callable, service.getMembers());
		if (futureMap != null) {
			try {
				Collection<Future<Response>> results = futureMap.values();
				for(Future<Response> f : results) {
					Response response = f.get();
					if (response != null && response.getServerId() != null) {
						return response.getError();
					}
				}
			} catch (InterruptedException e) {
				throw new RuntimeException(e.getMessage(), e);
			} catch (ExecutionException e) {
				throw new RuntimeException(e.getMessage(), e);
			}
			return "Server " + serverId + " not found";
		} else {
			return "Failed to send start request through cluster service";
		}
	}
	
	@Override
	public String stop(String serverId) {
		IClusterService service = getClusterService();
		if (service == null)
			return "Cluster service not available";
		
		StopCallable callable = new StopCallable(serverId);
		Map<IClusterMember, Future<Response>> futureMap = service.execute(callable, service.getMembers());
		if (futureMap != null) {
			try {
				Collection<Future<Response>> results = futureMap.values();
				for(Future<Response> f : results) {
					Response response = f.get();
					if (response != null && response.getServerId() != null) {
						return response.getError();
					}
				}
			} catch (InterruptedException e) {
				throw new RuntimeException(e.getMessage(), e);
			} catch (ExecutionException e) {
				throw new RuntimeException(e.getMessage(), e);
			}
			return "Server " + serverId + " not found";
		} else {
			return "Failed to send stop request through cluster service";
		}
	}
	
	@Override
	public String reload() {
		IClusterService service = getClusterService();
		if (service == null)
			return "Cluster service not available";
		
		ReloadCallable callable = new ReloadCallable();
		Map<IClusterMember, Future<String>> futureMap = service.execute(callable, service.getMembers());
		if (futureMap != null) {
			try {
				Collection<Future<String>> results = futureMap.values();
				for(Future<String> f : results) {
					String response = f.get();
					if (response != null) {
						return response;
					}
				}
			} catch (InterruptedException e) {
				throw new RuntimeException(e.getMessage(), e);
			} catch (ExecutionException e) {
				throw new RuntimeException(e.getMessage(), e);
			}
			return null;
		} else {
			return "Failed to send reload request through cluster service";
		}
	}
	
	@Override
	public Timestamp getStartTime() {
		IClusterService service = getClusterService();
		if (service == null)
			return null;
		
		Timestamp earliest = null;
		GetStartTimeCallable callable = new GetStartTimeCallable();
		Map<IClusterMember, Future<Timestamp>> futureMap = service.execute(callable, service.getMembers());
		if (futureMap != null) {
			try {
				Collection<Future<Timestamp>> results = futureMap.values();
				for(Future<Timestamp> f : results) {
					Timestamp response = f.get();
					if (response != null) {
						if (earliest == null)
							earliest = response;
						else if (response.before(earliest))
							earliest = response;
					}
				}
			} catch (InterruptedException e) {
				throw new RuntimeException(e.getMessage(), e);
			} catch (ExecutionException e) {
				throw new RuntimeException(e.getMessage(), e);
			}
		}
		return earliest;
	}
	
	@Override
	public ServerCount getServerCount() {
		IClusterService service = getClusterService();
		if (service == null)
			return null;
		
		ServerCount serverCount = null;
		GetServerCountCallable callable = new GetServerCountCallable();
		Map<IClusterMember, Future<ServerCount>> futureMap = service.execute(callable, service.getMembers());
		if (futureMap != null) {
			try {
				Collection<Future<ServerCount>> results = futureMap.values();
				for(Future<ServerCount> f : results) {
					ServerCount response = f.get();
					if (response != null) {
						if (serverCount == null) {
							serverCount = response;
						} else {
							serverCount.addStarted(response.getStarted());
							serverCount.addStopped(response.getStopped());
						}
					}
				}
			} catch (InterruptedException e) {
				throw new RuntimeException(e.getMessage(), e);
			} catch (ExecutionException e) {
				throw new RuntimeException(e.getMessage(), e);
			}
		}
		return serverCount;
	}
	
	@Override
	public ServerInstance[] getServerInstances() {
		IClusterService service = getClusterService();
		if (service == null)
			return null;
		
		List<ServerInstance> servers = new ArrayList<>();
		GetAllCallable callable = new GetAllCallable();
		Map<IClusterMember, Future<ServerInstance[]>> futureMap = service.execute(callable, service.getMembers());
		if (futureMap != null) {
			try {
				Set<Entry<IClusterMember, Future<ServerInstance[]>>> results = futureMap.entrySet();
				for(Entry<IClusterMember, Future<ServerInstance[]>> f : results) {
					ServerInstance[] response = f.getValue().get();
					if (response != null) {
						Arrays.stream(response).forEach(e -> {
							e.setClusterMember(f.getKey());
							servers.add(e);
						});
					}
				}
			} catch (InterruptedException e) {
				throw new RuntimeException(e.getMessage(), e);
			} catch (ExecutionException e) {
				throw new RuntimeException(e.getMessage(), e);
			}
		}
		return servers.toArray(new ServerInstance[0]);
	}

	@Override
	public String getDescription() {
		return Adempiere.getVersion();
	}
	
	@Override
	public String startAll() {
		IClusterService service = getClusterService();
		if (service == null)
			return "Cluster service not available";
		
		StartAllCallable callable = new StartAllCallable();
		Map<IClusterMember, Future<String>> futureMap = service.execute(callable, service.getMembers());
		if (futureMap != null) {
			try {
				Collection<Future<String>> results = futureMap.values();
				for(Future<String> f : results) {
					String response = f.get();
					if (response != null) {
						return response;
					}
				}
			} catch (InterruptedException e) {
				throw new RuntimeException(e.getMessage(), e);
			} catch (ExecutionException e) {
				throw new RuntimeException(e.getMessage(), e);
			}
			return null;
		} else {
			return "Failed to send start all request through cluster servie";
		}
	}
	
	@Override
	public String stopAll() {
		IClusterService service = getClusterService();
		if (service == null)
			return "Cluster service not available";
		
		StopAllCallable callable = new StopAllCallable();
		Map<IClusterMember, Future<String>> futureMap = service.execute(callable, service.getMembers());
		if (futureMap != null) {
			try {
				Collection<Future<String>> results = futureMap.values();
				for(Future<String> f : results) {
					String response = f.get();
					if (response != null) {
						return response;
					}
				}
			} catch (InterruptedException e) {
				throw new RuntimeException(e.getMessage(), e);
			} catch (ExecutionException e) {
				throw new RuntimeException(e.getMessage(), e);
			}
			return null;
		} else {
			return "Failed to send stop all request through cluster servie";
		}
	}

	@Override
	public String addScheduler(MScheduler scheduler) {
		IClusterService service = getClusterService();
		if (service == null)
			return "Cluster service not available";
		
		AddSchedulerCallable callable = new AddSchedulerCallable(scheduler);
		Map<IClusterMember, Future<Response>> futureMap = service.execute(callable, service.getMembers());
		if (futureMap != null) {
			try {
				Collection<Future<Response>> results = futureMap.values();
				for(Future<Response> f : results) {
					Response response = f.get();
					if (response != null && response.getServerId() != null) {
						return response.getError();
					}
				}
			} catch (InterruptedException e) {
				throw new RuntimeException(e.getMessage(), e);
			} catch (ExecutionException e) {
				throw new RuntimeException(e.getMessage(), e);
			}
			return null;
		} else {
			return "Failed to send add scheduler request through cluster servie";
		}
	}
	
	@Override
	public String removeScheduler(MScheduler scheduler) {
		IClusterService service = getClusterService();
		if (service == null)
			return "Cluster service not available";
		
		RemoveSchedulerCallable callable = new RemoveSchedulerCallable(scheduler);
		Map<IClusterMember, Future<Response>> futureMap = service.execute(callable, service.getMembers());
		if (futureMap != null) {
			try {
				Collection<Future<Response>> results = futureMap.values();
				for(Future<Response> f : results) {
					Response response = f.get();
					if (response != null && response.getServerId() != null) {
						return response.getError();
					}
				}
			} catch (InterruptedException e) {
				throw new RuntimeException(e.getMessage(), e);
			} catch (ExecutionException e) {
				throw new RuntimeException(e.getMessage(), e);
			}
			return null;
		} else {
			return "Failed to send remove scheduler request through cluster servie";
		}
	}
}