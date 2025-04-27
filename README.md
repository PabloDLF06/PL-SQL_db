# PL-SQL_db

# Lección 1: Introducción a PL/SQL y Conceptos Básicos

## ¿Qué es PL/SQL?

**PL/SQL** (Procedural Language extensions to SQL) es un lenguaje de programación diseñado específicamente para trabajar con bases de datos, especialmente con Oracle Database. Si trabajas con MariaDB como en nuestro caso, encontrarás una implementación similar con algunas diferencias sintácticas, pero los conceptos fundamentales son muy parecidos.

> 💡 **Nota**: PL/SQL añade capacidades procedimentales al lenguaje SQL estándar, permitiéndote crear lógica de programación compleja dentro de la base de datos.

### Características principales

- Combina la potencia de SQL con estructuras de programación
- Permite encapsular lógica de negocio en la base de datos
- Mejora el rendimiento al reducir el tráfico de red
- Ofrece manejo de excepciones para control de errores


### Diferencia entre SQL y PL/SQL

| SQL | PL/SQL |
| :-- | :-- |
| Lenguaje declarativo | Lenguaje procedimental |
| Ejecuta una sola consulta a la vez | Ejecuta un bloque entero de código |
| Enfocado en manipulación de datos | Enfocado en lógica de programación |
| No tiene estructuras de control | Incluye estructuras condicionales y bucles |

## Estructura básica de un bloque PL/SQL

En MariaDB/MySQL, un bloque PL/SQL básico tiene esta estructura:

```sql
DELIMITER //

CREATE PROCEDURE nombre_procedimiento()
BEGIN
    -- Declaración de variables
    DECLARE variable1 INT;
    
    -- Cuerpo del programa (instrucciones)
    SET variable1 = 10;
    
    -- Puedes incluir consultas SQL
    SELECT * FROM tabla WHERE campo = variable1;
    
END //

DELIMITER ;
```


### El delimitador DELIMITER

El uso de `DELIMITER //` y `DELIMITER ;` es fundamental en PL/SQL para MariaDB por las siguientes razones:

1. En SQL estándar, cada instrucción termina con punto y coma (`;`)
2. Dentro de procedimientos PL/SQL, también usamos punto y coma para terminar cada línea
3. Para evitar que el intérprete se confunda, cambiamos temporalmente el delimitador a `//`
4. Esto permite que los puntos y coma dentro del procedimiento sean parte de su sintaxis interna

> ⚠️ **Importante**: Olvidar cambiar el delimitador es uno de los errores más comunes al comenzar con PL/SQL.

## Tu primer programa PL/SQL

Vamos a crear un procedimiento muy simple que muestre un mensaje:

```sql
DELIMITER //

CREATE PROCEDURE hola_mundo()
BEGIN
    SELECT 'Hola, mundo!' AS mensaje;
END //

DELIMITER ;

-- Para ejecutarlo:
CALL hola_mundo();
```

Este procedimiento simplemente devuelve un mensaje "Hola, mundo!" cuando lo ejecutas.

### Resultado esperado:

| mensaje |
| :-- |
| Hola, mundo! |

## Ejercicio práctico

Intenta crear un procedimiento llamado `mostrar_fecha_actual` que muestre la fecha y hora actuales.

**Pista**: Puedes usar la función `NOW()` de MySQL.

<details>
<summary>Ver solución</summary>

```sql
DELIMITER //

CREATE PROCEDURE mostrar_fecha_actual()
BEGIN
    SELECT NOW() AS fecha_actual;
END //

DELIMITER ;

-- Para ejecutarlo:
CALL mostrar_fecha_actual();
```

Resultado esperado:


| fecha_actual |
| :-- |
| 2025-04-27 23:02:15 |

</details>

---

## 📚 Resumen de conceptos clave

- **PL/SQL** es una extensión procedimental de SQL que permite crear lógica de programación
- La estructura básica incluye un bloque delimitado con `BEGIN` y `END`
- El uso de `DELIMITER` es esencial para evitar confusiones con los puntos y coma
- Los procedimientos se invocan con el comando `CALL`

<!--horizontal divider(gradiant)-->
<img src="https://user-images.githubusercontent.com/73097560/115834477-dbab4500-a447-11eb-908a-139a6edaec5c.gif">

# Lección 2: Variables y Tipos de Datos en PL/SQL

## ¿Qué son las variables en PL/SQL?

Las variables son elementos fundamentales en cualquier lenguaje de programación, incluyendo PL/SQL. Funcionan como contenedores temporales que nos permiten almacenar y manipular datos durante la ejecución de nuestros procedimientos almacenados.

> 💡 **Nota**: Las variables solo existen durante la ejecución del procedimiento y se eliminan de la memoria una vez que este finaliza.

### Declaración de variables

En PL/SQL para MariaDB, las variables se declaran en la sección inmediatamente posterior a la palabra clave `BEGIN`. La sintaxis básica es:

```sql
DECLARE nombre_variable tipo_dato [DEFAULT valor_inicial];
```

También podemos asignar valores después de la declaración usando la instrucción `SET`:

```sql
SET nombre_variable = valor;
```


## Tipos de datos en PL/SQL

MariaDB ofrece una amplia variedad de tipos de datos que podemos utilizar en nuestras variables:

### Tipos numéricos

| Tipo de dato | Descripción | Rango |
| :-- | :-- | :-- |
| `INT` o `INTEGER` | Números enteros | -2³¹ a 2³¹-1 |
| `TINYINT` | Enteros pequeños | -128 a 127 |
| `DECIMAL(p,s)` | Números decimales con precisión `p` y escala `s` | Depende de la precisión |
| `FLOAT`, `DOUBLE` | Números con decimales (punto flotante) | Amplio rango |

### Tipos de texto

| Tipo de dato | Descripción | Tamaño máximo |
| :-- | :-- | :-- |
| `CHAR(n)` | Cadena de longitud fija | n caracteres |
| `VARCHAR(n)` | Cadena de longitud variable | Hasta n caracteres |
| `TEXT` | Texto de longitud variable grande | Hasta 65,535 caracteres |

### Tipos de fecha y hora

| Tipo de dato | Descripción | Formato |
| :-- | :-- | :-- |
| `DATE` | Solo fecha | 'YYYY-MM-DD' |
| `TIME` | Solo hora | 'HH:MM:SS' |
| `DATETIME` | Fecha y hora | 'YYYY-MM-DD HH:MM:SS' |
| `TIMESTAMP` | Similar a DATETIME con rango más limitado | 'YYYY-MM-DD HH:MM:SS' |

### Tipo booleano

MariaDB no tiene un tipo `BOOLEAN` nativo, pero podemos usar:

- `BOOLEAN` o `BOOL`: Internamente se implementa como `TINYINT(1)`
- `TINYINT(1)`: Donde 0 es falso y 1 es verdadero


## Ejemplo práctico con variables

Vamos a crear un procedimiento que demuestre el uso de diferentes tipos de variables:

```sql
DELIMITER //

CREATE PROCEDURE ejemplo_variables()
BEGIN
    -- Declaración de variables con diferentes tipos de datos
    DECLARE edad INT DEFAULT 25;
    DECLARE nombre VARCHAR(50);
    DECLARE precio DECIMAL(10,2);
    DECLARE fecha_actual DATE;
    DECLARE es_activo BOOLEAN;
    
    -- Asignación de valores
    SET nombre = 'Juan Pérez';
    SET precio = 199.99;
    SET fecha_actual = CURDATE();
    SET es_activo = TRUE;
    
    -- Mostrar valores
    SELECT 
        edad AS edad_usuario,
        nombre AS nombre_usuario,
        precio AS precio_producto,
        fecha_actual AS fecha,
        es_activo AS estado;
END //

DELIMITER ;
```


### Resultado esperado:

| edad_usuario | nombre_usuario | precio_producto | fecha | estado |
| :-- | :-- | :-- | :-- | :-- |
| 25 | Juan Pérez | 199.99 | 2025-04-27 | 1 |

## Variables especiales: INTO

Una característica muy útil de PL/SQL es la capacidad de capturar resultados de consultas directamente en variables usando la cláusula `INTO`:

```sql
DELIMITER //

CREATE PROCEDURE obtener_info_pista(IN id_pista INT)
BEGIN
    DECLARE tipo_pista VARCHAR(20);
    DECLARE precio_pista DECIMAL(10,2);
    
    -- Capturar valores de una consulta en variables
    SELECT tipo, precio INTO tipo_pista, precio_pista
    FROM pistas
    WHERE id = id_pista;
    
    -- Mostrar información usando las variables
    SELECT CONCAT('La pista es de tipo ', tipo_pista, ' y cuesta ', precio_pista, '€') AS informacion;
END //

DELIMITER ;
```

> ⚠️ **Importante**: La consulta debe devolver exactamente una fila y el número de columnas debe coincidir con el número de variables en la cláusula `INTO`.

## Variables de usuario

MariaDB también soporta variables de usuario que persisten durante toda la sesión. Se distinguen por el prefijo `@`:

```sql
SET @mi_variable = 'Valor persistente';
SELECT @mi_variable;
```

Estas variables son útiles para:

- Mantener valores entre distintas llamadas a procedimientos
- Compartir datos entre diferentes partes de un script
- Definir parámetros que se utilizarán en múltiples consultas


