class_name Smenimies extends AnimatableBody2D

const BULLET_RESOURCE: Resource = preload("uid://roxd4iwbsnj1")
var direction := Vector2.RIGHT
var SPEED := 100

signal update_score(new_score: int)
signal end_game(won: bool)

@onready var collision_shape_2d: CollisionShape2D = $CollisionShape2D


func _physics_process(delta: float) -> void:
	# When only the collision shape is left, game is over
	if get_child_count() == 1:
		end_game.emit(true)
	
	var move_result := move_and_collide(direction * SPEED * delta)
	
	if move_result:
		var collider := move_result.get_collider()
		if collider:
			direction.x *= -1
			global_position.y = global_position.y + 15
			
			if direction.x < 0:
				SPEED += 25


func _on_enemy_got_shot(score: int) -> void:
	update_score.emit(score)
