-- 2. Muestra los nombres de todas las películas con una clasificación por edades de ‘R’.
select title as pelicula
from film f
where rating = 'R';

-- 3. Encuentra los nombres de los actores que tengan un “actor_id” entre 30 y 40.
select  CONCAT(a.first_name, ' ', a.last_name) as actor
from actor a 
where actor_id between 30 and 40;

-- 4. Obtén las películas cuyo idioma coincide con el idioma original.
select title as pelicula
from film f
where language_id = original_language_id;

-- 5. Ordena las películas por duración de forma ascendente.
select title as pelicula
from film f
order by length asc;

-- 6. Encuentra el nombre y apellido de los actores que tengan ‘Allen’ en su apellido.
select  CONCAT(a.first_name, ' ', a.last_name) as actor
from actor a 
where a.last_name ilike '%ALLEN%';

-- 7. Encuentra la cantidad total de películas en cada clasificación de la tabla “film” y muestra la clasificación junto con el recuento.
select rating as clasificacion, COUNT(rating) as total
from film f 
group by rating;

-- 8. Encuentra el título de todas las películas que son ‘PG-13’ o tienen una duración mayor a 3 horas en la tabla film.
select title as pelicula
from film f
where rating = 'PG-13' or length > 180;

-- 9. Encuentra la variabilidad de lo que costaría reemplazar las películas.
select round(variance(replacement_cost),2) as costo
from film f;

-- 10. Encuentra la mayor y menor duración de una película de nuestra BBDD.
select MIN(length) as minima_duracion, MAX(length) as maxima_duracion
from film f;

-- 11. Encuentra lo que costó el antepenúltimo alquiler ordenado por día.
select amount as costo, payment_date as fecha
from payment p
order by payment_date desc
limit 1 offset 2;

-- 12. Encuentra el título de las películas en la tabla “film” que no sean ni ‘NC-17’ ni ‘G’ en cuanto a su clasificación.
select title as pelicula, rating as clasificacion
from film f
where rating <> 'G' and rating <> 'NC-17'; 

-- 13. Encuentra el promedio de duración de las películas para cada clasificación de la tabla film y muestra la clasificación junto con el promedio de duración.
select rating as clasificacion, round(AVG(length),0) as duracion
from film f 
group by rating;

-- 14. Encuentra el título de todas las películas que tengan una duración mayor a 180 minutos.
select title as pelicula
from film f
where length > 180;

-- 15. ¿Cuánto dinero ha generado en total la empresa?
select SUM(amount) as dinero_total
from payment p;

-- 16. Muestra los 10 clientes con mayor valor de id.
select CONCAT(c.first_name, ' ', c.last_name) as cliente, customer_id as cliente_id
from customer c
order by customer_id desc
limit 10;

-- 17. Encuentra el nombre y apellido de los actores que aparecen en la película con título ‘Egg Igby’.
select  CONCAT(a.first_name, ' ', a.last_name) as actor
from actor a
join film_actor fa on a.actor_id = fa.actor_id
join film f on f.film_id = fa.film_id
where f.title ilike 'EGG IGBY';

-- 18. Selecciona todos los nombres de las películas únicos.
select distinct title as pelicula
from film f
order by title;

--  19. Encuentra el título de las películas que son comedias y tienen una duración mayor a 180 minutos en la tabla “film”.
select title as pelicula
from film f
join film_category fc on fc.film_id  = f.film_id
join category c on c.category_id = fc.category_id
where c.name = 'Comedy' and f.length > '180';

-- 20. Encuentra las categorías de películas que tienen un promedio de duración superior a 110 minutos y muestra el nombre de la categoría junto con el promedio de duración.
select c.name as Categoria, round(AVG(length),0) as promedio_de_duracion
from film f
join film_category fc on fc.film_id  = f.film_id
join category c on c.category_id = fc.category_id
group by c."name"
having AVG(length) > 110;

