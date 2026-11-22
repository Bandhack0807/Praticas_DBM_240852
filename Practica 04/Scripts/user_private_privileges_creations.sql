/*
============================================================
CONFIGURACIÓN COMPLETA DE USUARIOS, ROLES Y PRIVILEGIOS
BASE DE DATOS: db_test_victor_7b
COMPATIBILIDAD: MySQL 8.0+
============================================================
*/

USE db_test_victor_7b;


/*
============================================================
1. VERIFICACIÓN DE TABLAS
============================================================
*/

SHOW TABLES;


/*
============================================================
2. CREACIÓN DE USUARIOS
============================================================
*/

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

/* Usuarios de middleware */

CREATE USER IF NOT EXISTS 'app_web'@'%'
IDENTIFIED BY 'web123';

CREATE USER IF NOT EXISTS 'app_mobile'@'%'
IDENTIFIED BY 'mobile890';


/*
============================================================
3. CREACIÓN DE ROLES
============================================================
*/

CREATE ROLE IF NOT EXISTS 'super_admin'@'%';
CREATE ROLE IF NOT EXISTS 'admin'@'%';
CREATE ROLE IF NOT EXISTS 'seller'@'%';
CREATE ROLE IF NOT EXISTS 'buyer'@'%';
CREATE ROLE IF NOT EXISTS 'support'@'%';
CREATE ROLE IF NOT EXISTS 'common_user'@'%';
CREATE ROLE IF NOT EXISTS 'user_not_registered'@'%';


/*
============================================================
4. PRIVILEGIOS DEL ROL SUPER ADMIN
============================================================
*/

GRANT ALL PRIVILEGES
ON *.*
TO 'super_admin'@'%'
WITH GRANT OPTION;


/*
============================================================
5. PRIVILEGIOS DEL ROL ADMIN
============================================================
*/

GRANT ALL PRIVILEGES
ON db_test_victor_7b.*
TO 'admin'@'%';


/*
============================================================
6. PRIVILEGIOS DEL ROL SELLER
============================================================
*/

GRANT SELECT, INSERT, UPDATE, DELETE
ON db_test_victor_7b.tb_products
TO 'seller'@'%';


/*
============================================================
7. PRIVILEGIOS DEL ROL BUYER
============================================================
*/

GRANT SELECT
ON db_test_victor_7b.tb_products
TO 'buyer'@'%';


/*
============================================================
8. PRIVILEGIOS DEL ROL SUPPORT
============================================================
*/

GRANT SELECT, INSERT, UPDATE
ON db_test_victor_7b.tb_users
TO 'support'@'%';

GRANT SELECT, INSERT, UPDATE
ON db_test_victor_7b.tb_people
TO 'support'@'%';

GRANT SELECT, INSERT, UPDATE
ON db_test_victor_7b.tb_user_addresses
TO 'support'@'%';

GRANT SELECT, INSERT, UPDATE
ON db_test_victor_7b.tbc_categories
TO 'support'@'%';

GRANT SELECT, INSERT, UPDATE
ON db_test_victor_7b.tbd_products_categories
TO 'support'@'%';


/*
============================================================
9. PRIVILEGIOS DEL ROL COMMON USER
============================================================
*/

GRANT SELECT
ON db_test_victor_7b.*
TO 'common_user'@'%';


/*
============================================================
10. PRIVILEGIOS DEL ROL USER NOT REGISTERED
============================================================
*/

GRANT SELECT
ON db_test_victor_7b.tb_products
TO 'user_not_registered'@'%';


/*
============================================================
11. MODIFICACIÓN DE PRIVILEGIOS EXECUTE
============================================================
*/

-- Se retira EXECUTE del rol user_not_registered para evitar
-- que se herede por todos los usuarios con dicho rol.
REVOKE EXECUTE
ON PROCEDURE db_test_victor_7b.sp_register_new_user
FROM 'user_not_registered'@'%';

-- El permiso EXECUTE se concede directamente a las cuentas
-- de la aplicación web y móvil.
GRANT EXECUTE
ON PROCEDURE db_test_victor_7b.sp_register_new_user
TO 'app_web'@'%';

GRANT EXECUTE
ON PROCEDURE db_test_victor_7b.sp_register_new_user
TO 'app_mobile'@'%';


/*
============================================================
12. ASIGNACIÓN DE ROLES A LOS USUARIOS
============================================================
*/

GRANT 'super_admin'@'%'
TO 'Victor.Manuel'@'%';

GRANT 'admin'@'%'
TO 'marco.ramirez'@'%';

GRANT 'support'@'%'
TO 'Rodolfo.cs'@'%';

GRANT 'seller'@'%'
TO 'angel'@'%';

GRANT 'seller'@'%'
TO 'diego'@'%';

GRANT 'buyer'@'%'
TO 'osmar'@'%';

GRANT 'common_user'@'%'
TO 'samuel'@'%';

GRANT 'user_not_registered'@'%'
TO 'jorge'@'%';

/* Middleware */

GRANT 'user_not_registered'@'%'
TO 'app_web'@'%';

GRANT 'user_not_registered'@'%'
TO 'app_mobile'@'%';


/*
============================================================
13. CONFIGURACIÓN DE ROLES PREDETERMINADOS
============================================================
*/

SET DEFAULT ROLE 'super_admin'@'%'
TO 'Victor.Manuel'@'%';

