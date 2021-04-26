package org.adempiere.webui.factory;

import org.adempiere.base.MappedByNameFactory;
import org.adempiere.webui.panel.ADForm;
import org.osgi.service.component.annotations.Component;

@Component(name = "org.adempiere.ui.zk.MappedProcessFactory",
immediate = true,
service = {IFormFactory.class, IMappedFormFactory.class},
property = {"service.ranking:Integer=1"})
public class MappedFormFactory extends MappedByNameFactory<ADForm> implements IFormFactory, IMappedFormFactory {

	public MappedFormFactory() {
	}

	@Override
	public ADForm newFormInstance(String formName) {
		return newInstance(formName);
	}

}
