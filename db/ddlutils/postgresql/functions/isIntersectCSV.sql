/*
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
CREATE OR REPLACE FUNCTION isintersectcsv(
        p_csv1 character varying,
        p_csv2 character varying)
    RETURNS char
    LANGUAGE 'plpgsql'
    COST 100
    STABLE PARALLEL SAFE 
AS $BODY$
begin
        IF string_to_array(p_csv1, ',') && string_to_array(p_csv2, ',')
        THEN
            RETURN 'Y';
        ELSE
            RETURN 'N';
        END IF;
end;
$BODY$;

