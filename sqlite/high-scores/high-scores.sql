-- Schema: 
--   CREATE TABLE "scores" ("game_id" TEXT, "score" INT);
--   CREATE TABLE "results" ("game_id" TEXT, "property" TEXT, "result" TEXT);

-- Task: Given the data in the "scores" table, update the "result" field in the "results" table.

UPDATE results
SET result = (
    SELECT GROUP_CONCAT(score, ',') 
    FROM scores AS s
    WHERE s.game_id = results.game_id
    ORDER BY ROWID
)
WHERE property = 'scores';
-- Paso 2: Actualizar el campo "latest" en `results`
UPDATE results
SET result = (
    SELECT CAST(score AS TEXT) 
    FROM scores AS s
    WHERE s.game_id = results.game_id
    ORDER BY ROWID DESC
    LIMIT 1
)
WHERE property = 'latest';
-- Paso 3: Actualizar el campo "personalBest" en `results`
UPDATE results
SET result = (
    SELECT CAST(MAX(score) AS TEXT) 
    FROM scores AS s
    WHERE s.game_id = results.game_id
)
WHERE property = 'personalBest';
-- Paso 4: Actualizar el campo "personalTopThree" en `results`
UPDATE results
SET result = (
    SELECT GROUP_CONCAT(score, ',') 
    FROM (
        SELECT score
        FROM scores AS s
        WHERE s.game_id = results.game_id
        ORDER BY score DESC
        LIMIT 3
    )
)
WHERE property = 'personalTopThree';