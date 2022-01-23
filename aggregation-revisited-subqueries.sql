
-- 1. Select the first name, last name, and email address of all the customers who have rented a movie.
SELECT first_name, last_name, email  FROM sakila.customer
WHERE customer_id IN (SELECT customer_id FROM sakila.rental);

-- 2 What is the average payment made by each customer (display the customer id, customer name (concatenated), and the average payment made).
SELECT customer_id, concat(first_name,' ', last_name) AS name, ROUND(AVG(amount),2) AS payment FROM sakila.customer
JOIN sakila.payment USING (customer_id)
GROUP BY customer_id, concat(first_name,' ', last_name)
ORDER BY payment DESC;


-- 3. Select the name and email address of all the customers who have rented the "Action" movies.
	-- Write the query using multiple join statements
	-- Write the query using sub queries with multiple WHERE clause and IN condition
	-- Verify if the above two queries produce the same results or not


SELECT concat(first_name,' ', last_name) AS name, email FROM sakila.customer
WHERE customer_id IN (SELECT customer_id FROM sakila.rental
JOIN sakila.inventory USING (inventory_id)
JOIN sakila.film_category ON inventory.film_id = film_category.film_id
JOIN sakila.category ON film_category.category_id = category.category_id
WHERE name = "Action");

-- 4. Use the case statement to create a new column classifying existing columns as either or high value transactions based on the amount of payment. 
-- If the amount is between 0 and 2
	-- > label should be low and 
-- if the amount is between 2 and 4
	 -- > the label should be medium
-- and if it is more than 4
	-- > then it should be high

SELECT customer_id, concat(first_name,' ', last_name) AS name, amount,
CASE
	WHEN amount >= 0 and amount <=2 THEN "low"
    WHEN amount > 2 and amount <=4 THEN "medium"
    WHEN amount >4 THEN "high"
END
AS transanction_value
FROM sakila.customer
JOIN sakila.payment USING (customer_id);

SELECT *,
CASE
	WHEN amount >= 0 and amount <=2 THEN "low"
    WHEN amount > 2 and amount <=4 THEN "medium"
    WHEN amount >4 THEN "high"
END
AS transanction_value
FROM sakila.customer
JOIN sakila.payment USING (customer_id);

