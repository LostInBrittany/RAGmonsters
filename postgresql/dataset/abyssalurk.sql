-- SQL Insertion statements for Abyssalurk
-- This file contains the SQL commands to insert the Abyssalurk monster into the database

-- Set search path to ragmonsters schema
SET search_path TO ragmonsters, public;

-- Insert monster data
INSERT INTO monsters (
    name, subcategory_id, monster_type, habitat, biome, rarity, discovery, height, weight, appearance, 
    primary_power, secondary_power, special_ability, weakness, 
    behavior_ecology, notable_specimens
) VALUES (
    'Abyssalurk',
    (SELECT subcategory_id FROM subcategories WHERE subcategory_name = 'Environmental Entity'),
    'Deep Sea Entity',
    'Aquatic',
    'Oceanic Trenches',
    'Rare', 
    'First documented in 2024 by marine biologist Dr. Marina Depths during a deep-sea expedition',
    3.2, 
    '400 kg', 
    'Elongated humanoid with fish-like features and bioluminescent patterns across its midnight-blue skin. Has multiple sets of arms that end in webbed claws. Eyes are large, entirely black, and adapted for extreme pressure environments. Possesses both gills and rudimentary lungs.',
    'Pressure Manipulation - Control over water pressure in localized areas',
    'Bioluminescent Communication - Can create complex light patterns for signaling and hypnosis',
    'Depth Charge - Can create imploding water bubbles that generate devastating shockwaves',
    'Rapid decompression causes severe damage, reducing vitality by 75%',
    'Abyssalurks inhabit the darkest depths of the ocean, creating complex societies in underwater caves and trenches. They are territorial and mark their domains with distinctive bioluminescent patterns. They communicate through a combination of light signals and low-frequency vibrations. They reproduce slowly, with females laying eggs in protected nursery caves that are guarded by the entire community.',
    '"The Trench Sovereign" is a colossal Abyssalurk that has established a kingdom spanning multiple oceanic trenches. It has developed the ability to control deep sea currents and can communicate telepathically with all marine life in its territory. Its bioluminescence is so sophisticated it can create three-dimensional illusions underwater.'
);

-- Get the monster_id for Abyssalurk
DO $$
DECLARE
    monster_id_val INTEGER;
    stats_id_val INTEGER;
    keyword_id_val INTEGER;
BEGIN
    SELECT monster_id INTO monster_id_val FROM monsters WHERE name = 'Abyssalurk';
    
    -- Insert QuestWorlds stats
    INSERT INTO questworlds_stats (monster_id) VALUES (monster_id_val) RETURNING stats_id INTO stats_id_val;
    
    -- Insert keywords
    INSERT INTO keywords (stats_id, keyword_name, rating, base_value, improvement_points) VALUES
    (stats_id_val, 'Pressure Manipulator', 20, 15, 5) RETURNING keyword_id INTO keyword_id_val;
    
    -- Insert abilities for Pressure Manipulator
    INSERT INTO abilities (stats_id, keyword_id, ability_name, mastery_value) VALUES
    (stats_id_val, keyword_id_val, 'Depth Charge', '5M'),
    (stats_id_val, keyword_id_val, 'Localized Pressure Control', '5M'),
    (stats_id_val, keyword_id_val, 'Water Compression', '5M');
    
    -- Insert next keyword
    INSERT INTO keywords (stats_id, keyword_name, rating, base_value, improvement_points) VALUES
    (stats_id_val, 'Deep Sea Entity', 17, 10, 7) RETURNING keyword_id INTO keyword_id_val;
    
    -- Insert abilities for Deep Sea Entity
    INSERT INTO abilities (stats_id, keyword_id, ability_name, mastery_value) VALUES
    (stats_id_val, keyword_id_val, 'Underwater Navigation', '2M'),
    (stats_id_val, keyword_id_val, 'Withstand Pressure', '2M'),
    (stats_id_val, keyword_id_val, 'Multiple Webbed Limbs', '2M');
    
    -- Insert next keyword
    INSERT INTO keywords (stats_id, keyword_name, rating, base_value, improvement_points) VALUES
    (stats_id_val, 'Bioluminescent Communicator', 18, 10, 8) RETURNING keyword_id INTO keyword_id_val;
    
    -- Insert abilities for Bioluminescent Communicator
    INSERT INTO abilities (stats_id, keyword_id, ability_name, mastery_value) VALUES
    (stats_id_val, keyword_id_val, 'Hypnotic Light Patterns', '3M'),
    (stats_id_val, keyword_id_val, 'Underwater Signaling', '3M'),
    (stats_id_val, keyword_id_val, 'Create Light Source', '3M');
    
    -- Insert flaws
    INSERT INTO flaws (stats_id, flaw_name, rating) VALUES
    (stats_id_val, 'Vulnerability to Decompression', 20),
    (stats_id_val, 'Limited Mobility on Land', 17);
    
    -- Insert augments (Strong Against)
    INSERT INTO augments (monster_id, target_name, modifier) VALUES
    (monster_id_val, 'Surface dwellers', 5),
    (monster_id_val, 'Fire creatures', 5);
    
    -- Insert hindrances (Weak Against)
    INSERT INTO hindrances (monster_id, target_name, modifier) VALUES
    (monster_id_val, 'Electricity manipulators', -5),
    (monster_id_val, 'Sonic entities', -5);
END $$;