-- 21. ¿Cuál es la media de duración del alquiler de las películas?
select justify_interval(AVG(return_date - rental_date)) as duracion_media
from rental r ;

-- 22. Crea una columna con el nombre y apellidos de todos los actores y actrices.
select concat(first_name, ' ', last_name) as actor
from actor;

-- 23. Números de alquiler por día, ordenados por cantidad de alquiler de forma descendente.

select date(rental_date) as fecha, count(rental_date) as cantidad_de_alquileres
from rental
group by date(rental_date)
order by cantidad_de_alquileres desc;

-- 24. Encuentra las películas con una duración superior al promedio.
select title as pelicula
from film f
where length > (select AVG(length) from film f);

-- 25. Averigua el número de alquileres registrados por mes.
select date_trunc('month', rental_date) as mes, count(*) as cantidad_de_alquileres
from rental
group by mes
order by mes;

-- 26. Encuentra el promedio, la desviación estándar y varianza del total pagado.
select AVG(amount) as promedio, stddev(amount) as desviacion_standard, variance(amount) as varianza_del_total_pagado
from payment p;

-- 27. ¿Qué películas se alquilan por encima del precio medio?
select title as pelicula
from film f
where rental_rate > (select AVG(rental_rate) from film f);

-- 28. Muestra el id de los actores que hayan participado en más de 40 películas.
select actor_id, COUNT(actor_id) as cantidad_de_peliculas
from film_actor fa
join film f on fa.film_id = f.film_id
group by fa.actor_id
having COUNT(actor_id) > 40;

-- 29. Obtener todas las películas y, si están disponibles en el inventario, mostrar la cantidad disponible.
select title as peliculas, COUNT(title) as cantidad_disponible
from film f
left join inventory i on f.film_id = i.film_id 
group by title;

-- 30. Obtener los actores y el número de películas en las que ha actuado.
select a.actor_id, 
	CONCAT(a.first_name, ' ', a.last_name) as actor,
    COUNT(fa.film_id) as cantidad_de_peliculas
from actor a
join film_actor fa on a.actor_id = fa.actor_id
group by a.actor_id, a.first_name, a.last_name
order by cantidad_de_peliculas desc;

-- 31. Obtener todas las películas y mostrar los actores que han actuado en ellas, incluso si algunas películas no tienen actores asociados.
select title as pelicula, CONCAT(a.first_name, ' ', a.last_name) as actor
from film f
left join film_actor fa on f.film_id = fa.film_id
left join actor a on fa.actor_id = a.actor_id
order by title asc;

-- 32. Obtener todos los actores y mostrar las películas en las que han actuado, incluso si algunos actores no han actuado en ninguna película.
select CONCAT(a.first_name, ' ', a.last_name) as actor, title as pelicula
from actor a 
left join film_actor fa on a.actor_id = fa.actor_id 
left join film f on fa.film_id = f.film_id
order by last_name, first_name asc;

-- 33. Obtener todas las películas que tenemos y todos los registros de alquiler.
select f.title as pelicula, r.rental_id as alquiler_id, r.rental_date as fecha_de_alquiler, r.customer_id as cliente_id
from rental r
left join inventory i on r.inventory_id = i.inventory_id
left join film f on i.film_id  = f.film_id 
order by title;

-- 34. Encuentra los 5 clientes que más dinero se hayan gastado con nosotros.
select  c.customer_id as cliente_id, 
		CONCAT(c.first_name, ' ', c.last_name) as cliente, 
		SUM(p.amount) as dinero_gastado
from customer c 
join payment p on c.customer_id = p.customer_id 
group by c.customer_id, first_name, last_name 
order by SUM(p.amount) desc
limit 5;

-- 35. Selecciona todos los actores cuyo primer nombre es 'Johnny'.
select CONCAT(a.first_name, ' ', a.last_name) as actor
from actor a 
where first_name ilike '%JOHNNY%';

-- 36. Renombra la columna “first_name” como Nombre y “last_name” como Apellido.
select first_name as Nombre, last_name as Apellido
from actor a 