## Ámbito de las variables

Es importante entender el ámbito (scope) de las variables en PL/SQL:

- **Variables locales**: Declaradas con `DECLARE`, solo existen dentro del bloque donde se declaran
- **Variables de usuario**: Declaradas con `@`, existen durante toda la sesión
- **Parámetros**: Solo existen dentro del procedimiento o función donde se definen


## Ejercicio práctico

Vamos a crear un procedimiento que calcule el precio con descuento de una pista de deporte:

```sql
DELIMITER //

CREATE PROCEDURE calcular_precio_con_descuento(
    IN id_pista_param INT, 
    IN porcentaje_descuento INT
)
BEGIN
    DECLARE precio_original DECIMAL(10,2);
    DECLARE precio_con_descuento DECIMAL(10,2);
    DECLARE nombre_tipo VARCHAR(20);
    
    -- Obtener el precio y tipo de la pista
    SELECT precio, tipo INTO precio_original, nombre_tipo
    FROM pistas
    WHERE id = id_pista_param;
    
    -- Calcular el precio con descuento
    SET precio_con_descuento = precio_original - (precio_original * porcentaje_descuento / 100);
    
    -- Mostrar resultados
    SELECT 
        id_pista_param AS id_pista,
        nombre_tipo AS tipo,
        precio_original AS precio_original,
        CONCAT(porcentaje_descuento, '%') AS descuento,
        precio_con_descuento AS precio_final;
END //

DELIMITER ;
```


### Prueba del procedimiento:

```sql
CALL calcular_precio_con_descuento(1, 10);
```


### Resultado esperado:

| id_pista | tipo | precio_original | descuento | precio_final |
| :-- | :-- | :-- | :-- | :-- |
| 1 | futbol | 25.00 | 10% | 22.50 |


---

## 📚 Resumen de conceptos clave

- Las **variables** en PL/SQL son contenedores temporales para almacenar datos
- Se declaran con `DECLARE` después de `BEGIN`
- MariaDB soporta diversos **tipos de datos**: numéricos, texto, fecha/hora y booleanos
- La cláusula `INTO` permite capturar resultados de consultas en variables
- Las **variables de usuario** con prefijo `@` persisten durante toda la sesión
- El **ámbito** determina dónde y cuándo es accesible una variable

<!--horizontal divider(gradiant)-->
<img src="https://user-images.githubusercontent.com/73097560/115834477-dbab4500-a447-11eb-908a-139a6edaec5c.gif">

# Lección 3: Estructuras de Control Condicionales en PL/SQL

## ¿Qué son las estructuras de control condicionales?

Las estructuras de control condicionales son componentes fundamentales en cualquier lenguaje de programación, incluido PL/SQL. Estas estructuras permiten que nuestros programas tomen decisiones, ejecutando diferentes bloques de código según se cumplan o no determinadas condiciones.

> 💡 **Nota**: Las estructuras condicionales son esenciales para crear procedimientos inteligentes que puedan adaptarse a diferentes situaciones.

## La estructura IF-THEN-ELSE

La estructura IF es la más básica y versátil de las estructuras condicionales en PL/SQL. Permite evaluar una condición y ejecutar código específico dependiendo del resultado de dicha evaluación.

### Sintaxis básica

```sql
IF condicion THEN
    -- Código a ejecutar si la condición es verdadera
ELSEIF otra_condicion THEN
    -- Código a ejecutar si la otra condición es verdadera
ELSE
    -- Código a ejecutar si ninguna condición es verdadera
END IF;
```


### IF simple

La forma más básica solo ejecuta un bloque cuando la condición es verdadera:

```sql
DELIMITER //

CREATE PROCEDURE verificar_numero(IN numero INT)
BEGIN
    IF numero &gt; 0 THEN
        SELECT 'El número es positivo' AS resultado;
    END IF;
END //

DELIMITER ;
```


### IF-THEN-ELSE

Cuando necesitamos una alternativa para cuando la condición no se cumple:

```sql
DELIMITER //

CREATE PROCEDURE verificar_par_impar(IN numero INT)
BEGIN
    IF MOD(numero, 2) = 0 THEN
        SELECT 'El número es par' AS resultado;
    ELSE
        SELECT 'El número es impar' AS resultado;
    END IF;
END //

DELIMITER ;
```


### IF-THEN-ELSEIF-ELSE

Para manejar múltiples condiciones en secuencia:

```sql
DELIMITER //

CREATE PROCEDURE clasificar_edad(IN edad INT)
BEGIN
    IF edad &lt; 18 THEN
        SELECT 'Menor de edad' AS clasificacion;
    ELSEIF edad &lt; 65 THEN
        SELECT 'Adulto' AS clasificacion;
    ELSE
        SELECT 'Adulto mayor' AS clasificacion;
    END IF;
END //

DELIMITER ;
```


## Condiciones anidadas

Las condiciones pueden anidarse para crear lógicas de decisión más complejas:

```sql
DELIMITER //

CREATE PROCEDURE verificar_acceso_pista(
    IN id_pista_param INT, 
    IN edad_usuario INT
)
BEGIN
    DECLARE tipo_pista VARCHAR(20);
    
    -- Obtener el tipo de pista
    SELECT tipo INTO tipo_pista
    FROM pistas
    WHERE id = id_pista_param;
    
    IF tipo_pista = 'futbol' THEN
        IF edad_usuario &lt; 12 THEN
            SELECT 'Acceso permitido con supervisión' AS resultado;
        ELSE
            SELECT 'Acceso permitido' AS resultado;
        END IF;
    ELSEIF tipo_pista = 'tenis' THEN
        IF edad_usuario &lt; 10 THEN
            SELECT 'Acceso denegado por edad' AS resultado;
        ELSE
            SELECT 'Acceso permitido' AS resultado;
        END IF;
    ELSE
        SELECT 'Acceso permitido' AS resultado;
    END IF;
END //

DELIMITER ;
```


## La estructura CASE

La estructura CASE ofrece una alternativa más elegante al IF-ELSEIF cuando necesitamos evaluar una variable o expresión contra múltiples valores posibles.

### CASE simple

```sql
DELIMITER //

CREATE PROCEDURE obtener_precio_por_tipo(IN tipo_pista_param VARCHAR(20))
BEGIN
    DECLARE precio_base DECIMAL(10,2);
    
    SET precio_base = CASE tipo_pista_param
        WHEN 'futbol' THEN 25.00
        WHEN 'tenis' THEN 20.00
        WHEN 'baloncesto' THEN 20.00
        WHEN 'ping-pong' THEN 15.00
        ELSE 10.00
    END;
    
    SELECT CONCAT('El precio base para una pista de ', 
           tipo_pista_param, ' es ', precio_base, '€') AS informacion;
END //

DELIMITER ;
```


### CASE buscado

Esta forma de CASE permite evaluar condiciones más complejas:

```sql
DELIMITER //

CREATE PROCEDURE clasificar_pista_por_precio(IN id_pista_param INT)
BEGIN
    DECLARE precio_pista DECIMAL(10,2);
    DECLARE categoria VARCHAR(20);
    
    -- Obtener el precio de la pista
    SELECT precio INTO precio_pista
    FROM pistas
    WHERE id = id_pista_param;
    
    SET categoria = CASE 
        WHEN precio_pista &lt; 10 THEN 'Económica'
        WHEN precio_pista &lt; 20 THEN 'Estándar'
        WHEN precio_pista &lt; 30 THEN 'Premium'
        ELSE 'Lujo'
    END;
    
    SELECT CONCAT('La pista con ID ', id_pista_param, 
           ' es de categoría ', categoria) AS clasificacion;
END //

DELIMITER ;
```


### ¿Cuándo usar CASE vs. IF?

| Estructura | Ventajas | Ideal para |
| :-- | :-- | :-- |
| **IF** | Más flexible para condiciones complejas | Lógica ramificada con múltiples condiciones diferentes |
| **CASE** | Más legible y conciso | Evaluar una misma variable contra diferentes valores |

## Ejemplo práctico: Sistema de descuentos

Vamos a crear un procedimiento que calcule el precio final de una reserva aplicando diferentes descuentos según el historial del usuario:

```sql
DELIMITER //

CREATE PROCEDURE calcular_precio_reserva(
    IN id_pista_param INT,
    IN dni_usuario_param CHAR(9)
)
BEGIN
    DECLARE precio_pista DECIMAL(10,2);
    DECLARE descuento_usuario DECIMAL(5,2);
    DECLARE precio_final DECIMAL(10,2);
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
    IF num_reservas &gt; 10 THEN
        SET descuento_usuario = descuento_usuario + 0.15;
    ELSEIF num_reservas &gt; 5 THEN
        SET descuento_usuario = descuento_usuario + 0.10;
    ELSEIF num_reservas &gt; 0 THEN
        SET descuento_usuario = descuento_usuario + 0.05;
    END IF;
    
    -- Calcular precio final
    SET precio_final = precio_pista * (1 - descuento_usuario);
    
    -- Mostrar resultado
    SELECT 
        id_pista_param AS id_pista,
        precio_pista AS precio_original,
        CONCAT(descuento_usuario * 100, '%') AS descuento_aplicado,
        precio_final AS precio_final;
END //

DELIMITER ;
```


