-- SQL Insertion statements for Mirrormorph
-- This file contains the SQL commands to insert the Mirrormorph monster into the database

-- Insert monster data
INSERT INTO monsters (
    name, category, habitat, rarity, discovery, height, weight, appearance, 
    primary_power, secondary_power, special_ability, weakness, 
    behavior_ecology, notable_specimens
) VALUES (
    'Mirrormorph', 
    'Reflective Entity', 
    'Mirror Realms', 
    'Rare', 
    'First encountered in 2024 by optical researcher Dr. Glass during experiments with perfect reflective surfaces',
    0, 
    '70 kg', 
    'Humanoid figure with a perfectly reflective, mirror-like surface that shows distorted reflections of its surroundings. Features are minimal but can shift to mimic observed creatures. Movements are fluid but slightly delayed, as if following an invisible guide.',
    'Reflection Manipulation - Control over reflective surfaces and reflected light',
    'Mimicry - Can copy the appearance and some abilities of observed entities',
    'Mirror Step - Can travel between reflective surfaces within line of sight',
    'Completely dark environments render it nearly powerless, reducing abilities by 95%',
    'Mirrormorphs exist primarily in a parallel dimension accessible only through perfectly reflective surfaces. They are curious about the physical world and often observe through mirrors, occasionally crossing over. They feed on light energy and are most active in brightly lit areas. They communicate through patterns of reflected light that appear as shifting colors to observers. They reproduce by carefully cultivating fragments of their reflective surface that eventually develop consciousness when exposed to specific light patterns.',
    'The Gallery Guardian is an ancient Mirrormorph that has established a vast network of connected mirrors spanning multiple continents. It can observe through any connected mirror and has collected centuries of visual information about human civilization. It occasionally assists those it finds interesting by providing glimpses of distant locations through reflective surfaces.'
);

-- Get the monster_id for Mirrormorph
DO $$
DECLARE
    monster_id_val INTEGER;
    stats_id_val INTEGER;
    keyword_id_val INTEGER;
BEGIN
    SELECT monster_id INTO monster_id_val FROM monsters WHERE name = 'Mirrormorph';
    
    -- Insert QuestWorlds stats
    INSERT INTO questworlds_stats (monster_id) VALUES (monster_id_val) RETURNING stats_id INTO stats_id_val;
    
    -- Insert keywords
    INSERT INTO keywords (stats_id, keyword_name, rating, base_value, improvement_points) VALUES
    (stats_id_val, 'Reflection Manipulator', 20, 15, 5) RETURNING keyword_id INTO keyword_id_val;
    
    -- Insert abilities for Reflection Manipulator
    INSERT INTO abilities (stats_id, keyword_id, ability_name, mastery_value) VALUES
    (stats_id_val, keyword_id_val, 'Light Reflection Control', '5M'),
    (stats_id_val, keyword_id_val, 'Mirror Projection', '5M'),
    (stats_id_val, keyword_id_val, 'Visual Distortion', '5M');
    
    -- Insert next keyword
    INSERT INTO keywords (stats_id, keyword_name, rating, base_value, improvement_points) VALUES
    (stats_id_val, 'Reflective Entity', 18, 10, 8) RETURNING keyword_id INTO keyword_id_val;
    
    -- Insert abilities for Reflective Entity
    INSERT INTO abilities (stats_id, keyword_id, ability_name, mastery_value) VALUES
    (stats_id_val, keyword_id_val, 'Mirror Step', '3M'),
    (stats_id_val, keyword_id_val, 'Reflective Surface Integration', '3M'),
    (stats_id_val, keyword_id_val, 'Dimensional Shifting', '3M');
    
    -- Insert next keyword
    INSERT INTO keywords (stats_id, keyword_name, rating, base_value, improvement_points) VALUES
    (stats_id_val, 'Mimicry Master', 17, 10, 7) RETURNING keyword_id INTO keyword_id_val;
    
    -- Insert abilities for Mimicry Master
    INSERT INTO abilities (stats_id, keyword_id, ability_name, mastery_value) VALUES
    (stats_id_val, keyword_id_val, 'Appearance Copying', '2M'),
    (stats_id_val, keyword_id_val, 'Ability Replication', '2M'),
    (stats_id_val, keyword_id_val, 'Observational Learning', '2M');
    
    -- Insert flaws
    INSERT INTO flaws (stats_id, flaw_name, rating) VALUES
    (stats_id_val, 'Vulnerability to Darkness', 20),
    (stats_id_val, 'Delayed Movement Patterns', 18);
    
    -- Insert augments (Strong Against)
    INSERT INTO augments (monster_id, target_name, modifier) VALUES
    (monster_id_val, 'Light creatures', 5),
    (monster_id_val, 'Illusion-based entities', 5);
    
    -- Insert hindrances (Weak Against)
    INSERT INTO hindrances (monster_id, target_name, modifier) VALUES
    (monster_id_val, 'Shadow manipulators', -5),
    (monster_id_val, 'Sound-based creatures', -5);
END $$;