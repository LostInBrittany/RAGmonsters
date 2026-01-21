-- SQL Insertion statements for Windwhisper
-- This file contains the SQL commands to insert the Windwhisper monster into the database

-- Set search path to ragmonsters schema
SET search_path TO ragmonsters, public;

-- Insert monster data
INSERT INTO monsters (
    name, subcategory_id, monster_type, habitat, biome, rarity, discovery, height, weight, appearance, 
    primary_power, secondary_power, special_ability, weakness, 
    behavior_ecology, notable_specimens
) VALUES (
    'Windwhisper',
    (SELECT subcategory_id FROM subcategories WHERE subcategory_name = 'Ethereal Entity'),
    'Aerial Spirit',
    'Terrestrial Wilderness',
    'High Mountain Peaks',
    'Uncommon', 
    'First documented by mountaineer Zephyr Gale in 2024 at the summit of Mount Skyreach',
    2.2, 
    '40 kg (mostly incorporeal)', 
    'Semi-transparent humanoid composed of swirling air currents. Features are fluid but generally maintain a feminine form with long, flowing appendages resembling hair and robes. Eyes appear as small cyclones of concentrated air.',
    'Aerokinesis - Manipulation of air and wind currents',
    'Pressure Control - Can create areas of high or low atmospheric pressure',
    'Tempest Form - Can transform into a small, localized tornado',
    'Extreme cold can solidify portions of its form, reducing mobility by 80%',
    'Windwhispers are nomadic entities that follow global wind patterns. They communicate through subtle variations in air pressure that sound like whispered voices to those who can perceive them. They feed on kinetic energy and are drawn to areas with strong, consistent winds. During calm weather, they enter a dormant state, becoming nearly invisible.',
    'The Skyweaver is an ancient Windwhisper that has developed control over weather patterns across entire mountain ranges. It can create safe passages through storms for travelers it deems worthy and is said to carry messages between isolated mountain communities.'
);

-- Get the monster_id for Windwhisper
DO $$
DECLARE
    monster_id_val INTEGER;
    stats_id_val INTEGER;
    keyword_id_val INTEGER;
BEGIN
    SELECT monster_id INTO monster_id_val FROM monsters WHERE name = 'Windwhisper';
    
    -- Insert QuestWorlds stats
    INSERT INTO questworlds_stats (monster_id) VALUES (monster_id_val) RETURNING stats_id INTO stats_id_val;
    
    -- Insert keywords
    INSERT INTO keywords (stats_id, keyword_name, rating, base_value, improvement_points) VALUES
    (stats_id_val, 'Wind Manipulator', 20, 15, 5) RETURNING keyword_id INTO keyword_id_val;
    
    -- Insert abilities for Wind Manipulator
    INSERT INTO abilities (stats_id, keyword_id, ability_name, mastery_value) VALUES
    (stats_id_val, keyword_id_val, 'Aerokinesis', '5M'),
    (stats_id_val, keyword_id_val, 'Wind Current Control', '5M'),
    (stats_id_val, keyword_id_val, 'Air Manipulation', '5M');
    
    -- Insert next keyword
    INSERT INTO keywords (stats_id, keyword_name, rating, base_value, improvement_points) VALUES
    (stats_id_val, 'Aerial Spirit', 17, 10, 7) RETURNING keyword_id INTO keyword_id_val;
    
    -- Insert abilities for Aerial Spirit
    INSERT INTO abilities (stats_id, keyword_id, ability_name, mastery_value) VALUES
    (stats_id_val, keyword_id_val, 'Tempest Form', '2M'),
    (stats_id_val, keyword_id_val, 'Air Current Navigation', '2M'),
    (stats_id_val, keyword_id_val, 'Incorporeal Flight', '2M');
    
    -- Insert next keyword
    INSERT INTO keywords (stats_id, keyword_name, rating, base_value, improvement_points) VALUES
    (stats_id_val, 'Pressure Controller', 18, 10, 8) RETURNING keyword_id INTO keyword_id_val;
    
    -- Insert abilities for Pressure Controller
    INSERT INTO abilities (stats_id, keyword_id, ability_name, mastery_value) VALUES
    (stats_id_val, keyword_id_val, 'Atmospheric Pressure Alteration', '3M'),
    (stats_id_val, keyword_id_val, 'Weather Influence', '3M'),
    (stats_id_val, keyword_id_val, 'Whispered Communication', '3M');
    
    -- Insert flaws
    INSERT INTO flaws (stats_id, flaw_name, rating) VALUES
    (stats_id_val, 'Vulnerability to Cold', 20),
    (stats_id_val, 'Form Instability', 18);
    
    -- Insert augments (Strong Against)
    INSERT INTO augments (monster_id, target_name, modifier) VALUES
    (monster_id_val, 'Earth creatures', 5),
    (monster_id_val, 'Fire creatures', 5);
    
    -- Insert hindrances (Weak Against)
    INSERT INTO hindrances (monster_id, target_name, modifier) VALUES
    (monster_id_val, 'Ice creatures', -5),
    (monster_id_val, 'Electric creatures', -5);
END $$;