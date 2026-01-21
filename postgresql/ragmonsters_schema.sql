-- RAGmonsters Database Schema
-- PostgreSQL schema for the RAGmonsters dataset

-- Drop and recreate the ragmonsters schema
DROP SCHEMA IF EXISTS ragmonsters CASCADE;
CREATE SCHEMA ragmonsters;
SET search_path TO ragmonsters, public;

-- Categories table for normalized category structure
CREATE TABLE categories (
    category_id SERIAL PRIMARY KEY,
    category_name VARCHAR(100) NOT NULL UNIQUE,
    description TEXT
);

-- Subcategories table for normalized subcategory structure
CREATE TABLE subcategories (
    subcategory_id SERIAL PRIMARY KEY,
    subcategory_name VARCHAR(100) NOT NULL UNIQUE,
    category_id INTEGER NOT NULL REFERENCES categories(category_id),
    description TEXT,
    CONSTRAINT fk_subcategory_category FOREIGN KEY (category_id) REFERENCES categories(category_id)
);

-- Main monsters table
CREATE TABLE monsters (
    monster_id SERIAL PRIMARY KEY,
    name VARCHAR(100) NOT NULL,
    subcategory_id INTEGER NOT NULL REFERENCES subcategories(subcategory_id),
    monster_type VARCHAR(100) NOT NULL,
    habitat VARCHAR(100) NOT NULL,
    biome VARCHAR(100) NOT NULL,
    rarity VARCHAR(50) NOT NULL,
    discovery TEXT NOT NULL,
    height DECIMAL(5,2) NOT NULL,
    weight VARCHAR(100) NOT NULL, -- As VARCHAR to handle "Immeasurable" values
    appearance TEXT NOT NULL,
    primary_power VARCHAR(200) NOT NULL,
    secondary_power VARCHAR(200) NOT NULL,
    special_ability VARCHAR(200) NOT NULL,
    weakness TEXT NOT NULL,
    behavior_ecology TEXT NOT NULL,
    notable_specimens TEXT NOT NULL
);

-- QuestWorlds stats table
CREATE TABLE questworlds_stats (
    stats_id SERIAL PRIMARY KEY,
    monster_id INTEGER NOT NULL REFERENCES monsters(monster_id) ON DELETE CASCADE,
    CONSTRAINT fk_monster FOREIGN KEY (monster_id) REFERENCES monsters(monster_id)
);

-- Keywords table
CREATE TABLE keywords (
    keyword_id SERIAL PRIMARY KEY,
    stats_id INTEGER NOT NULL REFERENCES questworlds_stats(stats_id) ON DELETE CASCADE,
    keyword_name VARCHAR(100) NOT NULL,
    rating INTEGER NOT NULL,
    base_value INTEGER NOT NULL,
    improvement_points INTEGER NOT NULL,
    CONSTRAINT fk_stats_keywords FOREIGN KEY (stats_id) REFERENCES questworlds_stats(stats_id)
);

-- Abilities table
CREATE TABLE abilities (
    ability_id SERIAL PRIMARY KEY,
    stats_id INTEGER NOT NULL REFERENCES questworlds_stats(stats_id) ON DELETE CASCADE,
    keyword_id INTEGER NOT NULL REFERENCES keywords(keyword_id) ON DELETE CASCADE,
    ability_name VARCHAR(100) NOT NULL,
    mastery_value VARCHAR(10),
    CONSTRAINT fk_stats_abilities FOREIGN KEY (stats_id) REFERENCES questworlds_stats(stats_id),
    CONSTRAINT fk_keyword FOREIGN KEY (keyword_id) REFERENCES keywords(keyword_id)
);

-- Flaws table
CREATE TABLE flaws (
    flaw_id SERIAL PRIMARY KEY,
    stats_id INTEGER NOT NULL REFERENCES questworlds_stats(stats_id) ON DELETE CASCADE,
    flaw_name VARCHAR(100) NOT NULL,
    rating INTEGER NOT NULL,
    CONSTRAINT fk_stats_flaws FOREIGN KEY (stats_id) REFERENCES questworlds_stats(stats_id)
);

-- Augments table (replaces "Strong Against" affinities)
CREATE TABLE augments (
    augment_id SERIAL PRIMARY KEY,
    monster_id INTEGER NOT NULL REFERENCES monsters(monster_id) ON DELETE CASCADE,
    target_name VARCHAR(100) NOT NULL,
    modifier INTEGER NOT NULL DEFAULT 5,
    CONSTRAINT fk_monster_augments FOREIGN KEY (monster_id) REFERENCES monsters(monster_id)
);

-- Hindrances table (replaces "Weak Against" affinities)
CREATE TABLE hindrances (
    hindrance_id SERIAL PRIMARY KEY,
    monster_id INTEGER NOT NULL REFERENCES monsters(monster_id) ON DELETE CASCADE,
    target_name VARCHAR(100) NOT NULL,
    modifier INTEGER NOT NULL DEFAULT -5,
    CONSTRAINT fk_monster_hindrances FOREIGN KEY (monster_id) REFERENCES monsters(monster_id)
);

-- Create indexes for performance
CREATE INDEX idx_monster_name ON monsters(name);
CREATE INDEX idx_monster_subcategory_id ON monsters(subcategory_id);
CREATE INDEX idx_subcategory_category_id ON subcategories(category_id);
CREATE INDEX idx_category_name ON categories(category_name);
CREATE INDEX idx_subcategory_name ON subcategories(subcategory_name);
CREATE INDEX idx_monster_type ON monsters(monster_type);
CREATE INDEX idx_keyword_name ON keywords(keyword_name);
CREATE INDEX idx_ability_name ON abilities(ability_name);
CREATE INDEX idx_flaw_name ON flaws(flaw_name);
CREATE INDEX idx_augment_target ON augments(target_name);
CREATE INDEX idx_hindrance_target ON hindrances(target_name);

-- Example data insertion (commented out)
/*
-- First insert categories and subcategories (see sample_data_insertion.sql for full reference data)

-- Insert monster data for Abyssalurk using normalized structure
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
*/