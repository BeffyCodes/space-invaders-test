extends Control

signal restart_game
@onready var title: Label = %Title

func _on_restart_pressed() -> void:
	restart_game.emit()
	hide()


func _on_exit_pressed() -> void:
	get_tree().quit(0)
