/* ============================================================
   CONFIGURACIÓN DE USUARIOS, ROLES Y PRIVILEGIOS
   BASE DE DATOS: db_test_7b
   ============================================================ */

USE db_test_7b;


/* ============================================================
   1. VERIFICAR TABLAS
   ============================================================ */

SHOW TABLES;


/* ============================================================
   2. CREACIÓN DE USUARIOS
   ============================================================ */

CREATE USER IF NOT EXISTS 'Victor.Manuel'@'%'
IDENTIFIED BY '240852';

CREATE USER IF NOT EXISTS 'marco.ramirez'@'%'
IDENTIFIED BY 'qwerty123';

CREATE USER IF NOT EXISTS 'Rodolfo.cs'@'%'
IDENTIFIED BY '240836';

CREATE USER IF NOT EXISTS 'angel'@'%'
IDENTIFIED BY '240046';

CREATE USER IF NOT EXISTS 'diego'@'%'
IDENTIFIED BY '240709';

CREATE USER IF NOT EXISTS 'osmar'@'%'
IDENTIFIED BY '240036';

CREATE USER IF NOT EXISTS 'samuel'@'%'
IDENTIFIED BY '240023';

CREATE USER IF NOT EXISTS 'jorge'@'%'
IDENTIFIED BY '240456';


/* ============================================================
   3. CREACIÓN DE ROLES
   ============================================================ */

CREATE ROLE IF NOT EXISTS 'super_admin';
CREATE ROLE IF NOT EXISTS 'admin';
CREATE ROLE IF NOT EXISTS 'seller';
CREATE ROLE IF NOT EXISTS 'buyer';
CREATE ROLE IF NOT EXISTS 'support';
CREATE ROLE IF NOT EXISTS 'common_user';
CREATE ROLE IF NOT EXISTS 'user_not_registered';


/* ============================================================
   4. PRIVILEGIOS DE SUPER ADMIN
   ============================================================ */

GRANT ALL PRIVILEGES
ON *.*
TO 'super_admin'
WITH GRANT OPTION;


/* ============================================================
   5. PRIVILEGIOS DE ADMIN
   ============================================================ */

GRANT ALL PRIVILEGES
ON db_test_7b.*
TO 'admin';


/* ============================================================
   6. PRIVILEGIOS DE SELLER
   ============================================================ */

GRANT SELECT, INSERT, UPDATE, DELETE
ON db_test_7b.tb_products
TO 'seller';


/* ============================================================
   7. PRIVILEGIOS DE BUYER
   ============================================================ */

GRANT SELECT
ON db_test_7b.tb_products
TO 'buyer';


/* ============================================================
   8. PRIVILEGIOS DE SUPPORT
   ============================================================ */

GRANT SELECT, INSERT, UPDATE
ON db_test_7b.tb_users
TO 'support';

GRANT SELECT, INSERT, UPDATE
ON db_test_7b.tb_categories
TO 'support';

GRANT SELECT, INSERT, UPDATE
ON db_test_7b.tb_product_categories
TO 'support';


/* ============================================================
   9. PRIVILEGIOS DE COMMON USER
   ============================================================ */

GRANT SELECT
ON db_test_7b.*
TO 'common_user';


/* ============================================================
   10. PRIVILEGIOS DE USER NOT REGISTERED
   ============================================================ */

GRANT SELECT
ON db_test_7b.tb_products
TO 'user_not_registered';


/* ============================================================
   11. ASIGNACIÓN DE ROLES
   ============================================================ */

GRANT 'super_admin'
TO 'Victor.Manuel'@'%';

GRANT 'admin'
TO 'marco.ramirez'@'%';

GRANT 'support'
TO 'Rodolfo.cs'@'%';

GRANT 'seller'
TO 'angel'@'%';

GRANT 'seller'
TO 'diego'@'%';

GRANT 'buyer'
TO 'osmar'@'%';

GRANT 'common_user'
TO 'samuel'@'%';

GRANT 'user_not_registered'
TO 'jorge'@'%';


/* ============================================================
   12. ROLES PREDETERMINADOS
   ============================================================ */

SET DEFAULT ROLE 'super_admin'
TO 'Victor.Manuel'@'%';

SET DEFAULT ROLE 'admin'
TO 'marco.ramirez'@'%';

SET DEFAULT ROLE 'support'
TO 'Rodolfo.cs'@'%';

SET DEFAULT ROLE 'seller'
TO 'angel'@'%';

SET DEFAULT ROLE 'seller'
TO 'diego'@'%';

SET DEFAULT ROLE 'buyer'
TO 'osmar'@'%';

SET DEFAULT ROLE 'common_user'
TO 'samuel'@'%';

SET DEFAULT ROLE 'user_not_registered'
TO 'jorge'@'%';


/* ============================================================
   13. VERIFICAR USUARIOS
   ============================================================ */

SELECT
    User,
    Host,
    account_locked,
    password_expired
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
)
ORDER BY User;


/* ============================================================
   14. VERIFICAR PRIVILEGIOS DE LOS USUARIOS
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
   15. VERIFICAR PRIVILEGIOS DE LOS ROLES
   ============================================================ */

SHOW GRANTS FOR 'super_admin';
SHOW GRANTS FOR 'admin';
SHOW GRANTS FOR 'seller';
SHOW GRANTS FOR 'buyer';
SHOW GRANTS FOR 'support';
SHOW GRANTS FOR 'common_user';
SHOW GRANTS FOR 'user_not_registered';


/* ============================================================
   16. VERIFICAR ASIGNACIONES DE ROLES
   ============================================================ */

SELECT
    FROM_USER AS rol,
    FROM_HOST AS host_rol,
    TO_USER AS usuario,
    TO_HOST AS host_usuario,
    WITH_ADMIN_OPTION
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
)
ORDER BY TO_USER, FROM_USER;


/* ============================================================
   17. VERIFICAR ROLES PREDETERMINADOS
   ============================================================ */

SELECT
    USER AS usuario,
    HOST AS host_usuario,
    DEFAULT_ROLE_USER AS rol_predeterminado,
    DEFAULT_ROLE_HOST AS host_rol
FROM mysql.default_roles
WHERE USER IN (
    'Victor.Manuel',
    'marco.ramirez',
    'Rodolfo.cs',
    'angel',
    'diego',
    'osmar',
    'samuel',
    'jorge'
)
ORDER BY USER, HOST;


/* ============================================================
   18. MENSAJE FINAL
   ============================================================ */

SELECT
    'Configuración verificada'
    AS mensaje;