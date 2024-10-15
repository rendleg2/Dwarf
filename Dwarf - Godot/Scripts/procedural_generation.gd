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
var load = []
func _ready():
	for i in range(-Settings_var["renderDistance"]+1, Settings_var["renderDistance"]):
		load.append(i*Settings_var["chunkSize"])
	print(load)
	
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
	var cords3 = Ground.local_to_map(Vector2i(cords.x, cords.y))
	var cords2 = snapped(cords3, Vector2i(Settings_var["chunkSize"], Settings_var["chunkSize"]))
	
	var num = 0
	for y in load:
		for x in load:
			var cords4 = Vector2i(cords2.x + x, cords2.y + y)
			if x == load[0] or y == load[0]:
				if Ground.get_cell_atlas_coords(Vector2i(cords4.x, cords4.y)) != Vector2i(-1, -1):
					unloadChunk(cords4)
			elif x == load[Settings_var["renderDistance"]*2-2] or y == load[Settings_var["renderDistance"]*2-2]:
				if Ground.get_cell_atlas_coords(Vector2i(cords4.x, cords4.y)) != Vector2i(-1, -1):
					unloadChunk(cords4)
			elif Ground.get_cell_atlas_coords(Vector2i(cords4.x, cords4.y)) == Vector2i(-1, -1) and chunks.has(str(cords4.x, ",", cords4.y)):
				loadChunk(cords4)
			elif Ground.get_cell_atlas_coords(Vector2i(cords4.x, cords4.y)) == Vector2i(-1, -1):
				generateChunks(cords4)
			
			num += 1
	#generateChunks(cords2)
	#print(cords3, "< player, Chunk >",cords2)
	var test = str(0, ".", cords3)
	
func generateChunks(cords4):
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

func loadChunk(cords):
	for x in range(Settings_var["chunkSize"]):
		for y in range(Settings_var["chunkSize"]):
			var pos = Vector2i(cords.x+x, cords.y+y)
			var check = chunks[str(cords.x) + "," + str(cords.y)][x][y]
			if check["Block"] == "test":
				Ground.set_cell(pos, 0, Vector2i(5, 0))

func unloadChunk(cords):
	for x in range(Settings_var["chunkSize"]):
			for y in range(Settings_var["chunkSize"]):
				var pos = Vector2i(cords.x+x, cords.y+y)
				Ground.erase_cell(pos)

func _on_timer_timeout():
	locate()