--37. Encuentra el ID del actor más bajo y más alto en la tabla actor.
-- Seleccionamos el nombre completo del actor y su ID
select CONCAT(a.first_name, ' ', a.last_name) as actor, actor_id
from actor a
-- Filtramos solo los actores cuyo actor_id está en el conjunto devuelto por la subconsulta
where actor_id in (
    -- Subconsulta que devuelve:
    -- 1. El actor con el ID más alto (último actor en la tabla)
    select MAX(actor_id)
    from actor a
    -- UNION ALL: permite combinar los resultados de dos SELECT
    union all
    -- 2. El actor con el ID más bajo (primer actor en la tabla)
    select MIN(actor_id)
    from actor a
);

-- 38. Cuenta cuántos actores hay en la tabla “actor”.
select COUNT(actor_id) as cantidad_de_actores
from actor a;

-- 39. Selecciona todos los actores y ordénalos por apellido en orden ascendente.
select CONCAT(a.first_name, ' ', a.last_name) as actor
from actor a
order by last_name asc;

-- 40. Selecciona las primeras 5 películas de la tabla “film”.
select film_id as pelicula_id, title as pelicula
from film f
order by f.film_id asc
limit 5;

-- 41. Agrupa los actores por su nombre y cuenta cuántos actores tienen el mismo nombre. ¿Cuál es el nombre más repetido?
-- Seleccionamos el nombre y cuántas veces aparece
select first_name, COUNT(*) as total
from actor
-- Agrupamos por nombre
group by first_name
-- Nos quedamos solo con aquellos nombres que tienen la cantidad máxima de repeticiones
having COUNT(*) = (
    -- Subconsulta que obtiene la cantidad máxima de veces que se repite un nombre
    select MAX(name_count)
    from (
        -- Esta subconsulta cuenta cuántos actores hay por cada nombre
        select COUNT(*) AS name_count
        from actor
        group by first_name
    ) as counts
);

-- 42. Encuentra todos los alquileres y los nombres de los clientes que los realizaron.
select  rental_id as alquier_id, 
		date(rental_date) as fecha_de_alquiler, 
		date(return_date) as fecha_de_retorno, 
	    CONCAT(c.first_name, ' ', c.last_name) as cliente
from rental r
join customer c on r.customer_id = c.customer_id;

-- 43. Muestra todos los clientes y sus alquileres si existen, incluyendo aquellos que no tienen alquileres.
select  CONCAT(c.first_name, ' ', c.last_name) as cliente, 
		rental_id as alquier_id, 
		date(rental_date) as fecha_de_alquiler, 
		date(return_date) as fecha_de_retorno
from customer c
left join rental r on c.customer_id = r.customer_id;

-- 44 Realiza un CROSS JOIN entre las tablas film y category. ¿Aporta valor esta consulta? ¿Por qué? Deja después de la consulta la contestación.
select *
from film f
cross join category c
-- Esta consulta no aporta valor ya que genera combinaciones que no son reales, por ejemplo, le coloca todas las categorías a cada película, eso no tendría sentido.

-- 45 Encuentra los actores que han participado en películas de la categoría 'Action'.
select distinct CONCAT(a.first_name, ' ', a.last_name) as actor
from actor a
join film_actor fa on a.actor_id = fa.actor_id
join film f on fa.film_id = f.film_id
join film_category fc on f.film_id = fc.film_id
join category c on fc.category_id = c.category_id
where c."name" = 'Action';

-- 46. Encuentra todos los actores que no han participado en películas.
select CONCAT(a.first_name, ' ', a.last_name) as actor
from actor a
left join film_actor fa on a.actor_id = fa.actor_id
where fa.film_id is null;

-- 47. Selecciona el nombre de los actores y la cantidad de películas en las que han participado.
select a.actor_id, CONCAT(a.first_name, ' ', a.last_name) as actor, COUNT(a.actor_id) as cantidad_de_peliculas
from actor a
inner join film_actor fa on fa.actor_id = a.actor_id
group by a.actor_id, a.first_name, a.last_name
order by actor_id;