## Ejercicio práctico: Verificación de disponibilidad

Vamos a crear un procedimiento que verifique si una pista está disponible en una fecha determinada:

```sql
DELIMITER //

CREATE PROCEDURE verificar_disponibilidad_pista(
    IN id_pista_param INT,
    IN fecha_param DATETIME
)
BEGIN
    DECLARE reservas_existentes INT;
    DECLARE pista_operativa TINYINT(1);
    DECLARE pista_clausurada TINYINT(1);
    
    -- Verificar si la pista está clausurada
    SELECT COUNT(*) INTO pista_clausurada
    FROM pistas_cerradas
    WHERE id_pista = id_pista_param;
    
    IF pista_clausurada &gt; 0 THEN
        SELECT 'La pista está clausurada' AS estado;
    ELSE
        -- Verificar si la pista está operativa
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
            AND DATE(fecha_uso) = DATE(fecha_param);
            
            IF reservas_existentes &gt; 0 THEN
                SELECT 'La pista no está disponible en esa fecha' AS estado;
            ELSE
                SELECT 'La pista está disponible' AS estado;
            END IF;
        END IF;
    END IF;
END //

DELIMITER ;
```

<details>
<summary>Ver ejemplo de uso</summary>

```sql
-- Verificar disponibilidad de una pista
CALL verificar_disponibilidad_pista(1, '2025-05-15 16:00:00');
```

Posibles resultados:

- "La pista está disponible"
- "La pista no está disponible en esa fecha"
- "La pista no está operativa"
- "La pista está clausurada"

</details>

---

## 📚 Resumen de conceptos clave

- Las **estructuras condicionales** permiten que los procedimientos tomen decisiones basadas en condiciones
- La estructura **IF-THEN-ELSE** es ideal para evaluaciones condicionales complejas
- La estructura **CASE** proporciona una alternativa más clara cuando se evalúa una misma expresión contra diferentes valores
- Las condiciones pueden **anidarse** para crear lógicas más complejas
- El uso adecuado de estructuras condicionales mejora la **robustez** y **flexibilidad** de los procedimientos almacenados

<!--horizontal divider(gradiant)-->
<img src="https://user-images.githubusercontent.com/73097560/115834477-dbab4500-a447-11eb-908a-139a6edaec5c.gif">

# Lección 4: Estructuras de Control Iterativas en PL/SQL

## ¿Qué son las estructuras de control iterativas?

Las estructuras de control iterativas, comúnmente conocidas como bucles, son componentes fundamentales en la programación que nos permiten ejecutar un bloque de código de forma repetida mientras se cumpla una condición o un número determinado de veces.

> 💡 **Nota**: Los bucles son esenciales cuando necesitamos procesar múltiples filas de datos o realizar operaciones repetitivas de manera eficiente.

## Tipos de bucles en PL/SQL para MariaDB

MariaDB ofrece tres tipos principales de estructuras de bucle:


| Tipo de bucle | Característica principal | Uso recomendado |
| :-- | :-- | :-- |
| **LOOP** | Bucle básico sin condición incorporada | Cuando necesitamos control total sobre la condición de salida |
| **REPEAT** | Ejecuta primero, verifica después | Cuando necesitamos ejecutar el código al menos una vez |
| **WHILE** | Verifica primero, ejecuta después | Cuando queremos verificar la condición antes de ejecutar |

> ⚠️ **Importante**: A diferencia de otros sistemas de bases de datos, MySQL/MariaDB no soporta bucles de tipo FOR de manera nativa.

## El bucle LOOP

El bucle LOOP es la estructura más simple. Al no tener condición de salida incorporada, debemos implementarla manualmente usando la instrucción `LEAVE`:

```sql
[etiqueta:] LOOP
    -- Instrucciones a ejecutar
    IF condicion_salida THEN
        LEAVE [etiqueta];
    END IF;
END LOOP [etiqueta];
```


### Ejemplo práctico: Contar hasta diez

```sql
DELIMITER //

CREATE PROCEDURE contar_hasta_diez()
BEGIN
    DECLARE contador INT DEFAULT 1;
    
    bucle: LOOP
        SELECT contador AS numero;
        SET contador = contador + 1;
        
        IF contador &gt; 10 THEN
            LEAVE bucle;
        END IF;
    END LOOP bucle;
END //

DELIMITER ;
```


## El bucle REPEAT

El bucle REPEAT ejecuta el bloque de código al menos una vez y luego verifica la condición. Si la condición es verdadera, el bucle termina:

```sql
[etiqueta:] REPEAT
    -- Instrucciones a ejecutar
UNTIL condicion_salida
END REPEAT [etiqueta];
```


### Ejemplo práctico: Contar hasta diez con REPEAT

```sql
DELIMITER //

CREATE PROCEDURE contar_hasta_diez_repeat()
BEGIN
    DECLARE contador INT DEFAULT 1;
    
    REPEAT
        SELECT contador AS numero;
        SET contador = contador + 1;
    UNTIL contador &gt; 10
    END REPEAT;
END //

DELIMITER ;
```


## El bucle WHILE

El bucle WHILE verifica la condición antes de ejecutar el bloque de código. Si la condición es verdadera, el bloque se ejecuta:

```sql
[etiqueta:] WHILE condicion_continuacion DO
    -- Instrucciones a ejecutar
END WHILE [etiqueta];
```


### Ejemplo práctico: Contar hasta diez con WHILE

```sql
DELIMITER //

CREATE PROCEDURE contar_hasta_diez_while()
BEGIN
    DECLARE contador INT DEFAULT 1;
    
    WHILE contador &lt;= 10 DO
        SELECT contador AS numero;
        SET contador = contador + 1;
    END WHILE;
END //

DELIMITER ;
```


## Comparativa de los tres tipos de bucles

Para entender mejor las diferencias, aquí tienes un gráfico comparativo:


| Característica | LOOP | REPEAT | WHILE |
| :-- | :-- | :-- | :-- |
| **Condición** | Manual (con IF y LEAVE) | Al final (UNTIL) | Al inicio (WHILE) |
| **Ejecución mínima** | Depende del IF | Al menos una vez | Puede ser cero veces |
| **Equivalente en otros lenguajes** | No tiene equivalente directo | do-while | while |
| **Complejidad** | Mayor | Media | Menor |

## Control avanzado: LEAVE e ITERATE

Además de las estructuras básicas, PL/SQL ofrece dos comandos adicionales para controlar el flujo dentro de los bucles:

### LEAVE

El comando `LEAVE` permite salir inmediatamente de un bucle, similar a `break` en otros lenguajes:

```sql
LEAVE [etiqueta];
```


### ITERATE

El comando `ITERATE` permite saltar a la siguiente iteración del bucle sin ejecutar el resto del código, similar a `continue` en otros lenguajes:

```sql
ITERATE [etiqueta];
```


### Ejemplo práctico: Mostrar solo números pares

```sql
DELIMITER //

CREATE PROCEDURE mostrar_numeros_pares_hasta_diez()
BEGIN
    DECLARE contador INT DEFAULT 0;
    
    bucle: LOOP
        SET contador = contador + 1;
        
        -- Si es impar, saltamos a la siguiente iteración
        IF MOD(contador, 2) &lt;&gt; 0 THEN
            ITERATE bucle;
        END IF;
        
        -- Mostramos solo los números pares
        SELECT contador AS numero_par;
        
        -- Si llegamos a 10, salimos del bucle
        IF contador &gt;= 10 THEN
            LEAVE bucle;
        END IF;
    END LOOP bucle;
END //

DELIMITER ;
```


## Ejemplo práctico: Calcular el precio total de las reservas

Vamos a crear un procedimiento que calcule el precio total de todas las reservas realizadas por un usuario utilizando un bucle y un cursor:

```sql
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
```


## Bucles anidados

También podemos anidar bucles unos dentro de otros para resolver problemas más complejos:

```sql
DELIMITER //

CREATE PROCEDURE generar_tabla_multiplicar(IN limite INT)
BEGIN
    DECLARE i INT DEFAULT 1;
    DECLARE j INT;
    
    WHILE i &lt;= limite DO
        SET j = 1;
        WHILE j &lt;= 10 DO
            SELECT CONCAT(i, ' x ', j, ' = ', i*j) AS multiplicacion;
            SET j = j + 1;
        END WHILE;
        
        SELECT '------------------------' AS separador;
        SET i = i + 1;
    END WHILE;
END //

DELIMITER ;
```


## Ejercicio práctico: Informe de pistas por tipo

Vamos a crear un procedimiento que genere un informe detallado de las pistas de un tipo específico, mostrando su ID, precio y el número de reservas que tiene cada una:

