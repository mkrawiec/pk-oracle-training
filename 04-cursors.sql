------------------------------
--     Maciej Krawiec       --
--   Mech PK 2015/2016      --
--         12K2             --
------------------------------
--       04. Cursors        --
------------------------------

SET SERVEROUTPUT ON;

-- Zamiana wszystkich wystąpień \\ na /
CREATE OR REPLACE PROCEDURE usr_replace_backslash
IS
    prod_img_uri PRODUCTS.PRD_IMG%TYPE;
    prod_rpl_uri PRODUCTS.PRD_IMG%TYPE;
CURSOR c_products IS SELECT PRD_IMG FROM PRODUCTS FOR UPDATE;
BEGIN
    OPEN c_products;
    LOOP
        FETCH c_products INTO prod_img_uri;
        EXIT WHEN c_products%NOTFOUND;

        SELECT REPLACE(prod_img_uri, '\\', '/')
                INTO prod_rpl_uri FROM DUAL;

        IF prod_img_uri != prod_rpl_uri THEN
            UPDATE PRODUCTS SET PRD_IMG = prod_rpl_uri
            WHERE CURRENT OF c_products;

            DBMS_OUTPUT.PUT_LINE('Zmieniono: ' || prod_img_uri || ' -> '
            || prod_rpl_uri);
        END IF;
    END LOOP;
    CLOSE c_products;
END;
/

SHOW ERRORS PROCEDURE usr_replace_backslash;

-- Podoszenie ceny wszstkich produktów o zadaną wartość
CREATE OR REPLACE PROCEDURE usr_rise_prices(value_added IN number)
IS
    product_count number(4);
BEGIN
   UPDATE PRODUCTS SET PRD_PRICE = PRD_PRICE + value_added;
   IF sql%notfound THEN
      dbms_output.put_line('Nie ma produktow do uaktualnienia');
   ELSIF sql%found THEN
      product_count := sql%rowcount;
      dbms_output.put_line('Podniesiono cene ' || product_count ||
        ' produktow o ' || value_added );
   END IF;
END;
/

SHOW ERRORS PROCEDURE usr_rise_prices;

-- Wyszukiwanie wśród produktów sklepu
CREATE OR REPLACE PROCEDURE usr_search_prd(phrase IN varchar2)
IS
    TYPE result IS RECORD (
        name PRODUCTS.PRD_NAME%type,
        filename DIGITAL_RESOURCES.DRES_FILENAME%type
    );

    rec result;

    CURSOR cur_search_prd(name in PRODUCTS.PRD_NAME%type)
    RETURN result
	IS
		SELECT P.PRD_NAME, DR.DRES_FILENAME
		FROM PRODUCTS P LEFT JOIN DIGITAL_RESOURCES DR
        ON (P.PRD_DRES_ID = DR.DRES_ID)
		WHERE LOWER(PRD_NAME) LIKE LOWER('%'||name||'%');
BEGIN
    OPEN cur_search_prd(phrase);

    LOOP
        FETCH cur_search_prd INTO rec.name, rec.filename;
        dbms_output.put_line('- ' || rec.name || ' (' || rec.filename || ')');

        EXIT WHEN cur_search_prd%NOTFOUND;
    END LOOP;

    -- brak wynikow
    IF cur_search_prd%ROWCOUNT = 0 THEN
        dbms_output.put_line('Brak wynikow.');
    END IF;

    CLOSE cur_search_prd;
END;
/

SHOW ERRORS PROCEDURE usr_search_prd;

BEGIN
    usr_replace_backslash();
    dbms_output.put_line('x-x-x-x-x-x-x-x-x-x-x-x-x-x-x-x-x-x-x-x-x-x-x-x-x');
    usr_rise_prices(10);
    dbms_output.put_line('x-x-x-x-x-x-x-x-x-x-x-x-x-x-x-x-x-x-x-x-x-x-x-x-x');
    dbms_output.put_line('Wyszukiwanie: ');
    usr_search_prd('JavaScript');
    dbms_output.put_line('x-x-x-x-x-x-x-x-x-x-x-x-x-x-x-x-x-x-x-x-x-x-x-x-x');
END;
/

