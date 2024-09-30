extends Node2D

@onready var tileMap = $TileMap
const PLAYER = preload("res://player_scene.tscn")
const EXIT = preload("res://exit_door.tscn")

var borders = Rect2(1, 1, 38, 21)

func _ready():
	randomize()
	generate_level()

func reload_level():
	get_tree().reload_current_scene()

func generate_level():
	var walker = Walker.new(Vector2(19, 11), borders)
	var map = walker.walk(200)
	
	var player = PLAYER.instantiate()
	add_child(player)
	player.position = map.front() * 32
	
	var exit = EXIT.instantiate()
	add_child(exit)
	exit.position = walker.get_end_room().position * 32
	exit.connect("leaving_level", Callable(self, "reload_level"))
	
	var all_cells : Array = tileMap.get_used_cells(0)
	tileMap.clear()
	walker.queue_free()
	
	var using_cells : Array = []
	var not_using_cells : Array = []
	
	for cell in all_cells:
		if !map.has(Vector2(cell.x, cell.y)):
			using_cells.append(cell)
		else:
			not_using_cells.append(cell)
	tileMap.set_cells_terrain_connect(0, using_cells, 0, 0, false)
	tileMap.set_cells_terrain_connect(0, not_using_cells, 0, 1, false)

func _input(event):
	if event.is_action_pressed("ui_accept"):
		reload_level()

