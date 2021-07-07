## Card Data
- [ ] **You can't search for some card information**
	- [ ] Pokemon Category (Species) (e.g. Electric Pokemon)
	- [ ] Pokemon Length/Height (e.g. Ht:3'07'')
	- [ ] Pokedex Number (e.g. No. 125)
	- [ ] Pokemon Weight (e.g. WT 66.1 lbs)
## Deck Building
- [ ] **[Rotation](https://bulbapedia.bulbagarden.net/wiki/Rotation_(TCG)) isn't implemented**
- [ ] **You can build a deck with less than 60 cards**
- The player whose deck isn't exactly 60 cards loses the game.
- If neither player has a 60-card deck, the game ends in a draw.
- [ ] **You can't build a [Half Deck](https://bulbapedia.bulbagarden.net/wiki/Half_Deck_(TCG)) with exactly 30 cards**
- Enable `Do not check deck` when creating a game.
- The player whose Half Deck isn't exactly 30 cards loses the game.
- If neither player has a 30-card Half Deck, the game ends in a draw.
- [ ] **You're allowed to build a [side deck](https://en.wikipedia.org/wiki/Sideboard_(cards))**
- The player who has a side deck doesn't lose the game.
## Zones
- [ ] **Zones are positioned differently than in the actual card game**
- The discard pile is above the deck instead of below it.
- Each player's Active Pokemon isn't centered.
- The Bench isn't aligned with the discard pile.
- Each player has a zone to play a Stadium card in instead of there being only one zone to the left of the Active Pokemon.
- The Prize cards are above the discard pile instead of to the left of the Active Pokemon.
- [ ] **There are no [zones](https://yugioh.fandom.com/wiki/Zone) for Prize cards**
- [Face-up](https://yugioh.fandom.com/wiki/Face-up) [banished](https://yugioh.fandom.com/wiki/Banish) cards are in the Lost Zone.
- [Face-down](https://yugioh.fandom.com/wiki/Face-down) banished cards are Prize cards, and they have blue text.
- [ ] **You can look at your Prize cards at any time**
- If you're required to select your Prize card, the game will do it randomly for you.
- [ ] **You can't shuffle your Prize cards**
- The only way to randomize your Prize cards is to remove them first.
- [ ] **You can't have more than 5 Pokemon on your Bench**
- Cards like _[Sky Field](https://bulbapedia.bulbagarden.net/wiki/Sky_Field_(Roaring_Skies_89))_ that extend a player's Bench aren't fully implementable.
## Card Positions
- [ ] **Pokemon can't be upside down to show that they're [Confused](https://bulbapedia.bulbagarden.net/wiki/Special_Conditions_(TCG)#Confused)**
- Confused Pokemon remain right-side up and have a description to show that they're Confused.
- [ ] **Pokemon can't be turned clockwise to show that they're [Paralyzed](https://bulbapedia.bulbagarden.net/wiki/Special_Conditions_(TCG)#Paralyzed)**
- Paralyzed Pokemon are turned counterclockwise and have a description to show that they're Paralyzed.
- [ ] **Stadium cards can't be upside down**
- If you choose the upside down option of a Stadium card, that card is placed on your opponent's [field](https://yugioh.fandom.com/wiki/Field). For example, _[Chaos Tower](https://bulbapedia.bulbagarden.net/wiki/Chaos_Tower_(Fates_Collide_94))_.
## Card Effects
- [x] **Attacks that require Colorless Energy [C] can be used even if the Pokemon doesn't have enough Energy**
- [ ] **You don't always look through your entire deck when you take a card from it**
- If you're required to take a specific card from your deck, the game will only show you the relevant cards.
- [ ] **Pokemon BREAK don't always show the correct names of the attacks and Abilities they gained from their previous Evolution**
- [ ] **Pokemon LV.X don't always show the correct names of the attacks and Abilities they gained from their previous Level**
## Other
- [ ] **The turn count in the middle of the screen doesn't reset when [Sudden Death](https://www.pokebeach.com/forums/threads/sudden-death-questions.112470/) occurs**
