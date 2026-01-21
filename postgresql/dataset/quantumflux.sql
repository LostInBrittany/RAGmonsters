-- SQL Insertion statements for Quantumflux
-- This file contains the SQL commands to insert the Quantumflux monster into the database

-- Set search path to ragmonsters schema
SET search_path TO ragmonsters, public;

-- Insert monster data
INSERT INTO monsters (
    name, subcategory_id, monster_type, habitat, biome, rarity, discovery, height, weight, appearance, 
    primary_power, secondary_power, special_ability, weakness, 
    behavior_ecology, notable_specimens
) VALUES (
    'Quantumflux',
    (SELECT subcategory_id FROM subcategories WHERE subcategory_name = 'Anomaly'),
    'Quantum Anomaly',
    'Extra-dimensional',
    'Probability Nexuses',
    'Extremely Rare', 
    'First detected in 2025 by quantum physicist Dr. Heisen Berg during a particle superposition experiment',
    0, 
    'Fluctuating (follows uncertainty principles)', 
    'Humanoid figure that exists in multiple states simultaneously, appearing blurred and indistinct as it shifts between possible forms. Body composed of particles that constantly phase between matter and energy, with wave-like patterns flowing throughout its form.',
    'Quantum Manipulation - Can influence probability and quantum states',
    'Superposition - Can exist in multiple locations simultaneously',
    'Entanglement - Can quantum-link with other entities to share information instantly',
    'Observation by multiple conscious beings forces it into a single state, reducing abilities by 85%',
    'Quantumfluxes exist in a state of perpetual possibility, perceiving all potential outcomes simultaneously. They are drawn to areas where reality is thin or where probability behaves unusually. They communicate through quantum information that appears as intuitive understanding rather than language. Their reproduction involves creating quantum entangled "offspring" that gradually develop independent wave functions.',
    'The Possibility Engine is a unique Quantumflux that has learned to manipulate probability on a macroscopic scale. It exists in a self-created pocket dimension where all possible outcomes occur simultaneously, and it can selectively collapse wave functions to bring specific possibilities into the primary reality.'
);

-- Get the monster_id for Quantumflux
DO $$
DECLARE
    monster_id_val INTEGER;
    stats_id_val INTEGER;
    keyword_id_val INTEGER;
BEGIN
    SELECT monster_id INTO monster_id_val FROM monsters WHERE name = 'Quantumflux';
    
    -- Insert QuestWorlds stats
    INSERT INTO questworlds_stats (monster_id) VALUES (monster_id_val) RETURNING stats_id INTO stats_id_val;
    
    -- Insert keywords
    INSERT INTO keywords (stats_id, keyword_name, rating, base_value, improvement_points) VALUES
    (stats_id_val, 'Probability Manipulator', 20, 15, 5) RETURNING keyword_id INTO keyword_id_val;
    
    -- Insert abilities for Probability Manipulator
    INSERT INTO abilities (stats_id, keyword_id, ability_name, mastery_value) VALUES
    (stats_id_val, keyword_id_val, 'Entanglement', '5M'),
    (stats_id_val, keyword_id_val, 'Probability Alteration', '5M'),
    (stats_id_val, keyword_id_val, 'Quantum Information Processing', '5M');
    
    -- Insert next keyword
    INSERT INTO keywords (stats_id, keyword_name, rating, base_value, improvement_points) VALUES
    (stats_id_val, 'Quantum Anomaly', 17, 10, 7) RETURNING keyword_id INTO keyword_id_val;
    
    -- Insert abilities for Quantum Anomaly
    INSERT INTO abilities (stats_id, keyword_id, ability_name, mastery_value) VALUES
    (stats_id_val, keyword_id_val, 'Quantum State Manipulation', '2M'),
    (stats_id_val, keyword_id_val, 'Wave Function Navigation', '2M'),
    (stats_id_val, keyword_id_val, 'Reality Flux Adaptation', '2M');
    
    -- Insert next keyword
    INSERT INTO keywords (stats_id, keyword_name, rating, base_value, improvement_points) VALUES
    (stats_id_val, 'Superposition Entity', 18, 10, 8) RETURNING keyword_id INTO keyword_id_val;
    
    -- Insert abilities for Superposition Entity
    INSERT INTO abilities (stats_id, keyword_id, ability_name, mastery_value) VALUES
    (stats_id_val, keyword_id_val, 'Simultaneous Existence', '3M'),
    (stats_id_val, keyword_id_val, 'Phase Shifting', '3M'),
    (stats_id_val, keyword_id_val, 'Quantum Tunneling', '3M');
    
    -- Insert flaws
    INSERT INTO flaws (stats_id, flaw_name, rating) VALUES
    (stats_id_val, 'Vulnerability to Observation', 20),
    (stats_id_val, 'State Collapse Under Scrutiny', 18);
    
    -- Insert augments (Strong Against)
    INSERT INTO augments (monster_id, target_name, modifier) VALUES
    (monster_id_val, 'Time manipulators', 5),
    (monster_id_val, 'Reality benders', 5);
    
    -- Insert hindrances (Weak Against)
    INSERT INTO hindrances (monster_id, target_name, modifier) VALUES
    (monster_id_val, 'Hive minds', -5),
    (monster_id_val, 'Multiple observers', -5);
END $$;