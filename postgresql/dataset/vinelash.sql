-- SQL Insertion statements for Vinelash
-- This file contains the SQL commands to insert the Vinelash monster into the database

-- Insert monster data
INSERT INTO monsters (
    name, category, subcategory, habitat, biome, rarity, discovery, height, weight, appearance, 
    primary_power, secondary_power, special_ability, weakness, 
    behavior_ecology, notable_specimens
) VALUES (
    'Vinelash',
    'Nature/Organic',
    'Flora Sentinel',
    'Terrestrial Wilderness',
    'Dense Jungles',
    'Common', 
    'Documented by botanist Dr. Ivy Green during the Emerald Expedition of 2024',
    2.5, 
    '180 kg', 
    'Humanoid plant creature with bark-like skin and flexible vine limbs. Has a flowering crown that changes colors based on mood and season. Eyes are luminescent yellow-green pods.',
    'Chlorokinesis - Control and rapid growth of plant matter',
    'Photosynthetic Healing - Can rapidly heal when exposed to sunlight',
    'Spore Cloud - Releases hallucinogenic spores that confuse enemies',
    'Fire and extreme cold cause rapid dehydration, reducing mobility by 80%',
    'Vinelashes form symbiotic communities with local plant life, accelerating growth and protecting forest ecosystems. They are diurnal, requiring at least 6 hours of direct sunlight daily. During drought seasons, they can enter a dormant state, reducing to a seed-like form until conditions improve.',
    'The Ancient Gardener is a centuries-old Vinelash that has grown to twice the normal size and developed the ability to control entire forest ecosystems. It can communicate telepathically with all plant life within a 5-kilometer radius and has created a sanctuary where plants exhibit near-sentient behavior.'
);

-- Get the monster_id for Vinelash
DO $$
DECLARE
    monster_id_val INTEGER;
    stats_id_val INTEGER;
    keyword_id_val INTEGER;
BEGIN
    SELECT monster_id INTO monster_id_val FROM monsters WHERE name = 'Vinelash';
    
    -- Insert QuestWorlds stats
    INSERT INTO questworlds_stats (monster_id) VALUES (monster_id_val) RETURNING stats_id INTO stats_id_val;
    
    -- Insert keywords
    INSERT INTO keywords (stats_id, keyword_name, rating, base_value, improvement_points) VALUES
    (stats_id_val, 'Plant Manipulator', 20, 15, 5) RETURNING keyword_id INTO keyword_id_val;
    
    -- Insert abilities for Plant Manipulator
    INSERT INTO abilities (stats_id, keyword_id, ability_name, mastery_value) VALUES
    (stats_id_val, keyword_id_val, 'Chlorokinesis', '5M'),
    (stats_id_val, keyword_id_val, 'Vine Control', '5M'),
    (stats_id_val, keyword_id_val, 'Rapid Growth Stimulation', '5M');
    
    -- Insert next keyword
    INSERT INTO keywords (stats_id, keyword_name, rating, base_value, improvement_points) VALUES
    (stats_id_val, 'Flora Sentinel', 17, 10, 7) RETURNING keyword_id INTO keyword_id_val;
    
    -- Insert abilities for Flora Sentinel
    INSERT INTO abilities (stats_id, keyword_id, ability_name, mastery_value) VALUES
    (stats_id_val, keyword_id_val, 'Spore Cloud', '2M'),
    (stats_id_val, keyword_id_val, 'Bark-like Protection', '2M'),
    (stats_id_val, keyword_id_val, 'Jungle Adaptation', '2M');
    
    -- Insert next keyword
    INSERT INTO keywords (stats_id, keyword_name, rating, base_value, improvement_points) VALUES
    (stats_id_val, 'Nature Protector', 18, 10, 8) RETURNING keyword_id INTO keyword_id_val;
    
    -- Insert abilities for Nature Protector
    INSERT INTO abilities (stats_id, keyword_id, ability_name, mastery_value) VALUES
    (stats_id_val, keyword_id_val, 'Photosynthetic Healing', '3M'),
    (stats_id_val, keyword_id_val, 'Ecosystem Connection', '3M'),
    (stats_id_val, keyword_id_val, 'Symbiotic Relationship', '3M');
    
    -- Insert flaws
    INSERT INTO flaws (stats_id, flaw_name, rating) VALUES
    (stats_id_val, 'Vulnerability to Fire', 20),
    (stats_id_val, 'Susceptibility to Cold', 18);
    
    -- Insert augments (Strong Against)
    INSERT INTO augments (monster_id, target_name, modifier) VALUES
    (monster_id_val, 'Earth creatures', 5),
    (monster_id_val, 'Water creatures', 5);
    
    -- Insert hindrances (Weak Against)
    INSERT INTO hindrances (monster_id, target_name, modifier) VALUES
    (monster_id_val, 'Fire creatures', -5),
    (monster_id_val, 'Ice creatures', -5);
END $$;