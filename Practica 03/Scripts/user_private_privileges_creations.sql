/* ============================================================
   CONFIGURACIÓN DE USUARIOS, ROLES Y PRIVILEGIOS
   BASE DE DATOS: db_test_7b
   ============================================================ */

USE db_test_7b;


/* ============================================================
   VERIFICAR TABLAS NECESARIAS
   ============================================================ */

SHOW TABLES;


/* ============================================================
   VERIFICAR OBJETOS QUE PODRÍAN USAR USUARIOS ELIMINADOS
   COMO DEFINER
   ============================================================ */

SELECT
    TRIGGER_SCHEMA,
    TRIGGER_NAME,
    EVENT_OBJECT_TABLE,
    DEFINER
FROM information_schema.TRIGGERS
WHERE DEFINER IN (
    'Diego.Garrido@%',
    'Marianna.Mayte@%',
    'Jeysi.Damari@%',
    'Josue.Oloarte@%',
    'John@%'
);


SELECT
    ROUTINE_SCHEMA,
    ROUTINE_NAME,
    ROUTINE_TYPE,
    DEFINER
FROM information_schema.ROUTINES
WHERE DEFINER IN (
    'Diego.Garrido@%',
    'Marianna.Mayte@%',
    'Jeysi.Damari@%',
    'Josue.Oloarte@%',
    'John@%'
);


/* ============================================================
   ELIMINAR USUARIOS ANTERIORES QUE YA NO SE UTILIZARÁN
   ============================================================ */

DROP USER IF EXISTS 'Diego.Garrido'@'%';
DROP USER IF EXISTS 'Marianna.Mayte'@'%';
DROP USER IF EXISTS 'Jeysi.Damari'@'%';
DROP USER IF EXISTS 'Josue.Oloarte'@'%';
DROP USER IF EXISTS 'John'@'%';


/* ============================================================
   CREACIÓN DE USUARIOS
   ============================================================ */

/* SUPER ADMIN */
CREATE USER IF NOT EXISTS 'Victor.Manuel'@'%'
IDENTIFIED BY '240852';


/* ADMIN */
CREATE USER IF NOT EXISTS 'marco.ramirez'@'%'
IDENTIFIED BY 'qwerty123';


/* SUPPORT */
CREATE USER IF NOT EXISTS 'Rodolfo.cs'@'%'
IDENTIFIED BY '240836';


/* SELLER */
CREATE USER IF NOT EXISTS 'angel'@'%'
IDENTIFIED BY '240046';

CREATE USER IF NOT EXISTS 'diego'@'%'
IDENTIFIED BY '240709';


/* BUYER */
CREATE USER IF NOT EXISTS 'osmar'@'%'
IDENTIFIED BY '240036';


/* COMMON USER */
CREATE USER IF NOT EXISTS 'samuel'@'%'
IDENTIFIED BY '240023';


/* USER NOT REGISTERED */
CREATE USER IF NOT EXISTS 'jorge'@'%'
IDENTIFIED BY '240456';


/* ============================================================
   CREACIÓN DE ROLES
   ============================================================ */

CREATE ROLE IF NOT EXISTS 'super_admin';

CREATE ROLE IF NOT EXISTS 'admin';

CREATE ROLE IF NOT EXISTS 'seller';

CREATE ROLE IF NOT EXISTS 'buyer';

CREATE ROLE IF NOT EXISTS 'support';

CREATE ROLE IF NOT EXISTS 'common_user';

CREATE ROLE IF NOT EXISTS 'user_not_registered';


/* ============================================================
   PRIVILEGIOS DE SUPER ADMIN
   ============================================================ */

GRANT ALL PRIVILEGES
ON *.*
TO 'super_admin'
WITH GRANT OPTION;


/* ============================================================
   PRIVILEGIOS DE ADMIN
   ============================================================ */

GRANT ALL PRIVILEGES
ON db_test_7b.*
TO 'admin';


/* ============================================================
   PRIVILEGIOS DE SELLER
   ============================================================ */

GRANT SELECT, INSERT, UPDATE, DELETE
ON db_test_7b.tb_products
TO 'seller';


/* ============================================================
   PRIVILEGIOS DE BUYER
   ============================================================ */

GRANT SELECT
ON db_test_7b.tb_products
TO 'buyer';


/* ============================================================
   PRIVILEGIOS DE SUPPORT
   ============================================================ */

GRANT SELECT, INSERT, UPDATE
ON db_test_7b.tb_users
TO 'support';

GRANT SELECT, INSERT, UPDATE
ON db_test_7b.tb_categories
TO 'support';


/* ============================================================
   PRIVILEGIOS DE COMMON USER
   ============================================================ */

GRANT SELECT
ON db_test_7b.*
TO 'common_user';


/* ============================================================
   PRIVILEGIOS DE USER NOT REGISTERED
   ============================================================ */

GRANT SELECT
ON db_test_7b.tb_products
TO 'user_not_registered';


/* ============================================================
   ASIGNACIÓN DE ROLES A LOS USUARIOS
   ============================================================ */

/* SUPER ADMIN — VICTOR */
GRANT 'super_admin'
TO 'Victor.Manuel'@'%';


