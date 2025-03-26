-- Schema: CREATE TABLE "rna-transcription" ("dna" TEXT, "result" TEXT);
-- Task: update the rna-transcription table and set the result based on the dna field.

UPDATE "rna-transcription" SET "result" = "dna";
UPDATE "rna-transcription" SET "result" = replace("result", 'A', 'U');
UPDATE "rna-transcription" SET "result" = replace("result", 'T', 'A');
UPDATE "rna-transcription" SET "result" = replace("result", 'C', 'H');
UPDATE "rna-transcription" SET "result" = replace("result", 'G', 'C');
UPDATE "rna-transcription" SET "result" = replace("result", 'H', 'G');
