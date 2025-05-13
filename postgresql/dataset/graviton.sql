-- SQL Insertion statements for Graviton
-- This file contains the SQL commands to insert the Graviton monster into the database

-- Insert monster data
INSERT INTO monsters (
    name, category, subcategory, habitat, biome, rarity, discovery, height, weight, appearance, 
    primary_power, secondary_power, special_ability, weakness, 
    behavior_ecology, notable_specimens
) VALUES (
    'Graviton',
    'Anomaly/Phenomenon',
    'Gravitational Anomaly',
    'Extra-dimensional',
    'Gravity Wells',
    'Very Rare', 
    'First detected in 2025 by astrophysicist Dr. Newton Mass during gravitational wave research',
    2.2, 
    'Immeasurable (distorts measurement tools)', 
    'Humanoid silhouette composed of warped space-time. Its body appears as a dark outline with stars visible through its form, but distorted as if viewed through a lens. Small objects orbit around its core in unpredictable patterns.',
    'Gravitokinesis - Manipulation of gravitational forces',
    'Mass Alteration - Can increase or decrease the effective mass of objects',
    'Singularity - Can create a localized gravity well that pulls everything toward it',
    'Exposure to exotic matter disrupts gravitational control, reducing power by 85%',
    'Gravitons are solitary entities that are drawn to areas with unusual gravitational properties, such as the vicinity of black holes or neutron stars. They perceive time differently than other beings, sometimes responding to stimuli before they occur. They communicate through gravitational pulses that can be detected as subtle weight changes. Their reproduction process is theoretical but appears to involve the careful folding of space-time to create a "gravity bud" that eventually develops into a new Graviton.',
    'The Event Horizon is an ancient Graviton that has mastered control over space-time to such a degree that it can create temporary pockets of altered time flow. It resides near a dormant black hole and has developed a philosophical interest in the nature of infinity and cosmic cycles.'
);

-- Get the monster_id for Graviton
DO $$
DECLARE
    monster_id_val INTEGER;
    stats_id_val INTEGER;
    keyword_id_val INTEGER;
BEGIN
    SELECT monster_id INTO monster_id_val FROM monsters WHERE name = 'Graviton';
    
    -- Insert QuestWorlds stats
    INSERT INTO questworlds_stats (monster_id) VALUES (monster_id_val) RETURNING stats_id INTO stats_id_val;
    
    -- Insert keywords
    INSERT INTO keywords (stats_id, keyword_name, rating, base_value, improvement_points) VALUES
    (stats_id_val, 'Gravity Manipulator', 20, 15, 5) RETURNING keyword_id INTO keyword_id_val;
    
    -- Insert abilities for Gravity Manipulator
    INSERT INTO abilities (stats_id, keyword_id, ability_name, mastery_value) VALUES
    (stats_id_val, keyword_id_val, 'Singularity Creation', '5M'),
    (stats_id_val, keyword_id_val, 'Gravitokinesis', '5M'),
    (stats_id_val, keyword_id_val, 'Orbital Manipulation', '5M');
    
    -- Insert next keyword
    INSERT INTO keywords (stats_id, keyword_name, rating, base_value, improvement_points) VALUES
    (stats_id_val, 'Gravitational Anomaly', 18, 10, 8) RETURNING keyword_id INTO keyword_id_val;
    
    -- Insert abilities for Gravitational Anomaly
    INSERT INTO abilities (stats_id, keyword_id, ability_name, mastery_value) VALUES
    (stats_id_val, keyword_id_val, 'Space-Time Distortion', '3M'),
    (stats_id_val, keyword_id_val, 'Gravitational Field Generation', '3M'),
    (stats_id_val, keyword_id_val, 'Anomalous Physics', '3M');
    
    -- Insert next keyword
    INSERT INTO keywords (stats_id, keyword_name, rating, base_value, improvement_points) VALUES
    (stats_id_val, 'Mass Alterer', 17, 10, 7) RETURNING keyword_id INTO keyword_id_val;
    
    -- Insert abilities for Mass Alterer
    INSERT INTO abilities (stats_id, keyword_id, ability_name, mastery_value) VALUES
    (stats_id_val, keyword_id_val, 'Object Mass Modification', '2M'),
    (stats_id_val, keyword_id_val, 'Weight Perception Control', '2M'),
    (stats_id_val, keyword_id_val, 'Gravity Well Navigation', '2M');
    
    -- Insert flaws
    INSERT INTO flaws (stats_id, flaw_name, rating) VALUES
    (stats_id_val, 'Vulnerability to Exotic Matter', 20),
    (stats_id_val, 'Limited Speed', 18);
    
    -- Insert augments (Strong Against)
    INSERT INTO augments (monster_id, target_name, modifier) VALUES
    (monster_id_val, 'Physical creatures', 5),
    (monster_id_val, 'Flying creatures', 5);
    
    -- Insert hindrances (Weak Against)
    INSERT INTO hindrances (monster_id, target_name, modifier) VALUES
    (monster_id_val, 'Energy beings', -5),
    (monster_id_val, 'Quantum entities', -5);
END $$;