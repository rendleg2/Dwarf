extends Node2D
@onready var Settings_var = Settings.Settings_var
@onready var World_settings = Settings.World_settings
@onready var chunks = Settings.chunks
var chunksNumber = 0
var var_name = null

func _ready():
	pass

func save():
	chunksNumber += 1
	var_name = "chunk_" + str(chunksNumber)
	chunks[var_name] = []
	for x in range(0, Settings_var["chunkSize"]):
		chunks[var_name].append([{"x": x}])
		for y in range(0, Settings_var["chunkSize"]):
			chunks[var_name][x].append([{"block": y}])

func locate():
	var cords = World_settings["chunkLoaderOne"].global_position

func generateChunks():
	pass
	if chunks.has("notting lol"):
		pass
