--https://datalemur.com/questions/sql-bloomberg-stock-min-max-1

/*
The Bloomberg terminal is the go-to resource for financial professionals, offering convenient access to a wide array of financial datasets. 
As a Data Analyst at Bloomberg, you have access to historical data on stock performance.

Currently, you're analyzing the highest and lowest open prices for each FAANG stock by month over the years.

For each FAANG stock, display the ticker symbol, the month and year ('Mon-YYYY') with the corresponding highest and lowest open prices 
(refer to the Example Output format). Ensure that the results are sorted by ticker symbol.

Example Output:
ticker	highest_mth	highest_open	lowest_mth	lowest_open
AAPL	May-2023	176.76	Jan-2023	142.28
Apple Inc. (AAPL) achieved its highest opening price of $176.76 in May 2023 and its lowest opening price of $142.28 in January 2023.

The dataset you are querying against may have different input & output - this is just an example!

*/

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