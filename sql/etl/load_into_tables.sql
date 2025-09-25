-- Load data into brand table from staging_brand table
-- Make sure brand names are consistent (trimmed, lowercased if needed)
SELECT DISTINCT brand_name FROM staging_fragrance_core
WHERE brand_name NOT IN (SELECT brand_name FROM staging_brand);

-- Insert data into brand table from staging_brand, avoiding duplicates
INSERT INTO brand (brand_id, brand_name, country)
SELECT DISTINCT sb.brand_id, sb.brand_name, sb.country
FROM staging_brand sb;

-- Verify data load by retrieving all rows from brand table, ordered by brand_id
SELECT * FROM brand
ORDER BY brand_id;

-- Load data into accord table from staging_fragrance_core table
-- Preview data load by selecting distinct accord names from staging_fragrance_core
SELECT DISTINCT TRIM(a) AS accord_name
FROM staging_fragrance_core s
CROSS JOIN LATERAL unnest(      -- Use CROSS JOIN LATERAL to handle each row 
    ARRAY[s.accord_1, s.accord_2, s.accord_3, s.accord_4, s.accord_5]) AS a(a)      -- Unnest the array of accord columns into individual rows
WHERE a IS NOT NULL AND a <> '';

-- Insert into accord table, ensure that there's no duplicates and TRIM to clean up whitespace
INSERT INTO accord (accord_name)
SELECT DISTINCT TRIM(a)
FROM staging_fragrance_core s
CROSS JOIN LATERAL unnest(
    ARRAY[s.accord_1, s.accord_2, s.accord_3, s.accord_4, s.accord_5]) AS a
WHERE a IS NOT NULL AND a <> '';

-- Verify data load by retrieving all rows from accord table, ordered by accord_id
SELECT * FROM accord
ORDER BY accord_id;