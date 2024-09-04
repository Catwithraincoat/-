CREATE OR REPLACE PROCEDURE info_of_table(tabName text)
   LANGUAGE plpgsql
   AS $$
        DECLARE
        col record;

       BEGIN
           RAISE NOTICE 'Таблица: %', tabName;
           RAISE NOTICE 'No  Имя столбца    Атрибуты';
           RAISE NOTICE '--- -------------- ------------------------------------------';

           FOR col IN SELECT tab.relname, attr.attnum, attr.attname, attr.atttypid,typ.typname, des.description, idx.indexrelid::regclass as idxname FROM pg_class tab
                JOIN pg_namespace space on tab.relnamespace = space.oid
                JOIN pg_attribute attr on attr.attrelid = tab.oid
                JOIN pg_type typ on attr.atttypid = typ.oid
                LEFT JOIN pg_description des on des.objoid = tab.oid and des.objsubid = attr.attnum
                LEFT JOIN pg_index idx on tab.oid = idx.indrelid and attr.attnum = any(idx.indkey)
            WHERE tab.relname = tabName and attnum > 0 and space.nspname = 's336892'
            ORDER BY attnum

           LOOP
                RAISE NOTICE '% % Type    :  %(%)', RPAD(col.attnum::text, 5, ' '), RPAD(col.attname, 16, ' '), col.typname, col.atttypid;
                RAISE NOTICE '% Commen  :  "%"', RPAD('⠀', 22, ' '), CASE WHEN col.description is null THEN '' ELSE col.description END;
                RAISE NOTICE '% Index   :  "%"', RPAD('⠀', 22, ' '), CASE WHEN col.idxname is null THEN '' ELSE col.idxname::text END;
	            RAISE NOTICE ' ';
           END LOOP;
       END
   $$;

call info_of_table('guest')
