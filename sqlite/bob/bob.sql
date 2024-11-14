-- Schema: CREATE TABLE "bob" ("input" TEXT, "reply" TEXT);
-- Task: update the bob table and set the reply based on the input.

UPDATE bob
SET reply = "Sure."
WHERE SUBSTR(REPLACE(input, " ", ""), -1, 1) = "?";
UPDATE bob
SET reply = "Whoa, chill out!"
WHERE LOWER(input) != UPPER(input) AND input = UPPER(input);
UPDATE bob
SET reply = "Calm down, I know what I'm doing!"
WHERE LOWER(input) != UPPER(input) AND input = UPPER(input)
    AND SUBSTR(REPLACE(input, " ", ""), -1, 1) = "?";
UPDATE bob
SET reply = "Fine. Be that way!"
WHERE LENGTH(TRIM(
    REPLACE(
        REPLACE(
            REPLACE(
                REPLACE(
                    REPLACE(input, char(13), '')
                , char(12), '')
            , char(11), '')
        , char(10), '')
    , char(09), ''))) = 0;
UPDATE bob
SET reply = "Whatever."
WHERE reply = "";