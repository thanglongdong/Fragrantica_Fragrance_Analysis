-- Create a materialized view to analyze fragrances with their brands, notes, accords, and perfumers
DROP MATERIALIZED VIEW IF EXISTS mv_fragrance_analysis;

CREATE MATERIALIZED VIEW mv_fragrance_analysis AS
SELECT 
    f.fragrance_id,
    f.fragrance_name,
    b.brand_name,
    b.country,
    f.gender,
    f.rating_value,
    f.rating_count,
    STRING_AGG(DISTINCT n.note_name, ', ') AS all_notes,        -- Aggregate distinct note names into a comma-separated string
    STRING_AGG(DISTINCT a.accord_name, ', ') AS all_accords,        -- Aggregate distinct accord names
    STRING_AGG(DISTINCT p.perfumer_name, ', ') AS perfumers     -- Aggregate distinct perfumer names
FROM fragrance_list f
LEFT JOIN brand b ON f.brand_id = b.brand_id        -- Join with dimension tables using foreign keys to retreive relevant values
LEFT JOIN fragrance_note fn ON f.fragrance_id = fn.fragrance_id
LEFT JOIN note n ON fn.note_id = n.note_id
LEFT JOIN fragrance_accord fa ON f.fragrance_id = fa.fragrance_id
LEFT JOIN accord a ON fa.accord_id = a.accord_id
LEFT JOIN fragrance_perfumer fp ON f.fragrance_id = fp.fragrance_id
LEFT JOIN perfumer p ON fp.perfumer_id = p.perfumer_id
GROUP BY f.fragrance_id, b.brand_name, b.country;

-- Verify the materialized view by retrieving some rows
SELECT * FROM mv_fragrance_analysis LIMIT 10;