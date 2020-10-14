extends Node2D

onready var tileMap = $TileMap

const PLAYER = preload("res://shooter/Player.tscn")
const ENEMY = preload("res://shooter/Enemy.tscn")
const EXIT = preload("res://map/ExitDoor.tscn")

var boarders = Rect2(1, 1, 38, 21)
var rng = RandomNumberGenerator.new()
var enemies = []
var exit

export (int) var n_enemies = 2

func _ready():
	randomize()
	generate_level()

func generate_level():
	var walker = Walker.new(Vector2(19, 11), boarders)
	var map = walker.walk(500)

	var player = PLAYER.instance()
	add_child(player)
	player.position = map.front() * 32

	for _ene in range(n_enemies):
		var enemy = ENEMY.instance()
		add_child(enemy)
		rng.randomize()
		var chance = rng.randi_range(int((len(map) - 1.0) / 2), len(map) - 2)
		enemy.position = map[chance] * 32
	
	exit = EXIT.instance()
	add_child(exit)
	exit.position = walker.get_end_room().position * 32
	exit.hide()
	
	walker.queue_free()
	for location in map:
		tileMap.set_cellv(location, -1)
	tileMap.update_bitmask_region(boarders.position, boarders.end)

func reload_level():
	var _reload = get_tree().reload_current_scene()
	
func _input(event):
	if event.is_action_pressed("ui_accept"):
		reload_level()

func _process(delta):
	enemies = get_tree().get_nodes_in_group("enemy")
	if len(enemies) == 0:
		exit.connect("leaving_level", self, "reload_level")
		exit.show()
