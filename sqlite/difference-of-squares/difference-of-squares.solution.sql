-- Schema: CREATE TABLE "difference-of-squares" ("number" INT", property" TEXT, "result" INT);
-- Task: update the difference-of-squares table and set the result based on the number and property fields.
CREATE TABLE difference_of_squares (
    number INT,
    property TEXT,
    result INT
);

-- Step 1: Calculate square of sum
UPDATE "difference-of-squares"
SET Result = (number * (number + 1) / 2) * (number * (number + 1) / 2)
WHERE property = "squareOfSum";

-- Step 2: Calculate sum of squares
UPDATE "difference-of-squares"
SET Result = (number * (number + 1) * (2 * number + 1)) / 6
WHERE property = "sumOfSquares";

-- Step 3: Calculate the difference between square of sum and sum of squares
UPDATE "difference-of-squares"
SET Result =  (number * (number + 1) / 2) * (number * (number + 1) / 2) - (number * (number + 1) * (2 * number + 1)) / 6
WHERE property = "differenceOfSquares";