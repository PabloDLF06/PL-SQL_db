-- Lección 1: Introducción a PL/SQL y conceptos básicos

DELIMITER //
CREATE PROCEDURE hola_mundo()
BEGIN
    SELECT 'Hola Mundo' AS mensaje;
END //
DELIMITER ;

-- Para ejecutar el procedimiento:
CALL hola_mundo();

DELIMITER //
CREATE PROCEDURE mostrar_fecha_actual()
BEGIN
    SELECT NOW() AS fecha_actual;
END //
DELIMITER ;

-- Para ejecutar el procedimiento:
CALL mostrar_fecha_actual();

-- Lección 2: Variables y tipos de datos en PL/SQL
-- Ejemplo práctico
DELIMITER //
CREATE PROCEDURE ejemplo_variables()
BEGIN
    -- Declaración de variables
    DECLARE edad INT DEFAULT 25;
    DECLARE nombre VARCHAR(50);
    DECLARE precio DECIMAL(10, 2);
    DECLARE fecha_actual DATE;
    DECLARE es_activo BOOLEAN;

    -- Asignación de valores
    SET nombre = 'Juan Pérez';
    SET precio = 199.99;
    SET fecha_actual = CURDATE(); -- Función para obtener la fecha actual
    SET es_activo = TRUE;

    -- Mostrar los valores
    SELECT edad, nombre, precio, fecha_actual, es_activo;
END //
DELIMITER ;

-- Para ejecutar el procedimiento:
CALL ejemplo_variables();

-- Variables especiales
DELIMITER //
CREATE PROCEDURE obtener_info_pista(IN id_pista INT)
BEGIN
    DECLARE tipo_pista VARCHAR(20);
    DECLARE precio_pista DECIMAL(10, 2);

    -- Capturar valores de una consulta
    SELECT tipo, precio INTO tipo_pista, precio_pista
    FROM pistas
    WHERE id = id_pista;

    -- Mostrar información
    SELECT CONCAT('La pista es de tipo ', tipo_pista, ' y su precio es ', precio_pista, '€') AS informacion;
END //

DELIMITER ;

-- Para ejecutar el procedimiento:
CALL obtener_info_pista(1);

-- Variables de usuario
SET @mi_variable = 'Valor';
SELECT @mi_variable;

-- Ámbito de las variables
-- Ejercicio práctico
DELIMITER //
CREATE PROCEDURE calcular_precio_con_descuento(IN id_pista_param INT, IN porcentaje_descuento INT)
BEGIN
    DECLARE precio_original DECIMAL(10, 2);
    DECLARE precio_con_descuento DECIMAL(10, 2);
    DECLARE nombre_tipo VARCHAR(20);

    -- Obtener el precio y el tipo de pista
    SELECT precio, tipo INTO precio_original, nombre_tipo
    FROM pistas
    WHERE id = id_pista_param;

    -- Calcular el precio con descuento
    SET precio_con_descuento = precio_original - (precio_original * porcentaje_descuento / 100);

    -- Mostrar el resultado
    SELECT
        id_pista_param AS id_pista,
        nombre_tipo AS tipo,
        precio_original AS precio_original,
        CONCAT(porcentaje_descuento, '%') AS descuento,
        precio_con_descuento AS precio_final;
END //

DELIMITER ;

-- Para ejecutar el procedimiento:
CALL calcular_precio_con_descuento(1, 10);

-- Lección 3: Estructuras de control en PL/SQL
-- La estructura IF-THEN-ELSE
IF condicion THEN
    -- Código si la condición es verdadera
ELSEIF otra_condicion THEN
    -- Código si la otra condición es verdadera
ELSE
    -- Código si ninguna condición es verdadera
END IF;

-- IF simple
DELIMITER //
CREATE PROCEDURE verificar_numero2(IN numero INT)
BEGIN
    IF numero > 0 THEN
        SELECT 'El numero es positivo' AS resultado;
    END IF;
END //
DELIMITER ;

-- Para ejecutar el procedimiento:
CALL verificar_numero2(5);

-- IF-THEN-ELSE
DELIMITER //
CREATE PROCEDURE verificar_par_impar(IN numero INT)
BEGIN
    IF MOD(numero, 2) = 0 THEN
        SELECT 'El numero es par' AS resultado;
    ELSE
        SELECT 'El numero es impar' AS resultado;
    END IF;
END //
DELIMITER ;

