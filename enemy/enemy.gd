class_name Enemy extends CharacterBody2D

const COOLDOWN_MIN: float = 1.5
const COOLDOWN_MAX: float = 5

var BULLET_RESOURCE: Resource

signal got_shot(score: int)

func _ready() -> void:
	var parent_group: Smenimies = get_parent()
	BULLET_RESOURCE = parent_group.BULLET_RESOURCE
	 
	var cooldown = randf_range(.5,1)
	%ShootTimer.start(cooldown)

func shoot() -> void:
	var cooldown = randf_range(COOLDOWN_MIN,COOLDOWN_MAX)
	%ShootTimer.start(cooldown)
	
	var new_bullet: Bullet = BULLET_RESOURCE.instantiate()
	
	new_bullet.set_direction(Vector2.DOWN)
	new_bullet.set_mask(1)
	
	new_bullet.global_position = %ShootingPoint.global_position
	
	%ShootingPoint.add_child(new_bullet)

func on_bullet_hit(_damage: int) -> void:
	got_shot.emit(10)
	queue_free()


func _on_shoot_timer_timeout() -> void:
	shoot()

func _on_am_i_in_front_detector_body_entered(_body: Node2D) -> void:
	%ShootTimer.stop()

func _on_am_i_in_front_detector_body_exited(body: Node2D) -> void:
	if is_queued_for_deletion():
		return;
	
	var cooldown = randf_range(COOLDOWN_MIN,COOLDOWN_MAX)
	
	
	var bodies_remaining: Array[Node2D] = %AmIInFrontDetector.get_overlapping_bodies()
	bodies_remaining.erase(body)
		
	if bodies_remaining.is_empty():
		%ShootTimer.start(cooldown)
