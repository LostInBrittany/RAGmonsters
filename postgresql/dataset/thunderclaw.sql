-- SQL Insertion statements for Thunderclaw
-- This file contains the SQL commands to insert the Thunderclaw monster into the database

-- Insert monster data
INSERT INTO monsters (
    name, category, subcategory, habitat, biome, rarity, discovery, height, weight, appearance, 
    primary_power, secondary_power, special_ability, weakness, 
    behavior_ecology, notable_specimens
) VALUES (
    'Thunderclaw',
    'Elemental',
    'Storm Predator',
    'Terrestrial Wilderness',
    'Thunderstorm Plains',
    'Rare', 
    'First sighted during the Great Lightning Storm of 2025 by storm chaser Marcus Bolt',
    2.1, 
    '280 kg', 
    'Feline quadruped with metallic purple-blue fur that constantly emits small electrical discharges. Has elongated front claws made of conductive material that can extend up to 30cm. Eyes glow yellow during electrical charge buildup.',
    'Electrokinesis - Generation and control of electrical currents',
    'Static Field - Creates an electromagnetic field that disrupts electronic devices',
    'Thunder Dash - Can transform into pure electrical energy for short bursts of movement',
    'Grounding attacks that disperse electrical charge reduce power by 70%',
    'Thunderclaws are nomadic, following storm systems to recharge their electrical reserves. They are primarily nocturnal, using electrical sensing abilities to locate prey during thunderstorms. They reproduce during the most intense electrical storms, with cubs requiring frequent exposure to electrical energy to develop properly.',
    'Stormheart is an unusually large Thunderclaw that has developed the ability to create focused lightning strikes from clear skies. It''s rumored to be able to communicate with storm systems, calling down targeted lightning at will.'
);

-- Get the monster_id for Thunderclaw
DO $$
DECLARE
    monster_id_val INTEGER;
    stats_id_val INTEGER;
    keyword_id_val INTEGER;
BEGIN
    SELECT monster_id INTO monster_id_val FROM monsters WHERE name = 'Thunderclaw';
    
    -- Insert QuestWorlds stats
    INSERT INTO questworlds_stats (monster_id) VALUES (monster_id_val) RETURNING stats_id INTO stats_id_val;
    
    -- Insert keywords
    INSERT INTO keywords (stats_id, keyword_name, rating, base_value, improvement_points) VALUES
    (stats_id_val, 'Electric Manipulator', 20, 15, 5) RETURNING keyword_id INTO keyword_id_val;
    
    -- Insert abilities for Electric Manipulator
    INSERT INTO abilities (stats_id, keyword_id, ability_name, mastery_value) VALUES
    (stats_id_val, keyword_id_val, 'Electrokinesis', '5M'),
    (stats_id_val, keyword_id_val, 'Static Field', '5M'),
    (stats_id_val, keyword_id_val, 'Electrical Discharge', '5M');
    
    -- Insert next keyword
    INSERT INTO keywords (stats_id, keyword_name, rating, base_value, improvement_points) VALUES
    (stats_id_val, 'Storm Predator', 17, 10, 7) RETURNING keyword_id INTO keyword_id_val;
    
    -- Insert abilities for Storm Predator
    INSERT INTO abilities (stats_id, keyword_id, ability_name, mastery_value) VALUES
    (stats_id_val, keyword_id_val, 'Thunder Dash', '2M'),
    (stats_id_val, keyword_id_val, 'Storm Sensing', '2M'),
    (stats_id_val, keyword_id_val, 'Predatory Instincts', '2M');
    
    -- Insert next keyword
    INSERT INTO keywords (stats_id, keyword_name, rating, base_value, improvement_points) VALUES
    (stats_id_val, 'Lightning Beast', 18, 10, 8) RETURNING keyword_id INTO keyword_id_val;
    
    -- Insert abilities for Lightning Beast
    INSERT INTO abilities (stats_id, keyword_id, ability_name, mastery_value) VALUES
    (stats_id_val, keyword_id_val, 'Conductive Claws', '3M'),
    (stats_id_val, keyword_id_val, 'Electromagnetic Field Generation', '3M'),
    (stats_id_val, keyword_id_val, 'Storm Energy Absorption', '3M');
    
    -- Insert flaws
    INSERT INTO flaws (stats_id, flaw_name, rating) VALUES
    (stats_id_val, 'Vulnerability to Grounding', 20),
    (stats_id_val, 'Charge Dependency', 18);
    
    -- Insert augments (Strong Against)
    INSERT INTO augments (monster_id, target_name, modifier) VALUES
    (monster_id_val, 'Water creatures', 5),
    (monster_id_val, 'Metal creatures', 5);
    
    -- Insert hindrances (Weak Against)
    INSERT INTO hindrances (monster_id, target_name, modifier) VALUES
    (monster_id_val, 'Earth creatures', -5),
    (monster_id_val, 'Rubber-based creatures', -5);
END $$;