SET DEFAULT ROLE 'admin'@'%'
TO 'marco.ramirez'@'%';

SET DEFAULT ROLE 'support'@'%'
TO 'Rodolfo.cs'@'%';

SET DEFAULT ROLE 'seller'@'%'
TO 'angel'@'%';

SET DEFAULT ROLE 'seller'@'%'
TO 'diego'@'%';

SET DEFAULT ROLE 'buyer'@'%'
TO 'osmar'@'%';

SET DEFAULT ROLE 'common_user'@'%'
TO 'samuel'@'%';

SET DEFAULT ROLE 'user_not_registered'@'%'
TO 'jorge'@'%';

SET DEFAULT ROLE 'user_not_registered'@'%'
TO 'app_web'@'%';

SET DEFAULT ROLE 'user_not_registered'@'%'
TO 'app_mobile'@'%';


/*
============================================================
14. VERIFICACIÓN DE CUENTAS
============================================================
*/

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
    'jorge',
    'app_web',
    'app_mobile'
)
ORDER BY User, Host;


/*
============================================================
15. VERIFICACIÓN DE ROLES ASIGNADOS
============================================================
*/

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
    'jorge',
    'app_web',
    'app_mobile'
)
ORDER BY TO_USER, FROM_USER;


/*
============================================================
16. VERIFICACIÓN DE ROLES PREDETERMINADOS
============================================================
*/

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
    'jorge',
    'app_web',
    'app_mobile'
)
ORDER BY USER, HOST;


/*
============================================================
17. VERIFICACIÓN DE PROCEDIMIENTOS
============================================================
*/

SELECT
    ROUTINE_SCHEMA,
    ROUTINE_NAME,
    ROUTINE_TYPE,
    DEFINER,
    SECURITY_TYPE
FROM information_schema.ROUTINES
WHERE ROUTINE_SCHEMA = 'db_test_victor_7b'
AND ROUTINE_NAME IN (
    'sp_register_new_user',
    'sp_soft_delete_product',
    'sp_restore_product'
)
ORDER BY ROUTINE_NAME;


/*
============================================================
18. VERIFICACIÓN DE PRIVILEGIOS DE LOS ROLES
============================================================
*/

SHOW GRANTS FOR 'super_admin'@'%';
SHOW GRANTS FOR 'admin'@'%';
SHOW GRANTS FOR 'seller'@'%';
SHOW GRANTS FOR 'buyer'@'%';
SHOW GRANTS FOR 'support'@'%';
SHOW GRANTS FOR 'common_user'@'%';
SHOW GRANTS FOR 'user_not_registered'@'%';


/*
============================================================
19. VERIFICACIÓN DE PRIVILEGIOS EFECTIVOS
============================================================
*/

SHOW GRANTS FOR 'Victor.Manuel'@'%'
USING 'super_admin'@'%';

SHOW GRANTS FOR 'marco.ramirez'@'%'
USING 'admin'@'%';

SHOW GRANTS FOR 'angel'@'%'
USING 'seller'@'%';

SHOW GRANTS FOR 'diego'@'%'
USING 'seller'@'%';

SHOW GRANTS FOR 'Rodolfo.cs'@'%'
USING 'support'@'%';

SHOW GRANTS FOR 'osmar'@'%'
USING 'buyer'@'%';

SHOW GRANTS FOR 'samuel'@'%'
USING 'common_user'@'%';

SHOW GRANTS FOR 'jorge'@'%'
USING 'user_not_registered'@'%';

SHOW GRANTS FOR 'app_web'@'%'
USING 'user_not_registered'@'%';

SHOW GRANTS FOR 'app_mobile'@'%'
USING 'user_not_registered'@'%';


/*
============================================================
20. VERIFICACIÓN DE PRIVILEGIOS DIRECTOS DEL MIDDLEWARE
============================================================
*/

SELECT
    GRANTEE,
    TABLE_SCHEMA,
    TABLE_NAME,
    PRIVILEGE_TYPE
FROM information_schema.TABLE_PRIVILEGES
WHERE TABLE_SCHEMA = 'db_test_victor_7b'
AND GRANTEE IN (
    '''app_web''@''%''',
    '''app_mobile''@''%'''
)
ORDER BY GRANTEE, TABLE_NAME, PRIVILEGE_TYPE;


/*
============================================================
21. COMPROBACIÓN FINAL
============================================================
*/

SELECT
    (
        SELECT COUNT(*)
        FROM mysql.user
        WHERE User IN (
            'Victor.Manuel',
            'marco.ramirez',
            'Rodolfo.cs',
            'angel',
            'diego',
            'osmar',
            'samuel',
            'jorge',
            'app_web',
            'app_mobile'
        )
    ) AS cuentas_encontradas,

    (
        SELECT COUNT(*)
        FROM mysql.user
        WHERE User IN (
            'super_admin',
            'admin',
            'seller',
            'buyer',
            'support',
            'common_user',
            'user_not_registered'
        )
    ) AS roles_encontrados,

    (
        SELECT COUNT(*)
        FROM mysql.role_edges
        WHERE TO_USER IN (
            'Victor.Manuel',
            'marco.ramirez',
            'Rodolfo.cs',
            'angel',
            'diego',
            'osmar',
            'samuel',
            'jorge',
            'app_web',
            'app_mobile'
        )
    ) AS asignaciones_de_roles;


SELECT
    'Configuración de usuarios, roles y privilegios finalizada.'
    AS mensaje;