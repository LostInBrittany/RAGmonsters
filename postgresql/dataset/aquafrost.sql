-- SQL Insertion statements for Aquafrost
-- This file contains the SQL commands to insert the Aquafrost monster into the database

-- Insert monster data
INSERT INTO monsters (
    name, category, habitat, rarity, discovery, height, weight, appearance, 
    primary_power, secondary_power, special_ability, weakness, 
    behavior_ecology, notable_specimens
) VALUES (
    'Aquafrost', 
    'Elemental Hybrid', 
    'Glacial Lakes', 
    'Uncommon', 
    'Discovered in 2023 by marine biologist Dr. Elena Winters during an expedition to the Frozen Depths',
    1.8, 
    '320 kg', 
    'Humanoid water entity with crystalline ice formations throughout its transparent blue body. Its core glows with a pulsating cyan light, and ice crystals form a crown-like structure around its head.',
    'Cryohydrokinesis - Control of water and ice simultaneously',
    'Freezing Touch - Can instantly freeze small bodies of water on contact',
    'Blizzard Veil - Creates a swirling storm of ice and water that obscures vision and slows enemies',
    'Heat-based attacks cause rapid evaporation, reducing mass by up to 40%',
    'Aquafrost entities are semi-social, often forming small groups of 3-5 individuals. They communicate through harmonic resonances within their crystalline structures. During summer months, they retreat to deeper waters where temperatures remain cold enough to maintain their ice components.',
    'The Glacier Queen is an ancient Aquafrost that has existed for over 150 years, developing the unique ability to create semi-sentient ice sculptures that act as guardians. Her control over water extends to atmospheric moisture, allowing her to create localized weather phenomena.'
);

-- Get the monster_id for Aquafrost
DO $$
DECLARE
    monster_id_val INTEGER;
    stats_id_val INTEGER;
    keyword_id_val INTEGER;
BEGIN
    SELECT monster_id INTO monster_id_val FROM monsters WHERE name = 'Aquafrost';
    
    -- Insert QuestWorlds stats
    INSERT INTO questworlds_stats (monster_id) VALUES (monster_id_val) RETURNING stats_id INTO stats_id_val;
    
    -- Insert keywords
    INSERT INTO keywords (stats_id, keyword_name, rating, base_value, improvement_points) VALUES
    (stats_id_val, 'Cryohydrokinetic Entity', 19, 15, 4) RETURNING keyword_id INTO keyword_id_val;
    
    -- Insert abilities for Cryohydrokinetic Entity
    INSERT INTO abilities (stats_id, keyword_id, ability_name, mastery_value) VALUES
    (stats_id_val, keyword_id_val, 'Blizzard Veil', '4M'),
    (stats_id_val, keyword_id_val, 'Water Control', '4M'),
    (stats_id_val, keyword_id_val, 'Ice Manipulation', '4M');
    
    -- Insert next keyword
    INSERT INTO keywords (stats_id, keyword_name, rating, base_value, improvement_points) VALUES
    (stats_id_val, 'Elemental Hybrid', 17, 10, 7) RETURNING keyword_id INTO keyword_id_val;
    
    -- Insert abilities for Elemental Hybrid
    INSERT INTO abilities (stats_id, keyword_id, ability_name, mastery_value) VALUES
    (stats_id_val, keyword_id_val, 'Adapt to Frozen Environments', '2M'),
    (stats_id_val, keyword_id_val, 'Water-Ice Transition', '2M'),
    (stats_id_val, keyword_id_val, 'Crystalline Resonance', '2M');
    
    -- Insert next keyword
    INSERT INTO keywords (stats_id, keyword_name, rating, base_value, improvement_points) VALUES
    (stats_id_val, 'Ice Former', 19, 10, 9) RETURNING keyword_id INTO keyword_id_val;
    
    -- Insert abilities for Ice Former
    INSERT INTO abilities (stats_id, keyword_id, ability_name, mastery_value) VALUES
    (stats_id_val, keyword_id_val, 'Freezing Touch', '4M'),
    (stats_id_val, keyword_id_val, 'Ice Structure Creation', '4M'),
    (stats_id_val, keyword_id_val, 'Cooling Aura', '4M');
    
    -- Insert flaws
    INSERT INTO flaws (stats_id, flaw_name, rating) VALUES
    (stats_id_val, 'Vulnerability to Heat', 19),
    (stats_id_val, 'Mass Reduction Under Stress', 17);
    
    -- Insert augments (Strong Against)
    INSERT INTO augments (monster_id, target_name, modifier) VALUES
    (monster_id_val, 'Fire creatures', 5),
    (monster_id_val, 'Earth creatures', 5);
    
    -- Insert hindrances (Weak Against)
    INSERT INTO hindrances (monster_id, target_name, modifier) VALUES
    (monster_id_val, 'Electric creatures', -5),
    (monster_id_val, 'Wind creatures', -5);
END $$;