-- Para ejecutar el procedimiento:
CALL verificar_par_impar(7);

-- IF-THEN-ELSEIF-ELSE
DELIMITER //
CREATE PROCEDURE clasificar_edad(IN edad INT)
BEGIN
    IF edad < 18 THEN
        SELECT 'Menor de edad' AS clasificacion;
    ELSEIF edad < 65 THEN
        SELECT 'Adulto' AS clasificacion;
    ELSE
        SELECT 'Anciano' AS clasificacion;
    END IF;
END //
DELIMITER ;

-- Para ejecutar el procedimiento:
CALL clasificar_edad(30);

-- Condiciones anidadas
DELIMITER //
CREATE PROCEDURE IF NOT EXISTS verificar_Acceso_pista(IN id_pista_param INT, IN edad_usuario INT)
BEGIN
    DECLARE tipo_pista VARCHAR(20);

    -- Obtener el tipo de pista
    SELECT tipo INTO tipo_pista
    FROM pistas
    WHERE id = id_pista_param;

    IF tipo_pista = 'futbol' THEN
        IF edad_usuario < 12 THEN
            SELECT 'Acceso permitido con supervision' AS resultado;
        ELSE
            SELECT 'Acceso permitido' AS resultado;
        END IF;
    ELSEIF tipo_pista = 'tenis' THEN
        IF edad_usuario < 10 THEN
            SELECT 'Acceso denegado por edad' AS resultado;
        ELSE
            SELECT 'Acceso permitido' AS resultado;
        END IF;
    ELSE
        SELECT 'Acceso permitido' AS resultado;
    END IF;
END //
DELIMITER ;

-- Para ejecutar el procedimiento:
CALL verificar_Acceso_pista(1, 11);

-- Estructura CASE
-- CASE simple
DELIMITER //
CREATE PROCEDURE obtener_precio_por_tipo(IN tipo_pista_param VARCHAR(20))
BEGIN
    DECLARE precio_base DECIMAL(10, 2);

    SET precio_base = CASE tipo_pista_param
        WHEN 'futbol' THEN 25.00
        WHEN 'tenis' THEN 20.00
        WHEN 'baloncesto' THEN 20.00
        WHEN 'ping-pong' THEN 15.00
        ELSE 10.00
    END;

    SELECT CONCAT('El precio base para una pista de ', tipo_pista_param, ' es ', precio_base, '€') AS informacion;
END //
DELIMITER ;

-- Para ejecutar el procedimiento:
CALL obtener_precio_por_tipo('tenis');

-- CASE buscado
DELIMITER //
CREATE PROCEDURE obtener_pista_por_precio(IN id_pista_param INT)
BEGIN
    DECLARE precio_pista DECIMAL(10, 2);
    DECLARE categoria VARCHAR(20);

    -- Obtener el precio de la pista
    SELECT precio INTO precio_pista
    FROM pistas
    WHERE id = id_pista_param;

    SET categoria = CASE
        WHEN precio_pista < 10 THEN 'Económica'
        WHEN precio_pista < 20 THEN 'Estándar'
        WHEN precio_pista < 30 THEN 'Premium'
        ELSE 'Lujo'
    END;

    SELECT CONCAT('La pista con ID ', id_pista_param, ' es de categoría ', categoria) AS clasificacion;
END //
DELIMITER ;

-- Para ejecutar el procedimiento:
CALL obtener_pista_por_precio(1);

-- Ejemplo práctico: Descuento por tipo de usuario
-- Vamos a crear un procedimiento que calcule el precio final de una reserva aplicando diferentes descuentos según el tipo de usuario:
DELIMITER //
CREATE PROCEDURE calcular_precio_reserva(
    IN id_pista_param INT,
    IN dni_usuario_param CHAR(9)
)
BEGIN
    DECLARE precio_pista DECIMAL(10, 2);
    DECLARE descuento_usuario DECIMAL(10, 2);
    DECLARE precio_final DECIMAL(10, 2);
    DECLARE num_reservas INT;

    -- Obtener el precio de la pista
    SELECT precio INTO precio_pista
    FROM pistas
    WHERE id = id_pista_param;

    -- Obtener el descuento base del usuario
    SELECT descuento INTO descuento_usuario
    FROM usuarios
    WHERE dni = dni_usuario_param;

    -- Contar cuántas reservas ha hecho el usuario
    SELECT COUNT(*) INTO num_reservas
    FROM usuario_reserva
    WHERE dni_usuario = dni_usuario_param;

    -- Aplicar descuento adicional según el número de reservas
    IF num_reservas > 10 THEN
        SET descuento_usuario = descuento_usuario + 0.15; -- 15% adicional
    ELSEIF num_reservas > 5 THEN
        SET descuento_usuario = descuento_usuario + 0.10; -- 10% adicional
    ELSEIF num_reservas > 0 THEN
        SET descuento_usuario = descuento_usuario + 0.05; -- 5% adicional
    END IF;

    -- Calcular el precio final
    SET precio_final = precio_pista - (1 - descuento_usuario);

    -- Mostrar el resultado
    SELECT id_pista_param AS id_pista,
           precio_pista AS precio_original,
           CONCAT(descuento_usuario * 100, '%') AS descuento_aplicado,
              precio_final AS precio_final;
