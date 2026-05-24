class_name Game extends Node2D

@export var WorldScene: PackedScene
@export var PlayerScene: PackedScene
@export var SmenimiesScene: PackedScene

@export var ui: UI

var smenimies: Smenimies
var world: World
var player: PlayerShip

func start_game():
	ui.score = 0
	
	world = WorldScene.instantiate()
	smenimies = SmenimiesScene.instantiate()
	player = PlayerScene.instantiate()
	
	# Add and wire up the game world
	add_child(world)
	move_child(world, 0)
	world.game_over.connect(_on_game_over)
	world.update_score.connect(ui._on_update_score)
	
	# Add, wire up, and position the player
	add_child(player)
	player.destroyed.connect(_on_game_over)
	player.global_position = Vector2(304, 345)
	
	# Add, wire, and position up the smenimies block
	add_child(smenimies)
	smenimies.update_score.connect(ui._on_update_score)
	smenimies.end_game.connect(_on_game_over)
	smenimies.global_position = Vector2(188, 63)


func _on_ui_start_game() -> void:
	start_game()

func _on_game_over(won: bool) -> void:
	if world:
		world.queue_free()
	
	if player:
		player.queue_free()
	
	if smenimies:
		smenimies.queue_free()
	
	if won:
		ui.game_over.title.text = "You won.\n\nThe president of the world thanks you.\n\nNow go back to work."
	else:
		ui.game_over.title.text = "You lost.\n\nYour entire planet was counting on you.\n\nYou have failed them."
	
	ui.game_over.visible = true
