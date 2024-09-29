-- Schema: CREATE TABLE "allergies" ("task" TEXT, "item" TEXT, "score" INT NOT NULL, "result" TEXT);
-- Task: update the bob allergies and set the result based on the task.
--       - The `allergicTo` task expects `true` or `false` based on the `score` and the `item` fields.
--       - For the `list` task you have to write corresponding items to the result field

-- Allergens and their corresponding scores
WITH allergens AS (
    SELECT 'eggs' AS item, 1 AS score UNION
    SELECT 'peanuts', 2 UNION
    SELECT 'shellfish', 4 UNION
    SELECT 'strawberries', 8 UNION
    SELECT 'tomatoes', 16 UNION
    SELECT 'chocolate', 32 UNION
    SELECT 'pollen', 64 UNION
    SELECT 'cats', 128
)

-- Update based on the task
UPDATE allergies
SET result = CASE 
    -- Check if allergic to a specific item (allergicTo task)
    WHEN task = 'allergicTo' THEN 
        CASE 
            -- Perform bitwise AND to check if the item is in the score
            WHEN (score & (SELECT score FROM allergens WHERE item = allergies.item)) > 0 THEN 'true'
            ELSE 'false'
        END

    -- List all allergens (list task)
    WHEN task = 'list' THEN (
        SELECT GROUP_CONCAT(item, ', ') 
        FROM allergens 
        WHERE (score & allergens.score) > 0
    )
END
WHERE task IN ('allergicTo', 'list');

    -- List all allergens (list task)
    WHEN task = 'list' THEN (
        SELECT STRING_AGG(item, ', ') 
        FROM allergens 
        WHERE (score & allergens.score) > 0
    )
END
WHERE task IN ('allergicTo', 'list');
