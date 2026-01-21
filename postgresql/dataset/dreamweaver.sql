-- SQL Insertion statements for Dreamweaver
-- This file contains the SQL commands to insert the Dreamweaver monster into the database

-- Set search path to ragmonsters schema
SET search_path TO ragmonsters, public;

-- Insert monster data
INSERT INTO monsters (
    name, subcategory_id, monster_type, habitat, biome, rarity, discovery, height, weight, appearance, 
    primary_power, secondary_power, special_ability, weakness, 
    behavior_ecology, notable_specimens
) VALUES (
    'Dreamweaver',
    (SELECT subcategory_id FROM subcategories WHERE subcategory_name = 'Digital Entity'),
    'Subconscious Entity',
    'Extra-dimensional',
    'Dream Realms',
    'Very Rare', 
    'First documented in 2025 by neurologist Dr. Somnia during experimental dream-sharing research',
    2.0, 
    'Negligible (exists primarily in mental space)', 
    'Humanoid figure composed of constantly shifting dreamscapes and memory fragments. Features are fluid and change based on observer''s subconscious. Body appears to be wrapped in flowing fabrics made of dreams that ripple with images from the minds of nearby sleepers.',
    'Dream Manipulation - Can create, alter, and control dreams',
    'Memory Extraction - Can access and visualize memories from sleeping minds',
    'Nightmare Manifestation - Can temporarily bring dream constructs into reality',
    'Logical paradoxes and lucid dreamers can disrupt its control, reducing power by 80%',
    'Dreamweavers exist primarily in the collective unconscious, moving between the dreams of sleeping creatures. They feed on emotional energy generated during dreams and are particularly drawn to vivid dreamers. They communicate through shared dream symbols and can connect the dreams of multiple individuals. They reproduce by cultivating recurring dream patterns that eventually develop consciousness.',
    'The Nightmare Shepherd is an ancient Dreamweaver that has mastered the art of nightmare manipulation. It collects and catalogs fears from across the collective unconscious, but rather than exploiting them, it helps dreamers confront and overcome their deepest terrors. It can maintain dream constructs in the waking world for extended periods and has created a sanctuary where dreams and reality seamlessly blend.'
);

-- Get the monster_id for Dreamweaver
DO $$
DECLARE
    monster_id_val INTEGER;
    stats_id_val INTEGER;
    keyword_id_val INTEGER;
BEGIN
    SELECT monster_id INTO monster_id_val FROM monsters WHERE name = 'Dreamweaver';
    
    -- Insert QuestWorlds stats
    INSERT INTO questworlds_stats (monster_id) VALUES (monster_id_val) RETURNING stats_id INTO stats_id_val;
    
    -- Insert keywords
    INSERT INTO keywords (stats_id, keyword_name, rating, base_value, improvement_points) VALUES
    (stats_id_val, 'Dream Manipulator', 20, 15, 5) RETURNING keyword_id INTO keyword_id_val;
    
    -- Insert abilities for Dream Manipulator
    INSERT INTO abilities (stats_id, keyword_id, ability_name, mastery_value) VALUES
    (stats_id_val, keyword_id_val, 'Nightmare Manifestation', '5M'),
    (stats_id_val, keyword_id_val, 'Dream Alteration', '5M'),
    (stats_id_val, keyword_id_val, 'Dream Creation', '5M');
    
    -- Insert next keyword
    INSERT INTO keywords (stats_id, keyword_name, rating, base_value, improvement_points) VALUES
    (stats_id_val, 'Subconscious Entity', 18, 10, 8) RETURNING keyword_id INTO keyword_id_val;
    
    -- Insert abilities for Subconscious Entity
    INSERT INTO abilities (stats_id, keyword_id, ability_name, mastery_value) VALUES
    (stats_id_val, keyword_id_val, 'Dreamscape Navigation', '3M'),
    (stats_id_val, keyword_id_val, 'Emotional Energy Absorption', '3M'),
    (stats_id_val, keyword_id_val, 'Mental Space Habitation', '3M');
    
    -- Insert next keyword
    INSERT INTO keywords (stats_id, keyword_name, rating, base_value, improvement_points) VALUES
    (stats_id_val, 'Memory Extractor', 17, 10, 7) RETURNING keyword_id INTO keyword_id_val;
    
    -- Insert abilities for Memory Extractor
    INSERT INTO abilities (stats_id, keyword_id, ability_name, mastery_value) VALUES
    (stats_id_val, keyword_id_val, 'Memory Visualization', '2M'),
    (stats_id_val, keyword_id_val, 'Subconscious Connection', '2M'),
    (stats_id_val, keyword_id_val, 'Dream Symbol Interpretation', '2M');
    
    -- Insert flaws
    INSERT INTO flaws (stats_id, flaw_name, rating) VALUES
    (stats_id_val, 'Vulnerability to Logical Paradoxes', 20),
    (stats_id_val, 'Disruption by Lucid Dreamers', 18);
    
    -- Insert augments (Strong Against)
    INSERT INTO augments (monster_id, target_name, modifier) VALUES
    (monster_id_val, 'Sleeping entities', 5),
    (monster_id_val, 'Emotion-based creatures', 5);
    
    -- Insert hindrances (Weak Against)
    INSERT INTO hindrances (monster_id, target_name, modifier) VALUES
    (monster_id_val, 'Logical entities', -5),
    (monster_id_val, 'Reality anchors', -5);
END $$;