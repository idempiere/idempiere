package org.idempiere.hazelcast.service;

import java.util.Collection;
import java.util.Set;

import org.eclipse.osgi.framework.console.CommandInterpreter;
import org.eclipse.osgi.framework.console.CommandProvider;

import com.hazelcast.collection.impl.set.SetService;
import com.hazelcast.core.Cluster;
import com.hazelcast.core.DistributedObject;
import com.hazelcast.core.HazelcastInstance;
import com.hazelcast.core.IMap;
import com.hazelcast.core.ISet;
import com.hazelcast.core.Member;
import com.hazelcast.map.impl.MapService;

public class CacheConsoleProvider implements CommandProvider {

    /*
     * (non-Javadoc)
     * 
     * @see org.eclipse.osgi.framework.console.CommandProvider#getHelp()
     */
    @Override
    public String getHelp() {

        final StringBuilder buffer = new StringBuilder();
        buffer.append("---- Hazelcast plugin console commands: ");
        buffer.append("\n\t hazelcastStatus – print informations of current hazelcast Server");
        buffer.append("\n\t hazelcastObjects – list all distributed objects saved into hazelcast Server");
        return buffer.toString();

    }

    public Object _hazelcastStatus(final CommandInterpreter console) {

        console.nextArgument();

        final StringBuilder sb = new StringBuilder();

        if (Activator.getHazelcastInstance() == null) {
            sb.append("\n hazelcast not started.");
        } else {

        	HazelcastInstance instance = Activator.getHazelcastInstance();
        	Cluster cluster = instance.getCluster();
            Set<Member> members = cluster.getMembers();

            if (members != null) {

                for (Member member : members) {
                    sb.append("hazelcast ");
                    sb.append(member.getUuid());
                    sb.append(" Node Server: ");
                    sb.append(member.getAddress());
                    sb.append("\n");
                }
            }
        }

        console.println(sb.toString());

        return null;
    }

    public Object _hazelcastObjects(final CommandInterpreter console) {

        final StringBuilder sb = new StringBuilder();

        if (Activator.getHazelcastInstance() == null) {
            sb.append("\n hazelcast not started.");
        } else {

        	HazelcastInstance instance = Activator.getHazelcastInstance();
        	Collection<DistributedObject> objects = instance.getDistributedObjects();
            sb.append("\nHave ");
            sb.append(objects.size());
            sb.append(" keys:");
        	for (DistributedObject object : objects) {
                sb.append("\n\t");
                sb.append(object.getServiceName() + "->" + object.getName());
                if (MapService.SERVICE_NAME.equals(object.getServiceName())) {
                    IMap<Object, Object> map = instance.getMap(object.getName());
                    sb.append(" #" + map.size());
                } else if (SetService.SERVICE_NAME.equals(object.getServiceName())) {
                    ISet<Object> set = instance.getSet(object.getName());
                    sb.append(" #" + set.size());
                }
        	}
        }

        console.println(sb.toString());

        return null;
    }

}
