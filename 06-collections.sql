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

    name varchar2(20);
    curr_month varchar2(20);
    discount number;
BEGIN
    -- Dodaj przeceny do kolekcji
    list_of_discounts('January') := 20;
    list_of_discounts('February') := 20;
    list_of_discounts('March') := 30;
    list_of_discounts('April') := 10;
    list_of_discounts('May') := 10;
    list_of_discounts('June') := 10;
    list_of_discounts('July') := 10;
    list_of_discounts('August') := 10;
    list_of_discounts('September') := 10;
    list_of_discounts('October') := 10;
    list_of_discounts('November') := 10;
    list_of_discounts('December') := 5;

    -- Zróżnicuj przeceny +-5%
    name := list_of_discounts.FIRST;
    WHILE name IS NOT null LOOP
        list_of_discounts(name) := list_of_discounts(name) +
            floor(dbms_random.value(0,5)) - floor(dbms_random.value(0,5));

        dbms_output.put_line('Miesiac ' || name || ' przecena o ' ||
            TO_CHAR(list_of_discounts(name)) || '%');

        name := list_of_discounts.NEXT(name);
    END LOOP;

    -- Dodaj do bazy przecene bieżącego miesiąca
    SELECT to_char(sysdate, 'fmMonth') INTO curr_month FROM dual;
    SELECT list_of_discounts(curr_month) INTO discount FROM dual;
    INSERT INTO SALES(SAL_NAME, SAL_REDUCTION) VALUES (curr_month, discount);
END;
/

SHOW ERRORS PROCEDURE usr_apply_discounts;


/*
 Symulator sklepu i kupowania produktów
 */
CREATE OR REPLACE PROCEDURE usr_shop_sim(num in number)
IS
    random_id number(10);
    TYPE orders_t IS TABLE OF orders%ROWTYPE;
    l_orders   orders_t;
    l_index   PLS_INTEGER;

    TYPE prod_rec IS RECORD(
        name PRODUCTS.PRD_NAME%type,
        price PRODUCTS.PRD_PRICE%type
    );
    TYPE cus_rec IS RECORD(
        first CUSTOMERS.CUS_FIRST_NAME%type,
        last CUSTOMERS.CUS_LAST_NAME%type
    );
    product1 prod_rec;
    l_cus cus_rec;
BEGIN
    /* Load up the table. */
    FOR indx IN 1 .. num
    LOOP
        -- Wybierz losowy produkt
        SELECT PRD_ID INTO random_id FROM ( SELECT PRD_ID, dbms_random.value FROM PRODUCTS ORDER BY 2 ) WHERE rownum = 1;

        INSERT INTO orders(ORD_PRD_ID) VALUES (random_id);
    END LOOP;

    EXECUTE IMMEDIATE 'SELECT * FROM orders'
        BULK COLLECT INTO l_orders;

    ---
    l_index := l_orders.FIRST;
    WHILE (l_index IS NOT NULL)
    LOOP
        SELECT PRD_NAME, PRD_PRICE
            INTO product1 FROM PRODUCTS
            WHERE PRD_ID = l_orders(l_index).ORD_PRD_ID;

        dbms_output.put_line('Tytul: ' || product1.name || ' || Cena: ' || product1.price || 'zl.');

        SELECT CUS_ID INTO random_id FROM ( SELECT CUS_ID, dbms_random.value FROM CUSTOMERS ORDER BY 2 ) WHERE rownum = 1;
        SELECT CUS_FIRST_NAME, CUS_LAST_NAME
            INTO l_cus FROM CUSTOMERS
            WHERE CUS_ID = random_id;

        dbms_output.put_line('Kupiony przez: ' || l_cus.first || ' ' || l_cus.last);
        dbms_output.put_line('======================');

        INSERT INTO CUSTOMERS_ORDERS(CUS_ID, ORD_ID) VALUES (random_id, l_orders(l_index).ORD_ID);

        l_index := l_orders.NEXT(l_index);
    END LOOP;

    DBMS_OUTPUT.put_line ('Kupiono ' || l_orders.COUNT || ' produktow');
END;
/

SHOW ERRORS PROCEDURE usr_shop_sim;

BEGIN
    delete customers_orders;
    delete orders;
    delete sales;


    dbms_output.put_line('x-x-x-x-x-x-x-x-x-x-x-x-x-x-x-x-x-x-x-x-x-x-x-x-x');
    usr_apply_discounts();
    dbms_output.put_line('x-x-x-x-x-x-x-x-x-x-x-x-x-x-x-x-x-x-x-x-x-x-x-x-x');
    usr_shop_sim(11);
    dbms_output.put_line('x-x-x-x-x-x-x-x-x-x-x-x-x-x-x-x-x-x-x-x-x-x-x-x-x');
END;
/

