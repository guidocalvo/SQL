# 🎮 Análisis SQL en tienda de películas ficticia

## 📖 Descripción

Este proyecto consiste en una serie de consultas SQL aplicadas sobre un esquema de ejemplo orientado al negocio del alquiler de películas.
El objetivo principal es **explorar datos, responder preguntas específicas y obtener insights útiles** sobre actores, películas, alquileres y más, utilizando técnicas de análisis con SQL puro.

Se abordan consultas de tipo:

- Agrupaciones y agregaciones.
- Subconsultas.
- Uso de funciones de fecha y texto.
- Relaciones entre tablas mediante `JOIN`.

Este proyecto puede servir como base para practicar SQL en un contexto realista y estructurado.

## 🗂 Estructura del Proyecto

El trabajo se compone de tres archivos. El readme.md con la descripción del proyecto, el esquema de la base de datos y el archivo SQL con las consultas resueltas.

## 🛠 Instalación y Requisitos

Para ejecutar las consultas necesitas las herramientas PostgreSQL y Dbeaver.

## 📊 Resultados y Conclusiones

Algunos hallazgos interesantes obtenidos con las consultas:

- Hay varios actores que comparten el mismo nombre, siendo algunos nombres muy comunes.
- Existen múltiples películas con la misma duración que *Dancing Fever*, lo que sugiere tiempos de producción estandarizados.
- Es posible identificar a los actores que actuaron en películas alquiladas después de cierto evento específico (como el primer alquiler de *Spartacus Cheaper*), permitiendo análisis basados en líneas temporales.
- El uso de subconsultas correlacionadas permite filtrar información compleja sin necesidad de múltiples pasos intermedios.

## 🔄 Próximos Pasos

- Añadir visualizaciones simples de los datos (por ejemplo, con Python y pandas).
- Crear vistas almacenadas para consultas recurrentes.
- Ampliar el análisis a categorías de películas y comportamiento de clientes.
- Traducir las consultas a PostgreSQL o SQLite para portabilidad.

## 🤝 Contribuciones

Las contribuciones son bienvenidas. Puedes sugerir nuevas consultas, correcciones o mejoras estructurales.

## ✍️ Autores

Guido Julián Calvo Sio