```sql
DELIMITER //

CREATE PROCEDURE generar_informe_pistas(IN tipo_pista_param VARCHAR(20))
BEGIN
    DECLARE id_pista_actual INT;
    DECLARE precio_actual DECIMAL(10,2);
    DECLARE num_reservas INT;
    DECLARE fin_cursor BOOLEAN DEFAULT FALSE;
    DECLARE total_pistas INT DEFAULT 0;
    DECLARE precio_promedio DECIMAL(10,2) DEFAULT 0;
    DECLARE total_reservas INT DEFAULT 0;
    
    -- Declarar un cursor para recorrer las pistas del tipo especificado
    DECLARE cursor_pistas CURSOR FOR 
        SELECT id, precio 
        FROM pistas 
        WHERE tipo = tipo_pista_param
        ORDER BY precio DESC;
    
    -- Manejador para cuando no hay más filas
    DECLARE CONTINUE HANDLER FOR NOT FOUND SET fin_cursor = TRUE;
    
    -- Mostrar encabezado del informe
    SELECT CONCAT('📊 INFORME DE PISTAS DE TIPO: ', UPPER(tipo_pista_param)) AS encabezado;
    
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
        
        -- Incrementar contador de pistas
        SET total_pistas = total_pistas + 1;
        SET precio_promedio = precio_promedio + precio_actual;
        
        -- Contar el número de reservas para esta pista
        SELECT COUNT(*) INTO num_reservas 
        FROM reservas 
        WHERE id_pista = id_pista_actual;
        
        -- Actualizar total de reservas
        SET total_reservas = total_reservas + num_reservas;
        
        -- Mostrar la información de la pista
        SELECT 
            id_pista_actual AS id_pista,
            precio_actual AS precio,
            num_reservas AS numero_reservas;
    END LOOP bucle_pistas;
    
    -- Cerrar el cursor
    CLOSE cursor_pistas;
    
    -- Mostrar resumen final
    IF total_pistas &gt; 0 THEN
        SET precio_promedio = precio_promedio / total_pistas;
        
        SELECT 
            total_pistas AS total_pistas_encontradas,
            precio_promedio AS precio_promedio,
            total_reservas AS total_reservas,
            ROUND(total_reservas / total_pistas, 2) AS reservas_por_pista;
    ELSE
        SELECT CONCAT('No se encontraron pistas de tipo ', tipo_pista_param) AS resultado;
    END IF;
END //

DELIMITER ;
```

<details>
<summary>Ver ejemplo de uso</summary>

```sql
CALL generar_informe_pistas('futbol');
```

Resultado esperado:


| encabezado |
| :-- |
| 📊 INFORME DE PISTAS DE TIPO: FUTBOL |

Resultados para cada pista:


| id_pista | precio | numero_reservas |
| :-- | :-- | :-- |
| 1 | 25.00 | 5 |
| 3 | 22.50 | 3 |
| 7 | 20.00 | 1 |

Resumen final:


| total_pistas_encontradas | precio_promedio | total_reservas | reservas_por_pista |
| :-- | :-- | :-- | :-- |
| 3 | 22.50 | 9 | 3.00 |

</details>

---

## 📚 Resumen de conceptos clave

- Las **estructuras de control iterativas** permiten ejecutar bloques de código repetidamente
- MariaDB ofrece tres tipos de bucles: **LOOP**, **REPEAT** y **WHILE**
- El bucle **LOOP** requiere una condición de salida manual con **LEAVE**
- El bucle **REPEAT** ejecuta el código al menos una vez antes de verificar la condición
- El bucle **WHILE** verifica la condición antes de ejecutar el código
- Los comandos **LEAVE** e **ITERATE** permiten controlar el flujo dentro de los bucles
- Los **bucles anidados** permiten resolver problemas más complejos
- Los bucles suelen usarse junto con **cursores** para procesar conjuntos de datos fila por fila

<!--horizontal divider(gradiant)-->
<img src="https://user-images.githubusercontent.com/73097560/115834477-dbab4500-a447-11eb-908a-139a6edaec5c.gif">

# Lección 5: Cursores y Manejadores de Errores en PL/SQL

## ¿Qué son los cursores?

Los cursores son mecanismos fundamentales en PL/SQL que permiten recorrer fila por fila los resultados de una consulta SQL dentro de un procedimiento almacenado, función o trigger. Son especialmente útiles cuando necesitamos procesar cada registro de manera individual para realizar operaciones específicas.

> 💡 **Nota**: Los cursores actúan como punteros a un conjunto de resultados, permitiéndonos acceder a cada fila de forma secuencial.

### Tipos de cursores en PL/SQL

En MariaDB existen dos tipos principales de cursores:


| Tipo de cursor | Descripción | Uso típico |
| :-- | :-- | :-- |
| **Implícitos** | Gestionados automáticamente por el SGBD | Consultas que devuelven un único resultado (INTO) |
| **Explícitos** | Definidos manualmente por el programador | Conjuntos de resultados que requieren procesamiento fila a fila |

## Trabajando con cursores explícitos

Para utilizar un cursor explícito en MariaDB, debemos seguir una secuencia de pasos bien definida:

### 1. Declaración del cursor

```sql
DECLARE nombre_cursor CURSOR FOR consulta_sql;
```

La consulta SQL puede ser cualquier SELECT válido, incluyendo JOINs, condiciones, etc.

### 2. Declaración del manejador para fin de cursor

```sql
DECLARE CONTINUE HANDLER FOR NOT FOUND SET variable_fin = TRUE;
```

Esta declaración es crucial para detectar cuándo se han procesado todas las filas.

### 3. Apertura del cursor

```sql
OPEN nombre_cursor;
```

Este comando prepara el cursor para su uso y ejecuta la consulta SQL.

### 4. Recuperación y procesamiento de datos

```sql
FETCH nombre_cursor INTO variable1, variable2, ...;
```

Se utiliza dentro de un bucle para recuperar cada fila una a una.

### 5. Cierre del cursor

```sql
CLOSE nombre_cursor;
```

Este paso libera los recursos asociados al cursor.

### Ejemplo completo de uso de cursor

```sql
DELIMITER //

CREATE PROCEDURE listar_pistas_por_tipo(IN tipo_pista_param VARCHAR(20))
BEGIN
    DECLARE id_actual INT;
    DECLARE precio_actual DECIMAL(10,2);
    DECLARE id_polideportivo_actual INT;
    DECLARE fin_cursor BOOLEAN DEFAULT FALSE;
    
    -- Declaración del cursor
    DECLARE cursor_pistas CURSOR FOR 
        SELECT id, precio, id_polideportivo 
        FROM pistas 
        WHERE tipo = tipo_pista_param;
    
    -- Manejador para cuando no hay más filas
    DECLARE CONTINUE HANDLER FOR NOT FOUND SET fin_cursor = TRUE;
    
    -- Abrir el cursor
    OPEN cursor_pistas;
    
    -- Mostrar encabezado
    SELECT CONCAT('📋 Listado de pistas de tipo: ', UPPER(tipo_pista_param)) AS titulo;
    
    -- Bucle para recorrer el cursor
    bucle_pistas: LOOP
        -- Obtener la siguiente fila
        FETCH cursor_pistas INTO id_actual, precio_actual, id_polideportivo_actual;
        
        -- Salir si no hay más filas
        IF fin_cursor THEN
            LEAVE bucle_pistas;
        END IF;
        
        -- Mostrar información de la pista
        SELECT 
            id_actual AS id_pista,
            precio_actual AS precio,
            id_polideportivo_actual AS id_polideportivo;
    END LOOP bucle_pistas;
    
    -- Cerrar el cursor
    CLOSE cursor_pistas;
END //

DELIMITER ;
```

> ⚠️ **Importante**: Siempre debes cerrar un cursor después de usarlo para liberar recursos del servidor.

## Manejadores de errores (Handlers)

Los manejadores de errores son estructuras que permiten gestionar condiciones excepcionales durante la ejecución de código PL/SQL. Actúan capturando errores, advertencias o condiciones personalizadas para evitar que el flujo del programa se interrumpa abruptamente.

### Tipos de manejadores

MariaDB soporta dos tipos principales de manejadores:


| Tipo | Comportamiento | Uso recomendado |
| :-- | :-- | :-- |
| **CONTINUE** | La ejecución continúa con la siguiente instrucción | Para errores no críticos que no deben detener el procedimiento |
| **EXIT** | Se termina el bloque BEGIN-END actual | Para errores críticos que imposibilitan continuar la ejecución |

### Condiciones que pueden capturarse

Los manejadores pueden responder a diversas condiciones:


| Condición | Descripción | Ejemplo de uso |
| :-- | :-- | :-- |
| **NOT FOUND** | No hay más filas en un FETCH o no hay resultados | Detectar el final de un cursor |
| **SQLEXCEPTION** | Cualquier error SQL | Capturar errores genéricos |
| **SQLWARNING** | Advertencias SQL | Detectar situaciones no críticas |
| **Código específico** | Código de error concreto | Manejar errores específicos (ej: 1062 para duplicados) |

### Sintaxis para declarar un manejador

```sql
DECLARE [CONTINUE | EXIT] HANDLER FOR condición acción;
```

Donde `acción` puede ser una instrucción simple o un bloque BEGIN-END completo.

### Ejemplos de manejadores

#### Manejador para fin de cursor

```sql
DECLARE CONTINUE HANDLER FOR NOT FOUND SET fin_cursor = TRUE;
```


#### Manejador para clave duplicada

```sql
DECLARE EXIT HANDLER FOR 1062 
BEGIN
    SELECT 'Error: La clave ya existe en la base de datos' AS mensaje;
    -- Otras acciones si son necesarias
END;
```


#### Manejador para cualquier error SQL

```sql
DECLARE EXIT HANDLER FOR SQLEXCEPTION
BEGIN
    SELECT 'Error en la ejecución del procedimiento' AS mensaje;
    -- Opciones de registro del error
END;
```


