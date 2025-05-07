# 🧩 RAGmonsters Dataset

## Overview

The RAGmonsters dataset is a collection of 30 fictional monsters created specifically for demonstrating and testing Retrieval-Augmented Generation (RAG) systems. Each monster is completely fictional and contains detailed information that would not be found in an LLM's training data, making it perfect for showcasing how RAG can enhance an LLM's knowledge with external information.

## Purpose

This dataset serves several educational purposes:

1. **Demonstrates RAG Value**: Shows how RAG can provide accurate answers about topics not in the LLM's training data
2. **Tests Retrieval Quality**: The varied attributes and relationships allow testing of different retrieval methods
3. **Supports Advanced Features**: Perfect for demonstrating filtering, re-ranking, and hybrid search techniques
4. **Provides Engaging Content**: Makes learning RAG concepts more fun and memorable

## Dataset Structure

Each RAGmonster is described in its own markdown file with a consistent structure:

```
# [Monster Name]

## Basic Information
- Category
- Habitat
- Rarity
- Discovery

## Physical Characteristics
- Height
- Weight
- Appearance

## Powers and Abilities
- Primary Power
- Secondary Power
- Special Ability
- Weakness

## Combat Statistics
- Attack Power
- Defense
- Speed
- Intelligence
- Special Power

## Affinities
- Strong Against
- Weak Against
- Neutral

## Behavior and Ecology
[Description of behavior patterns and ecological role]

## Notable Specimens
[Description of a famous individual of this species]
```

## RAGmonsters List

The dataset contains 30 unique monsters:

1. **Abyssalurk** - Deep Sea Entity
2. **Aquafrost** - Elemental Hybrid
3. **Chronoshift** - Temporal Anomaly
4. **Crystalcore** - Mineral Construct
5. **Dreamweaver** - Subconscious Entity
6. **Echospecter** - Resonance Entity
7. **Flameburst** - Elemental Beast
8. **Frostbite** - Cryo Entity
9. **Fungalnet** - Mycelial Collective
10. **Glitchwisp** - Digital Anomaly
11. **Graviton** - Gravitational Anomaly
12. **Lumiglow** - Light Elemental
13. **Magmawraith** - Volcanic Entity
14. **Magnetron** - Magnetic Entity
15. **Mechabyte** - Techno-Organic Hybrid
16. **Mirrormorph** - Reflective Entity
17. **Nebulon** - Cosmic Gas Entity
18. **Plasmaweave** - Energy Construct
19. **Psyforge** - Psychic Construct
20. **Quantumflux** - Quantum Anomaly
21. **Sandshifter** - Desert Entity
22. **Shadowrift** - Void Entity
23. **Soundweaver** - Sonic Entity
24. **Terrashift** - Geological Entity
25. **Thunderclaw** - Storm Predator
26. **Toxitangle** - Toxic Flora
27. **Vinelash** - Flora Sentinel
28. **Vitalspirit** - Life Force Entity
29. **Voidwalker** - Cosmic Entity
30. **Windwhisper** - Aerial Spirit

## Sample Queries

Here are some example queries that can be used to test a RAG system with this dataset:

- "Which RAGmonster has the highest attack power?"
- "What are the weaknesses of Flameburst?"
- "Find all creatures that are strong against water-based entities"
- "Compare the abilities of Chronoshift and Graviton"
- "Which RAGmonsters can manipulate time or gravity?"
- "What is the habitat of Toxitangle and how does it behave there?"
- "Find RAGmonsters discovered by female scientists"
- "Which RAGmonster would be most effective against Thunderclaw?"
- "What are the physical characteristics of Voidwalker?"
- "Describe the notable specimens of plant-based RAGmonsters"

## Usage in RAG Systems

To use this dataset in a RAG pipeline:

1. **Ingest**: Process each markdown file as a document
2. **Chunk**: Split documents into appropriate chunks (by section or semantic units)
3. **Embed**: Generate vector embeddings for each chunk
4. **Store**: Save chunks and embeddings in a vector database
5. **Retrieve**: Implement retrieval methods to find relevant information
6. **Generate**: Use retrieved context to answer queries about RAGmonsters

## License

© 2025 Horacio "LostInBrittany" Gonzalez. All rights reserved.

The RAGmonsters dataset is provided under a custom license that allows for the following uses:

1. **Educational Use**: You may use this dataset for educational purposes to demonstrate and teach Retrieval-Augmented Generation (RAG) concepts and techniques.

2. **Research Use**: You may use this dataset for research purposes related to RAG, embeddings, vector databases, and similar technologies.

3. **Demo Applications**: You may use this dataset in demonstration applications that showcase RAG capabilities.

The following restrictions apply:

1. **Commercial Restrictions**: You may not use this dataset for commercial purposes without explicit permission from the copyright owner.

2. **Attribution Required**: Any use of this dataset must include appropriate attribution to the original creator.

3. **No Derivative Works**: You may not create derivative works based on the RAGmonsters characters without permission.

4. **No Redistribution**: You may not redistribute this dataset except as part of RAG demonstrations or educational materials.

### QuestWorlds License

The QuestWorlds statistics for the monsters in this dataset follow the QuestWorlds System Reference Document (SRD) license. The QuestWorlds SRD is released under the ORC (Open RPG Creative) License and requires proper attribution to the original creators.

This project uses the QuestWorlds SRD, © Moon Design Publications, LLC, used with permission under the ORC License. For more information on the ORC License, please visit the official QuestWorlds SRD website at [https://www.chaosium.com/questworlds-srd/](https://www.chaosium.com/questworlds-srd/) or review the ORC License at [https://openrpg.creative/](https://openrpg.creative/).

For full license details, see the [LICENSE file](./LICENSE.md) in the repository.

---

*Created for the Practical RAG Course: Building with LLaMA 3 and SQLite*
