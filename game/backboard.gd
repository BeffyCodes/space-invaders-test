class_name Backboard extends Area2D

signal got_hit(points: int)

func on_bullet_hit(_damage: int) -> void:
	got_hit.emit(-10)
