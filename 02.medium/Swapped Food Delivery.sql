--https://datalemur.com/questions/sql-swapped-food-delivery

/*
Zomato is a leading online food delivery service that connects users with various restaurants and cuisines, allowing them to browse menus, 
place orders, and get meals delivered to their doorsteps.

Recently, Zomato encountered an issue with their delivery system. Due to an error in the delivery driver instructions, each item's order was 
swapped with the item in the subsequent row. As a data analyst, you're asked to correct this swapping error and return the proper pairing of order ID 
and item.

If the last item has an odd order ID, it should remain as the last item in the corrected data. For example, if the last item is Order ID 7 Tandoori Chicken,
then it should remain as Order ID 7 in the corrected data.

In the results, return the correct pairs of order IDs and items.
The corrected data should look like this:

corrected_order_id	item
1	Pizza
2	Chow Mein
3	Butter Chicken
4	Pad Thai
5	Burger
6	Eggrolls
7	Tandoori Chicken
Order ID 1 is now associated with Pizza and Order ID 2 is paired with Chow Mein. 
This adjustment ensures that each order is correctly aligned with its respective item, addressing the initial swapping error.

Order ID 7 remains unchanged and is still associated with Tandoori Chicken. This preserves the order sequence ensuring that the last 
odd order ID remains unaltered.

The dataset you are querying against may have different input & output - this is just an example!


*/

WITH c_order AS (
    SELECT order_id, 
           item,
           LAG(item) OVER(ORDER BY order_id ASC) AS lagx,
           LEAD(item) OVER(ORDER BY order_id ASC) AS leady
    FROM orders
)
SELECT
      ROW_NUMBER() OVER(ORDER BY (SELECT NULL)) AS corrected_order_id,
      CASE 
          WHEN order_id % 2 = 0 THEN lagx
          WHEN order_id % 2 = 1 THEN COALESCE(leady,item)
      END AS item
FROM c_order;