-- 48. Crea una vista llamada “actor_num_peliculas” que muestre los nombres de los actores y el número de películas en las que han participado.
create view actor_num_peliculas as
select a.first_name, a.last_name, COUNT(fa.film_id)
from actor a
join film_actor fa on a.actor_id = fa.actor_id
group by a.actor_id;

-- 49. Calcula el número total de alquileres realizados por cada cliente.
select c.customer_id as cliente_id, CONCAT(c.first_name, ' ', c.last_name) as cliente, COUNT(c.customer_id) as cantidad_de_alquileres
from customer c 
left join rental r on r.customer_id = c.customer_id
group by c.customer_id, c.first_name, c.last_name
order by c.customer_id;

-- 50. Calcula la duración total de las películas en la categoría 'Action'.
select c."name" as categoria, SUM(length) as duracion_total_minutos
from film f
join film_category fc on fc.film_id = f.film_id
join category c on fc.category_id = c.category_id
where c."name" = 'Action'
group by c."name";

-- 51. Crea una tabla temporal llamada “cliente_rentas_temporal” para almacenar el total de alquileres por cliente.
with cliente_rentas_temporal as (
	select c.customer_id, c.first_name, c.last_name, COUNT(c.customer_id)
	from customer c 
	join rental r on c.customer_id = r.customer_id
	group by c.customer_id	
	order by c.customer_id asc
)

select *
from cliente_rentas_temporal;

-- 52. Crea una tabla temporal llamada “peliculas_alquiladas” que almacene las películas que han sido alquiladas al menos 10 veces.

with peliculas_alquiladas as (
	select f.title, COUNT(f.film_id)
	from film f
	join inventory i on f.film_id = i.film_id
	join rental r on i.inventory_id = r.inventory_id
	group by f.film_id
	having COUNT(f.film_id) >10
	order by COUNT asc
)

select * 
from peliculas_alquiladas;

--53. Encuentra el título de las películas que han sido alquiladas por el cliente con el nombre ‘Tammy Sanders’ y que aún no se han devuelto. 
-- Ordena los resultados alfabéticamente por título de película.
select title as pelicula
from film f
join inventory i on f.film_id = i.film_id
join rental r on i.inventory_id = r.inventory_id
join customer c on r.customer_id = c.customer_id
where c.first_name = 'TAMMY' and c.last_name = 'SANDERS' and r.return_date is null
order by title asc;

-- 54. Encuentra los nombres de los actores que han actuado en al menos una película que pertenece a la categoría ‘Sci-Fi’. 
-- Ordena los resultados alfabéticamente por apellido.
select distinct last_name as apellido, first_name as nombre
from actor a
join film_actor fa on a.actor_id = fa.actor_id
join film f on fa.film_id = f.film_id
join film_category fc on f.film_id = fc.film_id
join category c on fc.category_id = c.category_id
where c.name = 'Sci-Fi'
order by last_name asc;

-- 55. Encuentra el nombre y apellido de los actores que han actuado en películas que se alquilaron después de que la película ‘Spartacus Cheaper’ se alquilara por primera vez. 
-- Ordena los resultados alfabéticamente por apellido.

-- Seleccionamos los apellidos y nombres de los actores, sin repeticiones
select distinct a.last_name as apellido, a.first_name as nombre
from actor a
    -- Relacionamos actores con películas a través de la tabla film_actor
    join film_actor fa on a.actor_id = fa.actor_id
    -- Relacionamos películas con la tabla film
    join film f on fa.film_id = f.film_id
    -- Unimos con inventario para poder acceder a los rentals (alquileres)
    join inventory i on f.film_id = i.film_id
    -- Finalmente unimos con la tabla de alquileres
    join rental r on i.inventory_id = r.inventory_id
