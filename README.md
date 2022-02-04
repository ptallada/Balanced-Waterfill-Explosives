# Balanced-Waterfill
A Factorio mod that aims to provide a less broken version of standard waterfill mods.

# Overview
Other waterfill mods traditionally have the issue that placing water is unrestricted, and let you place water under biters, players, and even biter nests, instantly killing them. This has led to many lost spidertrons to accidental waterfilling, and countless accidents. The ablity to place an indestructible, impassible (except for landfill) baririer will also understandably lead to people making perfect walls, that remove the challenge of biters from the game. This mod rectifes the balance issues with other waterfill mods, by making it impossible to place water under entities, as well as making (only) the water placed by waterfill walkable to both players and biters. These changes make it possible to still use waterfill to build efficient nuclear power plants, and generally lessen the hassle of moving water, while being significantly more vanilla freindly than most other waterfill mods.

# Features

 - **NEW!** Integration with Space Exploration / Krastorio 2 (Integration still needs work, please report bugs on the issues tab of the github or the discussions tab of the mod page)
 - Configurable recipe cost for making waterfill, from just consuming water, to requiring water to be barreled before making waterfill (this returns the same ammount of empty barrels), to actually consuming those barrels, requiring a constant supply of barrels to produce waterfill.
 - A setting for Collision Type, the ability to make waterfill lethal, and impassible to players, while still protecting spidertrons, your factory, cliffs, and other entities from getting destroyed by waterfill. The "Kills players" setting will only make it impassible to players, while the "Impassible" setting will take it a step further, and make it totally impassible, to biters, players and cars alike, (will still protect spidertrons and the factory from getting destroyed, the setting will only make it impossible to walk on for other entities)
 - A setting to enable or disable waterfilling on "waterless" planets. (Space Exploration only)
 - Works with offshore pumps
 - Has a technology unlock

# Notes

 - The Collision Type setting only works in versions 1.1.51 and beyond, as it requires a special flag that was added in that version (If you are on a version before that, leave the setting on Normal)
 - Thanks to the factorio discord community for answering my silly questions about Lua
 - Thanks to WUBE software, the art assets are all made from base art
 - Please report any questions, suggestions, or bugs in the "Issues" tab of the GitHub page
