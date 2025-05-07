-- SQL Insertion statements for Lumiglow
-- This file contains the SQL commands to insert the Lumiglow monster into the database

-- Insert monster data
INSERT INTO monsters (
    name, category, habitat, rarity, discovery, height, weight, appearance, 
    primary_power, secondary_power, special_ability, weakness, 
    behavior_ecology, notable_specimens
) VALUES (
    'Lumiglow', 
    'Light Elemental', 
    'Aurora Fields', 
    'Uncommon', 
    'First documented in 2024 by physicist Dr. Ray Prism during a study of unusual light phenomena',
    1.6, 
    '5 kg (mostly energy)', 
    'Humanoid figure composed of brilliant, shifting light in all colors of the spectrum. Core is a concentrated white light that pulses with its heartbeat. Features are suggested rather than defined, with limbs that trail into wisps of colored light.',
    'Photokinesis - Control and generation of light energy',
    'Chromatic Shift - Can alter the wavelength of light, changing colors and properties',
    'Solar Flare - Can release a blinding burst of concentrated light energy',
    'Darkness and void energy can absorb its form, reducing power by 75%',
    'Lumiglows are drawn to sources of natural light, particularly auroras, bioluminescence, and solar phenomena. They communicate through pulses of colored light that form complex patterns. They feed on ambient light energy and can enter a dormant state during extended periods of darkness. They reproduce by splitting off portions of their light energy during particularly intense light events.',
    'The Prismatic Sage is an ancient Lumiglow that has learned to manipulate light at the quantum level. It can create holographic projections of past events it has witnessed and has developed the ability to bend light around itself, becoming effectively invisible. It serves as a keeper of knowledge, recording events through light impressions.'
);

-- Get the monster_id for Lumiglow
DO $$
DECLARE
    monster_id_val INTEGER;
    stats_id_val INTEGER;
    keyword_id_val INTEGER;
BEGIN
    SELECT monster_id INTO monster_id_val FROM monsters WHERE name = 'Lumiglow';
    
    -- Insert QuestWorlds stats
    INSERT INTO questworlds_stats (monster_id) VALUES (monster_id_val) RETURNING stats_id INTO stats_id_val;
    
    -- Insert keywords
    INSERT INTO keywords (stats_id, keyword_name, rating, base_value, improvement_points) VALUES
    (stats_id_val, 'Photon Manipulator', 20, 15, 5) RETURNING keyword_id INTO keyword_id_val;
    
    -- Insert abilities for Photon Manipulator
    INSERT INTO abilities (stats_id, keyword_id, ability_name, mastery_value) VALUES
    (stats_id_val, keyword_id_val, 'Solar Flare', '5M'),
    (stats_id_val, keyword_id_val, 'Photokinesis', '5M'),
    (stats_id_val, keyword_id_val, 'Light Beam Projection', '5M');
    
    -- Insert next keyword
    INSERT INTO keywords (stats_id, keyword_name, rating, base_value, improvement_points) VALUES
    (stats_id_val, 'Light Elemental', 18, 10, 8) RETURNING keyword_id INTO keyword_id_val;
    
    -- Insert abilities for Light Elemental
    INSERT INTO abilities (stats_id, keyword_id, ability_name, mastery_value) VALUES
    (stats_id_val, keyword_id_val, 'Energy Form Adaptation', '3M'),
    (stats_id_val, keyword_id_val, 'Light Absorption', '3M'),
    (stats_id_val, keyword_id_val, 'Luminous Presence', '3M');
    
    -- Insert next keyword
    INSERT INTO keywords (stats_id, keyword_name, rating, base_value, improvement_points) VALUES
    (stats_id_val, 'Chromatic Controller', 17, 10, 7) RETURNING keyword_id INTO keyword_id_val;
    
    -- Insert abilities for Chromatic Controller
    INSERT INTO abilities (stats_id, keyword_id, ability_name, mastery_value) VALUES
    (stats_id_val, keyword_id_val, 'Chromatic Shift', '2M'),
    (stats_id_val, keyword_id_val, 'Color Manipulation', '2M'),
    (stats_id_val, keyword_id_val, 'Light Pattern Communication', '2M');
    
    -- Insert flaws
    INSERT INTO flaws (stats_id, flaw_name, rating) VALUES
    (stats_id_val, 'Vulnerability to Darkness', 20),
    (stats_id_val, 'Insubstantial Form Fragility', 18);
    
    -- Insert augments (Strong Against)
    INSERT INTO augments (monster_id, target_name, modifier) VALUES
    (monster_id_val, 'Shadow creatures', 5),
    (monster_id_val, 'Plant creatures', 5);
    
    -- Insert hindrances (Weak Against)
    INSERT INTO hindrances (monster_id, target_name, modifier) VALUES
    (monster_id_val, 'Void creatures', -5),
    (monster_id_val, 'Darkness manipulators', -5);
END $$;