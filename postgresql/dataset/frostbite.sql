-- SQL Insertion statements for Frostbite
-- This file contains the SQL commands to insert the Frostbite monster into the database

-- Insert monster data
INSERT INTO monsters (
    name, category, subcategory, habitat, biome, rarity, discovery, height, weight, appearance, 
    primary_power, secondary_power, special_ability, weakness, 
    behavior_ecology, notable_specimens
) VALUES (
    'Frostbite',
    'Elemental',
    'Cryo Entity',
    'Terrestrial Wilderness',
    'Arctic Wastelands',
    'Common', 
    'First documented in 2023 by polar explorer Frost Whitewind during an expedition to the Eternal Ice',
    2.4, 
    '280 kg', 
    'Humanoid figure composed of crystalline ice with a core of swirling blue energy. Its body is covered in intricate frost patterns that constantly shift and reform. Fingers extend into sharp icicle claws, and its breath materializes as visible crystals.',
    'Cryokinesis - Control and generation of ice and cold',
    'Thermal Drain - Can absorb heat from surroundings, causing rapid freezing',
    'Blizzard Form - Can transform into a localized snowstorm for rapid movement',
    'Heat-based attacks cause rapid melting, reducing mass by up to 50%',
    'Frostbites form naturally in regions of extreme cold where ambient magical energy is present. They are territorial and create elaborate ice structures to mark their domains. They hibernate during warmer months by burrowing deep into glaciers. They reproduce by channeling their energy into ice formations during the winter solstice, which animate as new Frostbites when conditions are right.',
    'The Winter Monarch is an ancient Frostbite that has grown to enormous proportions and developed control over weather patterns across entire regions. It can create perpetual winter in its territory and has formed a symbiotic relationship with arctic wildlife, which it protects from environmental threats.'
);

-- Get the monster_id for Frostbite
DO $$
DECLARE
    monster_id_val INTEGER;
    stats_id_val INTEGER;
    keyword_id_val INTEGER;
BEGIN
    SELECT monster_id INTO monster_id_val FROM monsters WHERE name = 'Frostbite';
    
    -- Insert QuestWorlds stats
    INSERT INTO questworlds_stats (monster_id) VALUES (monster_id_val) RETURNING stats_id INTO stats_id_val;
    
    -- Insert keywords
    INSERT INTO keywords (stats_id, keyword_name, rating, base_value, improvement_points) VALUES
    (stats_id_val, 'Ice Manipulator', 20, 15, 5) RETURNING keyword_id INTO keyword_id_val;
    
    -- Insert abilities for Ice Manipulator
    INSERT INTO abilities (stats_id, keyword_id, ability_name, mastery_value) VALUES
    (stats_id_val, keyword_id_val, 'Cryokinesis', '5M'),
    (stats_id_val, keyword_id_val, 'Icicle Claw Formation', '5M'),
    (stats_id_val, keyword_id_val, 'Ice Structure Creation', '5M');
    
    -- Insert next keyword
    INSERT INTO keywords (stats_id, keyword_name, rating, base_value, improvement_points) VALUES
    (stats_id_val, 'Cryo Entity', 18, 10, 8) RETURNING keyword_id INTO keyword_id_val;
    
    -- Insert abilities for Cryo Entity
    INSERT INTO abilities (stats_id, keyword_id, ability_name, mastery_value) VALUES
    (stats_id_val, keyword_id_val, 'Crystalline Ice Body', '3M'),
    (stats_id_val, keyword_id_val, 'Arctic Adaptation', '3M'),
    (stats_id_val, keyword_id_val, 'Ice Pattern Formation', '3M');
    
    -- Insert next keyword
    INSERT INTO keywords (stats_id, keyword_name, rating, base_value, improvement_points) VALUES
    (stats_id_val, 'Cold Generator', 17, 10, 7) RETURNING keyword_id INTO keyword_id_val;
    
    -- Insert abilities for Cold Generator
    INSERT INTO abilities (stats_id, keyword_id, ability_name, mastery_value) VALUES
    (stats_id_val, keyword_id_val, 'Blizzard Form', '2M'),
    (stats_id_val, keyword_id_val, 'Thermal Drain', '2M'),
    (stats_id_val, keyword_id_val, 'Freezing Aura', '2M');
    
    -- Insert flaws
    INSERT INTO flaws (stats_id, flaw_name, rating) VALUES
    (stats_id_val, 'Vulnerability to Heat', 20),
    (stats_id_val, 'Mass Reduction When Melting', 18);
    
    -- Insert augments (Strong Against)
    INSERT INTO augments (monster_id, target_name, modifier) VALUES
    (monster_id_val, 'Water creatures', 5),
    (monster_id_val, 'Plant creatures', 5);
    
    -- Insert hindrances (Weak Against)
    INSERT INTO hindrances (monster_id, target_name, modifier) VALUES
    (monster_id_val, 'Fire creatures', -5),
    (monster_id_val, 'Earth creatures', -5);
END $$;