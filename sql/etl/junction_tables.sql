-- JUNCTION TABLE ETL

-- Load data into fragrance_accord junction table from staging_brand table
WITH accord_combined AS (   -- Combine all accord columns into a single column with fragrance_id
    SELECT 
        f.fragrance_id,
        s.accord_1 AS accord_name
    FROM fragrance_list f JOIN staging_fragrance_core s ON f.fragrance_name = s.fragrance_name      -- Join on fragrance_name to get fragrance_id
    UNION ALL
    SELECT 
        f.fragrance_id,
        s.accord_2 AS accord_name
    FROM fragrance_list f JOIN staging_fragrance_core s ON f.fragrance_name = s.fragrance_name
    UNION ALL
    SELECT 
        f.fragrance_id,
        s.accord_3 AS accord_name
    FROM fragrance_list f JOIN staging_fragrance_core s ON f.fragrance_name = s.fragrance_name
    UNION ALL
    SELECT
        f.fragrance_id,
        s.accord_4 AS accord_name
    FROM fragrance_list f JOIN staging_fragrance_core s ON f.fragrance_name = s.fragrance_name
    UNION ALL
    SELECT
        f.fragrance_id,
        s.accord_5 AS accord_name
    FROM fragrance_list f JOIN staging_fragrance_core s ON f.fragrance_name = s.fragrance_name
),
accord_linked AS (      -- Link accord names to accord_ids
    SELECT
        ac.fragrance_id,
        a.accord_id
    FROM accord_combined ac JOIN accord a ON TRIM(ac.accord_name) = a.accord_name
    WHERE ac.accord_name IS NOT NULL AND ac.accord_name <> ''       -- Exclude null or empty accord names
)
INSERT INTO fragrance_accord(fragrance_id, accord_id)
SELECT fragrance_id, accord_id
FROM accord_linked
ON CONFLICT DO NOTHING;     -- Ignore error caused by removing duplicates

-- Verify data load by retrieving rows from fragrance_accord junction table
SELECT * FROM fragrance_accord LIMIT 10;


-- Load data into fragrance_note junction table from staging_brand table
SELECT
    f.fragrance_id,
    s.top_notes
FROM fragrance_list f JOIN staging_fragrance_core s ON f.fragrance_name = s.fragrance_name;

-- Create a temporary table to hold fragrance_id and all columns from staging_fragrance_core
DROP TABLE IF EXISTS temp_staging_fragrance;
CREATE TEMP TABLE temp_staging_fragrance AS
SELECT
    f.fragrance_id,
    s.*
FROM staging_fragrance_core s LEFT JOIN fragrance_list f ON s.url = f.url;   -- Join on unique URL to get fragrance_id

-- Verify the temporary table
SELECT * FROM temp_staging_fragrance;
-- Check for any rows where fragrance_id is NULL (indicating no match found)
SELECT *
FROM temp_staging_fragrance
WHERE fragrance_id IS NULL
LIMIT 50;

-- Insert into fragrance_note junction table, ensure that there's no duplicates
INSERT INTO fragrance_note (fragrance_id, note_id, note_type)
SELECT DISTINCT t.fragrance_id,
                n.note_id,
                'top' AS note_type      -- Specify note_type as 'top'
FROM temp_staging_fragrance t 
CROSS JOIN LATERAL regexp_split_to_table(COALESCE(t.top_notes, ''), ',') AS raw_notes(note_name) -- Split top_notes by comma into rows, COALESCE to handle NULLs
JOIN note n ON n.note_name = TRIM (raw_notes.note_name)
WHERE TRIM(raw_notes.note_name) <> '' AND t.fragrance_id IS NOT NULL        -- Exclude empty note names and ensure fragrance_id is not NULL
ON CONFLICT DO NOTHING;     -- Ignore error caused by removing duplicates

-- Verify data load by retrieving rows from fragrance_note junction table
SELECT * FROM fragrance_note ORDER BY fragrance_id LIMIT 10;


-- Load data into fragrance_perfumer junction table from staging_brand table
