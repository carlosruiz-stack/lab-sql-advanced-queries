use sakila;

SELECT *
FROM film_actor
WHERE film_id = (
  SELECT MAX(film_id)
  FROM film
); 