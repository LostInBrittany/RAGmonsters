-- SQL Insertion statements for Plasmaweave
-- This file contains the SQL commands to insert the Plasmaweave monster into the database

-- Insert monster data
INSERT INTO monsters (
    name, category, habitat, rarity, discovery, height, weight, appearance, 
    primary_power, secondary_power, special_ability, weakness, 
    behavior_ecology, notable_specimens
) VALUES (
    'Plasmaweave', 
    'Energy Construct', 
    'Electromagnetic Hotspots', 
    'Rare', 
    'First documented in 2024 by plasma physicist Dr. Tesla Spark during a fusion experiment',
    2.1, 
    '15 kg (mostly energy)', 
    'Humanoid figure composed of swirling plasma contained within a self-generated electromagnetic field. Body constantly shifts between various states of matter, with arcs of electricity connecting different parts. Core is an intensely bright sphere of super-heated matter.',
    'Plasma Manipulation - Control over the fourth state of matter',
    'Electromagnetic Field Generation - Can create and shape EM fields',
    'Fusion Burst - Can briefly recreate stellar fusion conditions for explosive energy release',
    'Strong magnetic fields can disrupt its containment, reducing cohesion by 85%',
    'Plasmaweaves form naturally in areas of intense electromagnetic activity, such as during powerful solar storms or near fusion reactions. They feed on ambient energy and are drawn to power sources. They communicate through modulated electromagnetic frequencies that can be detected as unusual radio signals. They reproduce by carefully cultivating energy patterns that eventually develop consciousness when exposed to the right catalyst.',
    'The Living Star is an ancient Plasmaweave that has achieved perfect control over fusion reactions. It can maintain a miniature star within its core and has created a sanctuary where other energy beings can safely exist. It periodically releases controlled bursts of energy that manifest as aurora-like phenomena visible for hundreds of miles.'
);

-- Get the monster_id for Plasmaweave
DO $$
DECLARE
    monster_id_val INTEGER;
    stats_id_val INTEGER;
    keyword_id_val INTEGER;
BEGIN
    SELECT monster_id INTO monster_id_val FROM monsters WHERE name = 'Plasmaweave';
    
    -- Insert QuestWorlds stats
    INSERT INTO questworlds_stats (monster_id) VALUES (monster_id_val) RETURNING stats_id INTO stats_id_val;
    
    -- Insert keywords
    INSERT INTO keywords (stats_id, keyword_name, rating, base_value, improvement_points) VALUES
    (stats_id_val, 'Plasma Manipulator', 20, 15, 5) RETURNING keyword_id INTO keyword_id_val;
    
    -- Insert abilities for Plasma Manipulator
    INSERT INTO abilities (stats_id, keyword_id, ability_name, mastery_value) VALUES
    (stats_id_val, keyword_id_val, 'Fusion Burst', '5M'),
    (stats_id_val, keyword_id_val, 'Plasma Control', '5M'),
    (stats_id_val, keyword_id_val, 'Matter State Transformation', '5M');
    
    -- Insert next keyword
    INSERT INTO keywords (stats_id, keyword_name, rating, base_value, improvement_points) VALUES
    (stats_id_val, 'Energy Construct', 18, 10, 8) RETURNING keyword_id INTO keyword_id_val;
    
    -- Insert abilities for Energy Construct
    INSERT INTO abilities (stats_id, keyword_id, ability_name, mastery_value) VALUES
    (stats_id_val, keyword_id_val, 'State of Matter Shifting', '3M'),
    (stats_id_val, keyword_id_val, 'Energy Core Maintenance', '3M'),
    (stats_id_val, keyword_id_val, 'Electromagnetic Containment', '3M');
    
    -- Insert next keyword
    INSERT INTO keywords (stats_id, keyword_name, rating, base_value, improvement_points) VALUES
    (stats_id_val, 'Electromagnetic Generator', 17, 10, 7) RETURNING keyword_id INTO keyword_id_val;
    
    -- Insert abilities for Electromagnetic Generator
    INSERT INTO abilities (stats_id, keyword_id, ability_name, mastery_value) VALUES
    (stats_id_val, keyword_id_val, 'Field Generation', '2M'),
    (stats_id_val, keyword_id_val, 'Energy Channeling', '2M'),
    (stats_id_val, keyword_id_val, 'Frequency Modulation', '2M');
    
    -- Insert flaws
    INSERT INTO flaws (stats_id, flaw_name, rating) VALUES
    (stats_id_val, 'Vulnerability to Magnetic Fields', 20),
    (stats_id_val, 'Containment Instability', 18);
    
    -- Insert augments (Strong Against)
    INSERT INTO augments (monster_id, target_name, modifier) VALUES
    (monster_id_val, 'Water creatures', 5),
    (monster_id_val, 'Metal entities', 5);
    
    -- Insert hindrances (Weak Against)
    INSERT INTO hindrances (monster_id, target_name, modifier) VALUES
    (monster_id_val, 'Void entities', -5),
    (monster_id_val, 'Magnetic manipulators', -5);
END $$;