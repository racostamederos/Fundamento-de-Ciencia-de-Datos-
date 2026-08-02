---CONSULTAS---

use db_universidad;
go

---SELECT---
--selecciona todo de la tabla estudiante
select * from estudiante;
go

---WHERE---
--devuelve el nombre y apellido del dueño de esta cedula
select * from profesor;
go
select nombre, apellido from profesor where cedula = '001-030979-2005E';
go

---LIKE---
---Buscar todos los nombres que comiencen con Luc de la tabla de estudiante
select * from estudiante;
select nombre 
from estudiante 
where nombre like 'Luc%'
go

---AND---
---selecciona las asignaturas que tengan mas de 60 horas y que sumen 5 creditos
select * from asignatura;
select nombre, horas, credito
from asignatura 
where credito = 5 
and horas > 60
go

---OR---
---selecciona los que hayan pagado 150.00 o hayan pagado por sinpe
select *  from pago;
select * 
from pago 
where tipo_pago = 'Sinpe'
or monto = 150.00
go

---COUNT---
---Cuenta todos los que pagaron
select * from pago;
select COUNT (*) as cantidad_pagado
from pago 
where estado = 'Completado'
go

---SUM---
--monto de matriculas pagadas
select SUM (monto)
as total_pagado
from pago;

----AVG---
---Promedio pagado
select avg(monto)
as promedio_pagado
from pago;
go

---MIN---
---Monto minimo pagado
select min(monto)
as pago_minimo 
from pago;
go

---MAX---
---Monto maximo pagado
select max(monto)
as pago_maximo 
from pago;
go

---IS NULL---
---selecciona las notas nulas
select nota, estado
from detalle_matricula
where nota is null
go

---IS NOT NULL---
---selecciona las notas no nulas
select nota, estado
from detalle_matricula
where nota is NOT NULL
go

---BETWEEN---
---agrupa las notas entre 80 y 90
select nota, estado
from detalle_matricula
where nota between 80 and 90
go

---GROUP BY---
---HAVING---
---agrupa los que el hayan pagado menos de 150
select * from pago;
select id_pago,
sum(monto) as monto_total
from pago
group by id_pago
having sum(monto) < 150;

---ORDER BY---
---ordena los apellidos alfabeticamente---
select nombre, apellido, correo 
from estudiante
order by apellido asc;

---DISTINC---
---visualiza id_carreras no repetidos---
select distinct id_carrera 
from estudiante;

---TOP---
-- Devuelve únicamente las primeras 5 carreras registradas
select top 5 id_carrera, nombre, titulo 
from carrera;

---IN---
-- Consulta los tipos de pago en efectivo, tarjeta o sinpe
select id_pago, monto, tipo_pago 
from pago
where tipo_pago IN ('Efectivo', 'Tarjeta', 'Sinpe');

---NOT---
---Obtiene las asignaturas que no duran 64 horas
select nombre, horas 
from asignatura
where NOT horas = 64;

---INNER JOIN---
---visualiza datos de la tabla de estudiantes con la de las carreras
select
c.nombre,
p.nombre,
p.titulo
from estudiante c
inner join carrera p
on c.id_carrera = p.id_carrera;

---LEFT JOIN---
select 
    m.id_matricula,
    m.id_estudiante,
    p.id_pago,
    p.monto
from matricula m
LEFT JOIN pago p ON m.id_matricula = p.id_matricula
WHERE p.id_pago IS NULL; -- Filtra solo los que NO tienen pago asociado

---RIGHT JOIN---
SELECT 
    m.id_matricula,
    m.id_estudiante,
    p.id_pago,
    p.monto,
    p.tipo_pago
FROM matricula m               -- Tabla de la IZQUIERDA
RIGHT JOIN pago p               -- Tabla de la DERECHA (Principal)
    ON m.id_matricula = p.id_matricula;

    -----CONSULTAS CON CREATE VIEW
   
  CREATE VIEW pago_alto
  as
  select monto, tipo_pago 
  from pago
  where monto>100;
  SELECT * FROM pago_alto;

     CREATE VIEW matriculas_estudiantes AS
SELECT 
    m.id_matricula,
    e.id_estudiante,
    e.nombre,
    e.apellido,
    m.periodo,
    m.fecha_matricula,
    m.estado AS estado_matricula
FROM matricula m
INNER JOIN estudiante e ON m.id_estudiante = e.id_estudiante;
GO
SELECT * FROM matriculas_estudiantes;


CREATE VIEW resumen_pagos_estudiante AS
SELECT 
    e.id_estudiante,
    e.nombre,
    e.apellido,
    COUNT(p.id_pago) AS total_pagos_realizados,
    SUM(p.monto) AS total_monto_pagado
FROM estudiante e
INNER JOIN matricula m ON e.id_estudiante = m.id_estudiante
INNER JOIN pago p ON m.id_matricula = p.id_matricula
WHERE p.estado = 'Completado'
GROUP BY e.id_estudiante, e.nombre, e.apellido;
GO
SELECT * FROM resumen_pagos_estudiante;


CREATE VIEW estudiantes_reprobados AS
SELECT 
    d.id_detalle,
    e.id_estudiante,
    e.nombre,
    e.apellido,
    a.nombre AS asignatura,
    d.nota
FROM estudiante e
INNER JOIN matricula m ON e.id_estudiante = m.id_estudiante
INNER JOIN detalle_matricula d ON m.id_matricula = d.id_matricula
INNER JOIN asignatura a ON d.id_asignatura = a.id_asignatura
WHERE d.nota < 70.00 OR d.estado = 'Reprobada';
GO
SELECT * FROM estudiantes_reprobados;




CREATE VIEW matriculas_pendientes_pago AS
SELECT 
    m.id_matricula,
    e.id_estudiante,
    e.nombre,
    e.apellido,
    m.periodo,
    ISNULL(p.estado, 'Sin Registro') AS estado_pago
FROM matricula m
INNER JOIN estudiante e ON m.id_estudiante = e.id_estudiante
LEFT JOIN pago p ON m.id_matricula = p.id_matricula
WHERE p.id_pago IS NULL OR p.estado = 'Pendiente';
SELECT * FROM matriculas_pendientes_pago
ORDER BY estado_pago DESC;


CREATE VIEW vw_promedio_estudiantes AS
SELECT 
    e.id_estudiante,
    e.nombre,
    e.apellido,
    CAST(AVG(d.nota) AS DECIMAL(5,2)) AS promedio_general
FROM estudiante e
INNER JOIN matricula m ON e.id_estudiante = m.id_estudiante
INNER JOIN detalle_matricula d ON m.id_matricula = d.id_matricula
WHERE d.nota IS NOT NULL
GROUP BY e.id_estudiante, e.nombre, e.apellido;
GO
SELECT * FROM vw_promedio_estudiantes
ORDER BY promedio_general DESC;