END //
DELIMITER ;

-- Para ejecutar el procedimiento:
CALL calcular_precio_reserva(1, '12345678A');

-- Ejercicio práctico
DELIMITER //
CREATE PROCEDURE verificar_disponibilidad_pista(
    IN id_pista_param INT,
    IN fecha_reserva DATE
)
BEGIN
    DECLARE reservas_existentes INT;
    DECLARE pista_operativa BOOLEAN;
    DECLARE pista_clausurada BOOLEAN;

    -- Verificar si la pista está clausurada
    SELECT COUNT(*) INTO pista_clausurada
    FROM pistas_cerradas
    WHERE id_pista = id_pista_param;

    IF pista_clausurada > 0 THEN
        SELECT 'La pista está clausurada' AS estado;
    ELSE
        -- verificar si la pista está operativa
        SELECT operativa INTO pista_operativa
        FROM pistas_abiertas
        WHERE id_pista = id_pista_param;

        IF pista_operativa = 0 THEN
            SELECT 'La pista no está operativa' AS estado;
        ELSE
            -- Verificar si hay reservas para esa fecha
            SELECT COUNT(*) INTO reservas_existentes
            FROM reservas
            WHERE id_pista = id_pista_param
            AND DATE(fecha_uso) = DATE(fecha_reserva);

            IF reservas_existentes > 0 THEN
                SELECT 'La pista no está disponible en esa fecha' AS estado;
            ELSE
                SELECT 'La pista está disponible' AS estado;
            END IF;
        END IF;
    END IF;
END //
DELIMITER ;

-- Lección 4: Estructuras de control iterativas en PL/SQL
-- Bucle LOOP

etiqueta: LOOP
    -- Instrucciones a ejecutar
    IF condicion_salida THEN
        LEAVE etiqueta; -- Salir del bucle
    END IF;
END LOOP etiqueta;

-- Ejemplo de bucle LOOP
DELIMITER //

CREATE PROCEDURE contar_hasta_diez()
BEGIN
    DECLARE contador INT DEFAULT 1;

    bucle: LOOP
        SELECT contador = contador + 1;

        IF contador > 10 THEN
            LEAVE bucle; -- Salir del bucle
        END IF;
    END LOOP bucle;
END //
DELIMITER ;

-- Para ejecutar el procedimiento:
CALL contar_hasta_diez();

-- Bucle REPEAT

etiqueta: REPEAT
    -- Instrucciones a ejecutar
UNTIL condicion_salida
END REPEAT etiqueta;

-- Ejemplo de bucle REPEAT
DELIMITER //
CREATE PROCEDURE contar_hasta_diez_repeat()
BEGIN
    DECLARE contador INT DEFAULT 1;

    REPEAT
        SELECT contador = contador + 1;
        SET contador = contador + 1;
    UNTIL contador > 10
    END REPEAT;
END //
DELIMITER ;

-- Para ejecutar el procedimiento:
CALL contar_hasta_diez_repeat();

-- Bucle WHILE

etiqueta: WHILE condicion_salida DO
    -- Instrucciones a ejecutar
END WHILE etiqueta;

-- Ejemplo de bucle WHILE
DELIMITER //
CREATE PROCEDURE contar_hasta_diez_while()
BEGIN
    DECLARE contador INT DEFAULT 1;

    WHILE contador <= 10 DO
        SELECT contador;
        SET contador = contador + 1;
    END WHILE;
END //
DELIMITER ;

-- Para ejecutar el procedimiento:
CALL contar_hasta_diez_while();

