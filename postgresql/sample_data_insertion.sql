-- RAGmonsters Sample Data Insertion
-- This file contains reference data for categories/subcategories and sample data for monsters

-- Set search path to ragmonsters schema
SET search_path TO ragmonsters, public;

-- Insert reference data for categories
INSERT INTO categories (category_name, description) VALUES
('Elemental', 'Creatures composed of or strongly connected to fundamental forces and elements'),
('Construct/Artificial', 'Created beings including mechanical constructs and hybrid entities'),
('Anomaly/Phenomenon', 'Unusual entities that defy natural laws or exist in digital spaces'),
('Nature/Organic', 'Living creatures derived from natural processes and organic matter'),
('Celestial/Cosmic', 'Beings connected to cosmic forces and celestial phenomena'),
('Spirit/Ethereal', 'Ethereal entities with spiritual or intangible characteristics');

-- Insert reference data for subcategories
INSERT INTO subcategories (subcategory_name, category_id, description) VALUES
-- Elemental subcategories
('Energy Entity', (SELECT category_id FROM categories WHERE category_name = 'Elemental'), 'Beings of pure energy and plasma'),
('Elemental Being', (SELECT category_id FROM categories WHERE category_name = 'Elemental'), 'Traditional elemental creatures of fire, water, earth, air'),
('Environmental Entity', (SELECT category_id FROM categories WHERE category_name = 'Elemental'), 'Creatures that embody environmental forces and conditions'),
-- Construct/Artificial subcategories
('Construct', (SELECT category_id FROM categories WHERE category_name = 'Construct/Artificial'), 'Mechanical and artificially created beings'),
('Hybrid Entity', (SELECT category_id FROM categories WHERE category_name = 'Construct/Artificial'), 'Beings that combine organic and artificial elements'),
-- Anomaly/Phenomenon subcategories
('Anomaly', (SELECT category_id FROM categories WHERE category_name = 'Anomaly/Phenomenon'), 'Entities that bend or break natural laws'),
('Digital Entity', (SELECT category_id FROM categories WHERE category_name = 'Anomaly/Phenomenon'), 'Beings that exist in digital or dream realms'),
-- Nature/Organic subcategories
('Flora Entity', (SELECT category_id FROM categories WHERE category_name = 'Nature/Organic'), 'Plant-based creatures'),
('Geological Entity', (SELECT category_id FROM categories WHERE category_name = 'Nature/Organic'), 'Earth and mineral-based creatures'),
('Collective Entity', (SELECT category_id FROM categories WHERE category_name = 'Nature/Organic'), 'Creatures that exist as collective organisms'),
-- Celestial/Cosmic subcategories
('Cosmic Entity', (SELECT category_id FROM categories WHERE category_name = 'Celestial/Cosmic'), 'Beings connected to cosmic forces and space'),
-- Spirit/Ethereal subcategories
('Ethereal Entity', (SELECT category_id FROM categories WHERE category_name = 'Spirit/Ethereal'), 'Spiritual beings with intangible characteristics');

-- Insert monster data
INSERT INTO monsters (
    name, subcategory_id, monster_type, habitat, biome, rarity, discovery, height, weight, appearance, 
    primary_power, secondary_power, special_ability, weakness, 
    behavior_ecology, notable_specimens
) VALUES (
    'Abyssalurk', 
    (SELECT subcategory_id FROM subcategories WHERE subcategory_name = 'Environmental Entity'),
    'Deep Sea Entity', 
    'Aquatic',
    'Oceanic Trenches', 
    'Rare', 
    'First documented in 2024 by marine biologist Dr. Marina Depths during a deep-sea expedition',
    3.2, 
    '400 kg', 
    'Elongated humanoid with fish-like features and bioluminescent patterns across its midnight-blue skin. Has multiple sets of arms that end in webbed claws. Eyes are large, entirely black, and adapted for extreme pressure environments. Possesses both gills and rudimentary lungs.',
    'Pressure Manipulation - Control over water pressure in localized areas',
    'Bioluminescent Communication - Can create complex light patterns for signaling and hypnosis',
    'Depth Charge - Can create imploding water bubbles that generate devastating shockwaves',
    'Rapid decompression causes severe damage, reducing vitality by 75%',
    'Abyssalurks inhabit the darkest depths of the ocean, creating complex societies in underwater caves and trenches. They are territorial and mark their domains with distinctive bioluminescent patterns. They communicate through a combination of light signals and low-frequency vibrations. They reproduce slowly, with females laying eggs in protected nursery caves that are guarded by the entire community.',
    '"The Trench Sovereign" is a colossal Abyssalurk that has established a kingdom spanning multiple oceanic trenches. It has developed the ability to control deep sea currents and can communicate telepathically with all marine life in its territory. Its bioluminescence is so sophisticated it can create three-dimensional illusions underwater.'
);

-- Get the monster_id for Abyssalurk
DO $$
DECLARE
    monster_id_val INTEGER;
    stats_id_val INTEGER;
    keyword_id_val INTEGER;