-- Filtramos solo los alquileres que se realizaron DESPUÉS del primer alquiler de 'SPARTACUS CHEAPER'
where r.rental_date > (
    -- Subconsulta que obtiene la fecha del primer alquiler de la película 'SPARTACUS CHEAPER'
    select MIN(r.rental_date)
    from rental r
    join inventory i on r.inventory_id = i.inventory_id
    join film f on i.film_id = f.film_id
    where f.title ilike '%SPARTACUS CHEAPER%'
)
-- Ordenamos alfabéticamente por apellido
order by a.last_name asc;

-- 56. Encuentra el nombre y apellido de los actores que no han actuado en ninguna película de la categoría ‘Music’.
select distinct last_name as apellido, first_name as nombre
from actor a
left join film_actor fa on a.actor_id = fa.actor_id
left join film f on fa.film_id = f.film_id
left join film_category fc on f.film_id = fc.film_id
left join category c on fc.category_id = c.category_id and c.name = 'Music'
where c.category_id is NULL;

-- 57. Encuentra el título de todas las películas que fueron alquiladas por más de 8 días.
select distinct f.title as pelicula
from rental r
join inventory i on r.inventory_id = i.inventory_id
join film f on i.film_id = f.film_id
where (date(r.return_date) - date(r.rental_date)) > 8;

-- 58. Encuentra el título de todas las películas que son de la misma categoría que ‘Animation’.
select title as pelicula
from film f
join film_category fc on f.film_id = fc.film_id
join category c on fc.category_id = c.category_id
where c.name = 'Animation';

--59. Encuentra los nombres de las películas que tienen la misma duración que la película con el título ‘Dancing Fever’.
-- Ordena los resultados alfabéticamente por título de película.

-- seleccionamos el título de las películas que tienen la misma duración que 'dancing fever'
select title as pelicula
from film f
where f.length in (
    -- subconsulta: obtenemos la duración (length) de la película 'dancing fever'
    select f.length
    from film f
    where f.title ilike '%DANCING FEVER%'
)
-- ordenamos los resultados alfabéticamente por título
order by title asc;

-- 60. Encuentra los nombres de los clientes que han alquilado al menos 7 películas distintas. 
-- Ordena los resultados alfabéticamente por apellido.
select c.last_name as apellido, c.first_name as nombre
from customer c
join rental r on c.customer_id = r.customer_id
join inventory i on r.inventory_id = i.inventory_id
group by c.customer_id, c.first_name, c.last_name
having COUNT(DISTINCT i.film_id) >= 7
order by c.last_name asc;

-- 61. Encuentra la cantidad total de películas alquiladas por categoría y muestra el nombre de la categoría junto con el recuento de alquileres.
select c.name as categoria, COUNT(r.rental_id) as cantidad_de_peliculas
from category c
join film_category fc on c.category_id = fc.category_id
join film f on f.film_id = fc.film_id
join inventory i on f.film_id = i.film_id
join rental r on i.inventory_id = r.inventory_id
group by c."name";

-- 62. Encuentra el número de películas por categoría estrenadas en 2006.
select c.name as categoria, COUNT(f.film_id) as cantidad_de_peliculas
from category c
join film_category fc on c.category_id = fc.category_id
join film f on f.film_id = fc.film_id
where f.release_year = '2006'
group by c."name";

-- 63. Obtén todas las combinaciones posibles de trabajadores con las tiendas que tenemos.
select s.first_name as nombre_trabajador, s.last_name as apellido_trabajador, st.store_id as tienda_id
from staff s
cross join store st;

-- 64. Encuentra la cantidad total de películas alquiladas por cada cliente y muestra el ID del cliente, su nombre y apellido junto con la cantidad de películas alquiladas.
select c.customer_id as cliente, CONCAT(c.first_name, ' ', c.last_name) as cliente, COUNT(r.rental_id) as cantidad_de_peliculas
from customer c
join rental r ON c.customer_id = r.customer_id
group by c.customer_id, c.first_name, c.last_name
order by COUNT(r.rental_id) desc;















