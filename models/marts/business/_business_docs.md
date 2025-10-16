{% docs fct_orders_description %}
# Tabla de hechos: fct_orders

La tabla `fct_orders` representa las ventas agregadas a nivel de orden, cliente, producto y proveedor.

## Origen de los datos

- Basada en la capa intermedia `int_orders` que une:
  - Clientes (`stg_customer`)
  - Órdenes (`stg_orders`)
  - Line items (`stg_lineitem`)
  - Partes y proveedores (`stg_part`, `stg_supplier`, `stg_partsupp`)

## Transformaciones clave

1. **Claves y referencias:**
   - `orders_key`: clave principal construida a partir de `order_id`, `line_number` y `part_id`.
   - La tabla referencia a:
     - Clientes (`customer_key`)
     - Nación (`nation_key`)
     - Producto (`part_key`)
     - Proveedor (`supplier_key`)

2. **Columnas calculadas y métricas:**
   - `final_price`: precio total de la línea de la orden.
   - `total_cost`: coste total del proveedor por la línea.
   - `profit`: beneficio calculado como `final_price - total_cost`.
   - `days_of_delay`: número de días de retraso entre `commit_date` y `receipt_date`.
   - `shipping_days`: número de días entre `order_date` y `ship_date`.

3. **Fechas asociadas a la dimensión de tiempo:**
   - `order_date` y `ship_date` se relacionan con `dim_date` para análisis temporal.

## Observaciones de negocio

- Permite análisis granular por línea de orden.
- Facilita seguimiento de rentabilidad por producto, cliente y proveedor.
- Integración con dimensiones `dim_customer`, `dim_part`, `dim_supplier` y `dim_date` para análisis consistentes a nivel de negocio.
{% enddocs %}