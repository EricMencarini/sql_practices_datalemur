--https://datalemur.com/questions/sql-bloomberg-stock-min-max-1

WITH extremes AS (
    SELECT 
        ticker, 
        MAX(open) AS highest_open,
        MIN(open) AS lowest_open
    FROM stock_prices
    GROUP BY ticker
),
highest_date AS (
    SELECT 
        s.ticker,
        TO_CHAR(s.date, 'Mon-YYYY') AS highest_mth
    FROM stock_prices s
    JOIN extremes e
      ON s.ticker = e.ticker AND s.open = e.highest_open
),
lowest_date AS (
    SELECT 
        s.ticker,
        TO_CHAR(s.date, 'Mon-YYYY') AS lowest_mth
    FROM stock_prices s
    JOIN extremes e
      ON s.ticker = e.ticker AND s.open = e.lowest_open
)
SELECT 
    e.ticker,
    h.highest_mth,
    e.highest_open,
    l.lowest_mth,
    e.lowest_open
FROM extremes e
LEFT JOIN highest_date h ON e.ticker = h.ticker
LEFT JOIN lowest_date l ON e.ticker = l.ticker
ORDER BY e.ticker;