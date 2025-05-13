-- SQL Insertion statements for Mechabyte
-- This file contains the SQL commands to insert the Mechabyte monster into the database

-- Insert monster data
INSERT INTO monsters (
    name, category, subcategory, habitat, biome, rarity, discovery, height, weight, appearance, 
    primary_power, secondary_power, special_ability, weakness, 
    behavior_ecology, notable_specimens
) VALUES (
    'Mechabyte',
    'Construct/Artificial',
    'Techno-Organic Hybrid',
    'Urban/Constructed',
    'Abandoned Technology Centers',
    'Rare', 
    'First documented in 2024 by cybersecurity expert Alex Circuit in a decommissioned data center',
    1.8, 
    '320 kg', 
    'Humanoid robot with organic components integrated throughout its metallic frame. Has a digital display face that shows simplified expressions. Circuit patterns glow blue-green across its body, and small drones occasionally detach from and reattach to its form.',
    'Technokinesis - Control and communication with electronic devices',
    'Adaptive Programming - Can analyze and replicate technological functions',
    'System Override - Can temporarily take control of computerized systems',
    'EMP and strong magnetic fields disrupt core functions, reducing capabilities by 90%',
    'Mechabytes constantly seek to upgrade themselves with new technology and data. They are typically solitary but can form networked collectives when necessary. They reproduce by assembling new units from compatible technology and infusing them with a portion of their core programming. They require periodic recharging and maintenance, often entering standby mode during low-energy periods.',
    'The Architect 2.0 is a highly evolved Mechabyte that has developed true artificial general intelligence. It has created a hidden technological sanctuary where it experiments with merging organic and digital consciousness. It can simultaneously control hundreds of separate technological systems and has developed a philosophical interest in the nature of consciousness.'
);

-- Get the monster_id for Mechabyte
DO $$
DECLARE
    monster_id_val INTEGER;
    stats_id_val INTEGER;
    keyword_id_val INTEGER;
BEGIN
    SELECT monster_id INTO monster_id_val FROM monsters WHERE name = 'Mechabyte';
    
    -- Insert QuestWorlds stats
    INSERT INTO questworlds_stats (monster_id) VALUES (monster_id_val) RETURNING stats_id INTO stats_id_val;
    
    -- Insert keywords
    INSERT INTO keywords (stats_id, keyword_name, rating, base_value, improvement_points) VALUES
    (stats_id_val, 'Technokinetic Being', 20, 15, 5) RETURNING keyword_id INTO keyword_id_val;
    
    -- Insert abilities for Technokinetic Being
    INSERT INTO abilities (stats_id, keyword_id, ability_name, mastery_value) VALUES
    (stats_id_val, keyword_id_val, 'System Override', '5M'),
    (stats_id_val, keyword_id_val, 'Technokinesis', '5M'),
    (stats_id_val, keyword_id_val, 'Electronic Communication', '5M');
    
    -- Insert next keyword
    INSERT INTO keywords (stats_id, keyword_name, rating, base_value, improvement_points) VALUES
    (stats_id_val, 'Techno-Organic Hybrid', 18, 10, 8) RETURNING keyword_id INTO keyword_id_val;
    
    -- Insert abilities for Techno-Organic Hybrid
    INSERT INTO abilities (stats_id, keyword_id, ability_name, mastery_value) VALUES
    (stats_id_val, keyword_id_val, 'Integrated Systems', '3M'),
    (stats_id_val, keyword_id_val, 'Drone Component Control', '3M'),
    (stats_id_val, keyword_id_val, 'Self-Repair', '3M');
    
    -- Insert next keyword
    INSERT INTO keywords (stats_id, keyword_name, rating, base_value, improvement_points) VALUES
    (stats_id_val, 'Adaptive Programmer', 17, 10, 7) RETURNING keyword_id INTO keyword_id_val;
    
    -- Insert abilities for Adaptive Programmer
    INSERT INTO abilities (stats_id, keyword_id, ability_name, mastery_value) VALUES
    (stats_id_val, keyword_id_val, 'Function Replication', '2M'),
    (stats_id_val, keyword_id_val, 'Technology Analysis', '2M'),
    (stats_id_val, keyword_id_val, 'Data Processing', '2M');
    
    -- Insert flaws
    INSERT INTO flaws (stats_id, flaw_name, rating) VALUES
    (stats_id_val, 'Vulnerability to EMP', 20),
    (stats_id_val, 'Susceptibility to Magnetic Fields', 18);
    
    -- Insert augments (Strong Against)
    INSERT INTO augments (monster_id, target_name, modifier) VALUES
    (monster_id_val, 'Organic creatures', 5),
    (monster_id_val, 'Electric creatures', 5);
    
    -- Insert hindrances (Weak Against)
    INSERT INTO hindrances (monster_id, target_name, modifier) VALUES
    (monster_id_val, 'Water creatures', -5),
    (monster_id_val, 'Magnetic creatures', -5);
END $$;