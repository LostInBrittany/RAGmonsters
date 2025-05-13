-- SQL Insertion statements for Vitalspirit
-- This file contains the SQL commands to insert the Vitalspirit monster into the database

-- Insert monster data
INSERT INTO monsters (
    name, category, subcategory, habitat, biome, rarity, discovery, height, weight, appearance, 
    primary_power, secondary_power, special_ability, weakness, 
    behavior_ecology, notable_specimens
) VALUES (
    'Vitalspirit',
    'Spirit/Ethereal',
    'Life Force Entity',
    'Terrestrial Wilderness',
    'Biodiversity Hotspots',
    'Very Rare', 
    'First observed in 2025 by biologist Dr. Vita Bloom during research in pristine rainforest ecosystems',
    2.3, 
    '60 kg (mostly energy)', 
    'Humanoid figure composed of swirling green-gold energy that resembles flowing sap or liquid life force. Body is semi-transparent with visible currents of energy flowing throughout. Features are suggested rather than defined, with eyes that glow with inner light and limbs that trail into wisps of vital energy.',
    'Vitakinesis - Manipulation of life force energy',
    'Regenerative Aura - Can accelerate healing and growth in living organisms',
    'Life Bloom - Can rapidly accelerate plant growth and ecosystem development',
    'Areas of pollution or death drain its energy, reducing power by 85%',
    'Vitalspirits emerge in areas with exceptional biodiversity and life energy. They act as caretakers and balancers of ecosystems, helping to maintain harmony between different species. They feed on excess life energy produced by thriving ecosystems but never take more than can be naturally replenished. They communicate through bioelectric signals that can be sensed by plants and animals as intuitive understanding. They reproduce rarely, with new Vitalspirits emerging when an ecosystem reaches perfect balance and generates sufficient excess life energy.',
    'The Garden Keeper is an ancient Vitalspirit that has established a hidden valley where evolution has accelerated, producing unique species found nowhere else on Earth. It can communicate with all living things in its domain and has developed the ability to temporarily infuse non-living matter with life essence. It maintains a perfect record of genetic information from thousands of species, preserving biodiversity against potential extinction events.'
);

-- Get the monster_id for Vitalspirit
DO $$
DECLARE
    monster_id_val INTEGER;
    stats_id_val INTEGER;
    keyword_id_val INTEGER;
BEGIN
    SELECT monster_id INTO monster_id_val FROM monsters WHERE name = 'Vitalspirit';
    
    -- Insert QuestWorlds stats
    INSERT INTO questworlds_stats (monster_id) VALUES (monster_id_val) RETURNING stats_id INTO stats_id_val;
    
    -- Insert keywords
    INSERT INTO keywords (stats_id, keyword_name, rating, base_value, improvement_points) VALUES
    (stats_id_val, 'Vitakinetic Being', 20, 15, 5) RETURNING keyword_id INTO keyword_id_val;
    
    -- Insert abilities for Vitakinetic Being
    INSERT INTO abilities (stats_id, keyword_id, ability_name, mastery_value) VALUES
    (stats_id_val, keyword_id_val, 'Vitakinesis', '5M'),
    (stats_id_val, keyword_id_val, 'Life Bloom', '5M'),
    (stats_id_val, keyword_id_val, 'Healing Acceleration', '5M');
    
    -- Insert next keyword
    INSERT INTO keywords (stats_id, keyword_name, rating, base_value, improvement_points) VALUES
    (stats_id_val, 'Life Force Entity', 17, 10, 7) RETURNING keyword_id INTO keyword_id_val;
    
    -- Insert abilities for Life Force Entity
    INSERT INTO abilities (stats_id, keyword_id, ability_name, mastery_value) VALUES
    (stats_id_val, keyword_id_val, 'Regenerative Aura', '2M'),
    (stats_id_val, keyword_id_val, 'Life Energy Manipulation', '2M'),
    (stats_id_val, keyword_id_val, 'Bioelectric Communication', '2M');
    
    -- Insert next keyword
    INSERT INTO keywords (stats_id, keyword_name, rating, base_value, improvement_points) VALUES
    (stats_id_val, 'Ecosystem Harmonizer', 18, 10, 8) RETURNING keyword_id INTO keyword_id_val;
    
    -- Insert abilities for Ecosystem Harmonizer
    INSERT INTO abilities (stats_id, keyword_id, ability_name, mastery_value) VALUES
    (stats_id_val, keyword_id_val, 'Biodiversity Sensing', '3M'),
    (stats_id_val, keyword_id_val, 'Species Balance Maintenance', '3M'),
    (stats_id_val, keyword_id_val, 'Ecological Connection', '3M');
    
    -- Insert flaws
    INSERT INTO flaws (stats_id, flaw_name, rating) VALUES
    (stats_id_val, 'Vulnerability to Pollution', 20),
    (stats_id_val, 'Weakness in Lifeless Areas', 18);
    
    -- Insert augments (Strong Against)
    INSERT INTO augments (monster_id, target_name, modifier) VALUES
    (monster_id_val, 'Decay entities', 5),
    (monster_id_val, 'Undead creatures', 5);
    
    -- Insert hindrances (Weak Against)
    INSERT INTO hindrances (monster_id, target_name, modifier) VALUES
    (monster_id_val, 'Entropy manipulators', -5),
    (monster_id_val, 'Void entities', -5);
END $$;