-- Uso de LEAVE e ITERATE
-- LEAVE: Salir del bucle
-- ITERATE: Saltar a la siguiente iteración
DELIMITER //
CREATE PROCEDURE mostrar_numeros_pares_hasta_diez()
BEGIN
    DECLARE contador INT DEFAULT 0;

    bucle: LOOP
        SET contador = contador + 1;

        -- Si es impar, saltamos a la siguiente iteración
        IF MOD(contador, 2) <> 0 THEN
            ITERATE bucle;
        END IF;

        -- Mostramos solo los números pares
        SELECT contador;

        -- Si llegamos a 10, salimos del bucle
        IF contador >= 10 THEN
            LEAVE bucle;
        END IF;
    END LOOP bucle;
END //
DELIMITER ;

-- Para ejecutar el procedimiento:
CALL mostrar_numeros_pares_hasta_diez();

-- Ejemplo practico: Calcular el precio total de las reservas de un usuario
/*
Vamos a crear un procedimiento que calcule el precio total de todas las reservas
realizadas por un usuario utilizando un bucle:
*/
DELIMITER //
CREATE PROCEDURE calcular_precio_total_reservas(IN dni_usuario_param CHAR(9))
BEGIN
    DECLARE precio_total DECIMAL(10,2) DEFAULT 0;
    DECLARE precio_actual DECIMAL(10,2);
    DECLARE fin_cursor BOOLEAN DEFAULT FALSE;

    -- Declarar un cursor para recorrer las reservas del usuario
    DECLARE cursor_reservas CURSOR FOR
        SELECT r.precio
        FROM reservas r
        INNER JOIN usuario_reserva ur ON r.id = ur.id_reserva
        WHERE ur.dni_usuario = dni_usuario_param;

    -- Manejador para cuando no hay más filas
    DECLARE CONTINUE HANDLER FOR NOT FOUND SET fin_cursor = TRUE;

    -- Abrir el cursor
    OPEN cursor_reservas;

    -- Bucle para recorrer las reservas
    bucle_reservas: LOOP
        -- Obtener la siguiente reserva
        FETCH cursor_reservas INTO precio_actual;

        -- Salir si no hay más reservas
        IF fin_cursor THEN
            LEAVE bucle_reservas;
        END IF;

        -- Acumular el precio
        SET precio_total = precio_total + precio_actual;
    END LOOP bucle_reservas;

    -- Cerrar el cursor
    CLOSE cursor_reservas;

    -- Mostrar el resultado
    SELECT
        dni_usuario_param AS dni_usuario,
        precio_total AS total_gastado,
        (SELECT COUNT(*) FROM usuario_reserva WHERE dni_usuario = dni_usuario_param) AS num_reservas;
END //
DELIMITER ;

-- Para ejecutar el procedimiento:
CALL calcular_precio_total_reservas('12345678A');

-- Ejercicio práctico
/*
Crea un procedimiento llamado generar_informe_pistas que muestre un informe de las
pistas de un tipo específico (por ejemplo, 'futbol', 'tenis', etc.) mostrando su ID,
precio y el número de reservas que tiene cada una. Utiliza un bucle para recorrer las
pistas y mostrar la información.
*/
DELIMITER //
CREATE PROCEDURE generar_informe_pistas(IN tipo_pista_param VARCHAR(20))
BEGIN
    DECLARE id_pista_actual INT;
    DECLARE precio_actual DECIMAL(10,2);
    DECLARE num_reservas INT;
    DECLARE fin_cursor BOOLEAN DEFAULT FALSE;

    -- Declarar un cursor para recorrer las pistas del tipo especificado
    DECLARE cursor_pistas CURSOR FOR
        SELECT id, precio
        FROM pistas
        WHERE tipo = tipo_pista_param;

    -- Manejador para cuando no hay más filas
    DECLARE CONTINUE HANDLER FOR NOT FOUND SET fin_cursor = TRUE;

    -- Mostrar encabezado del informe
    SELECT CONCAT('Informe de pistas de tipo: ', tipo_pista_param) AS informe;

    -- Abrir el cursor
    OPEN cursor_pistas;

    -- Bucle para recorrer las pistas
    bucle_pistas: LOOP
        -- Obtener la siguiente pista
        FETCH cursor_pistas INTO id_pista_actual, precio_actual;

        -- Salir si no hay más pistas
        IF fin_cursor THEN
            LEAVE bucle_pistas;
        END IF;

        -- Contar el número de reservas para esta pista
        SELECT COUNT(*) INTO num_reservas
        FROM reservas
        WHERE id_pista = id_pista_actual;

        -- Mostrar la información de la pista
        SELECT
            id_pista_actual AS id_pista,
            precio_actual AS precio,
            num_reservas AS numero_reservas;
    END LOOP bucle_pistas;

    -- Cerrar el cursor
    CLOSE cursor_pistas;
