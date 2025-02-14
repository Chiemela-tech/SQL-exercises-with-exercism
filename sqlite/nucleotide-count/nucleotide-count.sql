-- Task:  - Update the "nucleotide-count" table and set the result based on the input field.
--        - Update table creation with constraints.

DROP TABLE IF EXISTS "nucleotide-count";
CREATE TABLE "nucleotide-count" (
    "strand" TEXT,
    "result" TEXT,
    CHECK (strand REGEXP '^[ACGT]*$')
);

-- Please don't change the following two import lines. Feel free to edit the previous lines, though.
.mode csv
.import ./data.csv "nucleotide-count"

-- Write your code below. Feel free to edit the CREATE TABLE above, too!
WITH nucleotides(base) AS (
    VALUES ('A'), ('C'), ('G'), ('T')
)
UPDATE "nucleotide-count"
SET result = (
    SELECT json_object(
        'A', sum(CASE WHEN base = 'A' THEN c ELSE 0 END),
        'C', sum(CASE WHEN base = 'C' THEN c ELSE 0 END),
        'G', sum(CASE WHEN base = 'G' THEN c ELSE 0 END),
        'T', sum(CASE WHEN base = 'T' THEN c ELSE 0 END)
    )
    FROM (
        SELECT base, LENGTH("nucleotide-count".strand) - LENGTH(REPLACE("nucleotide-count".strand, base, '')) AS c
        FROM nucleotides
    )
);