BEGIN
    SELECT monster_id INTO monster_id_val FROM monsters WHERE name = 'Abyssalurk';
    
    -- Insert QuestWorlds stats
    INSERT INTO questworlds_stats (monster_id) VALUES (monster_id_val) RETURNING stats_id INTO stats_id_val;
    
    -- Insert keywords
    INSERT INTO keywords (stats_id, keyword_name, rating, base_value, improvement_points) VALUES
    (stats_id_val, 'Pressure Manipulator', 20, 15, 5) RETURNING keyword_id INTO keyword_id_val;
    
    -- Insert abilities for Pressure Manipulator
    INSERT INTO abilities (stats_id, keyword_id, ability_name, mastery_value) VALUES
    (stats_id_val, keyword_id_val, 'Depth Charge', '5M'),
    (stats_id_val, keyword_id_val, 'Localized Pressure Control', '5M'),
    (stats_id_val, keyword_id_val, 'Water Compression', '5M');
    
    -- Insert next keyword
    INSERT INTO keywords (stats_id, keyword_name, rating, base_value, improvement_points) VALUES
    (stats_id_val, 'Deep Sea Entity', 17, 10, 7) RETURNING keyword_id INTO keyword_id_val;
    
    -- Insert abilities for Deep Sea Entity
    INSERT INTO abilities (stats_id, keyword_id, ability_name, mastery_value) VALUES
    (stats_id_val, keyword_id_val, 'Underwater Navigation', '2M'),
    (stats_id_val, keyword_id_val, 'Withstand Pressure', '2M'),
    (stats_id_val, keyword_id_val, 'Multiple Webbed Limbs', '2M');
    
    -- Insert next keyword
    INSERT INTO keywords (stats_id, keyword_name, rating, base_value, improvement_points) VALUES
    (stats_id_val, 'Bioluminescent Communicator', 18, 10, 8) RETURNING keyword_id INTO keyword_id_val;
    
    -- Insert abilities for Bioluminescent Communicator
    INSERT INTO abilities (stats_id, keyword_id, ability_name, mastery_value) VALUES
    (stats_id_val, keyword_id_val, 'Hypnotic Light Patterns', '3M'),
    (stats_id_val, keyword_id_val, 'Underwater Signaling', '3M'),
    (stats_id_val, keyword_id_val, 'Create Light Source', '3M');
    
    -- Insert flaws
    INSERT INTO flaws (stats_id, flaw_name, rating) VALUES
    (stats_id_val, 'Vulnerability to Decompression', 20),
    (stats_id_val, 'Limited Mobility on Land', 17);
    
    -- Insert augments (Strong Against)
    INSERT INTO augments (monster_id, target_name, modifier) VALUES
    (monster_id_val, 'Surface dwellers', 5),
    (monster_id_val, 'Fire creatures', 5);
    
    -- Insert hindrances (Weak Against)
    INSERT INTO hindrances (monster_id, target_name, modifier) VALUES
    (monster_id_val, 'Electricity manipulators', -5),
    (monster_id_val, 'Sonic entities', -5);
    

END $$;

-- Add another monster: Flameburst
INSERT INTO monsters (
    name, subcategory_id, monster_type, habitat, biome, rarity, discovery, height, weight, appearance, 
    primary_power, secondary_power, special_ability, weakness, 
    behavior_ecology, notable_specimens
) VALUES (
    'Flameburst', 
    (SELECT subcategory_id FROM subcategories WHERE subcategory_name = 'Elemental Being'),
    'Elemental Beast', 
    'Terrestrial Wilderness',
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

-- Sample queries demonstrating normalized structure
/*
-- Query to get all monsters with their category and subcategory information
SELECT 
    m.name,
    c.category_name,
    s.subcategory_name,
    m.monster_type,
    m.habitat,
    m.biome
FROM monsters m
    JOIN subcategories s ON m.subcategory_id = s.subcategory_id
    JOIN categories c ON s.category_id = c.category_id
ORDER BY c.category_name, s.subcategory_name, m.name;

-- Query to get all monsters in a specific category
SELECT 
    m.name,
    s.subcategory_name,
    m.monster_type
FROM monsters m
    JOIN subcategories s ON m.subcategory_id = s.subcategory_id
    JOIN categories c ON s.category_id = c.category_id
WHERE c.category_name = 'Elemental'
ORDER BY s.subcategory_name, m.name;

-- Query to count monsters by category
SELECT 
    c.category_name,
    COUNT(m.monster_id) as monster_count
FROM categories c
    LEFT JOIN subcategories s ON c.category_id = s.category_id
    LEFT JOIN monsters m ON s.subcategory_id = m.subcategory_id
GROUP BY c.category_id, c.category_name
ORDER BY monster_count DESC, c.category_name;

-- Query to get subcategory distribution
SELECT 
    c.category_name,
    s.subcategory_name,
    COUNT(m.monster_id) as monster_count
FROM categories c
    JOIN subcategories s ON c.category_id = s.category_id
    LEFT JOIN monsters m ON s.subcategory_id = m.subcategory_id
GROUP BY c.category_id, c.category_name, s.subcategory_id, s.subcategory_name
ORDER BY c.category_name, s.subcategory_name;
*/