-- SQL Insertion statements for Magnetron
-- This file contains the SQL commands to insert the Magnetron monster into the database

-- Insert monster data
INSERT INTO monsters (
    name, category, subcategory, habitat, biome, rarity, discovery, height, weight, appearance, 
    primary_power, secondary_power, special_ability, weakness, 
    behavior_ecology, notable_specimens
) VALUES (
    'Magnetron',
    'Construct/Artificial',
    'Magnetic Entity',
    'Urban/Constructed',
    'Ferrous Deposits',
    'Uncommon', 
    'First documented in 2024 by geophysicist Dr. Ferris Iron during magnetic anomaly research',
    2.2, 
    '450 kg', 
    'Humanoid figure composed of magnetized metal fragments held together by powerful magnetic fields. Body constantly shifts as metal pieces realign. Core is a sphere of intensely magnetized rare earth elements that pulses with blue-white energy.',
    'Magnetokinesis - Control over magnetic fields and ferrous materials',
    'Electromagnetic Pulse Generation - Can create localized EMPs',
    'Magnetic Attraction - Can pull metal objects toward itself with tremendous force',
    'Extreme heat reduces magnetic properties, weakening control by 75%',
    'Magnetrons form naturally in areas with high concentrations of magnetic minerals, particularly near deposits of magnetite and rare earth elements. They constantly absorb and integrate metal from their surroundings, growing stronger over time. They communicate through modulated magnetic fields that can be detected as unusual compass behavior. They reproduce by carefully cultivating a portion of their core that eventually develops into a new Magnetron when exposed to sufficient magnetic energy.',
    'The Lodestone Emperor is an ancient Magnetron that has grown to enormous proportions by absorbing metal from an entire mountain range. It has developed control over electromagnetic forces so precise it can manipulate individual electrons, and has created a sanctuary where metal objects float in complex, constantly shifting patterns.'
);

-- Get the monster_id for Magnetron
DO $$
DECLARE
    monster_id_val INTEGER;
    stats_id_val INTEGER;
    keyword_id_val INTEGER;
BEGIN
    SELECT monster_id INTO monster_id_val FROM monsters WHERE name = 'Magnetron';
    
    -- Insert QuestWorlds stats
    INSERT INTO questworlds_stats (monster_id) VALUES (monster_id_val) RETURNING stats_id INTO stats_id_val;
    
    -- Insert keywords
    INSERT INTO keywords (stats_id, keyword_name, rating, base_value, improvement_points) VALUES
    (stats_id_val, 'Magnetokinetic Being', 20, 15, 5) RETURNING keyword_id INTO keyword_id_val;
    
    -- Insert abilities for Magnetokinetic Being
    INSERT INTO abilities (stats_id, keyword_id, ability_name, mastery_value) VALUES
    (stats_id_val, keyword_id_val, 'Magnetic Attraction', '5M'),
    (stats_id_val, keyword_id_val, 'Magnetokinesis', '5M'),
    (stats_id_val, keyword_id_val, 'Metal Manipulation', '5M');
    
    -- Insert next keyword
    INSERT INTO keywords (stats_id, keyword_name, rating, base_value, improvement_points) VALUES
    (stats_id_val, 'Magnetic Entity', 18, 10, 8) RETURNING keyword_id INTO keyword_id_val;
    
    -- Insert abilities for Magnetic Entity
    INSERT INTO abilities (stats_id, keyword_id, ability_name, mastery_value) VALUES
    (stats_id_val, keyword_id_val, 'Ferrous Material Integration', '3M'),
    (stats_id_val, keyword_id_val, 'Magnetic Field Perception', '3M'),
    (stats_id_val, keyword_id_val, 'Metallic Composition', '3M');
    
    -- Insert next keyword
    INSERT INTO keywords (stats_id, keyword_name, rating, base_value, improvement_points) VALUES
    (stats_id_val, 'Electromagnetic Generator', 17, 10, 7) RETURNING keyword_id INTO keyword_id_val;
    
    -- Insert abilities for Electromagnetic Generator
    INSERT INTO abilities (stats_id, keyword_id, ability_name, mastery_value) VALUES
    (stats_id_val, keyword_id_val, 'Electromagnetic Pulse', '2M'),
    (stats_id_val, keyword_id_val, 'Energy Core Pulsation', '2M'),
    (stats_id_val, keyword_id_val, 'Magnetic Field Generation', '2M');
    
    -- Insert flaws
    INSERT INTO flaws (stats_id, flaw_name, rating) VALUES
    (stats_id_val, 'Vulnerability to Extreme Heat', 20),
    (stats_id_val, 'Limited Speed', 18);
    
    -- Insert augments (Strong Against)
    INSERT INTO augments (monster_id, target_name, modifier) VALUES
    (monster_id_val, 'Metal creatures', 5),
    (monster_id_val, 'Technology-based entities', 5);
    
    -- Insert hindrances (Weak Against)
    INSERT INTO hindrances (monster_id, target_name, modifier) VALUES
    (monster_id_val, 'Heat manipulators', -5),
    (monster_id_val, 'Non-metallic entities', -5);
END $$;