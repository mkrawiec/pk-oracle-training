------------------------------
--     Maciej Krawiec       --
--   Mech PK 2015/2016      --
--         12K2             --
------------------------------
--       02. Inserts        --
------------------------------

-- Kategorie
INSERT INTO CATEGORIES (CAT_NAME, CAT_PARENT_ID) VALUES ('Root', NULL);
INSERT INTO CATEGORIES (CAT_NAME, CAT_PARENT_ID) VALUES ('Programowanie', 1);
INSERT INTO CATEGORIES (CAT_NAME, CAT_PARENT_ID) VALUES ('Javascript', 2);
INSERT INTO CATEGORIES (CAT_NAME, CAT_PARENT_ID) VALUES ('C#', 2);
INSERT INTO CATEGORIES (CAT_NAME, CAT_PARENT_ID) VALUES ('Java', 2);
INSERT INTO CATEGORIES (CAT_NAME, CAT_PARENT_ID) VALUES ('Techniki programowania', 1);
INSERT INTO CATEGORIES (CAT_NAME, CAT_PARENT_ID) VALUES ('Webdevelopment', 2);
INSERT INTO CATEGORIES (CAT_NAME, CAT_PARENT_ID) VALUES ('Bezpieczeństwo', 1);
INSERT INTO CATEGORIES (CAT_NAME, CAT_PARENT_ID) VALUES ('Sieci', 1);

-- Adresy
INSERT INTO ADDRESSES (ADD_CITY, ADD_STREET) VALUES ('Kraków', 'Budryka 13');
INSERT INTO ADDRESSES (ADD_CITY, ADD_STREET) VALUES ('Kraków', 'Lubicz 1');
INSERT INTO ADDRESSES (ADD_CITY, ADD_STREET) VALUES ('Kraków', 'Al. Jana Pawła III');

-- Typy produktów
INSERT INTO PRODUCT_TYPES (PTYP_NAME) VALUES ('Fizyczny');
INSERT INTO PRODUCT_TYPES (PTYP_NAME) VALUES ('Wirtualny');
INSERT INTO PRODUCT_TYPES (PTYP_NAME) VALUES ('DRM');

-- Zasoby cyfrowe
INSERT INTO DIGITAL_RESOURCES (DRES_NAME, DRES_FILENAME, DRES_MAX_DOWNLOAD)
VALUES ('Parostatkiem W Piękny Rejs', 'parostatkiem.mp3', '10');
INSERT INTO DIGITAL_RESOURCES (DRES_NAME, DRES_FILENAME, DRES_MAX_DOWNLOAD)
VALUES ('Chciałbym Być', 'chcialbym_byc.mp3', '10');
INSERT INTO DIGITAL_RESOURCES (DRES_NAME, DRES_FILENAME, DRES_MAX_DOWNLOAD)
VALUES ('Bo Jesteś Ty', 'bo_jestes_ty.mp3', '10');

