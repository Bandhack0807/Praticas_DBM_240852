# Diccionario de datos

Consulta estática generada desde `respaldo_31_10_26.sql`, el respaldo completo más reciente disponible en `Practica 03/Backup`. Incluye metadatos de tablas y vistas y no publica filas de datos. La consulta funciona sin MySQL ni conexión de red.

## Requisitos y uso

- Node.js 18 o posterior para regenerar el catálogo; no necesita paquetes externos.
- Abra `index.html` en un navegador para consultar el diccionario.
- Para regenerar, ejecute `node generate.js` desde esta carpeta. El generador lee únicamente definiciones DDL del respaldo en `../Backup` y produce `index.html` y `schema.json`.

## Archivos

- `generate.js`: extracción de tablas, columnas, claves, índices, restricciones y vistas.
- `schema.json`: metadatos estructurados extraídos.
- `index.html`, `styles.css`: diccionario navegable.

Los propósitos de tabla son descripciones inferidas de nombres y columnas, no comentarios del motor. Las relaciones se presentan solo cuando existe una restricción FOREIGN KEY. La cardinalidad refleja índices únicos y nulabilidad; no implica que haya filas relacionadas.
