-- Split main_accords into individual accord columns (accord_n) to be inserted into accord and fragrance_accord tables
ALTER TABLE staging_fragrance_core
    ADD COLUMN accord_1 VARCHAR(255),
    ADD COLUMN accord_2 VARCHAR(255),
    ADD COLUMN accord_3 VARCHAR(255),
    ADD COLUMN accord_4 VARCHAR(255),
    ADD COLUMN accord_5 VARCHAR(255);

-- extract accords from main_accords column by position using SPLIT_PART function
UPDATE staging_fragrance_core
SET accord_1 = SPLIT_PART(main_accords, ',', 1),
    accord_2 = SPLIT_PART(main_accords, ',', 2),
    accord_3 = SPLIT_PART(main_accords, ',', 3),
    accord_4 = SPLIT_PART(main_accords, ',', 4),
    accord_5 = SPLIT_PART(main_accords, ',', 5);

-- Verify the update by retrieving 10 rows from staging_fragrance_core
SELECT fragrance_name, main_accords, accord_1, accord_2, accord_3, accord_4, accord_5
FROM staging_fragrance_core LIMIT 10;

SELECT * FROM staging_fragrance_core LIMIT 10;

