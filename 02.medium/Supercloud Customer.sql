--https://datalemur.com/questions/supercloud-customer

/*
A Microsoft Azure Supercloud customer is defined as a customer who has purchased at least one product from every product category 
listed in the products table.

Write a query that identifies the customer IDs of these Supercloud customers.

Example Output:
customer_id
1
Explanation:
Customer 1 bought from Analytics, Containers, and Compute categories of Azure, and thus is a Supercloud customer. Customer 2 isn't a Supercloud customer, since they don't buy any container services from Azure.

The dataset you are querying against may have different input & output - this is just an example!

*/

WITH supercloud_cust AS (
  SELECT 
    customers.customer_id, 
    COUNT(DISTINCT products.product_category) AS product_count
  FROM 
    customer_contracts AS customers
    INNER JOIN products ON customers.product_id = products.product_id
  GROUP BY 
    customers.customer_id
)

SELECT 
  customer_id
FROM 
  supercloud_cust
WHERE 
  product_count = (
    SELECT 
      COUNT(DISTINCT product_category) FROM products);