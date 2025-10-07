--https://datalemur.com/questions/tesla-unfinished-parts

/*
Tesla is investigating production bottlenecks and they need your help to extract the relevant data. 
Write a query to determine which parts have begun the assembly process but are not yet finished.

Assumptions:

parts_assembly table contains all parts currently in production, each at varying stages of the assembly process.
An unfinished part is one that lacks a finish_date.
This question is straightforward, so let's approach it with simplicity in both thinking and solution.

Effective April 11th 2023, the problem statement and assumptions were updated to enhance clarity.

Explanation
The bumpers in step 3 and 4 are the only item that remains unfinished as it lacks a recorded finish date.

The dataset you are querying against may have different input & output - this is just an example!

*/
SELECT part, assembly_step 
FROM parts_assembly
WHERE finish_date IS NULL