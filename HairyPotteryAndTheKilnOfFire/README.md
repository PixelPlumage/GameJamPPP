# Hairy Pottery and the Kiln of Fire (HPKF)
A pottery game by RadiationHazard & M6yj4xgmd3

###### Genre
Simulation | Casual | Crafting | Management
###### Platforms
Web | Desktop
###### Target Audience
**All ages** | Casual gamers, crafting enthusiasts, and fans of simulation and resource management games.

## Description
The player is an independent potter building their business, fulfilling villager needs, creating unique pottery designs, and competing with rival potteries. The game blends resource gathering (mining, monster hunting, buying), crafting (pottery creation), and business management (selling, fulfilling orders).
Players will gather resources, craft pottery, and utilize the powerful Kiln of Fire (KOF) to create unique and valuable items


## Getting Started!
1. To run the project, open the project in Godot Engine 4

## How To Play

### Objective
Players must gather resources, craft pottery, and sell it to earn money. They must also fulfill villager requests to gain reputation and unlock new opportunities.

#### Mines
Players enter mines for materials and money.
* Slaying monsters and opening chests will drop materials and money.
* Materials may be collected directly from specific ores.
* Mine shafts are randomly generated in a Mountain location.
* Mine difficulty will be decided by external markings of the mine shaft

## Core Gameplay Features

#### Resource Gathering:
* **Mining:** Mine for clay, minerals, and other materials. Different areas yield different resources.
* **Monster Hunting:** Defeat monsters for rare materials or ingredients used in special glazes.
* **Shop:** Purchase common resources for convenience.
#### Pottery Creation:
* **Wheel Throwing:** Mini-game or simplified interface for shaping pots.
* **Firing:** Using kilns, potentially with different fuel types (linking to the "ever-burning fire" theme). More advanced kilns could fire more complex or higher-quality pieces.
* **Glazing:** Applying glazes to enhance the appearance and value of pottery.

#### Business Management:
* **Selling:** Player places pottery in their shop. Villagers visit and purchase pottery at displayed prices. Prices affect sales rate.
* **Villager Requests:** Villagers request specific types of pottery. Completing requests rewards the player with money and reputation.
* **Competition:** Potentially interact with or compete against rival potteries (e.g., selling similar items, participating in pottery fairs).
#### Progression:
* **Skill Upgrades:** Improve mining speed, crafting efficiency, or combat abilities.
New Recipes: Unlock new pottery designs and glaze recipes.
* **Studio Upgrades:** Expand the studio with more kilns, storage, or display space.
#### Kilns
Different types of kilns, powered by different fuels, each affecting the firing process and the properties of the pottery.
* **Wood:** Standard fuel, basic firing.
* **Hairy Tuft:** A special fuel made from hairy creature tufts, which creates a hotter fire and can imbue pottery with slight magical properties (e.g., glows in the dark).
* **Firestone Kiln:** Uses mined firestone, hotter fire, faster firing, unlocks certain glazes.
* **Magma Kiln:** Uses rare magma (monster drop or deep mining), extremely hot fire, unlocks special pottery types and glazes, but requires careful temperature control (mini-game element).

## Game Design

#### Worldbuilding
##### Setting
A whimsical world inhabited by quirky creatures, including the hairy creatures that provide some of the clay. The environment could have exaggerated features and vibrant colors.
##### Tone
Lighthearted, humorous, and slightly absurd. Relaxing and charming, with a focus on creativity and community.

#### Story
##### Premise
The player is a new potter who has just moved to the region to start their own business. They must learn the local pottery traditions, build relationships with the villagers, and compete with other potters to establish themselves as a successful artisan.

The **Kiln of Fire (KOF) KOF** is an ancient kiln, said to have been built by the first potters of the region. It's believed to be imbued with magical energy, which can be harnessed by using special fuels.

