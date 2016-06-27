------------------------------
--     Maciej Krawiec       --
--   Mech PK 2015/2016      --
--         12K2             --
------------------------------
--       05. Records        --
------------------------------

SET SERVEROUTPUT ON;

-- Porównuje ze sobą 2 produkty o podanych id
CREATE OR REPLACE PROCEDURE usr_compare_products(p1_id IN number, p2_id IN number)
IS
    TYPE prod_rec IS RECORD(
        name PRODUCTS.PRD_NAME%type,
        price PRODUCTS.PRD_PRICE%type,
        filename DIGITAL_RESOURCES.DRES_FILENAME%type,
        max_download DIGITAL_RESOURCES.DRES_MAX_DOWNLOAD%type
    );

    product1 prod_rec;
    product2 prod_rec;
BEGIN
    SELECT P.PRD_NAME, P.PRD_PRICE, R.DRES_FILENAME, R.DRES_MAX_DOWNLOAD
        INTO product1 FROM PRODUCTS P, DIGITAL_RESOURCES R
        WHERE P.PRD_ID = p1_id AND R.DRES_ID = P.PRD_DRES_ID;

    SELECT P.PRD_NAME, P.PRD_PRICE, R.DRES_FILENAME, R.DRES_MAX_DOWNLOAD
        INTO product2 FROM PRODUCTS P, DIGITAL_RESOURCES R
        WHERE P.PRD_ID = p2_id AND R.DRES_ID = P.PRD_DRES_ID;


    IF product1.name = product2.name
        AND product1.price = product2.price
        AND product1.filename = product2.filename
    THEN
        DBMS_OUTPUT.PUT_LINE('Produkty takie same');
        IF product1.max_download = product2.max_download THEN
            DBMS_OUTPUT.PUT_LINE('Taka sama liczba mozliwych pobran');
        END IF;
    ELSE
        DBMS_OUTPUT.PUT_LINE('Produkty rozne');
    END IF;

    EXCEPTION
      WHEN NO_DATA_FOUND THEN
        DBMS_OUTPUT.PUT_LINE('---------------------------');
        DBMS_OUTPUT.PUT_LINE('Brak wystarczajacych danych');
        DBMS_OUTPUT.PUT_LINE('---------------------------');
END;
/

SHOW ERRORS PROCEDURE usr_compare_products;

CREATE OR REPLACE FUNCTION RandomString(p_Characters varchar2, p_length number)
return varchar2
is
  l_res varchar2(256);
begin
  select substr(listagg(substr(p_Characters, level, 1)) within group(order by dbms_random.value), 1, p_length)
    into l_res
    from dual
  connect by level <= length(p_Characters);
  return l_res;
end;
/

CREATE OR REPLACE PROCEDURE usr_gen_fake_usrs(num IN number)
IS
    TYPE usr IS RECORD(
        gender number, -- (0 = f) (1 = m)
        f_name CUSTOMERS.CUS_FIRST_NAME%type,
        l_name CUSTOMERS.CUS_LAST_NAME%type
    );

    TYPE usr_array IS TABLE OF usr;
    arr usr_array := usr_array();
BEGIN
    arr.extend(num);

    -- Generuje płeć wszystkich osobników
    FOR i IN 1..num LOOP
        arr(i).gender := round(dbms_random.value(0, 1));
    END LOOP;

    FOR i IN 1..num LOOP
        IF arr(i).gender = 0 THEN
            arr(i).f_name := INITCAP(randomstring('maciej', 5));
            arr(i).l_name := INITCAP(randomstring('krawiec', 5) || 'ski');
        ELSE
            arr(i).f_name := INITCAP(randomstring('maciej', 5) || 'a');
            arr(i).l_name := INITCAP(randomstring('krawiec', 5) || 'ska');
        END IF;
    END LOOP;

    FOR i IN 1..num LOOP
        DBMS_OUTPUT.PUT_LINE(arr(i).f_name || ' ' || arr(i).l_name);
        INSERT INTO CUSTOMERS(CUS_FIRST_NAME, CUS_LAST_NAME, CUS_ADD_ID)
            VALUES (arr(i).f_name, arr(i).l_name, 1);
    END LOOP;
END;
/

SHOW ERRORS PROCEDURE usr_gen_fake_usrs;

BEGIN
    dbms_output.put_line('x-x-x-x-x-x-x-x-x-x-x-x-x-x-x-x-x-x-x-x-x-x-x-x-x');
    usr_compare_products(1, 1);
    usr_compare_products(13, 1);
    usr_compare_products(4, 2);
    dbms_output.put_line('x-x-x-x-x-x-x-x-x-x-x-x-x-x-x-x-x-x-x-x-x-x-x-x-x');
    usr_gen_fake_usrs(10);
    dbms_output.put_line('x-x-x-x-x-x-x-x-x-x-x-x-x-x-x-x-x-x-x-x-x-x-x-x-x');
END;
/