/* ADMIN — MARCO */
GRANT 'admin'
TO 'marco.ramirez'@'%';


/* SUPPORT — RODOLFO */
GRANT 'support'
TO 'Rodolfo.cs'@'%';


/* SELLER — ANGEL */
GRANT 'seller'
TO 'angel'@'%';


/* SELLER — DIEGO */
GRANT 'seller'
TO 'diego'@'%';


/* BUYER — OSMAR */
GRANT 'buyer'
TO 'osmar'@'%';


/* COMMON USER — SAMUEL */
GRANT 'common_user'
TO 'samuel'@'%';


/* USER NOT REGISTERED — JORGE */
GRANT 'user_not_registered'
TO 'jorge'@'%';


/* ============================================================
   ESTABLECER ROLES PREDETERMINADOS
   ============================================================ */

/* VICTOR — SUPER ADMIN */
SET DEFAULT ROLE 'super_admin'
TO 'Victor.Manuel'@'%';


/* MARCO — ADMIN */
SET DEFAULT ROLE 'admin'
TO 'marco.ramirez'@'%';


/* RODOLFO — SUPPORT */
SET DEFAULT ROLE 'support'
TO 'Rodolfo.cs'@'%';


/* ANGEL — SELLER */
SET DEFAULT ROLE 'seller'
TO 'angel'@'%';


/* DIEGO — SELLER */
SET DEFAULT ROLE 'seller'
TO 'diego'@'%';


/* OSMAR — BUYER */
SET DEFAULT ROLE 'buyer'
TO 'osmar'@'%';


/* SAMUEL — COMMON USER */
SET DEFAULT ROLE 'common_user'
TO 'samuel'@'%';


/* JORGE — USER NOT REGISTERED */
SET DEFAULT ROLE 'user_not_registered'
TO 'jorge'@'%';


/* ============================================================
   VERIFICACIÓN DE PRIVILEGIOS DE LOS USUARIOS
   ============================================================ */

SHOW GRANTS FOR 'Victor.Manuel'@'%';

SHOW GRANTS FOR 'marco.ramirez'@'%';

SHOW GRANTS FOR 'Rodolfo.cs'@'%';

SHOW GRANTS FOR 'angel'@'%';

SHOW GRANTS FOR 'diego'@'%';

SHOW GRANTS FOR 'osmar'@'%';

SHOW GRANTS FOR 'samuel'@'%';

SHOW GRANTS FOR 'jorge'@'%';


/* ============================================================
   VERIFICACIÓN DE PRIVILEGIOS DE LOS ROLES
   ============================================================ */

SHOW GRANTS FOR 'super_admin';

SHOW GRANTS FOR 'admin';

SHOW GRANTS FOR 'seller';

SHOW GRANTS FOR 'buyer';

SHOW GRANTS FOR 'support';

SHOW GRANTS FOR 'common_user';

SHOW GRANTS FOR 'user_not_registered';


/* ============================================================
   VERIFICACIÓN DE ROLES ASIGNADOS
   ============================================================ */

SELECT
    FROM_USER,
    TO_USER
FROM mysql.role_edges;


/* ============================================================
   VERIFICACIÓN DE ROLES PREDETERMINADOS
   ============================================================ */

SELECT
    DEFAULT_ROLE_USER,
    DEFAULT_ROLE_HOST,
    DEFAULT_ROLE
FROM mysql.default_roles;


/* ============================================================
   VERIFICACIÓN GENERAL DE USUARIOS
   ============================================================ */

SELECT
    User,
    Host
FROM mysql.user
WHERE User IN (
    'Victor.Manuel',
    'marco.ramirez',
    'Rodolfo.cs',
    'angel',
    'diego',
    'osmar',
    'samuel',
    'jorge'
);


/* ============================================================
   TABLA FINAL DE USUARIOS Y ROLES
   ============================================================ */

SELECT
    FROM_USER AS rol,
    TO_USER AS usuario
FROM mysql.role_edges
WHERE TO_USER IN (
    'Victor.Manuel',
    'marco.ramirez',
    'Rodolfo.cs',
    'angel',
    'diego',
    'osmar',
    'samuel',
    'jorge'
);


/* ============================================================
   TABLA FINAL DE USUARIOS Y ROLES PREDETERMINADOS
   ============================================================ */

SELECT
    DEFAULT_ROLE_USER AS usuario,
    DEFAULT_ROLE_HOST AS host,
    DEFAULT_ROLE AS rol_predeterminado
FROM mysql.default_roles
WHERE DEFAULT_ROLE_USER IN (
    'Victor.Manuel',
    'marco.ramirez',
    'Rodolfo.cs',
    'angel',
    'diego',
    'osmar',
    'samuel',
    'jorge'
);


/* ============================================================
   VERIFICACIÓN DE PRIVILEGIOS DEL ROL SUPER ADMIN
   ============================================================ */

SHOW GRANTS FOR 'super_admin';


/* ============================================================
   MENSAJE DE CONFIRMACIÓN
   ============================================================ */

SELECT
    'Los usuarios, roles y privilegios han sido configurados correctamente'
    AS mensaje;