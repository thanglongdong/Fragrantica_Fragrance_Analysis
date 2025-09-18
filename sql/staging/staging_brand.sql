-- Create brand staging table for data import
CREATE TABLE IF NOT EXISTS public.staging_brand {
    brand_id INT,
    brand_name VARCHAR(255),
    country VARCHAR(255)
}