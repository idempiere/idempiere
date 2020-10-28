/***********************************************************************
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
 * - hengsin                         								   *
 **********************************************************************/
package org.idempiere.test.performance;

import java.io.Reader;
import java.util.Arrays;
import java.util.List;

import javax.script.Bindings;
import javax.script.ScriptContext;
import javax.script.ScriptEngine;
import javax.script.ScriptEngineFactory;
import javax.script.ScriptException;

/**
 * 
 * @author hengsin
 *
 */
public class FakeScriptEngineFactory implements ScriptEngineFactory {

	public FakeScriptEngineFactory() {
	}

	@Override
	public String getEngineName() {
		return null;
	}

	@Override
	public String getEngineVersion() {
		return null;
	}

	@Override
	public List<String> getExtensions() {
		return null;
	}

	@Override
	public List<String> getMimeTypes() {
		return null;
	}

	@Override
	public List<String> getNames() {
		return Arrays.asList(FakeScriptEngineFactory.class.getName());
	}

	@Override
	public String getLanguageName() {
		return null;
	}

	@Override
	public String getLanguageVersion() {
		return null;
	}

	@Override
	public Object getParameter(String key) {
		return null;
	}

	@Override
	public String getMethodCallSyntax(String obj, String m, String... args) {
		return null;
	}

	@Override
	public String getOutputStatement(String toDisplay) {
		return null;
	}

	@Override
	public String getProgram(String... statements) {
		return null;
	}

	@Override
	public ScriptEngine getScriptEngine() {
		return new ScriptEngine() {
			
			@Override
			public void setContext(ScriptContext context) {
			}
			
			@Override
			public void setBindings(Bindings bindings, int scope) {
			}
			
			@Override
			public void put(String key, Object value) {
			}
			
			@Override
			public ScriptEngineFactory getFactory() {
				return null;
			}
			
			@Override
			public ScriptContext getContext() {
				return null;
			}
			
			@Override
			public Bindings getBindings(int scope) {
				return null;
			}
			
			@Override
			public Object get(String key) {
				return null;
			}
			
			@Override
			public Object eval(Reader reader, Bindings n) throws ScriptException {
				return null;
			}
			
			@Override
			public Object eval(String script, Bindings n) throws ScriptException {
				return null;
			}
			
			@Override
			public Object eval(Reader reader, ScriptContext context) throws ScriptException {
				return null;
			}
			
			@Override
			public Object eval(String script, ScriptContext context) throws ScriptException {
				return null;
			}
			
			@Override
			public Object eval(Reader reader) throws ScriptException {
				return null;
			}
			
			@Override
			public Object eval(String script) throws ScriptException {
				return null;
			}
			
			@Override
			public Bindings createBindings() {
				return null;
			}
		};
	}
}
