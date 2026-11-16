# Explorador ER interactivo

Aplicación de esquema offline con animaciones educativas. Está basada en `respaldo_10_11_26.sql`, igual que el diccionario. Los registros de las animaciones son **ejemplos simulados**, no filas del respaldo; no hay operaciones contra MySQL.

## Ejecución local

Requiere Node.js 18 o posterior. No instala paquetes ni crea `node_modules`.

1. Desde esta carpeta, ejecute `npm start` (o `node server.js`).
2. Abra `http://127.0.0.1:4173`.
3. Pulse Ctrl+C en la terminal para detener el servidor.

El servidor solo entrega los archivos estáticos de esta carpeta. La app necesita este origen local porque los navegadores restringen `fetch` y módulos cuando se abre el HTML directamente como `file://`. No necesita internet ni MySQL.

## Funciones

- Vista SVG con las 25 entidades, columnas, PK/FK y referencias confirmadas.
- En vista general, un punto por cada FK recorre simultáneamente las 33 relaciones declaradas y destaca las entidades conectadas. Se pueden pausar/reanudar y filtrar tipos de relación. **Ver flujo completo** abre además la secuencia guiada.
- Búsqueda de tablas/columnas, grupos plegables, filtros de relación, selección y resaltado contextual.
- Zoom con rueda y controles, desplazamiento arrastrando el fondo, centrado y reinicio.
- Inspector de columnas, tipos, restricciones, claves y relaciones entrantes/salientes.
- Modos general, relaciones, flujo y guiado.
- Botón **Ver flujo**: inicia directamente la animación visible de un registro simulado sobre una FK confirmada, con las columnas FK y PK de ambos extremos resaltadas.
- Animación del recorrido de tarjetas simuladas siguiendo conectores de claves foráneas.
- Guía de diez etapas con controles de reproducción, pausa, paso, reinicio y velocidad.
- Ejemplos didácticos 1:N, asociación N:M, autorreferencias, consulta conceptual y operaciones CRUD visuales.

## Archivos

- `index.html`, `styles.css`, `src/extra.css`: interfaz.
- `src/app.js`: selección, filtros, inspector y modos.
- `src/graph.js`: distribución, representación SVG y navegación.
- `src/lesson.js`: guía, simulaciones y animación de registros.
- `schema.json`: esquema autónomo sin conexión a base de datos.
- `server.js`, `package.json`: servidor local mínimo sin dependencias.
