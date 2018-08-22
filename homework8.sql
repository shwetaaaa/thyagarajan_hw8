USE sakila;

#1a
SELECT
		first_name
        ,last_name
FROM
		actor
;

#1b
SELECT 
		UPPER(CONCAT(first_name,' ',last_name)) AS 'Actor Name'
FROM
		actor
;

#2a
SELECT
		actor_id
		,first_name
        ,last_name
FROM
		actor
WHERE
		first_name LIKE '%JOE%'
;

#2b
SELECT
		actor_id
		,first_name
        ,last_name
FROM
		actor
WHERE
		last_name LIKE '%GEN%'
;

#2c
SELECT
		actor_id
		,first_name
        ,last_name
FROM
		actor
WHERE
		last_name LIKE '%LI%'
ORDER BY 3,2
;

#2d
SELECT
		country_id
        ,country
FROM
		country
WHERE
		country IN ('Afghanistan', 'Bangladesh', 'China')
;

#3a
ALTER TABLE actor
	ADD descrpition BLOB
;

#3b
ALTER TABLE actor
	DROP descrpition
;

#4a
SELECT
		last_name
        ,COUNT(last_name) as 'Count of Last Name'
FROM
		actor
GROUP BY last_name
;

#4b
SELECT
		last_name
        ,COUNT(last_name) as 'Count of Last Name'
FROM
		actor
GROUP BY last_name
HAVING COUNT(last_name) > 1
;

#4c
UPDATE actor
	SET first_name = 'HARPO'
    WHERE first_name = 'GROUCHO'
    AND last_name = 'WILLIAMS'
;

#4d
UPDATE actor
	SET first_name = 'GROUCHO'
    WHERE first_name = 'HARPO'
    AND last_name = 'WILLIAMS'
;

#5a
SHOW CREATE TABLE address;

#6a
SELECT
		s.first_name
        ,s.last_name
        ,a.address
FROM staff s
LEFT JOIN address a
ON s.address_id = a.address_id
;

#6b
SELECT
		s.staff_id
        ,SUM(p.amount) as 'Total Amount'
FROM staff s
LEFT JOIN payment p
ON s.staff_id = p.staff_id
WHERE p.payment_date LIKE '2005-08%'
GROUP BY 1
;

#6c
SELECT
		f.title
        ,COUNT(a.actor_id) as 'Number of Actors'
FROM film f
INNER JOIN film_actor a
ON f.film_id = a.film_id
GROUP BY 1
;

#6d
SELECT
		i.film_id
		,COUNT(i.inventory_id) as 'Number of Copies'
FROM inventory i
INNER JOIN film f
ON f.film_id = i.film_id
WHERE f.title = 'Hunchback Impossible'
GROUP BY 1
;

#6e
SELECT
		c.last_name
        ,c.first_name
        ,SUM(p.amount) as 'Total Amount Paid'
FROM customer c
INNER JOIN payment p
ON c.customer_id = p.customer_id
GROUP BY c.customer_id
ORDER BY 1
;

#7a
SELECT title
FROM film
WHERE language_id IN
( SELECT language_id
  FROM language 
  WHERE name = 'English'
  )
AND title LIKE 'K%' 
AND title LIKE 'Q%'
;

#7b
SELECT first_name, last_name
FROM actor a
WHERE actor_id IN
(
  SELECT actor_id
  FROM film_actor fa
  WHERE film_id IN
  (
    SELECT film_id
    FROM film 
    WHERE title = 'Alone Trip'
  ) 
);

#7c
SELECT 
		first_name
        ,last_name
        ,email
FROM 
		customer c
		,address a
        ,city ci
        ,country co
WHERE	c.address_id = a.address_id
AND		a.city_id = ci.city_id
AND		ci.country_id = co.country_id
AND		co.country = 'Canada'
;

#7d
SELECT DISTINCT
		f.title
FROM
		film f
        ,film_category fc
        ,category c
WHERE c.name = 'FAMILY'
;

#7e
SELECT
		f.title
        ,COUNT(r.rental_id) AS 'Total Rentals'
FROM
		film f
        ,inventory i
        ,rental r
WHERE	f.film_id =i.film_id
AND		r.inventory_id =i.inventory_id
GROUP BY 1
ORDER BY 2 DESC
;

#7f
SELECT
		s.store_id
        ,SUM(p.amount) AS 'Total Revenue'
FROM
		store s
		,film f
        ,inventory i
        ,rental r
        ,payment p
WHERE	f.film_id =i.film_id
AND		r.inventory_id =i.inventory_id
AND		p.rental_id = r.rental_id
AND		i.store_id = s.store_id
GROUP BY 1
ORDER BY 2 DESC
;

#7g
SELECT
		s.store_id
        ,c.city
        ,co.country
FROM
		store s
        ,address a
        ,city c
        ,country co
WHERE	s.address_id = a.address_id
AND		a.city_id = c.city_id
AND		c.country_id = co.country_id
;

#7h
SELECT
		c.name
        ,SUM(p.amount) as 'Total Revenue'
FROM
		category c
        ,film_category fc
        ,inventory i
        ,payment p
        ,rental r
WHERE	c.category_id = fc.category_id
AND		fc.film_id = i.film_id
AND		i.inventory_id = r.inventory_id
AND		p.rental_id = r.rental_id
GROUP BY c.name
ORDER BY 2 DESC
LIMIT 5
;

#8a
CREATE VIEW top_five_genres AS
(SELECT
		c.name
        ,SUM(p.amount) as 'Total Revenue'
FROM
		category c
        ,film_category fc
        ,inventory i
        ,payment p
        ,rental r
WHERE	c.category_id = fc.category_id
AND		fc.film_id = i.film_id
AND		i.inventory_id = r.inventory_id
AND		p.rental_id = r.rental_id
GROUP BY c.name
ORDER BY 2 DESC
LIMIT 5)
;

#8b
SELECT *
FROM
		top_five_genres
;

#8c
DROP VIEW top_five_genres
;