## Ejemplo práctico integrado: Historial de reservas de un usuario

Vamos a crear un procedimiento completo que utilice tanto cursores como manejadores de errores para mostrar el historial de reservas de un usuario:

```sql
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
    
    -- Manejador para errores SQL
    DECLARE EXIT HANDLER FOR SQLEXCEPTION
    BEGIN
        SELECT '❌ Error en la consulta de reservas' AS error;
    END;
    
    -- Declarar el cursor
    DECLARE cursor_historial CURSOR FOR 
        SELECT r.id, r.fecha_reserva, r.fecha_uso, r.precio, p.tipo
        FROM reservas r
        INNER JOIN usuario_reserva ur ON r.id = ur.id_reserva
        INNER JOIN pistas p ON r.id_pista = p.id
        WHERE ur.dni_usuario = dni_usuario_param
        ORDER BY r.fecha_reserva DESC;
    
    -- Manejador para fin de cursor
    DECLARE CONTINUE HANDLER FOR NOT FOUND SET fin_cursor = TRUE;
    
    -- Verificar si el usuario existe
    IF NOT EXISTS (SELECT 1 FROM usuarios WHERE dni = dni_usuario_param) THEN
        SELECT '⚠️ El usuario no existe en la base de datos' AS mensaje;
        LEAVE historial_reservas_usuario;
    END IF;
    
    -- Abrir el cursor
    OPEN cursor_historial;
    
    -- Mostrar encabezado
    SELECT CONCAT('📝 Historial de reservas para el usuario con DNI: ', dni_usuario_param) AS titulo;
    
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
            CONCAT(precio_actual, ' €') AS precio;
    END LOOP bucle_historial;
    
    -- Si no hay reservas
    IF contador = 0 THEN
        SELECT '📭 El usuario no tiene reservas registradas' AS mensaje;
    ELSE
        SELECT CONCAT('✅ Total de reservas encontradas: ', contador) AS resumen;
    END IF;
    
    -- Cerrar el cursor
    CLOSE cursor_historial;
END //

DELIMITER ;
```


## Cursores y transacciones

Los cursores a menudo se utilizan dentro de transacciones para garantizar que un conjunto de operaciones se complete de manera atómica:

```sql
DELIMITER //

CREATE PROCEDURE actualizar_precios_pistas(IN tipo_pista_param VARCHAR(20), IN incremento DECIMAL(5,2))
BEGIN
    DECLARE id_pista_actual INT;
    DECLARE precio_actual DECIMAL(10,2);
    DECLARE fin_cursor BOOLEAN DEFAULT FALSE;
    DECLARE error_ocurrido BOOLEAN DEFAULT FALSE;
    
    -- Declarar cursor y manejadores
    DECLARE cursor_pistas CURSOR FOR 
        SELECT id, precio FROM pistas WHERE tipo = tipo_pista_param;
    
    DECLARE CONTINUE HANDLER FOR NOT FOUND SET fin_cursor = TRUE;
    
    DECLARE EXIT HANDLER FOR SQLEXCEPTION
    BEGIN
        ROLLBACK;
        SET error_ocurrido = TRUE;
        SELECT '❌ Error durante la actualización de precios' AS mensaje;
    END;
    
    -- Iniciar transacción
    START TRANSACTION;
    
    -- Abrir cursor
    OPEN cursor_pistas;
    
    -- Procesar cada pista
    bucle_actualizar: LOOP
        FETCH cursor_pistas INTO id_pista_actual, precio_actual;
        
        IF fin_cursor THEN
            LEAVE bucle_actualizar;
        END IF;
        
        -- Actualizar el precio con el incremento
        UPDATE pistas 
        SET precio = precio_actual * (1 + incremento / 100)
        WHERE id = id_pista_actual;
    END LOOP bucle_actualizar;
    
    -- Cerrar cursor
    CLOSE cursor_pistas;
    
    -- Confirmar cambios si no hubo errores
    IF NOT error_ocurrido THEN
        COMMIT;
        SELECT CONCAT('✅ Precios de pistas de tipo ', tipo_pista_param, ' actualizados con un incremento del ', incremento, '%') AS resultado;
    END IF;
END //

DELIMITER ;
```


## Ejercicio práctico: Informe detallado de polideportivos

A continuación, crearemos un procedimiento más complejo que genera un informe detallado de los polideportivos, mostrando sus pistas y estadísticas de reserva:

```sql
DELIMITER //

CREATE PROCEDURE informe_polideportivos()
BEGIN
    DECLARE id_poli_actual INT;
    DECLARE nombre_poli_actual VARCHAR(100);
    DECLARE fin_poli BOOLEAN DEFAULT FALSE;
    DECLARE total_polideportivos INT DEFAULT 0;
    DECLARE total_pistas INT;
    DECLARE ingresos_totales DECIMAL(12,2);
    
    -- Manejador para errores SQL generales
    DECLARE EXIT HANDLER FOR SQLEXCEPTION
    BEGIN
        SELECT '❌ Error durante la generación del informe' AS mensaje;
    END;
    
    -- Cursor principal para recorrer polideportivos
    DECLARE cursor_polideportivos CURSOR FOR 
        SELECT id, nombre FROM polideportivos ORDER BY nombre;
    
    -- Manejador para fin del cursor de polideportivos
    DECLARE CONTINUE HANDLER FOR NOT FOUND SET fin_poli = TRUE;
    
    -- Mostrar encabezado del informe
    SELECT '📊 INFORME COMPLETO DE POLIDEPORTIVOS' AS titulo;
    
    -- Abrir cursor de polideportivos
    OPEN cursor_polideportivos;
    
    -- Recorrer cada polideportivo
    bucle_polideportivos: LOOP
        FETCH cursor_polideportivos INTO id_poli_actual, nombre_poli_actual;
        
        IF fin_poli THEN
            LEAVE bucle_polideportivos;
        END IF;
        
        SET total_polideportivos = total_polideportivos + 1;
        
        -- Mostrar información del polideportivo
        SELECT CONCAT('🏢 POLIDEPORTIVO: ', nombre_poli_actual) AS polideportivo;
        
        -- Contar pistas del polideportivo
        SELECT COUNT(*) INTO total_pistas
        FROM pistas
        WHERE id_polideportivo = id_poli_actual;
        
        -- Calcular ingresos totales por reservas
        SELECT IFNULL(SUM(r.precio), 0) INTO ingresos_totales
        FROM reservas r
        JOIN pistas p ON r.id_pista = p.id
        WHERE p.id_polideportivo = id_poli_actual;
        
        -- Mostrar estadísticas
        SELECT 
            total_pistas AS numero_pistas,
            CONCAT(ingresos_totales, ' €') AS ingresos_totales;
        
        -- Mostrar desglose de pistas por tipo
        SELECT 
            tipo,
            COUNT(*) AS cantidad,
            CONCAT(ROUND(COUNT(*) * 100 / total_pistas, 2), '%') AS porcentaje
        FROM pistas
        WHERE id_polideportivo = id_poli_actual
        GROUP BY tipo
        ORDER BY COUNT(*) DESC;
        
        -- Separador entre polideportivos
        SELECT '----------------------------------------' AS separador;
    END LOOP bucle_polideportivos;
    
    -- Cerrar cursor
    CLOSE cursor_polideportivos;
    
    -- Mostrar resumen final
    SELECT CONCAT('Total de polideportivos analizados: ', total_polideportivos) AS resumen;
END //

DELIMITER ;
```

<details>
<summary>Ver ejemplo de resultado</summary>

```
| titulo |
|--------|
| 📊 INFORME COMPLETO DE POLIDEPORTIVOS |

| polideportivo |
|---------------|
| 🏢 POLIDEPORTIVO: Centro Deportivo Municipal |

| numero_pistas | ingresos_totales |
|--------------|------------------|
| 8 | 12450.50 € |

| tipo | cantidad | porcentaje |
|------|----------|------------|
| futbol | 3 | 37.50% |
| tenis | 2 | 25.00% |
| baloncesto | 2 | 25.00% |
| ping-pong | 1 | 12.50% |

| separador |
|-----------|
| ---------------------------------------- |

[resultados para más polideportivos...]

| resumen |
|---------|
| Total de polideportivos analizados: 5 |
```

</details>

---

## 📚 Resumen de conceptos clave

- Los **cursores** permiten recorrer fila por fila los resultados de una consulta SQL
- El ciclo de vida de un cursor incluye: **declaración**, **apertura**, **recuperación de datos** y **cierre**
- Los **manejadores de errores** permiten gestionar condiciones excepcionales durante la ejecución
- Existen dos tipos principales de manejadores: **CONTINUE** y **EXIT**
- Los manejadores pueden responder a condiciones como **NOT FOUND**, **SQLEXCEPTION** y códigos de error específicos
- La combinación de cursores y manejadores permite crear procedimientos robustos que manejan adecuadamente los datos y posibles errores
- Las **transacciones** a menudo se utilizan con cursores para garantizar la integridad de operaciones complejas

<!--horizontal divider(gradiant)-->
<img src="https://user-images.githubusercontent.com/73097560/115834477-dbab4500-a447-11eb-908a-139a6edaec5c.gif">