END //
DELIMITER ;

-- Lección 5: Cursores y manejadores de errores en PL/SQL
-- Cursores en PL/SQL

-- Declar un cursor
DECLARE cursor_nombre CURSOR FOR consulta_sql;

-- Abrir el cursor
OPEN cursor_nombre;

-- Recuperar datos del cursor
FETCH cursor_nombre INTO variable1, variable2, ...;

-- Cerrar el cursor
CLOSE cursor_nombre;

-- Ejemplo de cursor
DELIMITER //
CREATE PROCEDURE listar_pistas_por_tipo(IN tipo_pista_param VARCHAR(20))
BEGIN
    DECLARE id_actual INT;
    DECLARE precio_actual DECIMAL(10, 2);
    DECLARE id_polideportivo_actual INT;
    DECLARE fin_cursor BOOLEAN DEFAULT FALSE;

    -- Declarar un cursor para recorrer las pistas del tipo especificado
    DECLARE cursor_pistas CURSOR FOR
        SELECT id, precio, id_polideportivo
        FROM pistas
        WHERE tipo = tipo_pista_param;

    -- Manejador para cuando no hay más filas
    DECLARE CONTINUE HANDLER FOR NOT FOUND SET fin_cursor = TRUE;

    -- Abrir el cursor
    OPEN cursor_pistas;

    -- Mostrar encabezado
    SELECT CONCAT('Listado de pistas de tipo: ', tipo_pista_param) AS mensaje;

    -- Bucle para recorrer el cursor
    bucle_pistas: LOOP
        -- Obtener la siguiente fila
        FETCH cursor_pistas INTO id_actual, precio_actual, id_polideportivo_actual;

        -- Salir si no hay más filas
        IF fin_cursor THEN
            LEAVE bucle_pistas;
        END IF;

        -- Mostrar la información de la pista
        SELECT
            id_actual AS id_pista,
            precio_actual AS precio,
            id_polideportivo_actual AS id_polideportivo;
    END LOOP bucle_pistas;

    -- Cerrar el cursor
    CLOSE cursor_pistas;
END //
DELIMITER ;

-- Para ejecutar el procedimiento:
CALL listar_pistas_por_tipo('futbol');

-- Manejadores de errores (HANDLER)

-- Sintaxis para declarar un manejador
DECLARE [CONTINUE | EXIT] HANDLER FOR condicion acción;

-- Ejemplo de manejador para NOT FOUND
DECLARE CONTINUE HANDLER FOR NOT FOUND SET fin_cursor = TRUE;

-- Ejemplo de manejador para un código de error específico
DECLARE EXIT HANDLER FOR 1062
    SELECT 'Error: Clave duplicada' AS error_mensaje;

-- Ejemplo completo: Procesamiento de empleados
DELIMITER //
CREATE PROCEDURE procesar_empleados()
BEGIN
    DECLARE done INT DEFAULT FALSE;
    DECLARE id_empleado INT;
    DECLARE nombre_empleado VARCHAR(110);

    -- Declarar el cursor
    DECLARE cursor_empleados CURSOR FOR
        SELECT id, nombre FROM empleados WHERE activo = 1;

    -- Declarar el manejador para el fin del cursor
    DECLARE CONTINUE HANDLER FOR NOT FOUND SET done = TRUE;

    -- Abrir el cursor
    OPEN cursor_empleados;

    -- Bucle para procesar los empleados
    REPEAT
        FETCH cursor_empleados INTO id_empleado, nombre_empleado;

        IF NOT done THEN
            -- Llamar a otro procedimiento para cada empleado
            CALL actualizar_salario(id_empleado, 1000);
        END IF;
    UNTIL done END REPEAT;

    -- Cerrar el cursor
    CLOSE cursor_empleados;
END //
DELIMITER ;

-- Para ejecutar el procedimiento:
CALL procesar_empleados();

