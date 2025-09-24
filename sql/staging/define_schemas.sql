-- Define the schemas for the final tables

-- Create brand table
CREATE TABLE brand (
    brand_id INT PRIMARY KEY,
    brand_name VARCHAR(255) NOT NULL,
    country VARCHAR(255)
)

-- Create fragrance list table
CREATE TABLE fragrance_list (
    fragrance_id INT GENERATED ALWAYS AS IDENTITY PRIMARY KEY,
    fragrance_name VARCHAR(255) NOT NULL,
    brand_id INT REFERENCES brand(brand_id),
    gender VARCHAR(50),
    rating_value NUMERIC(3,2),
    rating_count INT,
    year INT,
    url TEXT
)

-- Create notes table and junction table for many-to-many relationship
CREATE TABLE note (
    note_id INT GENERATED ALWAYS AS IDENTITY PRIMARY KEY,
    note_name VARCHAR(255) NOT NULL
)

CREATE TABLE fragrance_note (
    fragrance_id INT REFERENCES fragrance_list(fragrance_id),
    note_id INT REFERENCES note(note_id),
    note_type VARCHAR(50)
)
-- Create perfumer table and junction table for many-to-many relationship
CREATE TABLE perfumer (
    perfumer_id INT GENERATED ALWAYS AS IDENTITY PRIMARY KEY,
    perfumer_name VARCHAR(555) NOT NULL
)

CREATE TABLE fragrance_perfumer (
    fragrance_id INT REFERENCES fragrance_list(fragrance_id),
    perfumer_id INT REFERENCES perfumer(perfumer_id)
)

-- Create accord table and junction table for many-to-many relationship
CREATE TABLE accord (
    accord_id INT GENERATED ALWAYS AS IDENTITY PRIMARY KEY,
    accord_name VARCHAR(255) NOT NULL
)

CREATE TABLE fragrance_accord (
    fragrance_id INT REFERENCES fragrance_list(fragrance_id),
    accord_name VARCHAR(255) NOT NULL
)

-- Verify the tables have been created
SELECT table_schema, table_name
FROM information_schema.tables
WHERE table_type = 'BASE TABLE'  -- ensure to list actual tables (not views or foreign tables)
  AND table_schema NOT IN ('pg_catalog', 'information_schema') -- exclude system schemas
ORDER BY table_schema, table_name;
