--https://datalemur.com/questions/pizzas-topping-cost

/*
You’re a consultant for a major pizza chain that will be running a promotion where all 3-topping pizzas will be sold for a fixed price, 
and are trying to understand the costs involved.

Given a list of pizza toppings, consider all the possible 3-topping pizzas, and print out the total cost of those 3 toppings. 
Sort the results with the highest total cost on the top followed by pizza toppings in ascending order.

Break ties by listing the ingredients in alphabetical order, starting from the first ingredient, followed by the second and third.

P.S. Be careful with the spacing (or lack of) between each ingredient. Refer to our Example Output.

Notes:

Do not display pizzas where a topping is repeated. For example, ‘Pepperoni,Pepperoni,Onion Pizza’.
Ingredients must be listed in alphabetical order. For example, 'Chicken,Onions,Sausage'. 'Onion,Sausage,Chicken' is not acceptable.

Explanation
There are four different combinations of the three toppings. Cost of the pizza with toppings Chicken, Pepperoni and Sausage is $0.55 + $0.50 + $0.70 = $1.75.

Additionally, they are arranged alphabetically; in the dictionary, the chicken comes before pepperoni and pepperoni comes before sausage.

The dataset you are querying against may have different input & output - this is just an example!


*/

SELECT
  CONCAT(pt.topping_name,',',
          ptt.topping_name,',',
            pttt.topping_name) AS pizza,
            
        pt.ingredient_cost + 
          ptt.ingredient_cost + 
            pttt.ingredient_cost AS total_cost
FROM
  pizza_toppings pt 
    CROSS JOIN pizza_toppings ptt, 
               pizza_toppings pttt
WHERE 1=1
  AND pt.topping_name < ptt.topping_name
  AND ptt.topping_name < pttt.topping_name
ORDER BY
  total_cost DESC, 
  pizza ASC;