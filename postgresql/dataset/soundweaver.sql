-- SQL Insertion statements for Soundweaver
-- This file contains the SQL commands to insert the Soundweaver monster into the database

-- Insert monster data
INSERT INTO monsters (
    name, category, subcategory, habitat, biome, rarity, discovery, height, weight, appearance, 
    primary_power, secondary_power, special_ability, weakness, 
    behavior_ecology, notable_specimens
) VALUES (
    'Soundweaver',
    'Spirit/Ethereal',
    'Sonic Entity',
    'Energy/Acoustic',
    'Echo Canyons',
    'Rare', 
    'First recorded in 2024 by acoustician Dr. Melody Harmonic during a sound-mapping expedition',
    1.9, 
    '30 kg (mostly sonic energy)', 
    'Vaguely humanoid figure composed of visible sound waves that ripple and flow in constant motion. Its form is outlined by blue-purple energy with musical note-like patterns throughout. Has no distinct facial features but communicates through a "face" of harmonic waveforms.',
    'Sonokinesis - Manipulation and generation of sound waves',
    'Frequency Modulation - Can alter the properties of existing sounds',
    'Harmonic Resonance - Can match the resonant frequency of objects, potentially shattering them',
    'Vacuum environments nullify all powers, rendering it nearly powerless',
    'Soundweavers are drawn to areas with interesting acoustic properties, particularly natural amphitheaters and echo chambers. They feed on ambient sound energy and can become dormant in extremely quiet environments. They communicate through complex symphonies of sound that can convey detailed information and emotions. They reproduce by creating "sound seeds" - concentrated packets of sonic energy that develop into new Soundweavers when exposed to sufficient acoustic stimulation.',
    'The Symphony is a collective of seven Soundweavers that have learned to harmonize their abilities, creating sound phenomena that no single entity could produce. Together they can generate healing frequencies, induce specific emotional states, or create destructive interference patterns that can reshape physical matter.'
);

-- Get the monster_id for Soundweaver
DO $$
DECLARE
    monster_id_val INTEGER;
    stats_id_val INTEGER;
    keyword_id_val INTEGER;
BEGIN
    SELECT monster_id INTO monster_id_val FROM monsters WHERE name = 'Soundweaver';
    
    -- Insert QuestWorlds stats
    INSERT INTO questworlds_stats (monster_id) VALUES (monster_id_val) RETURNING stats_id INTO stats_id_val;
    
    -- Insert keywords
    INSERT INTO keywords (stats_id, keyword_name, rating, base_value, improvement_points) VALUES
    (stats_id_val, 'Sound Manipulator', 20, 15, 5) RETURNING keyword_id INTO keyword_id_val;
    
    -- Insert abilities for Sound Manipulator
    INSERT INTO abilities (stats_id, keyword_id, ability_name, mastery_value) VALUES
    (stats_id_val, keyword_id_val, 'Sonokinesis', '5M'),
    (stats_id_val, keyword_id_val, 'Sound Wave Generation', '5M'),
    (stats_id_val, keyword_id_val, 'Acoustic Pattern Creation', '5M');
    
    -- Insert next keyword
    INSERT INTO keywords (stats_id, keyword_name, rating, base_value, improvement_points) VALUES
    (stats_id_val, 'Sonic Entity', 17, 10, 7) RETURNING keyword_id INTO keyword_id_val;
    
    -- Insert abilities for Sonic Entity
    INSERT INTO abilities (stats_id, keyword_id, ability_name, mastery_value) VALUES
    (stats_id_val, keyword_id_val, 'Harmonic Resonance', '2M'),
    (stats_id_val, keyword_id_val, 'Sonic Wave Composition', '2M'),
    (stats_id_val, keyword_id_val, 'Sound Energy Absorption', '2M');
    
    -- Insert next keyword
    INSERT INTO keywords (stats_id, keyword_name, rating, base_value, improvement_points) VALUES
    (stats_id_val, 'Frequency Controller', 18, 10, 8) RETURNING keyword_id INTO keyword_id_val;
    
    -- Insert abilities for Frequency Controller
    INSERT INTO abilities (stats_id, keyword_id, ability_name, mastery_value) VALUES
    (stats_id_val, keyword_id_val, 'Frequency Modulation', '3M'),
    (stats_id_val, keyword_id_val, 'Resonant Frequency Detection', '3M'),
    (stats_id_val, keyword_id_val, 'Harmonic Pattern Recognition', '3M');
    
    -- Insert flaws
    INSERT INTO flaws (stats_id, flaw_name, rating) VALUES
    (stats_id_val, 'Vulnerability to Vacuum', 20),
    (stats_id_val, 'Limited Physical Form', 18);
    
    -- Insert augments (Strong Against)
    INSERT INTO augments (monster_id, target_name, modifier) VALUES
    (monster_id_val, 'Crystal creatures', 5),
    (monster_id_val, 'Glass-based entities', 5);
    
    -- Insert hindrances (Weak Against)
    INSERT INTO hindrances (monster_id, target_name, modifier) VALUES
    (monster_id_val, 'Amorphous creatures', -5),
    (monster_id_val, 'Entities without physical form', -5);
END $$;