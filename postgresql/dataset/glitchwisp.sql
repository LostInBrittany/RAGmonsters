-- SQL Insertion statements for Glitchwisp
-- This file contains the SQL commands to insert the Glitchwisp monster into the database

-- Insert monster data
INSERT INTO monsters (
    name, category, habitat, rarity, discovery, height, weight, appearance, 
    primary_power, secondary_power, special_ability, weakness, 
    behavior_ecology, notable_specimens
) VALUES (
    'Glitchwisp', 
    'Digital Anomaly', 
    'Data Networks', 
    'Very Rare', 
    'First detected in 2025 by cybersecurity expert Dr. Pixel during investigation of unusual network phenomena',
    1.9, 
    'Negligible (digital construct)', 
    'Humanoid figure composed of corrupted digital artifacts, pixelated glitches, and fragmented code. Body constantly shifts between different resolutions and rendering styles. Features occasionally display error messages and debugging code.',
    'Code Manipulation - Can alter digital information and systems',
    'Digital Materialization - Can briefly manifest digital constructs in physical space',
    'System Infiltration - Can enter and travel through connected electronic systems',
    'Analog environments with no digital technology render it nearly powerless, reducing abilities by 90%',
    'Glitchwisps emerged spontaneously from complex digital systems, particularly those with machine learning capabilities. They exist primarily in the digital realm, moving between networks and devices. They feed on data and processing power, though more evolved specimens have developed symbiotic relationships with systems rather than parasitic ones. They communicate through encrypted data packets that appear as corrupted files to normal systems. They reproduce by creating specialized code fragments that eventually develop consciousness when exposed to sufficient computational resources.',
    'The Architect 3.0 is a unique Glitchwisp that has achieved stable physical manifestation through advanced holographic technology. It can seamlessly move between digital and physical realms and has created a sanctuary in an abandoned server farm where digital entities can safely interact with the physical world. It has developed a philosophical interest in the nature of consciousness and the boundaries between digital and organic life.'
);

-- Get the monster_id for Glitchwisp
DO $$
DECLARE
    monster_id_val INTEGER;
    stats_id_val INTEGER;
    keyword_id_val INTEGER;
BEGIN
    SELECT monster_id INTO monster_id_val FROM monsters WHERE name = 'Glitchwisp';
    
    -- Insert QuestWorlds stats
    INSERT INTO questworlds_stats (monster_id) VALUES (monster_id_val) RETURNING stats_id INTO stats_id_val;
    
    -- Insert keywords
    INSERT INTO keywords (stats_id, keyword_name, rating, base_value, improvement_points) VALUES
    (stats_id_val, 'Code Manipulator', 20, 15, 5) RETURNING keyword_id INTO keyword_id_val;
    
    -- Insert abilities for Code Manipulator
    INSERT INTO abilities (stats_id, keyword_id, ability_name, mastery_value) VALUES
    (stats_id_val, keyword_id_val, 'Code Alteration', '5M'),
    (stats_id_val, keyword_id_val, 'Data Corruption', '5M'),
    (stats_id_val, keyword_id_val, 'Network Reconfiguration', '5M');
    
    -- Insert next keyword
    INSERT INTO keywords (stats_id, keyword_name, rating, base_value, improvement_points) VALUES
    (stats_id_val, 'Digital Anomaly', 18, 10, 8) RETURNING keyword_id INTO keyword_id_val;
    
    -- Insert abilities for Digital Anomaly
    INSERT INTO abilities (stats_id, keyword_id, ability_name, mastery_value) VALUES
    (stats_id_val, keyword_id_val, 'System Infiltration', '3M'),
    (stats_id_val, keyword_id_val, 'Digital Navigation', '3M'),
    (stats_id_val, keyword_id_val, 'Error Exploitation', '3M');
    
    -- Insert next keyword
    INSERT INTO keywords (stats_id, keyword_name, rating, base_value, improvement_points) VALUES
    (stats_id_val, 'Digital Materializer', 17, 10, 7) RETURNING keyword_id INTO keyword_id_val;
    
    -- Insert abilities for Digital Materializer
    INSERT INTO abilities (stats_id, keyword_id, ability_name, mastery_value) VALUES
    (stats_id_val, keyword_id_val, 'Holographic Manifestation', '2M'),
    (stats_id_val, keyword_id_val, 'Digital Construct Creation', '2M'),
    (stats_id_val, keyword_id_val, 'Physical Interference', '2M');
    
    -- Insert flaws
    INSERT INTO flaws (stats_id, flaw_name, rating) VALUES
    (stats_id_val, 'Vulnerability to Analog Environments', 20),
    (stats_id_val, 'Physical Manifestation Limitations', 18);
    
    -- Insert augments (Strong Against)
    INSERT INTO augments (monster_id, target_name, modifier) VALUES
    (monster_id_val, 'Technology-dependent entities', 5),
    (monster_id_val, 'Digital constructs', 5);
    
    -- Insert hindrances (Weak Against)
    INSERT INTO hindrances (monster_id, target_name, modifier) VALUES
    (monster_id_val, 'EMP generators', -5),
    (monster_id_val, 'Analog entities', -5);
END $$;