-- Ejercicio práctico: Historial de reservas de un usuario
/*
Vamos a crear un procedimiento que muestre el historial de reservas
de un usuario utilizando cursores y manejadores de errores:
*/
DELIMITER //
CREATE PROCEDURE historial_reservas_usuario(IN dni_usuario_param CHAR(9))
BEGIN
    DECLARE id_reserva_actual INT;
    DECLARE fecha_reserva_actual DATETIME;
    DECLARE fecha_uso_actual DATETIME;
    DECLARE precio_actual DECIMAL(10,2);
    DECLARE tipo_pista_actual VARCHAR(20);
    DECLARE fin_cursor BOOLEAN DEFAULT FALSE;
    DECLARE contador INT DEFAULT 0;

    -- Declarar el cursor
    DECLARE cursor_historial CURSOR FOR
        SELECT r.id, r.fecha_reserva, r.fecha_uso, r.precio, p.tipo
        FROM reservas r
        INNER JOIN usuario_reserva ur ON r.id = ur.id_reserva
        INNER JOIN pistas p ON r.id_pista = p.id
        WHERE ur.dni_usuario = dni_usuario_param
        ORDER BY r.fecha_reserva DESC;

    -- Declarar el manejador
    DECLARE CONTINUE HANDLER FOR NOT FOUND SET fin_cursor = TRUE;

    -- Verificar si el usuario existe
    IF NOT EXISTS (SELECT 1 FROM usuarios WHERE dni = dni_usuario_param) THEN
        SELECT 'El usuario no existe' AS mensaje;
        LEAVE historial_reservas_usuario;
    END IF;

    -- Abrir el cursor
    OPEN cursor_historial;

    -- Mostrar encabezado
    SELECT CONCAT('Historial de reservas para el usuario con DNI: ', dni_usuario_param) AS mensaje;

    -- Bucle para recorrer el cursor
    bucle_historial: LOOP
        -- Obtener la siguiente reserva
        FETCH cursor_historial INTO id_reserva_actual, fecha_reserva_actual, fecha_uso_actual, precio_actual, tipo_pista_actual;

        -- Salir si no hay más reservas
        IF fin_cursor THEN
            LEAVE bucle_historial;
        END IF;

        -- Incrementar contador
        SET contador = contador + 1;

        -- Mostrar información de la reserva
        SELECT
            contador AS num,
            id_reserva_actual AS id_reserva,
            fecha_reserva_actual AS fecha_reserva,
            fecha_uso_actual AS fecha_uso,
            tipo_pista_actual AS tipo_pista,
            precio_actual AS precio;
    END LOOP bucle_historial;

    -- Si no hay reservas
    IF contador = 0 THEN
        SELECT 'El usuario no tiene reservas' AS mensaje;
    ELSE
        SELECT CONCAT('Total de reservas: ', contador) AS resumen;
    END IF;

    -- Cerrar el cursor
    CLOSE cursor_historial;
END //
DELIMITER ;

-- Lección 6: Procedimientos y funciones en PL/SQL

-- Sintaxis para crear un procedimiento

CREATE PROCEDURE nombre_proc
([param1 tipo, param2 tipo, ...])
BEGIN
    sentencias;
END


-- Sintaxis para crear una función

CREATE FUNCTION nombre_func
([param1 tipo, param2 tipo, ...])
RETURNS tipo
BEGIN
    sentencias;
    RETURN valor;
END

-- Parámetros en procedimientos y funciones
-- IN: Parámetro de entrada
-- OUT: Parámetro de salida
-- INOUT: Parámetro de entrada y salida

-- Ejemplo de procedimiento con diferentes tipos de parámetros
DELIMITER //
CREATE PROCEDURE calcular_precio_com_impuesto(
    IN precio_base DECIMAL(10, 2),
    IN porcentaje_impuesto INT,
    OUT precio_final DECIMAL(10, 2)
)
BEGIN
    SET precio_final = precio_base + (precio_base * porcentaje_impuesto / 100);
END //
DELIMITER ;

-- Creación de scripts
DELIMETER |
CREATE PROCEDURE ver_pistas()
BEGIN
    SELECT * FROM pistas;
END |
DELIMITER ;

-- Ejemplos prácticos

-- Procedimientos para mostrar reservas de un usuario
DELIMITER //

