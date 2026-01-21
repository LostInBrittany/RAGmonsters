-- SQL Insertion statements for Psyforge
-- This file contains the SQL commands to insert the Psyforge monster into the database

-- Set search path to ragmonsters schema
SET search_path TO ragmonsters, public;

-- Insert monster data
INSERT INTO monsters (
    name, subcategory_id, monster_type, habitat, biome, rarity, discovery, height, weight, appearance, 
    primary_power, secondary_power, special_ability, weakness, 
    behavior_ecology, notable_specimens
) VALUES (
    'Psyforge',
    (SELECT subcategory_id FROM subcategories WHERE subcategory_name = 'Construct'),
    'Psychic Construct',
    'Extra-dimensional',
    'Thought Nexuses',
    'Very Rare', 
    'First encountered in 2025 by parapsychologist Dr. Mentis during a controlled telepathy experiment',
    2.0, 
    '100 kg (partially psychic energy)', 
    'Humanoid figure composed of swirling iridescent energy with a metallic exoskeleton that forms and reforms constantly. Head is an abstract geometric shape with multiple eyes that shift position. Tendrils of psychic energy extend from its back, forming wing-like structures.',
    'Telekinesis - Movement and manipulation of objects with mind power',
    'Thought Sensing - Can detect and interpret neural activity in nearby beings',
    'Mind Forge - Can create temporary physical constructs from psychic energy',
    'Chaotic or extremely disordered environments disrupt concentration, reducing power by 85%',
    'Psyforges exist in areas with high concentrations of conscious thought. They feed on ambient mental energy but can also form symbiotic relationships with willing hosts, enhancing the host''s mental abilities in exchange for a stable energy source. They communicate telepathically and can share memories and experiences directly with receptive minds.',
    'The Architect is a uniquely powerful Psyforge that has developed the ability to create permanent psychic constructs that persist independently. It has established a sanctuary where thoughts take physical form, and visitors report experiencing shared dreamscapes that can provide profound insights into their subconscious.'
);

-- Get the monster_id for Psyforge
DO $$
DECLARE
    monster_id_val INTEGER;
    stats_id_val INTEGER;
    keyword_id_val INTEGER;
BEGIN
    SELECT monster_id INTO monster_id_val FROM monsters WHERE name = 'Psyforge';
    
    -- Insert QuestWorlds stats
    INSERT INTO questworlds_stats (monster_id) VALUES (monster_id_val) RETURNING stats_id INTO stats_id_val;
    
    -- Insert keywords
    INSERT INTO keywords (stats_id, keyword_name, rating, base_value, improvement_points) VALUES
    (stats_id_val, 'Telekinetic Entity', 20, 15, 5) RETURNING keyword_id INTO keyword_id_val;
    
    -- Insert abilities for Telekinetic Entity
    INSERT INTO abilities (stats_id, keyword_id, ability_name, mastery_value) VALUES
    (stats_id_val, keyword_id_val, 'Telekinesis', '5M'),
    (stats_id_val, keyword_id_val, 'Object Manipulation', '5M'),
    (stats_id_val, keyword_id_val, 'Force Projection', '5M');
    
    -- Insert next keyword
    INSERT INTO keywords (stats_id, keyword_name, rating, base_value, improvement_points) VALUES
    (stats_id_val, 'Psychic Construct', 18, 10, 8) RETURNING keyword_id INTO keyword_id_val;
    
    -- Insert abilities for Psychic Construct
    INSERT INTO abilities (stats_id, keyword_id, ability_name, mastery_value) VALUES
    (stats_id_val, keyword_id_val, 'Mind Forge', '3M'),
    (stats_id_val, keyword_id_val, 'Psychic Energy Channeling', '3M'),
    (stats_id_val, keyword_id_val, 'Mental Landscape Navigation', '3M');
    
    -- Insert next keyword
    INSERT INTO keywords (stats_id, keyword_name, rating, base_value, improvement_points) VALUES
    (stats_id_val, 'Thought Sensor', 17, 10, 7) RETURNING keyword_id INTO keyword_id_val;
    
    -- Insert abilities for Thought Sensor
    INSERT INTO abilities (stats_id, keyword_id, ability_name, mastery_value) VALUES
    (stats_id_val, keyword_id_val, 'Neural Activity Detection', '2M'),
    (stats_id_val, keyword_id_val, 'Telepathic Communication', '2M'),
    (stats_id_val, keyword_id_val, 'Emotion Reading', '2M');
    
    -- Insert flaws
    INSERT INTO flaws (stats_id, flaw_name, rating) VALUES
    (stats_id_val, 'Vulnerability to Chaotic Environments', 20),
    (stats_id_val, 'Concentration Dependency', 18);
    
    -- Insert augments (Strong Against)
    INSERT INTO augments (monster_id, target_name, modifier) VALUES
    (monster_id_val, 'Physical creatures', 5),
    (monster_id_val, 'Elemental creatures', 5);
    
    -- Insert hindrances (Weak Against)
    INSERT INTO hindrances (monster_id, target_name, modifier) VALUES
    (monster_id_val, 'Void creatures', -5),
    (monster_id_val, 'Other psychic entities', -5);
END $$;