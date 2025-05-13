-- SQL Insertion statements for Magmawraith
-- This file contains the SQL commands to insert the Magmawraith monster into the database

-- Insert monster data
INSERT INTO monsters (
    name, category, subcategory, habitat, biome, rarity, discovery, height, weight, appearance, 
    primary_power, secondary_power, special_ability, weakness, 
    behavior_ecology, notable_specimens
) VALUES (
    'Magmawraith',
    'Elemental',
    'Volcanic Entity',
    'Volcanic/Geothermal',
    'Active Volcanoes',
    'Rare', 
    'First documented in 2024 by volcanologist Dr. Ember Ash during an unexpected eruption',
    2.7, 
    '500 kg', 
    'Humanoid figure composed of semi-solid magma with a hardened obsidian exoskeleton that cracks to reveal the molten interior. Eyes are white-hot pools of liquid fire, and it leaves smoldering footprints that cool into volcanic glass.',
    'Magmakinesis - Control and generation of magma and lava',
    'Heat Aura - Maintains an area of extreme heat around its body',
    'Eruption - Can trigger explosive release of pressurized magma',
    'Rapid cooling causes temporary solidification, reducing mobility by 90%',
    'Magmawraiths form in the magma chambers of active volcanoes, absorbing minerals and heat energy until achieving consciousness. They are drawn to geothermal activity and can remain dormant for decades inside cooling lava flows. They communicate through heat pulses and low-frequency vibrations. They reproduce by creating "seed crystals" of specialized minerals that are ejected during volcanic eruptions and develop into new Magmawraiths when exposed to sufficient heat.',
    'The Eternal Flame is an ancient Magmawraith that has existed for centuries, developing control over tectonic activity in its region. It can trigger or prevent volcanic eruptions at will and has created a network of lava tubes that serve as pathways between distant volcanoes.'
);

-- Get the monster_id for Magmawraith
DO $$
DECLARE
    monster_id_val INTEGER;
    stats_id_val INTEGER;
    keyword_id_val INTEGER;
BEGIN
    SELECT monster_id INTO monster_id_val FROM monsters WHERE name = 'Magmawraith';
    
    -- Insert QuestWorlds stats
    INSERT INTO questworlds_stats (monster_id) VALUES (monster_id_val) RETURNING stats_id INTO stats_id_val;
    
    -- Insert keywords
    INSERT INTO keywords (stats_id, keyword_name, rating, base_value, improvement_points) VALUES
    (stats_id_val, 'Magma Manipulator', 20, 15, 5) RETURNING keyword_id INTO keyword_id_val;
    
    -- Insert abilities for Magma Manipulator
    INSERT INTO abilities (stats_id, keyword_id, ability_name, mastery_value) VALUES
    (stats_id_val, keyword_id_val, 'Eruption', '5M'),
    (stats_id_val, keyword_id_val, 'Magmakinesis', '5M'),
    (stats_id_val, keyword_id_val, 'Lava Flow Control', '5M');
    
    -- Insert next keyword
    INSERT INTO keywords (stats_id, keyword_name, rating, base_value, improvement_points) VALUES
    (stats_id_val, 'Volcanic Entity', 18, 10, 8) RETURNING keyword_id INTO keyword_id_val;
    
    -- Insert abilities for Volcanic Entity
    INSERT INTO abilities (stats_id, keyword_id, ability_name, mastery_value) VALUES
    (stats_id_val, keyword_id_val, 'Obsidian Exoskeleton', '3M'),
    (stats_id_val, keyword_id_val, 'Volcanic Adaptation', '3M'),
    (stats_id_val, keyword_id_val, 'Mineral Absorption', '3M');
    
    -- Insert next keyword
    INSERT INTO keywords (stats_id, keyword_name, rating, base_value, improvement_points) VALUES
    (stats_id_val, 'Heat Generator', 17, 10, 7) RETURNING keyword_id INTO keyword_id_val;
    
    -- Insert abilities for Heat Generator
    INSERT INTO abilities (stats_id, keyword_id, ability_name, mastery_value) VALUES
    (stats_id_val, keyword_id_val, 'Heat Aura', '2M'),
    (stats_id_val, keyword_id_val, 'Temperature Manipulation', '2M'),
    (stats_id_val, keyword_id_val, 'Thermal Resistance', '2M');
    
    -- Insert flaws
    INSERT INTO flaws (stats_id, flaw_name, rating) VALUES
    (stats_id_val, 'Vulnerability to Rapid Cooling', 20),
    (stats_id_val, 'Limited Mobility', 18);
    
    -- Insert augments (Strong Against)
    INSERT INTO augments (monster_id, target_name, modifier) VALUES
    (monster_id_val, 'Ice creatures', 5),
    (monster_id_val, 'Plant creatures', 5);
    
    -- Insert hindrances (Weak Against)
    INSERT INTO hindrances (monster_id, target_name, modifier) VALUES
    (monster_id_val, 'Water creatures', -5),
    (monster_id_val, 'Air creatures', -5);
END $$;