-- SQL Insertion statements for Echospecter
-- This file contains the SQL commands to insert the Echospecter monster into the database

-- Insert monster data
INSERT INTO monsters (
    name, category, habitat, rarity, discovery, height, weight, appearance, 
    primary_power, secondary_power, special_ability, weakness, 
    behavior_ecology, notable_specimens
) VALUES (
    'Echospecter', 
    'Resonance Entity', 
    'Acoustic Anomalies', 
    'Rare', 
    'First detected in 2024 by acoustician Dr. Echo Chamber during research on architectural acoustics',
    2.0, 
    '20 kg (mostly sound waves)', 
    'Translucent humanoid figure composed of visible sound waves that ripple and flow with every noise in its vicinity. Body constantly shifts between visibility and near-invisibility depending on ambient sound levels. Features are suggested by concentrated wave patterns that mimic facial structures.',
    'Echo Manipulation - Control over reflected sound waves',
    'Acoustic Memory - Can perfectly recall and reproduce any sound it has ever heard',
    'Resonance Cascade - Can amplify sounds to destructive levels by matching resonant frequencies',
    'Vacuum environments render it nearly powerless, reducing form stability by 95%',
    'Echospecters form in locations with unusual acoustic properties, such as ancient amphitheaters, cave systems, or specially designed concert halls. They feed on sound energy and are most active in noisy environments. They communicate through complex harmonic patterns that can convey detailed information. They reproduce by creating "sound seeds" - concentrated acoustic patterns that develop consciousness when exposed to the right harmonic conditions.',
    'The Symphony is an ancient Echospecter that has collected sounds from throughout history, preserving acoustic memories that would otherwise be lost to time. It can reproduce the exact sound of extinct species, lost languages, and historical events it witnessed. It has created an acoustic sanctuary where sound itself takes physical form, creating landscapes of pure resonance.'
);

-- Get the monster_id for Echospecter
DO $$
DECLARE
    monster_id_val INTEGER;
    stats_id_val INTEGER;
    keyword_id_val INTEGER;
BEGIN
    SELECT monster_id INTO monster_id_val FROM monsters WHERE name = 'Echospecter';
    
    -- Insert QuestWorlds stats
    INSERT INTO questworlds_stats (monster_id) VALUES (monster_id_val) RETURNING stats_id INTO stats_id_val;
    
    -- Insert keywords
    INSERT INTO keywords (stats_id, keyword_name, rating, base_value, improvement_points) VALUES
    (stats_id_val, 'Sound Manipulator', 20, 15, 5) RETURNING keyword_id INTO keyword_id_val;
    
    -- Insert abilities for Sound Manipulator
    INSERT INTO abilities (stats_id, keyword_id, ability_name, mastery_value) VALUES
    (stats_id_val, keyword_id_val, 'Resonance Cascade', '5M'),
    (stats_id_val, keyword_id_val, 'Echo Control', '5M'),
    (stats_id_val, keyword_id_val, 'Sound Amplification', '5M');
    
    -- Insert next keyword
    INSERT INTO keywords (stats_id, keyword_name, rating, base_value, improvement_points) VALUES
    (stats_id_val, 'Resonance Entity', 18, 10, 8) RETURNING keyword_id INTO keyword_id_val;
    
    -- Insert abilities for Resonance Entity
    INSERT INTO abilities (stats_id, keyword_id, ability_name, mastery_value) VALUES
    (stats_id_val, keyword_id_val, 'Sound Wave Navigation', '3M'),
    (stats_id_val, keyword_id_val, 'Acoustic Form Adaptation', '3M'),
    (stats_id_val, keyword_id_val, 'Harmonic Existence', '3M');
    
    -- Insert next keyword
    INSERT INTO keywords (stats_id, keyword_name, rating, base_value, improvement_points) VALUES
    (stats_id_val, 'Acoustic Memory Bank', 17, 10, 7) RETURNING keyword_id INTO keyword_id_val;
    
    -- Insert abilities for Acoustic Memory Bank
    INSERT INTO abilities (stats_id, keyword_id, ability_name, mastery_value) VALUES
    (stats_id_val, keyword_id_val, 'Perfect Sound Reproduction', '2M'),
    (stats_id_val, keyword_id_val, 'Sonic Information Storage', '2M'),
    (stats_id_val, keyword_id_val, 'Harmonic Communication', '2M');
    
    -- Insert flaws
    INSERT INTO flaws (stats_id, flaw_name, rating) VALUES
    (stats_id_val, 'Vulnerability to Vacuum', 20),
    (stats_id_val, 'Form Instability in Silence', 18);
    
    -- Insert augments (Strong Against)
    INSERT INTO augments (monster_id, target_name, modifier) VALUES
    (monster_id_val, 'Crystal entities', 5),
    (monster_id_val, 'Structure-based creatures', 5);
    
    -- Insert hindrances (Weak Against)
    INSERT INTO hindrances (monster_id, target_name, modifier) VALUES
    (monster_id_val, 'Silence manipulators', -5),
    (monster_id_val, 'Void entities', -5);
END $$;