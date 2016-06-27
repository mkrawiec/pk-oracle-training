------------------------------
--     Maciej Krawiec       --
--   Mech PK 2015/2016      --
--         12K2             --
------------------------------
--  03. Simple Procedures   --
------------------------------

SET SERVEROUTPUT ON;

-- DODAWANIE KLIENTA Z ADRESEM
CREATE OR REPLACE PROCEDURE usr_ins_cus(imie in VARCHAR2, nazwisko IN VARCHAR2,
    miasto IN VARCHAR2, ulica IN VARCHAR2)
IS
addr_id_curr ADDRESSES.ADD_id%TYPE;
BEGIN
    INSERT INTO ADDRESSES (ADD_CITY, ADD_STREET) VALUES (miasto, ulica);
    SELECT SEQ_ADDRESSES.currval INTO addr_id_curr from dual;
    --
    INSERT INTO CUSTOMERS (CUS_FIRST_NAME, CUS_LAST_NAME, CUS_ADD_ID)
    VALUES (imie, nazwisko, addr_id_curr);
END;
/

SHOW ERRORS PROCEDURE usr_ins_cus;

-- DODAWANIE (N) GENEROWANYCH KLIENTÓW
CREATE OR REPLACE PROCEDURE usr_st1_test(ile IN NUMBER)
IS
licznik number(2);
BEGIN
    licznik := 1;
    WHILE licznik < ile + 1
        LOOP
            DBMS_OUTPUT.PUT_LINE('Dodaje klienta ' || licznik);
            usr_ins_cus('Imie ' || licznik, 'Nazwisko ' || licznik, 'Miasto' || licznik, 'Ulica' || licznik);
            licznik := licznik + 1;
        END LOOP;
END;
/

-- GENEROWANIE LOSOWEGO ISBN'u
CREATE OR REPLACE FUNCTION usr_gen_isbn
RETURN VARCHAR2
IS
isbn_a NUMBER(1);
isbn_b NUMBER(4);
isbn_c NUMBER(4);
isbn_d NUMBER(1);
isbn_concat VARCHAR2(13);
BEGIN
    isbn_a := DBMS_RANDOM.VALUE(1, 9);
    isbn_b := DBMS_RANDOM.VALUE(1000, 9999);
    isbn_c := DBMS_RANDOM.VALUE(1000, 9999);
    isbn_d := DBMS_RANDOM.VALUE(1, 9);

    isbn_concat := isbn_a || '-' || isbn_b || '-' || isbn_c || '-' || isbn_d;
    DBMS_OUTPUT.PUT_LINE('Wygenerowano ISBN: ' || isbn_concat);

    RETURN isbn_concat;
END;
/

SHOW ERRORS FUNCTION usr_gen_isbn;

-- DODAWANIE PRODUKTU
CREATE OR REPLACE PROCEDURE usr_ins_prod(
    nazwa in VARCHAR2,
    cena in NUMBER,
    obrazek in VARCHAR2,
    kategoria in VARCHAR2)
IS
cat_id_curr CATEGORIES.CAT_ID%TYPE;
BEGIN
    BEGIN
        SELECT CAT_ID INTO cat_id_curr FROM CATEGORIES where CAT_NAME = kategoria;
    EXCEPTION WHEN NO_DATA_FOUND THEN
        INSERT INTO CATEGORIES(CAT_NAME, CAT_PARENT_ID) VALUES (kategoria, 1);
        SELECT SEQ_CATEGORIES.currval INTO cat_id_curr from dual;
    END;

    INSERT INTO PRODUCTS(PRD_NAME, PRD_PRICE, PRD_IMG, PRD_ISBN, PRD_CAT_ID, PRD_PTYP_ID) VALUES (nazwa, cena, obrazek, usr_gen_isbn(), cat_id_curr, 1);

    DBMS_OUTPUT.PUT_LINE('Dodano do kategorii ' || cat_id_curr);
END;
/

SHOW ERRORS PROCEDURE usr_ins_prod;

-- MAIN()
DECLARE
    isbn_test VARCHAR(13);
BEGIN
    DBMS_OUTPUT.PUT_LINE('@@@ START @@@');
    DBMS_OUTPUT.PUT_LINE('-- DODAWANIE/GENEROWANIE UZYTKOWNIKOW --');
        usr_st1_test(5);
    DBMS_OUTPUT.PUT_LINE('-- GENEROWANIE LOSOWYCH ISBNow --');
        isbn_test := usr_gen_isbn();
        isbn_test := usr_gen_isbn();
        isbn_test := usr_gen_isbn();
        isbn_test := usr_gen_isbn();
    DBMS_OUTPUT.PUT_LINE('-- DODAWANIE PRODUKTOW --');
        usr_ins_prod('Test1', 12, 'test1.jpg', 'Książki');
        usr_ins_prod('Test2', 32, 'test2.jpg', 'Czasopisma naukowe');
        usr_ins_prod('Test3', 543, 'test3.jpg', 'Książki');
    DBMS_OUTPUT.PUT_LINE('@@@ STOP @@@');
END;
/

