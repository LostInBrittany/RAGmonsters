-- SQL Insertion statements for Flameburst
-- This file contains the SQL commands to insert the Flameburst monster into the database

-- Set search path to ragmonsters schema
SET search_path TO ragmonsters, public;

-- Insert monster data
INSERT INTO monsters (
    name, subcategory_id, monster_type, habitat, biome, rarity, discovery, height, weight, appearance, 
    primary_power, secondary_power, special_ability, weakness, 
    behavior_ecology, notable_specimens
) VALUES (
    'Flameburst',
    (SELECT subcategory_id FROM subcategories WHERE subcategory_name = 'Elemental Being'),
    'Elemental Beast',
    'Volcanic/Geothermal',
    'Volcanic Mountains',
    'Rare', 
    'First documented in the Ember Peaks by explorer Jax Fireheart in 2024',
    2.3, 
    '450 kg', 
    'Reptilian quadruped with obsidian scales and magma-filled cracks across its body. Three horns protrude from its skull, glowing with internal heat.',
    'Magma Manipulation - Can control and generate molten rock',
    'Heat Aura - Maintains a 10-meter radius of intense heat',
    'Volcanic Burst - Once per day, can create a small volcanic eruption',
    'Water-based attacks reduce power output by 60%',
    'Flameburst creatures are solitary and territorial. They mark their territory with patches of scorched earth and small lava pools. They hibernate for three months during winter, burying themselves deep underground near magma chambers.',
    'The largest known Flameburst, nicknamed "Krakatoa," resides in the Crimson Caldera and is estimated to be over 200 years old with significantly higher combat statistics than average specimens.'
);

-- Get the monster_id for Flameburst
DO $$
DECLARE
    monster_id_val INTEGER;
    stats_id_val INTEGER;
    keyword_id_val INTEGER;
BEGIN
    SELECT monster_id INTO monster_id_val FROM monsters WHERE name = 'Flameburst';
    
    -- Insert QuestWorlds stats
    INSERT INTO questworlds_stats (monster_id) VALUES (monster_id_val) RETURNING stats_id INTO stats_id_val;
    
    -- Insert keywords
    INSERT INTO keywords (stats_id, keyword_name, rating, base_value, improvement_points) VALUES
    (stats_id_val, 'Magma Manipulator', 20, 15, 5) RETURNING keyword_id INTO keyword_id_val;
    
    -- Insert abilities for Magma Manipulator
    INSERT INTO abilities (stats_id, keyword_id, ability_name, mastery_value) VALUES
    (stats_id_val, keyword_id_val, 'Volcanic Burst', '5M'),
    (stats_id_val, keyword_id_val, 'Molten Rock Control', '5M'),
    (stats_id_val, keyword_id_val, 'Lava Pool Creation', '5M');
    
    -- Insert next keyword
    INSERT INTO keywords (stats_id, keyword_name, rating, base_value, improvement_points) VALUES
    (stats_id_val, 'Elemental Beast', 18, 10, 8) RETURNING keyword_id INTO keyword_id_val;
    
    -- Insert abilities for Elemental Beast
    INSERT INTO abilities (stats_id, keyword_id, ability_name, mastery_value) VALUES
    (stats_id_val, keyword_id_val, 'Reptilian Resilience', '3M'),
    (stats_id_val, keyword_id_val, 'Obsidian Scales', '3M'),
    (stats_id_val, keyword_id_val, 'Volcanic Adaptation', '3M');
    
    -- Insert next keyword
    INSERT INTO keywords (stats_id, keyword_name, rating, base_value, improvement_points) VALUES
    (stats_id_val, 'Heat Generator', 17, 10, 7) RETURNING keyword_id INTO keyword_id_val;
    
    -- Insert abilities for Heat Generator
    INSERT INTO abilities (stats_id, keyword_id, ability_name, mastery_value) VALUES
    (stats_id_val, keyword_id_val, 'Heat Aura', '2M'),
    (stats_id_val, keyword_id_val, 'Ignite Materials', '2M'),
    (stats_id_val, keyword_id_val, 'Temperature Resistance', '2M');
    
    -- Insert flaws
    INSERT INTO flaws (stats_id, flaw_name, rating) VALUES
    (stats_id_val, 'Vulnerability to Water', 20),
    (stats_id_val, 'Limited Speed', 18);
    
    -- Insert augments (Strong Against)
    INSERT INTO augments (monster_id, target_name, modifier) VALUES
    (monster_id_val, 'Ice creatures', 5),
    (monster_id_val, 'Plant creatures', 5);
    
    -- Insert hindrances (Weak Against)
    INSERT INTO hindrances (monster_id, target_name, modifier) VALUES
    (monster_id_val, 'Water creatures', -5),
    (monster_id_val, 'Stone creatures', -5);
END $$;