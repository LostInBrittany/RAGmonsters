-- SQL Insertion statements for Chronoshift
-- This file contains the SQL commands to insert the Chronoshift monster into the database

-- Insert monster data
INSERT INTO monsters (
    name, category, subcategory, habitat, biome, rarity, discovery, height, weight, appearance, 
    primary_power, secondary_power, special_ability, weakness, 
    behavior_ecology, notable_specimens
) VALUES (
    'Chronoshift',
    'Anomaly/Phenomenon',
    'Temporal Anomaly',
    'Extra-dimensional',
    'Time Fractures',
    'Extremely Rare', 
    'First observed in 2025 by theoretical physicist Dr. Tempus during experiments with quantum entanglement',
    2.0, 
    'Unmeasurable (exists partially outside normal time)', 
    'Humanoid figure that appears to be constantly shifting between different states of existence. Its form leaves visual echoes as it moves, showing past and future positions simultaneously. Body composed of clock-like mechanisms and flowing temporal energy.',
    'Chronokinesis - Manipulation of localized time flow',
    'Temporal Perception - Can see events slightly before and after they occur',
    'Time Loop - Can create a bubble where time repeats in short cycles',
    'Quantum uncertainty fields disrupt temporal control, reducing power by 95%',
    'Chronoshifts exist in areas where time flows abnormally, such as near black holes or dimensional boundaries. They experience reality non-linearly, sometimes responding to events before they occur. They communicate through temporal impressions that manifest as intuitive understanding rather than language. Their reproduction is paradoxical, with new Chronoshifts sometimes appearing before their "parent" creates them.',
    'The Watchmaker is a Chronoshift that has achieved perfect harmony with the flow of time. It can create stable time loops and has established a sanctuary where past, present, and future coexist in a carefully balanced ecosystem. It appears to be maintaining the integrity of local time-space against some future threat that only it can perceive.'
);

-- Get the monster_id for Chronoshift
DO $$
DECLARE
    monster_id_val INTEGER;
    stats_id_val INTEGER;
    keyword_id_val INTEGER;
BEGIN
    SELECT monster_id INTO monster_id_val FROM monsters WHERE name = 'Chronoshift';
    
    -- Insert QuestWorlds stats
    INSERT INTO questworlds_stats (monster_id) VALUES (monster_id_val) RETURNING stats_id INTO stats_id_val;
    
    -- Insert keywords
    INSERT INTO keywords (stats_id, keyword_name, rating, base_value, improvement_points) VALUES
    (stats_id_val, 'Chronokinetic Entity', 20, 15, 5) RETURNING keyword_id INTO keyword_id_val;
    
    -- Insert abilities for Chronokinetic Entity
    INSERT INTO abilities (stats_id, keyword_id, ability_name, mastery_value) VALUES
    (stats_id_val, keyword_id_val, 'Time Loop Creation', '5M'),
    (stats_id_val, keyword_id_val, 'Accelerate/Decelerate Time', '5M'),
    (stats_id_val, keyword_id_val, 'Temporal Echo Generation', '5M');
    
    -- Insert next keyword
    INSERT INTO keywords (stats_id, keyword_name, rating, base_value, improvement_points) VALUES
    (stats_id_val, 'Temporal Anomaly', 17, 10, 7) RETURNING keyword_id INTO keyword_id_val;
    
    -- Insert abilities for Temporal Anomaly
    INSERT INTO abilities (stats_id, keyword_id, ability_name, mastery_value) VALUES
    (stats_id_val, keyword_id_val, 'Exist Outside Normal Time', '2M'),
    (stats_id_val, keyword_id_val, 'Time-Space Navigation', '2M'),
    (stats_id_val, keyword_id_val, 'Phase Through Timeline', '2M');
    
    -- Insert next keyword
    INSERT INTO keywords (stats_id, keyword_name, rating, base_value, improvement_points) VALUES
    (stats_id_val, 'Time Perceiver', 18, 10, 8) RETURNING keyword_id INTO keyword_id_val;
    
    -- Insert abilities for Time Perceiver
    INSERT INTO abilities (stats_id, keyword_id, ability_name, mastery_value) VALUES
    (stats_id_val, keyword_id_val, 'Precognition', '3M'),
    (stats_id_val, keyword_id_val, 'Timeline Analysis', '3M'),
    (stats_id_val, keyword_id_val, 'Temporal Pattern Recognition', '3M');
    
    -- Insert flaws
    INSERT INTO flaws (stats_id, flaw_name, rating) VALUES
    (stats_id_val, 'Vulnerability to Quantum Uncertainty', 20),
    (stats_id_val, 'Timeline Anchoring Difficulty', 17);
    
    -- Insert augments (Strong Against)
    INSERT INTO augments (monster_id, target_name, modifier) VALUES
    (monster_id_val, 'Physical creatures', 5),
    (monster_id_val, 'Predictable pattern entities', 5);
    
    -- Insert hindrances (Weak Against)
    INSERT INTO hindrances (monster_id, target_name, modifier) VALUES
    (monster_id_val, 'Quantum creatures', -5),
    (monster_id_val, 'Chaos entities', -5);
END $$;