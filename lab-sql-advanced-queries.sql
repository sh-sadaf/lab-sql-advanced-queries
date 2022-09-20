 #1. List each pair of actors that have worked together.
 use sakila;

select concat(a1.first_name, " ",a1.last_name ) as a1_actor_name, concat(a2.first_name, " ", a2.last_name) as a2_actor_name
from film_actor as fa1 join film_actor as fa2 on fa1.film_id = fa2.film_id
join actor as a1 on a1.actor_id = fa1.actor_id
join actor as a2 on a2.actor_id = fa2.actor_id
and fa1.actor_id > fa2.actor_id
group by a1_actor_name, a2_actor_name;

#2. For each film, list actor that has acted in more films.

# first calculate the number of movies per each actor and ranking actors based on the no_of_movies they appeared.
create or replace view no_of_films_starred_by_each_actor as
select concat(first_name, " ", last_name) as actor_name, count(film_id) as no_of_films, actor_id, film_id, row_number() over(partition by film_id order by count(film_id) desc) as ranking
from actor join film_actor using(actor_id) group by actor_id;

select * from no_of_films_starred_by_each_actor;

# For each film, list actor that has acted in most films.
select actor_name, film_id from no_of_films_starred_by_each_actor 
where ranking = 1;