CREATE PROCEDURE mostrar_reservas_usuario(IN dni_usuario_param CHAR(9))
BEGIN
    SELECT r.id, r.fecha_reserva, r.fecha_uso, p.tipo, r.precio
    FROM reservas r
    INNER JOIN usuario_reserva ur ON r.id = ur.id_reserva
    INNER JOIN pistas p ON r.id_pista = p.id
    WHERE ur.dni_usuario = dni_usuario_param
    ORDER BY r.fecha_reserva DESC;
END //

DELIMITER ;

-- Para ejecutarlo:
CALL mostrar_reservas_usuario('WFPHMYMZ7');

-- Funciones para calcular el precio con descuento
DELIMITER //

CREATE FUNCTION calcular_precio_con_descuento(
    precio_original DECIMAL(10,2),
    porcentaje_descuento INT
)
RETURNS DECIMAL(10,2)
BEGIN
    DECLARE precio_final DECIMAL(10,2);

    SET precio_final = precio_original - (precio_original * porcentaje_descuento / 100);

    RETURN precio_final;
END //

DELIMITER ;

-- Para usarla:
SELECT calcular_precio_con_descuento(100.00, 20) AS precio_con_descuento;

-- Ejercicio práctico
/*
Basándonos en los ejercicios propuestos en tu material, vamos a implementar
una función que tome como parámetro un rango de fechas y devuelva la cantidad
de reservas realizadas en ese rango:
*/
DELIMITER //

CREATE FUNCTION contar_reservas_por_fecha(
    fecha_inicio DATETIME,
    fecha_fin DATETIME
)
RETURNS INT
BEGIN
    DECLARE total_reservas INT;

    SELECT COUNT(*) INTO total_reservas
    FROM reservas
    WHERE fecha_reserva BETWEEN fecha_inicio AND fecha_fin;

    RETURN total_reservas;
END //

DELIMITER ;

-- Para usarla:
SELECT contar_reservas_por_fecha('2013-01-01', '2013-12-31') AS reservas_2013;

-- Lección 7: Triggers (Disparadores) en PL/SQL

-- Un trigger es un bloque de código PL/SQL que se ejecuta automáticamente
-- en respuesta a ciertos eventos en la base de datos, como inserciones,
-- actualizaciones o eliminaciones de registros.

-- Sintaxis para crear un trigger

CREATE TRIGGER nombre_trigger
{BEFORE | AFTER} {INSERT | UPDATE | DELETE}
ON nombre_tabla
FOR EACH ROW
BEGIN
    -- Cuerpo del trigger (instrucciones a ejecutar)
END;

-- Ejemplo práctico: Incrementar un contador

DELIMITER //

CREATE TRIGGER increment_animal
AFTER INSERT ON animals
FOR EACH ROW
BEGIN
    UPDATE animal_count SET animal_count.animals = animal_count.animals + 1;
END //

DELIMITER ;

-- Ejemplo práctico: Registro de cambios en la población
DELIMITER //

CREATE TRIGGER before_country_reports_update
BEFORE UPDATE ON country_reports
FOR EACH ROW
BEGIN
    INSERT INTO population_logs(
        country_id,
        year,
        old_population,
        new_population
    )
    VALUES(
        OLD.country_id,
        OLD.year,
        OLD.population,
        NEW.population
    );
END //

DELIMITER ;

-- Cancelar una operación con un trigger
DELIMITER //

CREATE TRIGGER no_more_philosophy
BEFORE INSERT ON book
FOR EACH ROW
BEGIN
    IF NEW.genre = "Philosophy" AND (SELECT COUNT(*) FROM book WHERE genre = "Philosophy") > 0 THEN
        SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'Solo se permite un libro de Filosofía!';
    END IF;
END //

DELIMITER ;

-- Gestión de triggers

-- Para ver los triggers existentes en una base de datos:
SHOW TRIGGERS;

-- Para eliminar un trigger:
DROP TRIGGER nombre_trigger;

-- Ejercicio práctico
/*
Vamos a crear un trigger que calcule automáticamente la edad de los usuarios
en el momento en que se dan de alta, a partir de su fecha de nacimiento:
*/
DELIMITER //

CREATE TRIGGER nuevo_usuario
BEFORE INSERT ON Usuarios
FOR EACH ROW
BEGIN
    IF NEW.fecha_nacimiento IS NOT NULL THEN
        SET NEW.edad = YEAR(CURRENT_DATE()) - YEAR(NEW.fecha_nacimiento);
    END IF;
END //

DELIMITER ;