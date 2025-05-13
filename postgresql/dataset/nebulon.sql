-- SQL Insertion statements for Nebulon
-- This file contains the SQL commands to insert the Nebulon monster into the database

-- Insert monster data
INSERT INTO monsters (
    name, category, subcategory, habitat, biome, rarity, discovery, height, weight, appearance, 
    primary_power, secondary_power, special_ability, weakness, 
    behavior_ecology, notable_specimens
) VALUES (
    'Nebulon',
    'Celestial/Cosmic',
    'Cosmic Gas Entity',
    'Extra-dimensional',
    'Nebula Clouds',
    'Extremely Rare', 
    'First observed in 2025 by astrophysicist Dr. Nova Stardust using specialized spectral imaging',
    3.0, 
    '10 kg (mostly diffuse gas)', 
    'Amorphous cloud-like entity composed of colorful cosmic gases that swirl and pulse with internal energy. Core contains denser matter that glows with bioluminescent light in blues, purples, and pinks. Can form temporary appendages from concentrated gas.',
    'Gas Manipulation - Control over gaseous matter and its properties',
    'Nebula Mimicry - Can blend perfectly with cosmic gas clouds',
    'Stellar Seeding - Can initiate the formation of new stars within suitable gas clouds',
    'Strong magnetic fields disrupt its cohesion, reducing form stability by 80%',
    'Nebulons exist primarily in the vast gas clouds of interstellar space, though rare specimens have adapted to planetary atmospheres. They feed on radiation and stellar energy, growing more vibrant when exposed to cosmic rays. They communicate through patterns of gas density and chemical signatures that can be detected across vast distances. Their reproduction involves carefully cultivating specific gas mixtures that eventually develop consciousness.',
    'The Stellar Gardener is an ancient Nebulon that has mastered the art of star formation, creating a nursery of young stars within its home nebula. It has developed the ability to predict stellar lifecycles with perfect accuracy and can temporarily merge with stars to influence their development.'
);

-- Get the monster_id for Nebulon
DO $$
DECLARE
    monster_id_val INTEGER;
    stats_id_val INTEGER;
    keyword_id_val INTEGER;
BEGIN
    SELECT monster_id INTO monster_id_val FROM monsters WHERE name = 'Nebulon';
    
    -- Insert QuestWorlds stats
    INSERT INTO questworlds_stats (monster_id) VALUES (monster_id_val) RETURNING stats_id INTO stats_id_val;
    
    -- Insert keywords
    INSERT INTO keywords (stats_id, keyword_name, rating, base_value, improvement_points) VALUES
    (stats_id_val, 'Gas Manipulator', 20, 15, 5) RETURNING keyword_id INTO keyword_id_val;
    
    -- Insert abilities for Gas Manipulator
    INSERT INTO abilities (stats_id, keyword_id, ability_name, mastery_value) VALUES
    (stats_id_val, keyword_id_val, 'Gas Property Control', '5M'),
    (stats_id_val, keyword_id_val, 'Density Manipulation', '5M'),
    (stats_id_val, keyword_id_val, 'Chemical Composition Alteration', '5M');
    
    -- Insert next keyword
    INSERT INTO keywords (stats_id, keyword_name, rating, base_value, improvement_points) VALUES
    (stats_id_val, 'Cosmic Gas Entity', 18, 10, 8) RETURNING keyword_id INTO keyword_id_val;
    
    -- Insert abilities for Cosmic Gas Entity
    INSERT INTO abilities (stats_id, keyword_id, ability_name, mastery_value) VALUES
    (stats_id_val, keyword_id_val, 'Nebula Mimicry', '3M'),
    (stats_id_val, keyword_id_val, 'Gaseous Form Adaptation', '3M'),
    (stats_id_val, keyword_id_val, 'Radiation Absorption', '3M');
    
    -- Insert next keyword
    INSERT INTO keywords (stats_id, keyword_name, rating, base_value, improvement_points) VALUES
    (stats_id_val, 'Stellar Influencer', 17, 10, 7) RETURNING keyword_id INTO keyword_id_val;
    
    -- Insert abilities for Stellar Influencer
    INSERT INTO abilities (stats_id, keyword_id, ability_name, mastery_value) VALUES
    (stats_id_val, keyword_id_val, 'Stellar Seeding', '2M'),
    (stats_id_val, keyword_id_val, 'Energy Pattern Creation', '2M'),
    (stats_id_val, keyword_id_val, 'Cosmic Ray Channeling', '2M');
    
    -- Insert flaws
    INSERT INTO flaws (stats_id, flaw_name, rating) VALUES
    (stats_id_val, 'Vulnerability to Magnetic Fields', 20),
    (stats_id_val, 'Form Instability', 18);
    
    -- Insert augments (Strong Against)
    INSERT INTO augments (monster_id, target_name, modifier) VALUES
    (monster_id_val, 'Oxygen-dependent creatures', 5),
    (monster_id_val, 'Fire entities', 5);
    
    -- Insert hindrances (Weak Against)
    INSERT INTO hindrances (monster_id, target_name, modifier) VALUES
    (monster_id_val, 'Vacuum manipulators', -5),
    (monster_id_val, 'Gravity controllers', -5);
END $$;