-- Schema: CREATE TABLE "eliuds-eggs" ("number" INT, "result" INT);
-- Task: update the eliuds-eggs table and set the result based on the number field.

UPDATE "eliuds-eggs"
SET result = (
    WITH RECURSIVE bit_counter (original_number, current_number, bit) AS (
        -- Initialize the recursive CTE with the original number, starting bit count at 0
        SELECT number AS original_number, number AS current_number, 0 AS bit
        FROM "eliuds-eggs"
        
        UNION ALL
        
        -- Shift right by 1 (n >> 1) to examine each bit, and use bitwise AND (n & 1) to get the current bit
        SELECT original_number, current_number >> 1, current_number & 1
        FROM bit_counter
        WHERE current_number > 0
    )
    -- Sum up the bits where 'bit' is 1 to count the number of 1s in the binary representation
    SELECT SUM(bit) 
    FROM bit_counter 
    WHERE bit_counter.original_number = "eliuds-eggs".number
);