use sakila;

#1. List each pair of actors that have worked together.

SELECT fa1.actor_id AS actor1_id, a1.first_name AS actor1_first_name, a1.last_name AS actor1_last_name,
       fa2.actor_id AS actor2_id, a2.first_name AS actor2_first_name, a2.last_name AS actor2_last_name,
       f.title AS movie_title

# fa represents the table 'film_actor'
       
FROM film_actor fa1
JOIN film_actor fa2 ON fa1.film_id = fa2.film_id AND fa1.actor_id <> fa2.actor_id
JOIN actor a1 ON fa1.actor_id = a1.actor_id
JOIN actor a2 ON fa2.actor_id = a2.actor_id
JOIN film f ON fa1.film_id = f.film_id;

#2. For each film, list actor that has acted in more films.

SELECT 
  f.film_id, 
  f.title, 
  a.actor_id, 
  a.first_name, 
  a.last_name 
FROM 
  film_actor fa 
  JOIN actor a ON fa.actor_id = a.actor_id 
  JOIN film f ON fa.film_id = f.film_id 
WHERE 
  (
    SELECT 
      COUNT(*) 
    FROM 
      film_actor fa2 
    WHERE 
      fa2.actor_id = fa.actor_id
  ) = (
    SELECT 
      MAX(actor_film_count) 
    FROM 
      (
        SELECT 
          actor_id, 
          COUNT(DISTINCT film_id) AS actor_film_count 
        FROM 
          film_actor 
        GROUP BY 
          actor_id
      ) AS actor_film_counts 
    WHERE 
      actor_film_counts.actor_id = fa.actor_id
  );

# we used a sql code 'beautifier' to display it in a more readable format