# Lección 6: Procedimientos Almacenados en PL/SQL

## ¿Qué son los procedimientos almacenados?

Los procedimientos almacenados son bloques de código PL/SQL que se guardan en el servidor de la base de datos y pueden ser invocados posteriormente cuando sea necesario. Constituyen una de las herramientas más potentes para encapsular lógica de negocio directamente en la base de datos.

> 💡 **Nota**: A diferencia de las consultas SQL ad-hoc, los procedimientos almacenados se compilan una vez y se almacenan en forma ejecutable, lo que mejora significativamente el rendimiento.

### Ventajas de los procedimientos almacenados

| Ventaja | Descripción |
| :-- | :-- |
| **Reutilización de código** | Permite ejecutar la misma lógica repetidamente sin duplicar código |
| **Mayor seguridad** | Las aplicaciones cliente no necesitan acceso directo a las tablas |
| **Reducción del tráfico de red** | Se envía una sola llamada al procedimiento en lugar de múltiples consultas |
| **Centralización de la lógica** | Mantiene las reglas de negocio en un solo lugar |
| **Mantenimiento simplificado** | Los cambios se realizan en un único punto |

### Limitaciones

- No se pueden combinar con lenguajes de programación más avanzados
- Requieren conocimientos específicos de PL/SQL
- El debugging puede ser más complejo que en aplicaciones cliente


## Estructura de un procedimiento almacenado

La sintaxis básica para crear un procedimiento en MariaDB es:

```sql
DELIMITER //

CREATE PROCEDURE nombre_procedimiento
(
    [parámetros]
)
BEGIN
    -- Declaraciones
    -- Instrucciones
END //

DELIMITER ;
```


### Tipos de parámetros

Los parámetros en los procedimientos pueden ser de tres tipos:


| Tipo | Descripción | Uso típico |
| :-- | :-- | :-- |
| **IN** | Solo de entrada (valor por defecto) | Para recibir datos desde el cliente |
| **OUT** | Solo de salida | Para devolver valores al cliente |
| **INOUT** | Entrada y salida | Para modificar un valor recibido y devolverlo |

## Creación de procedimientos almacenados

Veamos ejemplos prácticos de procedimientos con diferentes tipos de parámetros:

### Procedimiento con parámetros de entrada (IN)

```sql
DELIMITER //

CREATE PROCEDURE buscar_pistas_por_tipo(IN tipo_pista_param VARCHAR(20))
BEGIN
    SELECT id, tipo, precio, id_polideportivo
    FROM pistas
    WHERE tipo = tipo_pista_param
    ORDER BY precio;
END //

DELIMITER ;
```

Para ejecutar este procedimiento:

```sql
CALL buscar_pistas_por_tipo('tenis');
```


### Procedimiento con parámetros de salida (OUT)

```sql
DELIMITER //

CREATE PROCEDURE obtener_estadisticas_pistas(
    IN tipo_pista_param VARCHAR(20),
    OUT total_pistas INT,
    OUT precio_promedio DECIMAL(10,2),
    OUT precio_maximo DECIMAL(10,2)
)
BEGIN
    SELECT 
        COUNT(*),
        AVG(precio),
        MAX(precio)
    INTO 
        total_pistas,
        precio_promedio,
        precio_maximo
    FROM pistas
    WHERE tipo = tipo_pista_param;
END //

DELIMITER ;
```

Para ejecutar este procedimiento:

```sql
SET @total = 0;
SET @promedio = 0;
SET @maximo = 0;
CALL obtener_estadisticas_pistas('futbol', @total, @promedio, @maximo);
SELECT @total AS total_pistas, @promedio AS precio_promedio, @maximo AS precio_maximo;
```


### Procedimiento con parámetros de entrada y salida (INOUT)

```sql
DELIMITER //

CREATE PROCEDURE aplicar_descuento(
    IN id_pista_param INT,
    INOUT precio_actual DECIMAL(10,2),
    IN porcentaje_descuento INT
)
BEGIN
    -- Obtener el precio actual si no se proporciona
    IF precio_actual = 0 THEN
        SELECT precio INTO precio_actual
        FROM pistas
        WHERE id = id_pista_param;
    END IF;
    
    -- Aplicar el descuento
    SET precio_actual = precio_actual - (precio_actual * porcentaje_descuento / 100);
END //

DELIMITER ;
```

Para ejecutar este procedimiento:

```sql
SET @precio = 0; -- Obtener automáticamente el precio de la base de datos
CALL aplicar_descuento(1, @precio, 15);
SELECT @precio AS precio_con_descuento;
```


## Procedimientos con control de errores

Es una buena práctica incluir manejo de errores en nuestros procedimientos:

```sql
DELIMITER //

CREATE PROCEDURE registrar_reserva_segura(
    IN id_pista_param INT,
    IN dni_usuario_param CHAR(9),
    IN fecha_uso_param DATETIME
)
BEGIN
    DECLARE EXIT HANDLER FOR SQLEXCEPTION
    BEGIN
        ROLLBACK;
        SELECT '❌ Error al registrar la reserva' AS resultado;
    END;
    
    START TRANSACTION;
    
    -- Verificar si la pista existe
    IF NOT EXISTS (SELECT 1 FROM pistas WHERE id = id_pista_param) THEN
        SELECT '⚠️ La pista no existe' AS resultado;
        ROLLBACK;
    -- Verificar si el usuario existe
    ELSEIF NOT EXISTS (SELECT 1 FROM usuarios WHERE dni = dni_usuario_param) THEN
        SELECT '⚠️ El usuario no existe' AS resultado;
        ROLLBACK;
    -- Verificar si la pista está disponible en esa fecha
    ELSEIF EXISTS (
        SELECT 1
        FROM reservas
        WHERE id_pista = id_pista_param
        AND DATE(fecha_uso) = DATE(fecha_uso_param)
    ) THEN
        SELECT '⚠️ La pista ya está reservada en esa fecha' AS resultado;
        ROLLBACK;
    ELSE
        -- Obtener el precio de la pista
        DECLARE precio_pista DECIMAL(10,2);
        SELECT precio INTO precio_pista FROM pistas WHERE id = id_pista_param;
        
        -- Insertar la reserva
        INSERT INTO reservas (id_pista, fecha_reserva, fecha_uso, precio)
        VALUES (id_pista_param, NOW(), fecha_uso_param, precio_pista);
        
        -- Obtener el ID de la reserva generada
        DECLARE id_reserva_nueva INT;
        SET id_reserva_nueva = LAST_INSERT_ID();
        
        -- Asociar la reserva con el usuario
        INSERT INTO usuario_reserva (dni_usuario, id_reserva)
        VALUES (dni_usuario_param, id_reserva_nueva);
        
        COMMIT;
        SELECT '✅ Reserva registrada con éxito' AS resultado, id_reserva_nueva AS id_reserva;
    END IF;
END //

DELIMITER ;
```


## Procedimientos con lógica de negocio compleja

Los procedimientos almacenados son ideales para implementar reglas de negocio complejas:

```sql
DELIMITER //

CREATE PROCEDURE procesar_reserva_con_descuento(
    IN id_pista_param INT,
    IN dni_usuario_param CHAR(9),
    IN fecha_uso_param DATETIME
)
BEGIN
    DECLARE precio_base DECIMAL(10,2);
    DECLARE descuento_usuario DECIMAL(5,2) DEFAULT 0;
    DECLARE descuento_dia_semana DECIMAL(5,2) DEFAULT 0;
    DECLARE descuento_total DECIMAL(5,2);
    DECLARE precio_final DECIMAL(10,2);
    DECLARE dia_semana INT;
    DECLARE id_reserva_nueva INT;
    
    DECLARE EXIT HANDLER FOR SQLEXCEPTION
    BEGIN
        ROLLBACK;
        SELECT '❌ Error al procesar la reserva' AS resultado;
    END;
    
    START TRANSACTION;
    
    -- Obtener el precio base de la pista
    SELECT precio INTO precio_base
    FROM pistas
    WHERE id = id_pista_param;
    
    -- Obtener el descuento base del usuario
    SELECT IFNULL(descuento, 0) INTO descuento_usuario
    FROM usuarios
    WHERE dni = dni_usuario_param;
    
    -- Calcular descuento por día de la semana (mayor descuento los lunes y martes)
    SET dia_semana = DAYOFWEEK(fecha_uso_param); -- 1=Domingo, 2=Lunes, ...
    
    IF dia_semana = 2 THEN -- Lunes
        SET descuento_dia_semana = 0.15; -- 15% de descuento
    ELSEIF dia_semana = 3 THEN -- Martes
        SET descuento_dia_semana = 0.10; -- 10% de descuento
    ELSEIF dia_semana = 4 OR dia_semana = 5 THEN -- Miércoles o Jueves
        SET descuento_dia_semana = 0.05; -- 5% de descuento
    END IF;
    
    -- Calcular descuento total (máximo 25%)
    SET descuento_total = LEAST(descuento_usuario + descuento_dia_semana, 0.25);
    
    -- Calcular precio final
    SET precio_final = precio_base * (1 - descuento_total);
    
    -- Insertar la reserva con el precio final calculado
    INSERT INTO reservas (id_pista, fecha_reserva, fecha_uso, precio)
    VALUES (id_pista_param, NOW(), fecha_uso_param, precio_final);
    
    -- Obtener el ID de la reserva generada
    SET id_reserva_nueva = LAST_INSERT_ID();
    
    -- Asociar la reserva con el usuario
    INSERT INTO usuario_reserva (dni_usuario, id_reserva)
    VALUES (dni_usuario_param, id_reserva_nueva);
    
    COMMIT;
    
    -- Devolver información detallada de la reserva
    SELECT 
        '✅ Reserva procesada con éxito' AS resultado,
        id_reserva_nueva AS id_reserva,
        precio_base AS precio_original,
        CONCAT(ROUND(descuento_total * 100, 2), '%') AS descuento_aplicado,
        precio_final AS precio_final;
END //

DELIMITER ;
```


