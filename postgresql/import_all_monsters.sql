-- RAGmonsters Database - Import All Monsters Script
-- This script includes the SQL statements to import all RAGmonsters into the database

-- First, create the database schema if it doesn't exist
\i ragmonsters_schema.sql

-- Set search path to ragmonsters schema for all subsequent operations
SET search_path TO ragmonsters, public;

-- Clear existing data if needed
-- Uncomment these lines if you want to start with a clean database
-- DELETE FROM hindrances;
-- DELETE FROM augments;
-- DELETE FROM flaws;
-- DELETE FROM abilities;
-- DELETE FROM keywords;
-- DELETE FROM questworlds_stats;
-- DELETE FROM monsters;
-- DELETE FROM subcategories;
-- DELETE FROM categories;

-- Insert reference data (categories and subcategories)
\echo 'Inserting reference data...'

-- Insert categories
INSERT INTO categories (category_name, description) VALUES
('Elemental', 'Creatures composed of or strongly connected to fundamental forces and elements'),
('Construct/Artificial', 'Created beings including mechanical constructs and hybrid entities'),
('Anomaly/Phenomenon', 'Unusual entities that defy natural laws or exist in digital spaces'),
('Nature/Organic', 'Living creatures derived from natural processes and organic matter'),
('Celestial/Cosmic', 'Beings connected to cosmic forces and celestial phenomena'),
('Spirit/Ethereal', 'Ethereal entities with spiritual or intangible characteristics')
ON CONFLICT (category_name) DO NOTHING;

-- Insert subcategories
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
('Ethereal Entity', (SELECT category_id FROM categories WHERE category_name = 'Spirit/Ethereal'), 'Spiritual beings with intangible characteristics')
ON CONFLICT (subcategory_name) DO NOTHING;

-- Import each monster
\echo 'Importing monsters...'

-- Abyssalurk
\echo 'Importing Abyssalurk...'
\i dataset/abyssalurk.sql

-- Aquafrost
\echo 'Importing Aquafrost...'
\i dataset/aquafrost.sql

-- Chronoshift
\echo 'Importing Chronoshift...'
\i dataset/chronoshift.sql

-- Crystalcore
\echo 'Importing Crystalcore...'
\i dataset/crystalcore.sql

-- Dreamweaver
\echo 'Importing Dreamweaver...'
\i dataset/dreamweaver.sql

-- Echospecter
\echo 'Importing Echospecter...'
\i dataset/echospecter.sql

-- Flameburst
\echo 'Importing Flameburst...'
\i dataset/flameburst.sql

-- Frostbite
\echo 'Importing Frostbite...'
\i dataset/frostbite.sql

-- Fungalnet
\echo 'Importing Fungalnet...'
\i dataset/fungalnet.sql

-- Glitchwisp
\echo 'Importing Glitchwisp...'
\i dataset/glitchwisp.sql

-- Graviton
\echo 'Importing Graviton...'
\i dataset/graviton.sql

-- Lumiglow
\echo 'Importing Lumiglow...'
\i dataset/lumiglow.sql

-- Magmawraith
\echo 'Importing Magmawraith...'
\i dataset/magmawraith.sql

-- Magnetron
\echo 'Importing Magnetron...'
\i dataset/magnetron.sql

-- Mechabyte
\echo 'Importing Mechabyte...'
\i dataset/mechabyte.sql

-- Mirrormorph
\echo 'Importing Mirrormorph...'
\i dataset/mirrormorph.sql

-- Nebulon
\echo 'Importing Nebulon...'
\i dataset/nebulon.sql

-- Plasmaweave
\echo 'Importing Plasmaweave...'
\i dataset/plasmaweave.sql

-- Psyforge
\echo 'Importing Psyforge...'
\i dataset/psyforge.sql

-- Quantumflux
\echo 'Importing Quantumflux...'
\i dataset/quantumflux.sql

-- Sandshifter
\echo 'Importing Sandshifter...'
\i dataset/sandshifter.sql

-- Shadowrift
\echo 'Importing Shadowrift...'
\i dataset/shadowrift.sql

-- Soundweaver
\echo 'Importing Soundweaver...'
\i dataset/soundweaver.sql

-- Terrashift
\echo 'Importing Terrashift...'
\i dataset/terrashift.sql

-- Thunderclaw
\echo 'Importing Thunderclaw...'
\i dataset/thunderclaw.sql

-- Toxitangle
\echo 'Importing Toxitangle...'
\i dataset/toxitangle.sql

-- Vinelash
\echo 'Importing Vinelash...'
\i dataset/vinelash.sql

-- Vitalspirit
\echo 'Importing Vitalspirit...'
\i dataset/vitalspirit.sql

-- Voidwalker
\echo 'Importing Voidwalker...'
\i dataset/voidwalker.sql

-- Windwhisper
\echo 'Importing Windwhisper...'
\i dataset/windwhisper.sql

\echo 'Import complete!'

-- Verify the imported data
\echo 'Verifying imported data...'
\echo 'Monster count:'
SELECT COUNT(*) FROM monsters;

\echo 'Keyword count:'
SELECT COUNT(*) FROM keywords;

\echo 'Ability count:'
SELECT COUNT(*) FROM abilities;

\echo 'Flaw count:'
SELECT COUNT(*) FROM flaws;

\echo 'Augment count:'
SELECT COUNT(*) FROM augments;

\echo 'Hindrance count:'
SELECT COUNT(*) FROM hindrances;