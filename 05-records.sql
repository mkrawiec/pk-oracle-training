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

    DBMS_OUTPUT.PUT_LINE(product1.name || ' | ' || product2.name);
    DBMS_OUTPUT.PUT_LINE(product1.price || ' | ' || product2.price);
    DBMS_OUTPUT.PUT_LINE(product1.filename || ' | ' || product2.filename);
    DBMS_OUTPUT.PUT_LINE(product1.max_download || ' | ' || product2.max_download);

    EXCEPTION
      WHEN NO_DATA_FOUND THEN
        DBMS_OUTPUT.PUT_LINE('---------------------------');
        DBMS_OUTPUT.PUT_LINE('Brak wystarczajacych danych');
        DBMS_OUTPUT.PUT_LINE('---------------------------');
END;
/

SHOW ERRORS PROCEDURE usr_compare_products;

BEGIN
    usr_compare_products(21, 22);
    usr_compare_products(1, 2);
END;
/
