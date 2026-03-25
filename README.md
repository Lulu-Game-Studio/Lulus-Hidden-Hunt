# Lulu’s Hidden Hunt

## 1. Game Overview

- **Title:** Lulu’s Hidden Hunt 
- **Genre:** 2D Puzzle - Exploration  
- **Platform:** PC  
- **Graphics Style:** Pixel Art  

**Description:**  
Lulu’s Hidden Hunt is a 2D exploration puzzle game where the player controls a dog searching for hidden objects across different park levels. Each level contains different objects that must be found in order to complete it. The player can use a limited number of hints to reveal the approximate location of one of the hidden objects.

---

## 2. Gameplay

### 2.1 Player

**Controls**

| Key | Action |
|----|----|
| W | Move Up |
| A | Move Left |
| S | Move Down |
| D | Move Right |
| Shift | Run |
| E | Bark |
| H | Use Hint |
| Q | Talk |

**Abilities**
- **Hint Ability:** The player has an amount of hints per level that reveal the approximate location of a hidden object.
- **Bark Ability:** The player can bark to interact with environmental elements (e.g., scare animals blocking paths).

**Actions**
- Move around the map.
- Search for hidden objects.
- Use hints to help locate objects.
- Interact with environment via barking.
- Read tutorial signs for guidance.

### 2.2 Objects
- **Hidden Objects:**  
  - Objects are placed around the map and must be found by the player.  
  - The player must collect all objects in the level to progress.

- **Environment:**  
  - Trees, bushes, benches, or other decorations where objects may be hidden.

- **Obstacles:**  
  - The park can contain obstacles that block paths or make exploration more difficult.
  - Animal groups that block paths until the player uses the bark ability to disperse them.

### 2.3 Enemies / Animals
  - Certain levels contain groups of animals blocking paths.
  - When the player barks:
    - Animals are dispersed in different directions (up/down/side).
    - Animals move a fixed distance and then disappear.
    - Animals act as temporary obstacles with collision.

### 2.4 Levels / Progression
  - The game consists of multiple levels.
  - Each level introduces new mechanics or variations:
    - Level 1–2: Basic exploration
    - Level 3: Animal interaction (bark mechanic)
    - Level 4-5: Combined mechanics and more complex layouts
  - Hints reset at the start of each level (1 per level currently).

### 2.5 Interaction Elements
  - **Hidden Objects**
    - Collected via collision.

  - **Hint System**
    - Shows a directional arrow pointing to the nearest collectible.
    - Limited usage per level.

  - **Tutorial Signs**
    - Interactive signs placed in levels.
    - When the player approaches, a text label appears.

---

## 3. Game Mechanics

- **Movement:** Free 2D movement with walking and running.
- **Search Mechanic:** Exploration-based object discovery.
- **Hint System:** Directional assistance using arrow pointing system.
- **Bark Mechanic:** Environmental interaction to remove obstacles (animals).
- **Collision System:** Used for collectibles, animals, and obstacles.
- **Tutorial System:** In-world signs provide guidance via proximity triggers.
- **Win Condition:** All hidden objects collected → level complete.

---

## 4. Technical Details

  - **Engine:** Godot

  - **Architecture:**
    - Autoload systems (Hint manager, Signals)
    - Scene-based level design
    - Group-based object tracking (collectibles)

  - **Physics:**
    - 2D physics with Area2D and StaticBody2D

  - **UI:**
    - HUD with collectible counter and hint indicator
    - World-space + UI elements (labels, arrows)