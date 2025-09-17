--https://datalemur.com/questions/pizzas-topping-cost

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
  pizza ASC