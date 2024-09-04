-- Schema: CREATE TABLE "leap" ( "year" INT, "is_leap" BOOL);
-- Task: update the leap table and set the is_leap based on the year field.
CREATE TABLE leap(
    year INT,
    is_leap BOOL
)

UPDATE leap
SET is_leap = CASE
    WHEN year % 4 = 0 AND (year % 100 != 0 OR year % 400 = 0) THEN TRUE
    ELSE FALSE
END;