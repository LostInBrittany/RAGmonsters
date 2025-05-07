-- SQL Insertion statements for Sandshifter
-- This file contains the SQL commands to insert the Sandshifter monster into the database

-- Insert monster data
INSERT INTO monsters (
    name, category, habitat, rarity, discovery, height, weight, appearance, 
    primary_power, secondary_power, special_ability, weakness, 
    behavior_ecology, notable_specimens
) VALUES (
    'Sandshifter', 
    'Desert Entity', 
    'Vast Deserts', 
    'Common', 
    'First documented in 2023 by geologist Dr. Dune Walker during an expedition to the Great Shifting Sands',
    1.9, 
    '200 kg (mostly compressed sand)', 
    'Humanoid figure composed of constantly shifting sand particles held together by an invisible force. Features are minimal and change frequently, with only its amber crystalline eyes remaining constant. Can alter its density from nearly solid to dispersed cloud.',
    'Sand Manipulation - Control over sand and fine particulates',
    'Erosion Touch - Can gradually break down solid materials into sand',
    'Sandstorm Form - Can transform into a localized sandstorm',
    'Water causes it to become mud-like, reducing mobility by 90%',
    'Sandshifters are nomadic entities that follow desert wind patterns. They are most active during the day when the sand is hot and dry, often becoming dormant at night by merging with the desert floor. They communicate through patterns of vibration sent through sand particles. They reproduce by gathering mineral-rich sand into a core that gradually develops consciousness when exposed to sufficient heat and energy.',
    'The Dune Emperor is an enormous Sandshifter that has existed for centuries, growing to control an entire desert region. It has developed the ability to create complex structures from sand that remain permanently solid, and can sense everything that occurs on the desert surface within its territory.'
);

-- Get the monster_id for Sandshifter
DO $$
DECLARE
    monster_id_val INTEGER;
    stats_id_val INTEGER;
    keyword_id_val INTEGER;
BEGIN
    SELECT monster_id INTO monster_id_val FROM monsters WHERE name = 'Sandshifter';
    
    -- Insert QuestWorlds stats
    INSERT INTO questworlds_stats (monster_id) VALUES (monster_id_val) RETURNING stats_id INTO stats_id_val;
    
    -- Insert keywords
    INSERT INTO keywords (stats_id, keyword_name, rating, base_value, improvement_points) VALUES
    (stats_id_val, 'Sand Manipulator', 20, 15, 5) RETURNING keyword_id INTO keyword_id_val;
    
    -- Insert abilities for Sand Manipulator
    INSERT INTO abilities (stats_id, keyword_id, ability_name, mastery_value) VALUES
    (stats_id_val, keyword_id_val, 'Sandstorm Form', '5M'),
    (stats_id_val, keyword_id_val, 'Density Alteration', '5M'),
    (stats_id_val, keyword_id_val, 'Particulate Manipulation', '5M');
    
    -- Insert next keyword
    INSERT INTO keywords (stats_id, keyword_name, rating, base_value, improvement_points) VALUES
    (stats_id_val, 'Desert Entity', 17, 10, 7) RETURNING keyword_id INTO keyword_id_val;
    
    -- Insert abilities for Desert Entity
    INSERT INTO abilities (stats_id, keyword_id, ability_name, mastery_value) VALUES
    (stats_id_val, keyword_id_val, 'Desert Adaptation', '2M'),
    (stats_id_val, keyword_id_val, 'Heat Resistance', '2M'),
    (stats_id_val, keyword_id_val, 'Surface Merging', '2M');
    
    -- Insert next keyword
    INSERT INTO keywords (stats_id, keyword_name, rating, base_value, improvement_points) VALUES
    (stats_id_val, 'Erosion Master', 18, 10, 8) RETURNING keyword_id INTO keyword_id_val;
    
    -- Insert abilities for Erosion Master
    INSERT INTO abilities (stats_id, keyword_id, ability_name, mastery_value) VALUES
    (stats_id_val, keyword_id_val, 'Erosion Touch', '3M'),
    (stats_id_val, keyword_id_val, 'Material Breakdown', '3M'),
    (stats_id_val, keyword_id_val, 'Surface Weathering', '3M');
    
    -- Insert flaws
    INSERT INTO flaws (stats_id, flaw_name, rating) VALUES
    (stats_id_val, 'Vulnerability to Water', 20),
    (stats_id_val, 'Mud Form Limitations', 18);
    
    -- Insert augments (Strong Against)
    INSERT INTO augments (monster_id, target_name, modifier) VALUES
    (monster_id_val, 'Water creatures', 5),
    (monster_id_val, 'Glass entities', 5);
    
    -- Insert hindrances (Weak Against)
    INSERT INTO hindrances (monster_id, target_name, modifier) VALUES
    (monster_id_val, 'Wind manipulators', -5),
    (monster_id_val, 'Plant controllers', -5);
END $$;