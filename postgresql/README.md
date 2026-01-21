# RAGmonsters PostgreSQL Database

This directory contains SQL scripts to create and populate a PostgreSQL database for the RAGmonsters dataset. The database provides a structured format for querying and analyzing monster data, particularly useful for language models interacting with it via MCP.

## Directory Structure

- `ragmonsters_schema.sql`: Main schema definition for the database
- `import_all_monsters.sql`: Script to import all monsters at once
- `sample_data_insertion.sql`: Example of inserting data for specific monsters
- `dataset/`: Directory containing individual SQL files for each monster

## Database Schema

The database is structured with the following tables:

1. **monsters**: Main table with basic monster information. 
2. **questworlds_stats**: Table linking monsters to their QuestWorlds game statistics
3. **keywords**: Table for monster keywords/abilities with ratings
4. **abilities**: Table for specific abilities within each keyword category
5. **flaws**: Table for monster weaknesses/flaws
6. **augments**: Table for creatures the monster is strong against
7. **hindrances**: Table for creatures the monster is weak against

## Getting Started

### Prerequisites

- PostgreSQL 12 or later

### Database Setup

1. Create a new PostgreSQL database:
   ```
   createdb ragmonsters
   ```

2. Import the schema:
   ```
   psql -d ragmonsters -f postgresql/ragmonsters_schema.sql
   ```

3. Import all monster data:
   ```
   psql -d ragmonsters -f postgresql/import_all_monsters.sql
   ```

Alternatively, you can import individual monsters:
```
psql -d ragmonsters -f postgresql/dataset/abyssalurk.sql
```

## Example Queries

Here are some example SQL queries you can run against the database:

```sql
-- Get all monsters with their categories and subcategories
SELECT m.name, c.category_name, sc.subcategory_name
FROM ragmonsters.monsters m
JOIN ragmonsters.subcategories sc ON m.subcategory_id = sc.subcategory_id
JOIN ragmonsters.categories c ON sc.category_id = c.category_id
ORDER BY m.name;

-- Find monsters by habitat and biome
SELECT name FROM ragmonsters.monsters WHERE habitat LIKE '%Mountain%' OR biome LIKE '%Mountain%';

-- Get all keywords for a specific monster
SELECT k.keyword_name, k.rating
FROM ragmonsters.keywords k
JOIN ragmonsters.questworlds_stats qs ON k.stats_id = qs.stats_id
JOIN ragmonsters.monsters m ON qs.monster_id = m.monster_id
WHERE m.name = 'Abyssalurk';

-- Find monsters strong against fire creatures
SELECT m.name
FROM ragmonsters.monsters m
JOIN ragmonsters.augments a ON m.monster_id = a.monster_id
WHERE a.target_name LIKE '%Fire%';

-- Get monsters with highest keyword ratings
SELECT m.name, k.keyword_name, k.rating
FROM ragmonsters.monsters m
JOIN ragmonsters.questworlds_stats qs ON m.monster_id = qs.monster_id
JOIN ragmonsters.keywords k ON qs.stats_id = k.stats_id
WHERE k.rating >= 19
ORDER BY k.rating DESC;
```

## QuestWorlds License

The QuestWorlds statistics for the monsters in this dataset follow the QuestWorlds System Reference Document (SRD) license. The QuestWorlds SRD is released under the ORC (Open RPG Creative) License and requires proper attribution to the original creators.

