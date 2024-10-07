extends Node2D
@onready var Settings_var = Settings.Settings_var
@onready var World_settings = Settings.World_settings
@onready var chunks = Settings.chunks
var chunksNumber = 0
var var_name = null
@onready var Ground = $Ground
@onready var Ysort = $Ysort
@onready var Walls = $Walls
@onready var cords = World_settings["chunkLoaderOne"].position

func _ready():
	pass

func save(cords):
	chunksNumber += 1
	var_name = str(cords.x) + "," + str(cords.y)
	chunks[var_name] = []
	for x in range(0, Settings_var["chunkSize"]):
		chunks[var_name].append([{"x": x}])
		for y in range(0, Settings_var["chunkSize"]):
			chunks[var_name][x].append({"cords": str(x,",",y)})
	for x in range(0, Settings_var["chunkSize"]):
		chunks[var_name][x].remove_at(0)

func locate():
	cords = World_settings["chunkLoaderOne"].global_position
	var cords2 = snapped(Ground.local_to_map(Vector2i(cords.x, cords.y)), Vector2i(Settings_var["chunkSize"], Settings_var["chunkSize"]))
	generateChunks(cords2)
	
func generateChunks(cords4):
	if chunks.has(str(cords4.x, ",", cords4.y)):
		print("no")
	else:
		print("yes")
		save(cords4)
		for x in range(Settings_var["chunkSize"]):
			for y in range(Settings_var["chunkSize"]):
				var gen = World_settings["NoiseMapOne"].get_noise_2d(cords4.x+x, cords4.y+y)
				var pos = Vector2i(cords4.x+x, cords4.y+y)
				if gen < 1 and gen > -1:
					Ground.set_cell(pos, 0, Vector2i(0, 0))
					var stats = {
						"Block": "test",
						"Hp": 100
					}
					chunks[str(cords4.x) + "," + str(cords4.y)][x][y].merge(stats)

func _on_timer_timeout():
	locate()
	print("gen")
