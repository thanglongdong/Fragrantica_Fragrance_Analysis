-- Create fragrance core staging table for data import
CREATE TABLE IF NOT EXISTS public.staging_fragrance_core {
    fragrance_name VARCHAR(255),
    gender VARCHAR(50),
    rating_value NUMERIC(3,2),
    rating_count INT,
    main_notes TEXT,
    description TEXT,
    url TEXT
}