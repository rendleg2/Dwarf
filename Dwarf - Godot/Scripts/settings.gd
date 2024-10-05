extends Node

var Settings_var = {"renderDistance": 2, "chunkSize": 32}
var World_settings = {"seed": randi(), "NoiseMapOne" : FastNoiseLite.new(), "rng": RandomNumberGenerator.new(), "chunkLoaderOne": null}
var chunks = {}
func _ready():
	World_settings["NoiseMapOne"].seed = World_settings["seed"]
	World_settings["rng"].seed = World_settings["seed"]
	print(World_settings["NoiseMapOne"].seed)
