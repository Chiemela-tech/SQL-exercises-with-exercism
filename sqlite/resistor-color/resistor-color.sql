-- CREATE TABLE "color_code" ("color" TEXT, "result" INT);
-- Task: update the color_code table and set the result based on the color.
UPDATE color_code
SET result = CASE
    WHEN color = 'black' THEN 0
    WHEN color = 'brown' THEN 1
    WHEN color = 'red' THEN 2
    WHEN color = 'orange' THEN 3
    WHEN color = 'yellow' THEN 4
    WHEN color = 'green' THEN 5
    WHEN color = 'blue' THEN 6
    WHEN color = 'violet' THEN 7
    WHEN color = 'grey' THEN 8
    WHEN color = 'white' THEN 9
    ELSE result -- In case there is an unknown color, keep the original result
END;