-- Schema: CREATE TABLE "grains" ("task" TEXT, "square" INT, "result" INT);
-- Task: update the grains table and set the result based on the task (and square fields).
CREATE TABLE grains (
    task TEXT,
    square INT,
    result INT
);

UPDATE grains
SET result = CASE 
    WHEN task = 'single-square' THEN POW(2, square - 1)
    WHEN task = 'total' THEN POW(2, 64) - 1
END;
-- Get the number of grains on a specific square (e.g., square 1)
SELECT * FROM grains WHERE task = 'single-square' AND square = 1;

-- Get the total number of grains on the chessboard
SELECT * FROM grains WHERE task = 'total';