-- SQL Insertion statements for Shadowrift
-- This file contains the SQL commands to insert the Shadowrift monster into the database

-- Insert monster data
INSERT INTO monsters (
    name, category, subcategory, habitat, biome, rarity, discovery, height, weight, appearance, 
    primary_power, secondary_power, special_ability, weakness, 
    behavior_ecology, notable_specimens
) VALUES (
    'Shadowrift',
    'Celestial/Cosmic',
    'Void Entity',
    'Extra-dimensional',
    'Dark Dimensions',
    'Very Rare', 
    'First documented by paranormal researcher Dr. Nyx Umbra in 2025 during the Midnight Eclipse',
    2.5, 
    'Negligible (exists partially outside physical space)', 
    'Humanoid silhouette composed of swirling darkness with star-like points of purple light throughout its form. Features shift constantly, with only its glowing white eyes remaining fixed.',
    'Umbramancy - Manipulation of shadows and darkness',
    'Dimensional Phasing - Can partially exist between dimensions',
    'Void Step - Can teleport between shadows within line of sight',
    'Intense light sources disrupt form, reducing cohesion by 75%',
    'Shadowrifts are solitary entities that avoid direct interaction with physical beings. They feed on ambient emotional energy, particularly fear and wonder. They are most active during astronomical events that create unique shadow patterns. Their reproduction is poorly understood but appears to involve the fragmentation of their consciousness during dimensional stress events.',
    'The Midnight Oracle is an ancient Shadowrift that has achieved a stable connection between dimensions. It can perceive possible futures and communicates through abstract visions. Those who find it and offer rare knowledge may receive cryptic prophecies in return.'
);

-- Get the monster_id for Shadowrift
DO $$
DECLARE
    monster_id_val INTEGER;
    stats_id_val INTEGER;
    keyword_id_val INTEGER;
BEGIN
    SELECT monster_id INTO monster_id_val FROM monsters WHERE name = 'Shadowrift';
    
    -- Insert QuestWorlds stats
    INSERT INTO questworlds_stats (monster_id) VALUES (monster_id_val) RETURNING stats_id INTO stats_id_val;
    
    -- Insert keywords
    INSERT INTO keywords (stats_id, keyword_name, rating, base_value, improvement_points) VALUES
    (stats_id_val, 'Shadow Manipulator', 20, 15, 5) RETURNING keyword_id INTO keyword_id_val;
    
    -- Insert abilities for Shadow Manipulator
    INSERT INTO abilities (stats_id, keyword_id, ability_name, mastery_value) VALUES
    (stats_id_val, keyword_id_val, 'Umbramancy', '5M'),
    (stats_id_val, keyword_id_val, 'Shadow Control', '5M'),
    (stats_id_val, keyword_id_val, 'Darkness Generation', '5M');
    
    -- Insert next keyword
    INSERT INTO keywords (stats_id, keyword_name, rating, base_value, improvement_points) VALUES
    (stats_id_val, 'Void Entity', 17, 10, 7) RETURNING keyword_id INTO keyword_id_val;
    
    -- Insert abilities for Void Entity
    INSERT INTO abilities (stats_id, keyword_id, ability_name, mastery_value) VALUES
    (stats_id_val, keyword_id_val, 'Void Step', '2M'),
    (stats_id_val, keyword_id_val, 'Extradimensional Existence', '2M'),
    (stats_id_val, keyword_id_val, 'Dark Energy Absorption', '2M');
    
    -- Insert next keyword
    INSERT INTO keywords (stats_id, keyword_name, rating, base_value, improvement_points) VALUES
    (stats_id_val, 'Dimensional Phaser', 18, 10, 8) RETURNING keyword_id INTO keyword_id_val;
    
    -- Insert abilities for Dimensional Phaser
    INSERT INTO abilities (stats_id, keyword_id, ability_name, mastery_value) VALUES
    (stats_id_val, keyword_id_val, 'Dimensional Phasing', '3M'),
    (stats_id_val, keyword_id_val, 'Reality Boundary Crossing', '3M'),
    (stats_id_val, keyword_id_val, 'Void Perception', '3M');
    
    -- Insert flaws
    INSERT INTO flaws (stats_id, flaw_name, rating) VALUES
    (stats_id_val, 'Vulnerability to Intense Light', 20),
    (stats_id_val, 'Form Instability', 18);
    
    -- Insert augments (Strong Against)
    INSERT INTO augments (monster_id, target_name, modifier) VALUES
    (monster_id_val, 'Light creatures', 5),
    (monster_id_val, 'Psychic creatures', 5);
    
    -- Insert hindrances (Weak Against)
    INSERT INTO hindrances (monster_id, target_name, modifier) VALUES
    (monster_id_val, 'Radiant creatures', -5),
    (monster_id_val, 'Reality-anchored creatures', -5);
END $$;