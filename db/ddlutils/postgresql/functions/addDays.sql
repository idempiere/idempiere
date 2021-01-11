/*
*This file is part of Adempiere ERP Bazaar
*http://www.adempiere.org
*
*Copyright (C) 2007 Low Heng Sin
*Copyright (C) 1999-2006 ComPiere, inc
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


CREATE OR REPLACE FUNCTION addDays(datetime TIMESTAMP WITH TIME ZONE, days Numeric)
RETURNS TIMESTAMP WITH TIME ZONE AS $$
BEGIN
	if datetime is null or days is null then
		return null;
	end if;
	return datetime + (interval '1' second * (86400 * days));
END;
$$ LANGUAGE plpgsql IMMUTABLE;


CREATE OR REPLACE FUNCTION adddays (in inter interval, in days numeric)
RETURNS integer AS $$
BEGIN   
RETURN ( EXTRACT( EPOCH FROM ( inter ) ) / 86400 ) + days;
END;    
$$ LANGUAGE plpgsql IMMUTABLE;


CREATE OR REPLACE FUNCTION subtractdays (day TIMESTAMP WITH TIME ZONE, days NUMERIC)
RETURNS TIMESTAMP WITH TIME ZONE AS $$
BEGIN
    RETURN addDays(day,(days * -1));
END;
$$ LANGUAGE plpgsql IMMUTABLE;


CREATE OR REPLACE FUNCTION subtractdays (in inter interval, in days numeric)
RETURNS integer AS $$
BEGIN
RETURN ( EXTRACT( EPOCH FROM ( inter ) ) / 86400 ) - days;
END;
$$ LANGUAGE plpgsql IMMUTABLE;


CREATE OPERATOR + (
    PROCEDURE = adddays,
    LEFTARG = timestamp with time zone,
    RIGHTARG = numeric,
    COMMUTATOR = OPERATOR(+)
);


CREATE OPERATOR + (
    PROCEDURE = adddays,
    LEFTARG = interval,
    RIGHTARG = numeric,
    COMMUTATOR = OPERATOR(-)
);


CREATE OPERATOR - (
    PROCEDURE = subtractdays,
    LEFTARG = timestamp with time zone,
    RIGHTARG = numeric,
    COMMUTATOR = OPERATOR(-)
);


CREATE OPERATOR - (
    PROCEDURE = subtractdays,
    LEFTARG = interval,
    RIGHTARG = numeric,
    COMMUTATOR = OPERATOR(-)
);

