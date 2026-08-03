USE db_jardineria;
go

select * from cliente;
---Buscar registros con valores null---
select nombre_cliente, ciudad, region
from cliente
where region IS NULL;
go

--->Empleados que no tienen jefe asignado---
select nombre, apellido1, codigo_jefe
from empleado
where codigo_jefe is null;
go

---Pedidos que aun no han sido entregados---
select codigo_pedido, fecha_pedido, fecha_entrega 
from pedido
where fecha_entrega is null;
go

select * from cliente
go
---cliente que si tienen limite de credito (is not null)
select nombre_cliente, limite_credito  
from cliente
where limite_credito is not null;
go

---oficinas que tienen una segunda direccion
select ciudad, linea_direccion2 
from oficina
where linea_direccion2 is not null;
go

select * from cliente
go
---Remplazar valores null con COALESCE
---COALESCE sirve para mostrar otro valor cuando aparece null
select nombre_cliente,
   COALESCE(region,'sin region') AS region
from cliente;
go

select * from empleado;

---Mostrar "No tiene jefe" cuando el empleado no tenga jefe
select nombre,
   COALESCE(CAST(codigo_jefe AS VARCHAR(10)),'No tiene jefe') 
   as jefe 
from empleado;
go

 ---Mostrar cometario de  pedidos---
   ---Si el pedido no tiene cometaios, aparece "Sin comentarios "
   select codigo_pedido,
   COALESCE(comentarios, 'Sin comentarios')
   as comentario 
from pedido;
go

select * from cliente
go

---clientes que tienen region y limite de credito
---limite de credito que no sea nulo select codigo_pedido
   select nombre_cliente, region, limite_credito
   from cliente
   where limite_credito is not null and region is not null
   go
  
 create view vista_clientes as
  select nombre_cliente, ciudad,pais
  from cliente;
  go
  select * from vista_clientes;


    ---vita de productos caros, nombre y precio de venta pero producto >100
  CREATE VIEW productos_caros
  as
  select nombre, precio_venta 
  from producto 
  where precio_venta>100;
  go

  select * from productos_caros

  select * from cliente;
   select * from pedido;

  ---VISTA CON INNER JOIN
  CREATE VIEW vista_pedidos_clientes
  AS
  Select p.codigo_pedido,
         c.nombre_cliente,
         p.fecha_pedido
FROM pedido p
INNER JOIN cliente c
On p.codigo_cliente = c.codigo_cliente;
go
  select * from vista_pedidos_clientes;


  ---Vista con funciones de agregacion group by 
  CREATE VIEW total_pagos_clientes
  AS
  Select codigo_cliente,
         sum(total) 
         as total_pedido
FROM pago
GROUP BY codigo_cliente;

select * from total_pagos_clientes;

---Eliminar una vista---
drop view vista_pedido_clientes;
go

---otra manera
CREATE VIEW total_pagos_clientes_max
  AS
  Select codigo_cliente,
         max(total) 
         as total_pagado
FROM pago
GROUP BY codigo_cliente;
 
 select * from total_pagos_clientes_max

 ---eliminarlos
 drop view vista_pagos_clientes_max;
go

---Con CTE
WITH promedio AS(
SELECT AVG(precio_venta) AS precio_promedio
from producto
)
select nombre,precio_venta
from producto, promedio
where precio_venta > promedio.precio_promedio;