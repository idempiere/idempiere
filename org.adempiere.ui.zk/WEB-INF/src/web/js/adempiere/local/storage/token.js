/******************************************************************************
 * Copyright (C) 2009 Low Heng Sin                                            *
 * Copyright (C) 2009 Idalica Corporation                                     *
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

window.adempiere = {};
var adempiere = window.adempiere;
adempiere.isSupportSavePass=typeof(Storage) !== "undefined";

adempiere.saveUserToken = function (key, hash, sessionId)
{
	if (!adempiere.isSupportSavePass)
		return;
	localStorage[key+".sid"] = sessionId;
	localStorage[key+".hash"] = hash;
};

adempiere.findUserToken = function (cmpid, key)
{
	if (!adempiere.isSupportSavePass)
		return;
	
	var sid = localStorage[key+".sid"];
	var hash = localStorage[key+".hash"];

	if (sid == null || sid == "" || hash == null || hash == ""){
		return
	}
	
	var widget = zk.Widget.$(cmpid);
	var event = new zk.Event(widget, 'onUserToken', {sid: sid, hash: hash}, {toServer: true});
	zAu.send(event);
};

adempiere.removeUserToken = function (key)
{
	localStorage[key+".sid"] = "";
	localStorage[key+".hash"] = "";	
};

adempiere.set = function (key, value){
	localStorage[key] = value;
}

adempiere.get = function (key, fn, scope){
	value = localStorage[key];

    if (fn)
      fn.call(scope || this, true, value);
}
