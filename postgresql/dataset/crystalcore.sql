-- SQL Insertion statements for Crystalcore
-- This file contains the SQL commands to insert the Crystalcore monster into the database

-- Insert monster data
INSERT INTO monsters (
    name, category, habitat, rarity, discovery, height, weight, appearance, 
    primary_power, secondary_power, special_ability, weakness, 
    behavior_ecology, notable_specimens
) VALUES (
    'Crystalcore', 
    'Mineral Construct', 
    'Crystal Caverns', 
    'Uncommon', 
    'Discovered in 2023 by gemologist Petra Quartz during a deep cave expedition',
    1.9, 
    '750 kg', 
    'Humanoid figure composed of interlocking geometric crystal formations. Core is a pulsating multi-colored geode that shifts hues based on energy levels. Surface crystals refract light, creating rainbow patterns around it.',
    'Crystallokinesis - Control and generation of crystal structures',
    'Light Refraction - Can bend light to create illusions or focused energy beams',
    'Prismatic Burst - Releases stored energy as a rainbow-spectrum blast',
    'Sonic attacks can cause resonance fractures, reducing structural integrity by 65%',
    'Crystalcores are sedentary beings that grow slowly over decades by absorbing mineral-rich water and ambient energy. They communicate through harmonic vibrations in their crystal lattice. When threatened, they can enter a dormant state, appearing as ordinary crystal formations until danger passes.',
    'The Radiant Architect is an ancient Crystalcore that has developed consciousness over centuries of absorbing various energy types. It can reshape entire cave systems and has created an underground crystal city with geometric precision. Its core contains rare elements not found elsewhere on Earth.'
);

-- Get the monster_id for Crystalcore
DO $$
DECLARE
    monster_id_val INTEGER;
    stats_id_val INTEGER;
    keyword_id_val INTEGER;
BEGIN
    SELECT monster_id INTO monster_id_val FROM monsters WHERE name = 'Crystalcore';
    
    -- Insert QuestWorlds stats
    INSERT INTO questworlds_stats (monster_id) VALUES (monster_id_val) RETURNING stats_id INTO stats_id_val;
    
    -- Insert keywords
    INSERT INTO keywords (stats_id, keyword_name, rating, base_value, improvement_points) VALUES
    (stats_id_val, 'Crystal Manipulator', 20, 15, 5) RETURNING keyword_id INTO keyword_id_val;
    
    -- Insert abilities for Crystal Manipulator
    INSERT INTO abilities (stats_id, keyword_id, ability_name, mastery_value) VALUES
    (stats_id_val, keyword_id_val, 'Crystallokinesis', '5M'),
    (stats_id_val, keyword_id_val, 'Crystal Generation', '5M'),
    (stats_id_val, keyword_id_val, 'Structural Manipulation', '5M');
    
    -- Insert next keyword
    INSERT INTO keywords (stats_id, keyword_name, rating, base_value, improvement_points) VALUES
    (stats_id_val, 'Mineral Construct', 18, 10, 8) RETURNING keyword_id INTO keyword_id_val;
    
    -- Insert abilities for Mineral Construct
    INSERT INTO abilities (stats_id, keyword_id, ability_name, mastery_value) VALUES
    (stats_id_val, keyword_id_val, 'Crystal Body Resilience', '3M'),
    (stats_id_val, keyword_id_val, 'Geometric Formation', '3M'),
    (stats_id_val, keyword_id_val, 'Mineral Absorption', '3M');
    
    -- Insert next keyword
    INSERT INTO keywords (stats_id, keyword_name, rating, base_value, improvement_points) VALUES
    (stats_id_val, 'Light Refractor', 17, 10, 7) RETURNING keyword_id INTO keyword_id_val;
    
    -- Insert abilities for Light Refractor
    INSERT INTO abilities (stats_id, keyword_id, ability_name, mastery_value) VALUES
    (stats_id_val, keyword_id_val, 'Prismatic Burst', '2M'),
    (stats_id_val, keyword_id_val, 'Illusion Creation', '2M'),
    (stats_id_val, keyword_id_val, 'Energy Beam Focus', '2M');
    
    -- Insert flaws
    INSERT INTO flaws (stats_id, flaw_name, rating) VALUES
    (stats_id_val, 'Vulnerability to Sonic Attacks', 20),
    (stats_id_val, 'Limited Mobility', 18);
    
    -- Insert augments (Strong Against)
    INSERT INTO augments (monster_id, target_name, modifier) VALUES
    (monster_id_val, 'Electric creatures', 5),
    (monster_id_val, 'Physical attackers', 5);
    
    -- Insert hindrances (Weak Against)
    INSERT INTO hindrances (monster_id, target_name, modifier) VALUES
    (monster_id_val, 'Sonic creatures', -5),
    (monster_id_val, 'Earth manipulators', -5);
END $$;