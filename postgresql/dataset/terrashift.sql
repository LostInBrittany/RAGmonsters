-- SQL Insertion statements for Terrashift
-- This file contains the SQL commands to insert the Terrashift monster into the database

-- Insert monster data
INSERT INTO monsters (
    name, category, subcategory, habitat, biome, rarity, discovery, height, weight, appearance, 
    primary_power, secondary_power, special_ability, weakness, 
    behavior_ecology, notable_specimens
) VALUES (
    'Terrashift',
    'Nature/Organic',
    'Geological Entity',
    'Terrestrial Wilderness',
    'Tectonic Boundaries',
    'Rare', 
    'First observed in 2025 by geologist Dr. Stone during an unusual seismic event',
    3.5, 
    '2,000 kg', 
    'Massive humanoid composed of shifting layers of rock, soil, and crystal. Its form constantly changes as different minerals rise to the surface and subduct beneath others. Eyes are deep geodes filled with glowing magma.',
    'Geokinesis - Manipulation of earth, stone, and minerals',
    'Seismic Sense - Can detect vibrations through the ground with extreme precision',
    'Tectonic Shift - Can create localized earthquakes and reshape terrain',
    'Separation from ground contact reduces power by 95% within minutes',
    'Terrashifts are ancient beings that spend most of their existence in a dormant state, appearing as unusual rock formations. They awaken during significant geological events or when their territory is threatened. They communicate through subtle vibrations in the earth that can be felt rather than heard. They reproduce extremely rarely, with new Terrashifts emerging from specially prepared mineral deposits after centuries of formation.',
    'The Mountain King is a colossal Terrashift that has existed for millennia and has become so large it''s often mistaken for a small mountain. It can control geological activity across an entire region and has created a network of crystal caves that serve as a sanctuary for mineral-based lifeforms.'
);

-- Get the monster_id for Terrashift
DO $$
DECLARE
    monster_id_val INTEGER;
    stats_id_val INTEGER;
    keyword_id_val INTEGER;
BEGIN
    SELECT monster_id INTO monster_id_val FROM monsters WHERE name = 'Terrashift';
    
    -- Insert QuestWorlds stats
    INSERT INTO questworlds_stats (monster_id) VALUES (monster_id_val) RETURNING stats_id INTO stats_id_val;
    
    -- Insert keywords
    INSERT INTO keywords (stats_id, keyword_name, rating, base_value, improvement_points) VALUES
    (stats_id_val, 'Earth Manipulator', 20, 15, 5) RETURNING keyword_id INTO keyword_id_val;
    
    -- Insert abilities for Earth Manipulator
    INSERT INTO abilities (stats_id, keyword_id, ability_name, mastery_value) VALUES
    (stats_id_val, keyword_id_val, 'Tectonic Shift', '5M'),
    (stats_id_val, keyword_id_val, 'Geokinesis', '5M'),
    (stats_id_val, keyword_id_val, 'Terrain Reshaping', '5M');
    
    -- Insert next keyword
    INSERT INTO keywords (stats_id, keyword_name, rating, base_value, improvement_points) VALUES
    (stats_id_val, 'Geological Entity', 17, 10, 7) RETURNING keyword_id INTO keyword_id_val;
    
    -- Insert abilities for Geological Entity
    INSERT INTO abilities (stats_id, keyword_id, ability_name, mastery_value) VALUES
    (stats_id_val, keyword_id_val, 'Mineral Composition', '2M'),
    (stats_id_val, keyword_id_val, 'Geologic Adaptation', '2M'),
    (stats_id_val, keyword_id_val, 'Earth Integration', '2M');
    
    -- Insert next keyword
    INSERT INTO keywords (stats_id, keyword_name, rating, base_value, improvement_points) VALUES
    (stats_id_val, 'Seismic Sensor', 18, 10, 8) RETURNING keyword_id INTO keyword_id_val;
    
    -- Insert abilities for Seismic Sensor
    INSERT INTO abilities (stats_id, keyword_id, ability_name, mastery_value) VALUES
    (stats_id_val, keyword_id_val, 'Seismic Sense', '3M'),
    (stats_id_val, keyword_id_val, 'Vibration Detection', '3M'),
    (stats_id_val, keyword_id_val, 'Underground Awareness', '3M');
    
    -- Insert flaws
    INSERT INTO flaws (stats_id, flaw_name, rating) VALUES
    (stats_id_val, 'Vulnerability to Ground Separation', 20),
    (stats_id_val, 'Limited Mobility', 18);
    
    -- Insert augments (Strong Against)
    INSERT INTO augments (monster_id, target_name, modifier) VALUES
    (monster_id_val, 'Electric creatures', 5),
    (monster_id_val, 'Fire creatures', 5);
    
    -- Insert hindrances (Weak Against)
    INSERT INTO hindrances (monster_id, target_name, modifier) VALUES
    (monster_id_val, 'Water creatures', -5),
    (monster_id_val, 'Air creatures', -5);
END $$;