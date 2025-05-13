-- SQL Insertion statements for Fungalnet
-- This file contains the SQL commands to insert the Fungalnet monster into the database

-- Insert monster data
INSERT INTO monsters (
    name, category, subcategory, habitat, biome, rarity, discovery, height, weight, appearance, 
    primary_power, secondary_power, special_ability, weakness, 
    behavior_ecology, notable_specimens
) VALUES (
    'Fungalnet',
    'Nature/Organic',
    'Mycelial Collective',
    'Terrestrial Wilderness',
    'Ancient Forests',
    'Uncommon', 
    'First identified in 2023 by mycologist Dr. Spore during research on fungal communication networks',
    3.0, 
    '150 kg', 
    'Humanoid figure composed of densely interwoven mycelium strands with clusters of various mushrooms and fungi growing from its surface. Body can separate into component fungi and reform at will. Bioluminescent spores constantly emanate from its form, creating a glowing aura.',
    'Mycelial Control - Manipulation of fungal networks and growth',
    'Spore Generation - Can produce various spores with different effects',
    'Collective Consciousness - Can connect to and communicate with all fungi in an ecosystem',
    'Extreme dry conditions cause rapid dehydration, reducing cohesion by 80%',
    'Fungalnets act as the conscious embodiment of forest mycelium networks. They can extend their awareness through connected fungal systems, effectively monitoring entire ecosystems. They communicate through chemical signals and can share information with plant life through mycorrhizal connections. They reproduce by establishing new mycelial networks that gradually develop collective consciousness.',
    'The Forest Memory is an ancient Fungalnet that has integrated with a primeval forest for centuries. It maintains a living record of the forest''s history stored within its mycelial network and can share these memories as vivid hallucinations with those who consume specific mushrooms it produces. It has developed symbiotic relationships with all life in its forest, creating a perfectly balanced ecosystem.'
);

-- Get the monster_id for Fungalnet
DO $$
DECLARE
    monster_id_val INTEGER;
    stats_id_val INTEGER;
    keyword_id_val INTEGER;
BEGIN
    SELECT monster_id INTO monster_id_val FROM monsters WHERE name = 'Fungalnet';
    
    -- Insert QuestWorlds stats
    INSERT INTO questworlds_stats (monster_id) VALUES (monster_id_val) RETURNING stats_id INTO stats_id_val;
    
    -- Insert keywords
    INSERT INTO keywords (stats_id, keyword_name, rating, base_value, improvement_points) VALUES
    (stats_id_val, 'Mycelial Collective', 20, 15, 5) RETURNING keyword_id INTO keyword_id_val;
    
    -- Insert abilities for Mycelial Collective
    INSERT INTO abilities (stats_id, keyword_id, ability_name, mastery_value) VALUES
    (stats_id_val, keyword_id_val, 'Collective Consciousness', '5M'),
    (stats_id_val, keyword_id_val, 'Ecosystem Awareness', '5M'),
    (stats_id_val, keyword_id_val, 'Mycelial Network Integration', '5M');
    
    -- Insert next keyword
    INSERT INTO keywords (stats_id, keyword_name, rating, base_value, improvement_points) VALUES
    (stats_id_val, 'Fungal Controller', 18, 10, 8) RETURNING keyword_id INTO keyword_id_val;
    
    -- Insert abilities for Fungal Controller
    INSERT INTO abilities (stats_id, keyword_id, ability_name, mastery_value) VALUES
    (stats_id_val, keyword_id_val, 'Mycelial Growth Manipulation', '3M'),
    (stats_id_val, keyword_id_val, 'Fungal Composition Control', '3M'),
    (stats_id_val, keyword_id_val, 'Decomposition Acceleration', '3M');
    
    -- Insert next keyword
    INSERT INTO keywords (stats_id, keyword_name, rating, base_value, improvement_points) VALUES
    (stats_id_val, 'Spore Generator', 17, 10, 7) RETURNING keyword_id INTO keyword_id_val;
    
    -- Insert abilities for Spore Generator
    INSERT INTO abilities (stats_id, keyword_id, ability_name, mastery_value) VALUES
    (stats_id_val, keyword_id_val, 'Varied Spore Production', '2M'),
    (stats_id_val, keyword_id_val, 'Bioluminescent Emanation', '2M'),
    (stats_id_val, keyword_id_val, 'Chemical Signaling', '2M');
    
    -- Insert flaws
    INSERT INTO flaws (stats_id, flaw_name, rating) VALUES
    (stats_id_val, 'Vulnerability to Dehydration', 20),
    (stats_id_val, 'Limited Mobility', 18);
    
    -- Insert augments (Strong Against)
    INSERT INTO augments (monster_id, target_name, modifier) VALUES
    (monster_id_val, 'Insect entities', 5),
    (monster_id_val, 'Decay-based creatures', 5);
    
    -- Insert hindrances (Weak Against)
    INSERT INTO hindrances (monster_id, target_name, modifier) VALUES
    (monster_id_val, 'Fire manipulators', -5),
    (monster_id_val, 'Cold-based entities', -5);
END $$;