-- Produkty
INSERT INTO PRODUCTS (PRD_NAME, PRD_PRICE, PRD_IMG, PRD_ISBN, PRD_CAT_ID, PRD_PTYP_ID, PRD_DRES_ID)
VALUES ('Security CCNA 210-260. Zostań administratorem sieci komputerowych Cisco', 23, 'elon_musk.png', '978-83-240-3440-6', 3, 1, 1);
INSERT INTO PRODUCTS (PRD_NAME, PRD_PRICE, PRD_IMG, PRD_ISBN, PRD_CAT_ID, PRD_PTYP_ID, PRD_DRES_ID)
VALUES ('TDD. Sztuka tworzenia dobrego kodu', 16, 'elon_musk.png', '978-83-240-3440-6', 3, 1, 1);
INSERT INTO PRODUCTS (PRD_NAME, PRD_PRICE, PRD_IMG, PRD_ISBN, PRD_CAT_ID, PRD_PTYP_ID, PRD_DRES_ID)
VALUES ('Czysty kod. Podręcznik dobrego programisty', 32, 'elon_musk.png', '978-83-240-3440-6', 3, 1, 1);
INSERT INTO PRODUCTS (PRD_NAME, PRD_PRICE, PRD_IMG, PRD_ISBN, PRD_CAT_ID, PRD_PTYP_ID, PRD_DRES_ID)
VALUES ('Tajniki języka JavaScript. Asynchroniczność i wydajność', 43, 'elon_musk.png', '978-83-240-3440-6', 3, 1, 1);
INSERT INTO PRODUCTS (PRD_NAME, PRD_PRICE, PRD_IMG, PRD_ISBN, PRD_CAT_ID, PRD_PTYP_ID, PRD_DRES_ID)
VALUES ('Tajniki języka JavaScript. Wskaźnik this i prototypy obiektów', 32, 'elon_musk.png', '978-83-240-3440-6', 3, 1, 1);
INSERT INTO PRODUCTS (PRD_NAME, PRD_PRICE, PRD_IMG, PRD_ISBN, PRD_CAT_ID, PRD_PTYP_ID, PRD_DRES_ID)
VALUES ('Tajniki języka JavaScript. Typy i składnia', 87, 'elon_musk.png', '978-83-240-3440-6', 3, 1, 1);
INSERT INTO PRODUCTS (PRD_NAME, PRD_PRICE, PRD_IMG, PRD_ISBN, PRD_CAT_ID, PRD_PTYP_ID, PRD_DRES_ID)
VALUES ('C# 6.0 i MVC 5. Tworzenie nowoczesnych portali internetowych', 32, 'elon_musk.png', '978-83-240-3440-6', 3, 1, 1);
INSERT INTO PRODUCTS (PRD_NAME, PRD_PRICE, PRD_IMG, PRD_ISBN, PRD_CAT_ID, PRD_PTYP_ID, PRD_DRES_ID)
VALUES ('AngularJS. Profesjonalne techniki', 123, 'elon_musk.png', '978-83-240-3440-6', 3, 1, 1);
INSERT INTO PRODUCTS (PRD_NAME, PRD_PRICE, PRD_IMG, PRD_ISBN, PRD_CAT_ID, PRD_PTYP_ID, PRD_DRES_ID)
VALUES ('Tajniki języka JavaScript. Zakresy i domknięcia', 52, 'elon_musk.png', '978-83-240-3440-6', 3, 1, 1);
INSERT INTO PRODUCTS (PRD_NAME, PRD_PRICE, PRD_IMG, PRD_ISBN, PRD_CAT_ID, PRD_PTYP_ID, PRD_DRES_ID)
VALUES ('TDD. Programowanie w Javie sterowane testami', 47, 'elon_musk.png', '978-83-240-3440-6', 3, 1, 1);
INSERT INTO PRODUCTS (PRD_NAME, PRD_PRICE, PRD_IMG, PRD_ISBN, PRD_CAT_ID, PRD_PTYP_ID, PRD_DRES_ID)
VALUES ('Tajniki języka JavaScript. Na drodze do biegłości', 27, 'elon_musk.png', '978-83-240-3440-6', 3, 1, 1);
INSERT INTO PRODUCTS (PRD_NAME, PRD_PRICE, PRD_IMG, PRD_ISBN, PRD_CAT_ID, PRD_PTYP_ID, PRD_DRES_ID)
VALUES ('Software Craftsman. Profesjonalizm, czysty kod i techniczna perfekcja', 35, 'elon_musk.png', '978-83-240-3440-6', 3, 1, 1);
INSERT INTO PRODUCTS (PRD_NAME, PRD_PRICE, PRD_IMG, PRD_ISBN, PRD_CAT_ID, PRD_PTYP_ID, PRD_DRES_ID)
VALUES ('Systemy operacyjne. Wydanie IV', 76, 'elon_musk.png', '978-83-240-3440-6', 3, 1, 1);
INSERT INTO PRODUCTS (PRD_NAME, PRD_PRICE, PRD_IMG, PRD_ISBN, PRD_CAT_ID, PRD_PTYP_ID, PRD_DRES_ID)
VALUES ('Python. Wprowadzenie. Wydanie IV', 68, 'elon_musk.png', '978-83-240-3440-6', 3, 1, 1);
INSERT INTO PRODUCTS (PRD_NAME, PRD_PRICE, PRD_IMG, PRD_ISBN, PRD_CAT_ID, PRD_PTYP_ID, PRD_DRES_ID)
VALUES ('Sieci komputerowe. Wydanie V', 64, 'elon_musk.png', '978-83-240-3440-6', 3, 1, 1);
INSERT INTO PRODUCTS (PRD_NAME, PRD_PRICE, PRD_IMG, PRD_ISBN, PRD_CAT_ID, PRD_PTYP_ID, PRD_DRES_ID)
VALUES ('HTML i CSS. Zaprojektuj i zbuduj witrynę WWW', 73, 'elon_musk.png', '978-83-240-3440-6', 3, 1, 1);

