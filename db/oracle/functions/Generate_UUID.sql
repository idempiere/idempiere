/*
*This file is part of Adempiere ERP Bazaar
*http://www.adempiere.org
*
*This program is free software; you can redistribute it and/or
*modify it under the terms of the GNU General Public License
*as published by the Free Software Foundation; either version 2
*of the License, or (at your option) any later version.
*
*This program is distributed in the hope that it will be useful,
*but WITHOUT ANY WARRANTY; without even the implied warranty of
*MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE. See the
*GNU General Public License for more details.
*
*You should have received a copy of the GNU General Public License
*along with this program; if not, write to the Free Software
*Foundation, Inc., 51 Franklin Street, Fifth Floor, Boston, MA 02110-1301, USA.of
*/
create or replace function generate_uuid return varchar as
guid varchar(32);
uuid varchar(36);
begin
	guid := lower(sys_guid());
	uuid := substr(guid, 1, 8) || '-' || substr(guid, 9, 4) || '-' || substr(guid, 13, 4) || '-' || substr(guid, 17, 4) || '-' || substr(guid, 21, 12);
	return uuid;
end;
/

