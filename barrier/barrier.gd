extends Area2D


func _process(_delta: float) -> void:
	if get_child_count() == 1:
		queue_free()
