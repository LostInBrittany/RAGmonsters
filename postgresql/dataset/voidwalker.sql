-- SQL Insertion statements for Voidwalker
-- This file contains the SQL commands to insert the Voidwalker monster into the database

-- Insert monster data
INSERT INTO monsters (
    name, category, subcategory, habitat, biome, rarity, discovery, height, weight, appearance, 
    primary_power, secondary_power, special_ability, weakness, 
    behavior_ecology, notable_specimens
) VALUES (
    'Voidwalker',
    'Celestial/Cosmic',
    'Cosmic Entity',
    'Extra-dimensional',
    'Interstellar Void',
    'Extremely Rare', 
    'First detected in 2025 by astronomer Dr. Stella Cosmos during observations of an unusual stellar phenomenon',
    2.5, 
    'Negligible (exists partially in higher dimensions)', 
    'Humanoid silhouette composed of what appears to be a slice of deep space. Its body contains swirling galaxies, nebulae, and stars that move independently of its actions. Eyes appear as bright quasar-like points of intense light.',
    'Void Manipulation - Control over empty space and cosmic energies',
    'Stellar Channeling - Can harness and direct the energy of stars',
    'Cosmic Step - Can traverse vast distances by folding space',
    'Planetary gravitational fields constrain abilities, reducing power by 70% on Earth-like worlds',
    'Voidwalkers are nomadic entities that travel between star systems, drawn to unusual cosmic phenomena. They perceive reality on multiple dimensional levels simultaneously and communicate through patterns of stellar energy that can be observed as unusual astronomical events. Their life cycle spans millions of years, with reproduction occurring during rare cosmic alignments when they can channel enough energy to split their consciousness.',
    'The Celestial Observer is an ancient Voidwalker that has witnessed the birth and death of countless stars. It has developed the ability to accelerate or decelerate stellar life cycles and maintains a "garden" of unusual star systems throughout the galaxy. It occasionally makes contact with advanced civilizations to share cosmic knowledge.'
);

-- Get the monster_id for Voidwalker
DO $$
DECLARE
    monster_id_val INTEGER;
    stats_id_val INTEGER;
    keyword_id_val INTEGER;
BEGIN
    SELECT monster_id INTO monster_id_val FROM monsters WHERE name = 'Voidwalker';
    
    -- Insert QuestWorlds stats
    INSERT INTO questworlds_stats (monster_id) VALUES (monster_id_val) RETURNING stats_id INTO stats_id_val;
    
    -- Insert keywords
    INSERT INTO keywords (stats_id, keyword_name, rating, base_value, improvement_points) VALUES
    (stats_id_val, 'Void Manipulator', 20, 15, 5) RETURNING keyword_id INTO keyword_id_val;
    
    -- Insert abilities for Void Manipulator
    INSERT INTO abilities (stats_id, keyword_id, ability_name, mastery_value) VALUES
    (stats_id_val, keyword_id_val, 'Void Control', '5M'),
    (stats_id_val, keyword_id_val, 'Space Folding', '5M'),
    (stats_id_val, keyword_id_val, 'Cosmic Energy Manipulation', '5M');
    
    -- Insert next keyword
    INSERT INTO keywords (stats_id, keyword_name, rating, base_value, improvement_points) VALUES
    (stats_id_val, 'Cosmic Entity', 17, 10, 7) RETURNING keyword_id INTO keyword_id_val;
    
    -- Insert abilities for Cosmic Entity
    INSERT INTO abilities (stats_id, keyword_id, ability_name, mastery_value) VALUES
    (stats_id_val, keyword_id_val, 'Cosmic Step', '2M'),
    (stats_id_val, keyword_id_val, 'Higher Dimensional Existence', '2M'),
    (stats_id_val, keyword_id_val, 'Multi-Dimensional Perception', '2M');
    
    -- Insert next keyword
    INSERT INTO keywords (stats_id, keyword_name, rating, base_value, improvement_points) VALUES
    (stats_id_val, 'Stellar Channel', 18, 10, 8) RETURNING keyword_id INTO keyword_id_val;
    
    -- Insert abilities for Stellar Channel
    INSERT INTO abilities (stats_id, keyword_id, ability_name, mastery_value) VALUES
    (stats_id_val, keyword_id_val, 'Stellar Energy Harnessing', '3M'),
    (stats_id_val, keyword_id_val, 'Star Connection', '3M'),
    (stats_id_val, keyword_id_val, 'Celestial Communication', '3M');
    
    -- Insert flaws
    INSERT INTO flaws (stats_id, flaw_name, rating) VALUES
    (stats_id_val, 'Gravitational Constraint', 20),
    (stats_id_val, 'Dimensional Anchoring', 18);
    
    -- Insert augments (Strong Against)
    INSERT INTO augments (monster_id, target_name, modifier) VALUES
    (monster_id_val, 'Elemental creatures', 5),
    (monster_id_val, 'Physical entities', 5);
    
    -- Insert hindrances (Weak Against)
    INSERT INTO hindrances (monster_id, target_name, modifier) VALUES
    (monster_id_val, 'Reality anchors', -5),
    (monster_id_val, 'Dimensional binders', -5);
END $$;