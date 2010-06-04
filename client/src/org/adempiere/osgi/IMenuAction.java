package org.adempiere.osgi;

import javax.swing.JMenuBar;

import org.adempiere.base.IService;

public interface IMenuAction extends IService {

	public void addAction(JMenuBar menuBar);
	
}
