------------------------------
--     Maciej Krawiec       --
--   Mech PK 2015/2016      --
--         12K2             --
------------------------------
--      06. Collections     --
------------------------------

SET SERVEROUTPUT ON;

-- Ustawia przeceny produktów na podstawie kolekcji
CREATE OR REPLACE PROCEDURE usr_apply_discounts
IS
    TYPE discounts IS TABLE OF NUMBER INDEX BY VARCHAR2(20);
    list_of_discounts discounts;
    name VARCHAR2(20);
BEGIN
    -- adding discounts to collection
    list_of_discounts('Nowy rok') := 20;
    list_of_discounts('Dzien dziecka') := 30;
    list_of_discounts('Halloween') := 10;
    list_of_discounts('Przecena swiateczna') := 5;

    -- adding to the database
    name := list_of_discounts.FIRST;
    WHILE name IS NOT null LOOP
        dbms_output.put_line('Przecena ' || name || ' o ' ||
            TO_CHAR(list_of_discounts(name)) || '%');

        INSERT INTO SALES(SAL_NAME, SAL_REDUCTION)
        VALUES (name, TO_NUMBER(list_of_discounts(name)));

        name := list_of_discounts.NEXT(name);
    END LOOP;
END;
/

SHOW ERRORS PROCEDURE usr_apply_discounts;

BEGIN
    usr_apply_discounts();
END;
/

