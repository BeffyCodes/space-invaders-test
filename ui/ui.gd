class_name UI extends CanvasLayer

signal start_game()

@onready var score_label: ScoreLabel = %Score
@onready var main_menu: Control = %"Main Menu"
@onready var game_over: Control = %GameOver

var score := 0:
	set(new_score):
		score = new_score
		_update_score_label()

func _ready():
	_update_score_label()

func _update_score_label() -> void:
	score_label.text = "Score: " + str(score)
	
func _on_update_score(new_score: int) -> void:
	score += new_score

func _on_main_menu_start_game() -> void:
	start_game.emit()
