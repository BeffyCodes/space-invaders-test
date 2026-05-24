class_name World extends Node2D

signal update_score(points: int)
signal game_over


func _on_backboard_got_hit(points: int) -> void:
	update_score.emit(points)


func _on_defeat_zone_area_entered(_area: Area2D) -> void:
	game_over.emit(false)
