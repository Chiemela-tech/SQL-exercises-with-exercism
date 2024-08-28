-- Schema: CREATE TABLE "gigasecond" ("moment" TEXT, "result" TEXT);
-- Task: update the gigasecond table and set the result based on the moment.
CREATE TABLE "gigasecond" (
    "moment" TEXT,
    "result" TEXT
);

-- Insert a sample date
INSERT INTO gigasecond (moment) VALUES ('2011-04-25');

-- Update the table to calculate the gigasecond anniversary
UPDATE gigasecond
SET result = replace(datetime(moment, '+1000000000 seconds'), ' ', 'T');

-- Query to see the result
SELECT * FROM gigasecond;