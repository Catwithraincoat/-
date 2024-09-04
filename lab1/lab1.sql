CREATE OR REPLACE PROCEDURE info_of_table(tabName text)
   LANGUAGE plpgsql
   AS $$
        DECLARE
        col record;
        table_count int;

       BEGIN
           SELECT COUNT(DISTINCT nspname) INTO table_count FROM pg_class tab JOIN pg_namespace space on tab.relnamespace = space.oid WHERE relname = tabName AND space.nspname = 's336892';
           IF table_count < 1 THEN
            RAISE EXCEPTION 'Таблица "%" не найдена', tabName;
           ELSE
               RAISE NOTICE 'Таблица: %', tabName;
               RAISE NOTICE 'No  Имя столбца    Атрибуты';
               RAISE NOTICE '--- -------------- ------------------------------------------';
               FOR col IN SELECT tab.relname, att.attnum, att.attname,att.atttypmod, typ.typname, des.description, idx.indexrelid::regclass as idxname FROM pg_class tab
                    JOIN pg_namespace space on tab.relnamespace = space.oid
                    JOIN pg_attribute att on att.attrelid = tab.oid
                    JOIN pg_type typ on att.atttypid = typ.oid
                    LEFT JOIN pg_description des on des.objoid = tab.oid and des.objsubid = att.attnum
                    LEFT JOIN pg_index idx on tab.oid = idx.indrelid and att.attnum = any(idx.indkey)
                WHERE tab.relname = tabName and attnum > 0 and space.nspname = 's336892'
                ORDER BY attnum

               LOOP
                    RAISE NOTICE '% % Type    :  % %', RPAD(col.attnum::text, 5, ' '), RPAD(col.attname, 16, ' '), CASE WHEN col.typname = 'int4' THEN 'NUMBER' ELSE col.typname END, CASE WHEN col.atttypmod != -1 THEN ' (' || col.atttypmod || ')' ELSE '' END;
                    RAISE NOTICE '% Commen  :  "%"', RPAD('⠀', 22, ' '), CASE WHEN col.description is null THEN '' ELSE col.description END;
                    RAISE NOTICE '% Index   :  "%"', RPAD('⠀', 22, ' '), CASE WHEN col.idxname is null THEN '' ELSE col.idxname::text END;
                    RAISE NOTICE ' ';
               END LOOP;
          END IF;
       END
   $$;

call info_of_table('guest')
