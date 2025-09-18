-- Create fragrance staging table for data import
CREATE TABLE IF NOT EXISTS public.staging_fragrance {
    fragrance_name VARCHAR(255),
    brand_name VARCHAR(255),
    country VARCHAR(100),
    gender VARCHAR(50),
    rating_value NUMERIC(3,2),
    rating_count INT,
    year INT,
    top_notes TEXT,,
    middle_notes TEXT,
    base_notes TEXT,
    perfumer_1 VARCHAR(255),
    perfumer_2 VARCHAR(255),
    mainaccord_1 VARCHAR(255),
    mainaccord_2 VARCHAR(255),
    mainaccord_3 VARCHAR(255),
    mainaccord_4 VARCHAR(255),
    mainaccord_5 VARCHAR(255),
    url TEXT
}