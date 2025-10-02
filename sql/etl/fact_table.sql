-- FACT TABLE ETL

-- Load data into fragrance_list table from staging_fragrance_core table
-- Preview data load and structure by selecting relevant columns from staging_fragrance_core
SELECT fragrance_name, gender, rating_count, rating_value, year, url 
FROM staging_fragrance_core 
ORDER BY fragrance_name
LIMIT 10;

-- Insert into fragrance_list table, ensuring data types match the target schema
INSERT INTO fragrance_list (fragrance_name, brand_id, gender, rating_value, rating_count, year, url)
SELECT 
    s.fragrance_name,
    brand_id,
    s.gender,
    s.rating_value::NUMERIC(3,2), -- Cast to match target schema data types
    s.rating_count::INT,
    s.year::INT,
    s.url
FROM staging_fragrance_core s JOIN brand b ON TRIM(s.brand_name) = b.brand_name; -- Join with brand table to get matching brand_id

-- Verify data load by retrieving rows from fragrance_list table
SELECT * FROM fragrance_list LIMIT 10;