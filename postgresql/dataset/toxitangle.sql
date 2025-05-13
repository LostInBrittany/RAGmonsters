-- SQL Insertion statements for Toxitangle
-- This file contains the SQL commands to insert the Toxitangle monster into the database

-- Insert monster data
INSERT INTO monsters (
    name, category, subcategory, habitat, biome, rarity, discovery, height, weight, appearance, 
    primary_power, secondary_power, special_ability, weakness, 
    behavior_ecology, notable_specimens
) VALUES (
    'Toxitangle',
    'Nature/Organic',
    'Toxic Flora',
    'Terrestrial Wilderness',
    'Polluted Swamps',
    'Uncommon', 
    'Identified in 2024 by environmental scientist Dr. Mira Sludge while investigating industrial waste sites',
    1.7, 
    '200 kg', 
    'Amorphous mass of twisted vines and bulbous sacs filled with luminescent toxic fluids. Has multiple vine-like tentacles tipped with thorns that secrete various toxins. Central mass contains multiple yellow-green eyes that blink asynchronously.',
    'Toxikinesis - Generation and control of various toxins and poisons',
    'Acid Secretion - Can produce corrosive fluids that dissolve organic and inorganic materials',
    'Miasma Cloud - Creates a fog of hallucinogenic spores that cause confusion and fear',
    'Purification elements and extreme cold solidify toxins, reducing effectiveness by 70%',
    'Toxitangles thrive in polluted environments, actively absorbing and processing environmental toxins. They are territorial and set up chemical barriers around their domain. They reproduce by budding, with small segments breaking off and developing into new individuals when conditions are favorable. Despite their toxic nature, they actually help purify environments over time by processing and neutralizing pollutants.',
    'The Purifier is an enormous Toxitangle that has evolved to process industrial pollutants at an unprecedented rate. It has developed a symbiotic relationship with local wildlife, providing them immunity to toxins in exchange for protection. Its central mass has developed a primitive form of collective consciousness from absorbing various chemical compounds.'
);

-- Get the monster_id for Toxitangle
DO $$
DECLARE
    monster_id_val INTEGER;
    stats_id_val INTEGER;
    keyword_id_val INTEGER;
BEGIN
    SELECT monster_id INTO monster_id_val FROM monsters WHERE name = 'Toxitangle';
    
    -- Insert QuestWorlds stats
    INSERT INTO questworlds_stats (monster_id) VALUES (monster_id_val) RETURNING stats_id INTO stats_id_val;
    
    -- Insert keywords
    INSERT INTO keywords (stats_id, keyword_name, rating, base_value, improvement_points) VALUES
    (stats_id_val, 'Toxin Manipulator', 20, 15, 5) RETURNING keyword_id INTO keyword_id_val;
    
    -- Insert abilities for Toxin Manipulator
    INSERT INTO abilities (stats_id, keyword_id, ability_name, mastery_value) VALUES
    (stats_id_val, keyword_id_val, 'Toxikinesis', '5M'),
    (stats_id_val, keyword_id_val, 'Miasma Cloud', '5M'),
    (stats_id_val, keyword_id_val, 'Poison Secretion', '5M');
    
    -- Insert next keyword
    INSERT INTO keywords (stats_id, keyword_name, rating, base_value, improvement_points) VALUES
    (stats_id_val, 'Toxic Flora', 17, 10, 7) RETURNING keyword_id INTO keyword_id_val;
    
    -- Insert abilities for Toxic Flora
    INSERT INTO abilities (stats_id, keyword_id, ability_name, mastery_value) VALUES
    (stats_id_val, keyword_id_val, 'Toxin Absorption', '2M'),
    (stats_id_val, keyword_id_val, 'Pollutant Processing', '2M'),
    (stats_id_val, keyword_id_val, 'Environmental Adaptation', '2M');
    
    -- Insert next keyword
    INSERT INTO keywords (stats_id, keyword_name, rating, base_value, improvement_points) VALUES
    (stats_id_val, 'Corrosive Entity', 18, 10, 8) RETURNING keyword_id INTO keyword_id_val;
    
    -- Insert abilities for Corrosive Entity
    INSERT INTO abilities (stats_id, keyword_id, ability_name, mastery_value) VALUES
    (stats_id_val, keyword_id_val, 'Acid Secretion', '3M'),
    (stats_id_val, keyword_id_val, 'Material Dissolution', '3M'),
    (stats_id_val, keyword_id_val, 'Chemical Barrier Creation', '3M');
    
    -- Insert flaws
    INSERT INTO flaws (stats_id, flaw_name, rating) VALUES
    (stats_id_val, 'Vulnerability to Purification', 20),
    (stats_id_val, 'Susceptibility to Cold', 18);
    
    -- Insert augments (Strong Against)
    INSERT INTO augments (monster_id, target_name, modifier) VALUES
    (monster_id_val, 'Water creatures', 5),
    (monster_id_val, 'Organic creatures', 5);
    
    -- Insert hindrances (Weak Against)
    INSERT INTO hindrances (monster_id, target_name, modifier) VALUES
    (monster_id_val, 'Fire creatures', -5),
    (monster_id_val, 'Stone creatures', -5);
END $$;