## Modificación y eliminación de procedimientos

Para modificar un procedimiento existente, simplemente usamos la misma sintaxis pero con la palabra clave `ALTER`:

```sql
DELIMITER //

ALTER PROCEDURE buscar_pistas_por_tipo(IN tipo_pista_param VARCHAR(20))
BEGIN
    -- Nuevo código del procedimiento
    SELECT id, tipo, precio, id_polideportivo, 
           CASE WHEN precio &lt; 15 THEN 'Económica'
                WHEN precio &lt; 25 THEN 'Estándar'
                ELSE 'Premium'
           END AS categoria
    FROM pistas
    WHERE tipo = tipo_pista_param
    ORDER BY precio;
END //

DELIMITER ;
```

Para eliminar un procedimiento:

```sql
DROP PROCEDURE IF EXISTS buscar_pistas_por_tipo;
```


## Consulta de procedimientos almacenados

MySQL/MariaDB proporciona varias formas de consultar los procedimientos existentes:

```sql
-- Listar todos los procedimientos en la base de datos actual
SHOW PROCEDURE STATUS WHERE Db = DATABASE();

-- Ver el código fuente de un procedimiento específico
SHOW CREATE PROCEDURE nombre_procedimiento;
```


## Ejercicio práctico: Informe de actividad mensual

Vamos a crear un procedimiento que genere un informe de actividad para un mes específico:

```sql
DELIMITER //

CREATE PROCEDURE informe_mensual_actividad(
    IN año_param INT,
    IN mes_param INT
)
BEGIN
    DECLARE fecha_inicio DATE;
    DECLARE fecha_fin DATE;
    
    -- Definir el período del informe
    SET fecha_inicio = CONCAT(año_param, '-', LPAD(mes_param, 2, '0'), '-01');
    SET fecha_fin = LAST_DAY(fecha_inicio);
    
    -- Mostrar encabezado del informe
    SELECT CONCAT('📊 INFORME DE ACTIVIDAD: ', 
                 MONTHNAME(fecha_inicio), ' ', año_param) AS titulo,
           CONCAT('Período: ', fecha_inicio, ' a ', fecha_fin) AS periodo;
    
    -- Resumen general de reservas
    SELECT 
        COUNT(*) AS total_reservas,
        SUM(precio) AS ingresos_totales,
        ROUND(AVG(precio), 2) AS precio_promedio_reserva,
        COUNT(DISTINCT ur.dni_usuario) AS total_usuarios_activos
    FROM reservas r
    JOIN usuario_reserva ur ON r.id = ur.id_reserva
    WHERE r.fecha_uso BETWEEN fecha_inicio AND fecha_fin;
    
    -- Desglose por tipo de pista
    SELECT 
        p.tipo AS tipo_pista,
        COUNT(*) AS numero_reservas,
        CONCAT(ROUND(COUNT(*) * 100.0 / (
            SELECT COUNT(*) 
            FROM reservas 
            WHERE fecha_uso BETWEEN fecha_inicio AND fecha_fin
        ), 2), '%') AS porcentaje,
        SUM(r.precio) AS ingresos,
        ROUND(AVG(r.precio), 2) AS precio_promedio
    FROM reservas r
    JOIN pistas p ON r.id_pista = p.id
    WHERE r.fecha_uso BETWEEN fecha_inicio AND fecha_fin
    GROUP BY p.tipo
    ORDER BY COUNT(*) DESC;
    
    -- Usuarios más activos
    SELECT 
        u.nombre AS nombre_usuario,
        u.dni AS dni,
        COUNT(*) AS num_reservas,
        SUM(r.precio) AS total_gastado
    FROM usuarios u
    JOIN usuario_reserva ur ON u.dni = ur.dni_usuario
    JOIN reservas r ON ur.id_reserva = r.id
    WHERE r.fecha_uso BETWEEN fecha_inicio AND fecha_fin
    GROUP BY u.dni
    ORDER BY COUNT(*) DESC
    LIMIT 5;
    
    -- Días más ocupados
    SELECT 
        DATE_FORMAT(r.fecha_uso, '%W, %d') AS dia,
        COUNT(*) AS num_reservas
    FROM reservas r
    WHERE r.fecha_uso BETWEEN fecha_inicio AND fecha_fin
    GROUP BY DATE(r.fecha_uso)
    ORDER BY COUNT(*) DESC
    LIMIT 7;
END //

DELIMITER ;
```

<details>
<summary>Ver ejemplo de uso</summary>

```sql
CALL informe_mensual_actividad(2025, 3);
```

Este procedimiento generará un informe completo para marzo de 2025, mostrando:

1. Resumen general de actividad
2. Estadísticas por tipo de pista
3. Los 5 usuarios más activos
4. Los 7 días con mayor número de reservas

</details>

---

## 📚 Resumen de conceptos clave

- Los **procedimientos almacenados** son bloques de código PL/SQL que se guardan en la base de datos
- Pueden recibir **parámetros** de tipo **IN**, **OUT** o **INOUT**
- Proporcionan ventajas como **reutilización de código**, **mayor seguridad** y **reducción del tráfico de red**
- Son ideales para implementar **lógica de negocio compleja** directamente en la base de datos
- Se pueden **modificar** y **eliminar** cuando sea necesario
- Para ejecutarlos se utiliza el comando **CALL**
- Es recomendable incluir **manejo de errores** para hacerlos más robustos

<!--horizontal divider(gradiant)-->
<img src="https://user-images.githubusercontent.com/73097560/115834477-dbab4500-a447-11eb-908a-139a6edaec5c.gif">

# Lección 7: Funciones y Triggers en PL/SQL

## ¿Qué son las funciones en PL/SQL?

Las funciones son objetos de base de datos similares a los procedimientos almacenados, pero con una diferencia fundamental: siempre devuelven un valor. Esta característica las hace ideales para operaciones de cálculo o transformación de datos que necesitan ser utilizadas dentro de consultas SQL o en otras rutinas PL/SQL.

> 💡 **Nota**: Mientras que los procedimientos se invocan con el comando `CALL`, las funciones se pueden utilizar directamente en expresiones SQL o en asignaciones de variables.

### Ventajas de las funciones

| Ventaja | Descripción |
| :-- | :-- |
| **Reutilización de código** | Permite encapsular lógica compleja que se puede invocar desde múltiples lugares |
| **Integración con SQL** | Las funciones pueden usarse en cláusulas `SELECT`, `WHERE`, etc. |
| **Modularidad** | Facilita dividir problemas complejos en componentes más simples |
| **Mantenimiento** | Cambios en la lógica se realizan en un único lugar |

## Creación de funciones en PL/SQL

La sintaxis básica para crear una función en MariaDB es:

```sql
DELIMITER //

CREATE FUNCTION nombre_funcion
(
    [parámetros]
)
RETURNS tipo_dato
[características]
BEGIN
    -- Declaraciones
    -- Instrucciones
    RETURN valor;
END //

DELIMITER ;
```


### Parámetros y tipo de retorno

A diferencia de los procedimientos, las funciones:

1. No pueden tener parámetros de tipo `OUT` o `INOUT`, solo `IN`
2. Deben especificar un tipo de datos de retorno con la cláusula `RETURNS`
3. Deben incluir al menos una instrucción `RETURN` que devuelva un valor del tipo especificado

### Características de las funciones

Las funciones pueden tener características adicionales como:

- `DETERMINISTIC`: Indica que para los mismos parámetros de entrada, la función siempre devuelve el mismo resultado
- `NOT DETERMINISTIC`: El resultado puede variar incluso con los mismos parámetros (comportamiento por defecto)
- `READS SQL DATA`: Indica que la función lee datos (realiza consultas)
- `MODIFIES SQL DATA`: Indica que la función modifica datos (inserta, actualiza o elimina)


## Ejemplos de funciones en PL/SQL

### Función simple para calcular descuento

```sql
DELIMITER //

CREATE FUNCTION calcular_descuento(
    precio DECIMAL(10,2),
    porcentaje INT
)
RETURNS DECIMAL(10,2)
DETERMINISTIC
BEGIN
    DECLARE precio_final DECIMAL(10,2);
    
    SET precio_final = precio * (1 - porcentaje/100);
    
    RETURN precio_final;
END //

DELIMITER ;
```

Para utilizar esta función:

```sql
SELECT id, tipo, precio, 
       calcular_descuento(precio, 10) AS precio_con_descuento
FROM pistas;
```


### Función para verificar disponibilidad

