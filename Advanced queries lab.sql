use sakila;

SELECT a1.first_name AS actor1_first_name,
       a1.last_name AS actor1_last_name,
       a2.first_name AS actor2_first_name,
       a2.last_name AS actor2_last_name
FROM film_actor af1
JOIN actor a1 ON af1.actor_id = a1.actor_id
JOIN film_actor af2 ON af1.film_id = af2.film_id AND af1.actor_id <> af2.actor_id
JOIN actor a2 ON af2.actor_id = a2.actor_id
ORDER BY a1.last_name, a1.first_name, a2.last_name, a2.first_name;

SELECT f.film_id,
       f.title AS film_title,
       a.actor_id,
       CONCAT(a.first_name, ' ', a.last_name) AS actor_name,
       COUNT(*) AS film_count
FROM film f
JOIN film_actor af ON f.film_id = af.film_id
JOIN actor a ON af.actor_id = a.actor_id
GROUP BY f.film_id, a.actor_id
HAVING COUNT(*) = (
    SELECT COUNT(*)
    FROM film_actor af_inner
    WHERE af_inner.film_id = f.film_id
    GROUP BY af_inner.actor_id
    ORDER BY COUNT(*) DESC
    LIMIT 1
)
ORDER BY f.film_id, film_count DESC;
