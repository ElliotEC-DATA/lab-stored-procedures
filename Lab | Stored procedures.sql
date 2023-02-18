use sakila;

drop procedure if exists customer_list_that_rent_this_category;

-- out is used to stored values to use them later

-- Update the stored procedure in a such manner that it can take a string argument for the category name and return the results for all customers that rented movie of that category/genre.

DELIMITER //
CREATE PROCEDURE customer_list_that_rent_this_category (IN x VARCHAR(30))
begin
select c.first_name, c.last_name, c.email
from customer c
join rental r on c.customer_id = r.customer_id
join inventory i on r.inventory_id = i.inventory_id
join film f on f.film_id = i.film_id
join film_category fc on fc.film_id = f.film_id
join category cat on cat.category_id = fc.category_id
where cat.name = x;
end //
DELIMITER ;

call customer_list_that_rent_this_category("Action");


-- Write a query to check the number of movies released in each movie category. Convert the query in to a stored procedure to filter only those categories that have movies released greater than a certain number. Pass that number as an argument in the stored procedure.

-- First query

select c.name, count(f.film_id) number_of_movies_released from category c
join film_category fc on c.category_id = fc.category_id
join film f on fc.film_id = f.film_id
group by c.name;

-- procedure

drop procedure if exists number_of_movies_released_per_category;

DELIMITER //
CREATE PROCEDURE number_of_movies_released_per_category (IN x INT)
begin
select * from (
select c.name, count(f.film_id) number_of_movies_released from category c
join film_category fc on c.category_id = fc.category_id
join film f on fc.film_id = f.film_id
group by c.name
)sub1
where number_of_movies_released > x;
end //
DELIMITER 

call number_of_movies_released_per_category(70);