```sql
DELIMITER //

CREATE FUNCTION esta_disponible(
    id_pista_param INT,
    fecha_param DATE
)
RETURNS BOOLEAN
READS SQL DATA
BEGIN
    DECLARE reservas INT;
    
    SELECT COUNT(*) INTO reservas
    FROM reservas
    WHERE id_pista = id_pista_param
    AND DATE(fecha_uso) = fecha_param;
    
    RETURN reservas = 0;
END //

DELIMITER ;
```

Para utilizarla:

```sql
SELECT id, tipo, 
       CASE WHEN esta_disponible(id, '2025-05-01') 
            THEN 'Disponible' 
            ELSE 'No disponible' 
       END AS estado
FROM pistas;
```


## ¿Qué son los Triggers (Disparadores)?

Los triggers son objetos de base de datos que se ejecutan automáticamente en respuesta a determinados eventos que ocurren en una tabla específica. Actúan como "vigilantes" que se disparan cuando se realizan operaciones de inserción, actualización o eliminación.

> ⚠️ **Importante**: A diferencia de procedimientos y funciones, los triggers no se invocan explícitamente, sino que se ejecutan automáticamente cuando ocurre el evento al que están asociados.

### Tipos de triggers según el momento de ejecución

| Tipo | Descripción | Uso típico |
| :-- | :-- | :-- |
| **BEFORE** | Se ejecuta antes de que ocurra la operación | Validar o modificar datos antes de ser almacenados |
| **AFTER** | Se ejecuta después de que la operación ha ocurrido | Mantener registros de auditoría o actualizar tablas relacionadas |

### Tipos de triggers según la operación

| Operación | Descripción | Referencias disponibles |
| :-- | :-- | :-- |
| **INSERT** | Se ejecuta al insertar filas | `NEW.*` |
| **UPDATE** | Se ejecuta al modificar filas | `OLD.*` y `NEW.*` |
| **DELETE** | Se ejecuta al eliminar filas | `OLD.*` |

## Creación de triggers en PL/SQL

La sintaxis básica para crear un trigger en MariaDB es:

```sql
DELIMITER //

CREATE TRIGGER nombre_trigger
{BEFORE | AFTER} {INSERT | UPDATE | DELETE}
ON nombre_tabla
FOR EACH ROW
BEGIN
    -- Instrucciones a ejecutar
END //

DELIMITER ;
```


### Referencias a valores en los triggers

Dentro de un trigger, podemos acceder a los valores de las columnas afectadas:

- `OLD.columna`: Contiene el valor original (antes de UPDATE o DELETE)
- `NEW.columna`: Contiene el nuevo valor (después de INSERT o UPDATE)


## Ejemplos prácticos de triggers

### Trigger para registro de auditoría

```sql
DELIMITER //

CREATE TRIGGER auditoria_reservas_after_insert
AFTER INSERT ON reservas
FOR EACH ROW
BEGIN
    INSERT INTO log_reservas (
        accion, 
        id_reserva, 
        id_pista, 
        fecha_uso, 
        precio, 
        fecha_registro
    )
    VALUES (
        'INSERT', 
        NEW.id, 
        NEW.id_pista, 
        NEW.fecha_uso, 
        NEW.precio, 
        NOW()
    );
END //

DELIMITER ;
```


### Trigger para validación de datos

```sql
DELIMITER //

CREATE TRIGGER validar_precio_pista
BEFORE INSERT ON pistas
FOR EACH ROW
BEGIN
    IF NEW.precio &lt; 5 THEN
        SIGNAL SQLSTATE '45000' 
        SET MESSAGE_TEXT = 'El precio mínimo para una pista es 5€';
    END IF;
END //

DELIMITER ;
```


### Trigger para mantener datos calculados

```sql
DELIMITER //

CREATE TRIGGER actualizar_total_polideportivo
AFTER INSERT ON pistas
FOR EACH ROW
BEGIN
    UPDATE polideportivos
    SET total_pistas = total_pistas + 1
    WHERE id = NEW.id_polideportivo;
END //

DELIMITER ;
```


## Encadenamiento de triggers y procedimientos

Los triggers pueden llamar a procedimientos y funciones, lo que permite crear lógica más compleja:

```sql
DELIMITER //

CREATE TRIGGER notificar_nueva_reserva
AFTER INSERT ON reservas
FOR EACH ROW
BEGIN
    -- Llamada a un procedimiento desde el trigger
    CALL registrar_notificacion(
        NEW.id,
        (SELECT dni_usuario FROM usuario_reserva WHERE id_reserva = NEW.id),
        CONCAT('Nueva reserva creada para la fecha ', DATE_FORMAT(NEW.fecha_uso, '%d/%m/%Y'))
    );
END //

DELIMITER ;
```


## Gestión de triggers

Para visualizar los triggers existentes:

```sql
SHOW TRIGGERS;
```

Para obtener información detallada de un trigger específico:

```sql
SHOW CREATE TRIGGER nombre_trigger;
```

Para eliminar un trigger:

```sql
DROP TRIGGER IF EXISTS nombre_trigger;
```


## Ejercicio práctico: Sistema completo de auditoría de reservas

Vamos a implementar un sistema completo de auditoría que registre todas las operaciones realizadas en la tabla de reservas:

```sql
DELIMITER //

-- Trigger para inserción
CREATE TRIGGER audit_reservas_insert
AFTER INSERT ON reservas
FOR EACH ROW
BEGIN
    INSERT INTO auditoria_reservas (
        id_reserva,
        accion,
        id_pista,
        fecha_uso_antigua,
        fecha_uso_nueva,
        precio_antiguo,
        precio_nuevo,
        usuario,
        fecha_modificacion
    )
    VALUES (
        NEW.id,
        'INSERT',
        NEW.id_pista,
        NULL,
        NEW.fecha_uso,
        NULL,
        NEW.precio,
        CURRENT_USER(),
        NOW()
    );
END //

-- Trigger para actualización
CREATE TRIGGER audit_reservas_update
AFTER UPDATE ON reservas
FOR EACH ROW
BEGIN
    INSERT INTO auditoria_reservas (
        id_reserva,
        accion,
        id_pista,
        fecha_uso_antigua,
        fecha_uso_nueva,
        precio_antiguo,
        precio_nuevo,
        usuario,
        fecha_modificacion
    )
    VALUES (
        NEW.id,
        'UPDATE',
        NEW.id_pista,
        OLD.fecha_uso,
        NEW.fecha_uso,
        OLD.precio,
        NEW.precio,
        CURRENT_USER(),
        NOW()
    );
END //

-- Trigger para eliminación
CREATE TRIGGER audit_reservas_delete
AFTER DELETE ON reservas
FOR EACH ROW
BEGIN
    INSERT INTO auditoria_reservas (
        id_reserva,
        accion,
        id_pista,
        fecha_uso_antigua,
        fecha_uso_nueva,
        precio_antiguo,
        precio_nuevo,
        usuario,
        fecha_modificacion
    )
    VALUES (
        OLD.id,
        'DELETE',
        OLD.id_pista,
        OLD.fecha_uso,
        NULL,
        OLD.precio,
        NULL,
        CURRENT_USER(),
        NOW()
    );
END //

DELIMITER ;
```


## Consideraciones importantes sobre los triggers

- **Rendimiento**: Los triggers añaden sobrecarga a las operaciones de base de datos, por lo que deben usarse con moderación
- **Depuración**: Los errores en triggers pueden ser difíciles de diagnosticar
- **Transparencia**: Los triggers se ejecutan "en silencio", lo que puede dificultar el seguimiento de las operaciones
- **Transacciones**: Los errores en triggers pueden hacer que fallen transacciones completas
- **Mantenimiento**: Es importante documentar bien todos los triggers implementados


## Comparativa: ¿Cuándo usar procedimientos, funciones o triggers?

| Característica | Procedimientos | Funciones | Triggers |
| :-- | :-- | :-- | :-- |
| **Invocación** | Explícita (`CALL`) | Explícita (en consultas) | Automática (evento) |
| **Retorno** | No (pero puede tener parámetros `OUT`) | Sí, un valor | No |
| **Uso en consultas** | No | Sí | No aplicable |
| **Parámetros** | `IN`, `OUT`, `INOUT` | Solo `IN` | No aplicable |
| **Mejor para** | Operaciones complejas | Cálculos, transformaciones | Validaciones, auditoría |


---

## 📚 Resumen de conceptos clave

- Las **funciones** son objetos de base de datos que siempre devuelven un valor
- A diferencia de los procedimientos, las funciones solo aceptan parámetros de tipo `IN`
- Las funciones se pueden utilizar directamente en consultas SQL
- Los **triggers** son objetos que se ejecutan automáticamente ante eventos en tablas
- Existen triggers `BEFORE` y `AFTER` para las operaciones `INSERT`, `UPDATE` y `DELETE`
- Los triggers permiten acceder a los valores a través de las referencias `OLD` y `NEW`
- Los triggers son útiles para validación de datos, auditoría y mantenimiento de datos calculados

<!--horizontal divider(gradiant)-->
<img src="https://user-images.githubusercontent.com/73097560/115834477-dbab4500-a447-11eb-908a-139a6edaec5c.gif">

¡Felicidades! Has completado el curso completo de PL/SQL para MariaDB. Ahora tienes los conocimientos necesarios para implementar lógica de negocio compleja directamente en tu base de datos.
