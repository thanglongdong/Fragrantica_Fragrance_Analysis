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

-- Load data into the tables using COPY command
COPY staging_brand
FROM 'C:\Users\thang\OneDrive\Documents\Fragrantica_Fragrance_Analysis\data\staging\brand_excelcleaned.csv'
WITH (FORMAT csv, HEADER true, DELIMITER ',', ENCODING 'UTF8');

COPY staging_fragrance_core
FROM 'C:\Users\thang\OneDrive\Documents\Fragrantica_Fragrance_Analysis\data\staging\fragrance_core.csv'
WITH (FORMAT csv, HEADER true, DELIMITER ',', ENCODING 'UTF8');

-- Verify data load by retrieving 10 rows from each table
SELECT * FROM staging_brand LIMIT 10;
SELECT * FROM staging_fragrance_core LIMIT 10;

/* Instructions to load data into staging tables using pgAdmin or when "Permission denied" Error occurs

1. Open pgAdmin
2. In Object Explorer (left-hand pane), navigate to `sql_course` database
3. Right-click `sql_course` and select `PSQL Tool`
            - This opens a terminal window to write the following code
4. Get the absolute file path of your csv files
            - Find path by right-clicking a CSV file in VS Code and selecting “Copy Path”
5. Paste the following into `PSQL Tool`,

\COPY staging_brand FROM 'C:/Users/thang/OneDrive/Documents/Fragrantica_Fragrance_Analysis/data/staging\brand_excelcleaned.csv' WITH (FORMAT csv, HEADER true, DELIMITER ',', ENCODING 'UTF8');

\COPY staging_fragrance_core FROM 'C:/Users/thang/OneDrive/Documents/Fragrantica_Fragrance_Analysis/data/staging/fragrance_core.csv' WITH (FORMAT csv, HEADER true, DELIMITER ',', ENCODING 'UTF8');

*/