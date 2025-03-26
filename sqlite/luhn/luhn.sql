-- Schema: CREATE TABLE "luhn" ("value" TEXT "result" Boolean);
-- Task: update the luhn table and set the result based on the value field.

UPDATE luhn
   SET result =
       CASE
       WHEN GLOB('*[^0-9]*', REPLACE(value, ' ', '')) THEN FALSE
       WHEN LENGTH(REPLACE(value, ' ', '')) < 2       THEN FALSE
       ELSE ''
       END
;
UPDATE luhn
   SET result = (
     WITH RECURSIVE
       rcte(digits, digit, i) AS (
         VALUES(
           REPLACE(
             PRINTF('%16s', REPLACE(value, ' ', '')), ' ', '0'
      ),
      '',
      1
    )
    UNION ALL
    SELECT digits,
           CASE
           WHEN i % 2 == 1 THEN
             CASE
             WHEN SUBSTRING(digits, i, 1) * 2 > 9
             THEN SUBSTRING(digits, i, 1) * 2 - 9
             ELSE SUBSTRING(digits, i, 1) * 2
             END
           ELSE SUBSTRING(digits, i, 1)
           END,
           i + 1
    FROM rcte
    WHERE i <= LENGTH(digits)
       )
     SELECT SUM(digit) % 10 == 0 FROM rcte
   )
 WHERE result = ''
;