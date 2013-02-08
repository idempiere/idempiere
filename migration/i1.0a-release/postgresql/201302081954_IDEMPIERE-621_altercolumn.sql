create or replace function altercolumn(tablename name, columnname name, datatype name,
nullclause varchar, defaultclause varchar) returns void as $$
declare
   command text;
   viewtext text[];
   viewname name[];
   dropviews name[];
   i int;
   j int;
   v record;
   sqltype       text;
   sqltype_short text;
   typename name;
begin
   if datatype is not null then
	select pg_type.typname, format_type(pg_type.oid, pg_attribute.atttypmod)
            into typename, sqltype
            from pg_class, pg_attribute, pg_type
            where relname = lower(tablename)
                and relkind = 'r'
                and pg_class.oid = pg_attribute.attrelid
                and attname = lower(columnname)
                and atttypid = pg_type.oid;
        sqltype_short := sqltype;
        if typename = 'numeric' then
	   sqltype_short := replace(sqltype, ',0', '');
        elsif strpos(sqltype,'character varying') = 1 then
	   sqltype_short := replace(sqltype, 'character varying', 'varchar');
        elsif sqltype = 'timestamp without time zone' then
           sqltype_short := 'timestamp';
        end if;
        if lower(datatype) <> sqltype and lower(datatype) <> sqltype_short then
		i := 0;
		for v in
	        with recursive depv(relname, viewoid, depth) as (
		    select distinct a.relname, a.oid, 1
		        from pg_class a, pg_depend b, pg_depend c, pg_class d, pg_attribute e
		        where a.oid = b.refobjid
			    and b.objid = c.objid
			    and b.refobjid <> c.refobjid
			    and b.deptype = 'n'
			    and c.refobjid = d.oid
			    and d.relname = lower(tablename)
			    and d.relkind = 'r'
			    and d.oid = e.attrelid
			    and e.attname = lower(columnname)
			    and c.refobjsubid = e.attnum
			    and a.relkind = 'v'
	          union all
		    select distinct dependee.relname, dependee.oid, depv.depth+1
		        from pg_depend 
			    join pg_rewrite on pg_depend.objid = pg_rewrite.oid 
			    join pg_class as dependee on pg_rewrite.ev_class = dependee.oid 
			    join pg_class as dependent on pg_depend.refobjid = dependent.oid 
			    join pg_attribute ON pg_depend.refobjid = pg_attribute.attrelid and pg_depend.refobjsubid = pg_attribute.attnum and pg_attribute.attnum > 0
			    join depv on dependent.relname = depv.relname
	        )
	        select relname, viewoid, max(depth) from depv group by relname, viewoid order by 3 desc
		loop
		    i := i + 1;
		    viewtext[i] := pg_get_viewdef(v.viewoid);
		    viewname[i] := v.relname;
		end loop;
		if i > 0 then
		   begin
		     for j in 1 .. i loop
		        command := 'drop view ' || viewname[j];
			raise notice 'executing -> %', command;
		        execute command;
		        dropviews[j] := viewname[j];
		     end loop;
                     exception
                        when others then
                          i := array_upper(dropviews, 1);
                          if i > 0 then
                             for j in reverse i .. 1 loop
                                command := 'create or replace view ' || dropviews[j] || ' as ' || viewtext[j];
			        raise notice 'executing -> %', 'create view ' || dropviews[j];
		                execute command;
                             end loop;
                          end if;
                          raise exception 'Failed to recreate dependent view. SQLERRM=%', SQLERRM;
                   end;
		end if;
		command := 'alter table ' || lower(tablename) || ' alter column ' || lower(columnname) || ' type ' || lower(datatype);
		raise notice 'executing -> %', command;
		execute command;
                i := array_upper(dropviews, 1);
		if i > 0 then
		   for j in reverse i .. 1 loop
		     command := 'create or replace view ' || dropviews[j] || ' as ' || viewtext[j];
		     raise notice 'executing -> %', 'create view ' || dropviews[j];
		     execute command;
		   end loop;
		end if;
        end if;
   end if;
   
   if defaultclause is not null then
       if lower(defaultclause) = 'null' then
          command := 'alter table ' || lower(tablename) || ' alter column ' || lower(columnname) || ' drop default ';
       else
	  command := 'alter table ' || lower(tablename) || ' alter column ' || lower(columnname) || ' set default ''' || defaultclause || '''';
       end if;
       raise notice 'executing -> %', command;
       execute command;
   end if;
   
   if nullclause is not null then
      if lower(nullclause) = 'not null' then
          command := 'alter table ' || lower(tablename) || ' alter column ' || lower(columnname) || ' set not null';
          raise notice 'executing -> %', command;
          execute command;
      elsif lower(nullclause) = 'null' then
          command := 'alter table ' || lower(tablename) || ' alter column ' || lower(columnname) || ' drop not null';
          raise notice 'executing -> %', command;
          execute command;
      end if;
   end if;
end;
$$ language plpgsql;

SELECT register_migration_script('201302081954_IDEMPIERE-621_altercolumn.sql') FROM dual
;