This project uses the QuestWorlds SRD, © Moon Design Publications, LLC, used with permission under the ORC License. For more information on the ORC License, please visit the official QuestWorlds SRD website at [https://www.chaosium.com/questworlds-srd/](https://www.chaosium.com/questworlds-srd/) or review the ORC License at [https://openrpg.creative/](https://openrpg.creative/).

## Using with MCP

This database schema is specifically designed to work well with language models via MCP (Model Control Protocol). The normalized structure allows for efficient querying and information retrieval about monster attributes, abilities, and relationships.

Example MCP queries might include:
- "Which monsters are strong against water creatures?"
- "What are the abilities of Graviton?"
- "Find monsters with vulnerability to electrical attacks"
- "Compare the keyword ratings of Abyssalurk and Flameburst"

## Deploy in Clever Cloud

Clever Cloud provides a managed PostgreSQL database service that's perfect for hosting the RAGmonsters database. Follow these steps to deploy your database using the Clever Cloud CLI and pgcli.

### Prerequisites

- [Clever Cloud CLI](https://www.clever-cloud.com/doc/getting-started/cli/) installed and configured
- PostgreSQL client tools (psql) - **Required for connecting and importing data**
- [pgcli](https://www.pgcli.com/) - Optional, provides an enhanced interface for PostgreSQL

To install the prerequisites on macOS using Homebrew:
```bash
brew install clever-tools
brew install postgresql  # This includes psql
# Optional: brew install pgcli
```

On Linux (Ubuntu/Debian):
```bash
# For Clever Cloud CLI
curl -fsSL https://clever-tools.clever-cloud.com/gpg/cc-nexus-deb.public.gpg.key | gpg --dearmor -o /usr/share/keyrings/cc-nexus-deb.gpg
echo "deb [arch=amd64 signed-by=/usr/share/keyrings/cc-nexus-deb.gpg] https://nexus.clever-cloud.com/repository/deb stable main" | tee /etc/apt/sources.list.d/clever-tools.list > /dev/null
apt-get update
apt-get install -y clever-tools

# For PostgreSQL client
apt-get install -y postgresql-client
# Optional: apt-get install -y pgcli
```

### Creating the Database

1. Install and login to the Clever Cloud CLI:
   ```bash
   npm install -g clever-tools
   clever login
   ```

2. Create a new PostgreSQL add-on:
   ```bash
   clever addon create postgresql-addon ragmonsters-db --plan dev
   ```

3. Get the database connection information using the Addon ID from the previous step:
   ```bash
   clever addon env <ADDON_ID>
   ```
   Replace `<ADDON_ID>` with the ID value returned when creating the addon (e.g., `addon_XXXXXXXX-XXXX-XXXX-XXXX-XXXXXXXXXXXX`).
   
   This will output environment variables including `POSTGRESQL_ADDON_URI` which contains the full connection string, as well as individual parameters like `POSTGRESQL_ADDON_HOST`, `POSTGRESQL_ADDON_DB`, etc.

4. Export the environment variables for easy access:
   ```bash
   export POSTGRESQL_ADDON_URI="your_uri_from_previous_step"
   ```
   Replace `your_uri_from_previous_step` with the corresponding value from the previous step.

### Connecting to the Database

Connect to your database using psql with the connection URI:

```bash
psql $POSTGRESQL_ADDON_URI
```

Alternatively, you can extract the connection string directly:

```bash
clever addon env <ADDON_ID> --format=shell | grep POSTGRESQL_ADDON_URI | cut -d '=' -f2 | xargs psql
```

If you installed pgcli (optional), you can use it for an enhanced interface:

```bash
pgcli $POSTGRESQL_ADDON_URI
```

### Importing the RAGmonsters Data

**Important:** These commands should be run from within the postgresql directory to ensure the relative paths work correctly.

1. Navigate to the postgresql directory:
   ```bash
   cd postgresql
   ```

2. Import the schema:
   ```bash
   psql $POSTGRESQL_ADDON_URI -f ragmonsters_schema.sql
   ```

3. Import all monster data:
   ```bash
   psql $POSTGRESQL_ADDON_URI -f import_all_monsters.sql
   ```

### Verifying the Import

Connect to your database using psql and run a simple query to verify the import:

```bash
psql $POSTGRESQL_ADDON_URI
```

Once connected, run:

```sql
SELECT m.name, c.category_name
FROM ragmonsters.monsters m
JOIN ragmonsters.subcategories sc ON m.subcategory_id = sc.subcategory_id
JOIN ragmonsters.categories c ON sc.category_id = c.category_id
ORDER BY m.name;
```

You should see a list of all 30 RAGmonsters with their categories.