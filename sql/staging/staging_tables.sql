-- Create brand staging table for data import
CREATE TABLE IF NOT EXISTS public.staging_brand (
    brand_id INT,
    brand_name VARCHAR(255),
    country VARCHAR(255)
)

-- Create fragrance staging table for data import
CREATE TABLE IF NOT EXISTS public.staging_fragrance_core (
    fragrance_name VARCHAR(255),
    brand_name VARCHAR(255),
    country VARCHAR(100),
    gender VARCHAR(50),
    rating_value NUMERIC(3,2),
    rating_count INT,
    year INT,
    top_notes TEXT,
    middle_notes TEXT,
    base_notes TEXT,
    perfumer_1 VARCHAR(255),
    perfumer_2 VARCHAR(255),
    main_accords VARCHAR(255),
    url TEXT
)

-- Create fragrance core staging table for data import
CREATE TABLE IF NOT EXISTS public.staging_fragrance_list (
    fragrance_name VARCHAR(255),
    gender VARCHAR(50),
    rating_value NUMERIC(3,2),
    rating_count INT,
    main_notes TEXT,
    description TEXT,
    url TEXT
)

-- Load data into the tables using COPY command
COPY staging_brand
FROM 'C:\Users\thang\OneDrive\Documents\Fragrantica_Fragrance_Analysis\data\staging\brand_excelcleaned.csv'
WITH (FORMAT csv, HEADER true, DELIMITER ',', ENCODING 'UTF8');

COPY staging_fragrance_core
FROM 'C:\Users\thang\OneDrive\Documents\Fragrantica_Fragrance_Analysis\data\staging\fragrance_core.csv'
WITH (FORMAT csv, HEADER true, DELIMITER ',', ENCODING 'UTF8');

COPY staging_fragrance_list
FROM 'C:\Users\thang\OneDrive\Documents\Fragrantica_Fragrance_Analysis\data\staging\fragrance_list.csv'
WITH (FORMAT csv, HEADER true, DELIMITER ',', ENCODING 'UTF8');