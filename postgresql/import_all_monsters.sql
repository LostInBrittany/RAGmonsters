-- RAGmonsters Database - Import All Monsters Script
-- This script includes the SQL statements to import all RAGmonsters into the database

-- First, create the database schema if it doesn't exist
\i ragmonsters_schema.sql

-- Clear existing data if needed
-- Uncomment these lines if you want to start with a clean database
-- DELETE FROM hindrances;
-- DELETE FROM augments;
-- DELETE FROM flaws;
-- DELETE FROM abilities;
-- DELETE FROM keywords;
-- DELETE FROM questworlds_stats;
-- DELETE FROM monsters;

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