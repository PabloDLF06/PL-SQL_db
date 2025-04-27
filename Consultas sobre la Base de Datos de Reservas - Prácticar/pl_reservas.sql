DELIMITER $$
/*
 * Crea una función que tome como parámetro un rango de fechas y devuelva
 * la cantidad de reservas realizadas en ese rango.
 * La función debe devolver un único valor entero.
 */
DELIMITER //
CREATE FUNCTION IF NOT EXISTS reservas_en_rango(fecha_inicio DATE, fecha_fin DATE)
RETURNS INT
BEGIN
    DECLARE total_reservas INT;

    SELECT COUNT(*) INTO total_reservas
    FROM reservas
    WHERE fecha_uso BETWEEN fecha_inicio AND fecha_fin;

    RETURN total_reservas;
END //
DELIMITER ;

CALL reservas_en_rango('2023-01-01', '2023-12-31');

-- Corrije el ejercicio anterior para que esté correctamente:

DELIMITER //
CREATE FUNCTION IF NOT EXISTS reservas.reservas_en_rango_correccion(fecha_inicio DATE, fecha_fin DATE)
RETURNS INT
BEGIN
    DECLARE total_reservas INT;

    SELECT COUNT(*) INTO total_reservas
    FROM reservas
    WHERE fecha_uso BETWEEN fecha_inicio AND fecha_fin;

    RETURN total_reservas;
END //
DELIMITER ;

/*
 * Crea un procedimiento que tome como parámetro un nombre de usuario y
 * muestre por pantalla la cantidad de reservas realizadas por ese usuario.
 * El procedimiento no debe devolver ningún valor.
 */
DELIMITER //
CREATE PROCEDURE IF NOT EXISTS reservas.cantidad_reservas_usuario(IN nombre_usuario VARCHAR(255))
BEGIN
    DECLARE total_reservas INT;

    SELECT COUNT(*) INTO total_reservas
    FROM reservas
    WHERE usuario = nombre_usuario;

    SELECT CONCAT('El usuario ', nombre_usuario, ' ha realizado ', total_reservas, ' reservas.') AS mensaje;
END //
DELIMITER ;
CALL reservas.cantidad_reservas_usuario('Juan Pérez');

/*
 * Crea una función que tome como parámetro un DNI de un usuario y el nombre de un polideportivo
 * y devuelva un booleano que indique si el usuario ha realizado alguna reserva en ese polideportivo.
 */

/*
 * Crea un procedimiento que tome como parámetro el DNI de un usuario 
 * y muestre un historial de las reservas realizadas por ese usuario.
 * El procedimiento no debe devolver ningún valor.
 */

/*
 * Crea un procedimiento que tome como parámetro el DNI de un usuario y
 * el id de una pista y realice una reserva para ese usuario en esa pista.
 * La fecha de la reserva debe ser la fecha actual, la fecha de uso debe ser
 * la fecha actual más 7 días y el precio debe ser el de la pista aplicando
 * el descuento correspondiente al usuario.
 */

DELIMITER ;