#### Characters
* **Player Character (MC):** A customizable potter with a passion for creating beautiful and functional pottery.
* **Villagers:** Various NPCs with unique personalities and needs, offering quests and buying pottery.
* **Rival Potters (Optional for the Jam):** Other potters who compete with the player for business.
* **Hairy Creatures:** The source of some of the hairy clay. They could be passive or hostile, depending on the type.

#### Locations
*  **Player's Studio:** A cozy workshop with a prominent Kiln of Fire. The KOF is located in the center of the player's workshop, dominating the space with its imposing size and flickering flames
* **Hairy Creature Habitats:** Where the player can find hairy creatures and gather hairy clay.
* **Villages:** Where the player interacts with villagers and receives quests.
* **Resource Gathering Areas:** Forests, mines, and other locations where the player can gather resources.

#### Level design
Levels will be designed with a focus on exploration and resource gathering, with clear pathways leading to key areas 
like mining nodes, hairy creature habitats, and villages.

## Game Mechanics

#### Controls
###### Movement
WASD or arrow keys.

###### Interaction
Mouse clicks or button presses to interact with objects and NPCs.

###### Crafting Interface
Mouse clicks to select recipes and manipulate crafting elements.

#### In-game GUI
Inventory
* Display collected resources
* Display tools

###### Crafting interface
Shows available recipes and required materials

###### Shop interface
Display pottery for sale, allow players to set prices

###### Quest log
Track villager requests and provides information on rewards

###### Dialogue boxes
Used for interacting with villagers and receiving quests

###### Minimap (Map)
* Shows the players location and points of interest
* May show new resources
* May include map pins (Future development)

#### Game Engine

###### Combat
Simple top-down combat with basic attacks. Focus on resource gathering from defeated monsters rather than complex combat mechanics.

###### Physics
Basic collision detection for movement and interactions with objects.

#### Terminology
* **Resource Management:** How resources are gained, stored, and used.
* **Economy:** How prices are determined, how money is earned and spent.
* **AI:** How NPCs behave.
* **Combat (if applicable):** Damage calculations, attack ranges, enemy behavior.
* **Physics (if applicable):** How objects interact with each other and the environment.
* **Random Number Generation (RNG):** How random events are determined (e.g., resource drops, enemy encounters).

KOF
* **Firing Time:** Specify the firing time for different fuels and pottery types.
* **Fuel Consumption:** Define how much fuel is consumed per firing.
* **Temperature Control (If applicable):** Detail the mechanics of any temperature control mini-game or system.
* **Special Effects:** Clearly define the effects of different fuels on the pottery (e.g., stat bonuses, visual changes).
  **Example:** "Firing a basic pot with wood takes 10 seconds. Using 'Hairy Tuft' reduces the firing time to 7 seconds and adds a +1 to the pot's 'Charm' stat."

## Assets
This game features original pixel art and music created exclusively for HPKF

#### Music

#### Sound effects
The KOF emits a constant crackling and roaring sound, which intensifies when using hotter fuels. Special sound effects play when pottery is successfully fired or when a firing error occurs.

#### Models
The KOF is a large, brick kiln with intricate carvings. Flames flicker within its opening, and smoke rises from its chimney. Its appearance changes slightly depending on the fuel being used

## Development
This project is created with [Godot Engine 4](https://godotengine.org/) and made for the [Alchemy Jam #3](https://itch.io/jam/alchemy-jam-3)

###### Alchemy Jam Tie-in
This game incorporates the "Ever-Burning Fire" theme through the Kiln of Fire (KOF), a mystical tool central to pottery creation and gameplay.

#### Project scope
Core gameplay loop. Prioritizing essential mechanics: resource gathering, pottery creation, selling, fulfilling simple villager requests

#### Project Roadmap
###### Short term (Game Jam)
* Players progress by fulfilling villager requests, earning money to upgrade tools and their pottery studio
* Unlock new pottery recipes and glazes through experimentation or by completing specific tasks.
* Mine floors will be of a single tileset

###### Long term (Post-Game Jam)
* Expand the studio with advanced features and equipment
* Master pottery techniques and build a reputation
* Find and train pottery apprentices
* Procedurally generated mine floors








