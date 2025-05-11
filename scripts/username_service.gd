extends Node

const _usernames = {
	"adjectives": [
		"raging", "feral", "venomous", "brutal", "shadowy", "vicious", "stormy", "savage", "blazing", "thundering",
		"explosive", "frostbitten", "crimson", "ironclad", "phantom", "berserk", "molten", "grim", "reckless", "howling",
		"volatile", "scarlet", "obsidian", "infernal", "shattered", "warped", "demonic", "electric", "untamed", "frenzied",
		"lethal", "chaotic", "darkened", "furious", "ashen", "colossal", "primordial", "tempestuous", "jagged", "monstrous",
		"bloodthirsty", "rogue", "unstoppable", "ruthless", "harbinger", "sinister", "barbed", "relentless", "bonecrushing", "nightmarish"
	],
	"nouns": [
		"chainsaw", "avalanche", "warhammer", "hydra", "maelstrom", "kraken", "wreckingball", "inferno", "cataclysm", "vortex",
		"shuriken", "gargoyle", "cannon", "fang", "scythe", "gauntlet", "blizzard", "dragon", "landmine", "firestorm",
		"spikedclub", "doomwheel", "battleship", "juggernaut", "razorblade", "warhorn", "thunderclap", "beartrap", "megalodon", "deathray",
		"ironfist", "tempest", "flamethrower", "onslaught", "stormbringer", "blastwave", "deathknell", "headhunter", "nightblade", "tsunami",
		"overlord", "obliterator", "deathstalker", "bloodfang", "skullcrusher", "wastelander", "sledgehammer", "grimreaper", "hellhound", "nightcrawler"
	]
}


## Gives a username based on the Uid
func generate_username(Uid: String):
	seed(hash(Uid))
	var adjective: String = _usernames["adjectives"][randi() % _usernames["adjectives"].size()]
	var noun: String = _usernames["nouns"][randi() % _usernames["nouns"].size()]
	return adjective.capitalize() + noun.capitalize()