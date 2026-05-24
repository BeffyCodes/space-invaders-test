extends Area2D


func on_bullet_hit(_damage) -> void:
	queue_free()
