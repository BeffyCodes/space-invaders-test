class_name PlayerShip extends CharacterBody2D

signal destroyed(won: bool)

const SPEED := 250.0
const BULLET_RESOURCE := preload("uid://roxd4iwbsnj1")

func _physics_process(_delta: float) -> void:
	var direction := Input.get_axis("Move Left","Move Right")
	
	if direction:
		velocity.x = direction * SPEED
	else:
		velocity.x = move_toward(velocity.x, 0, SPEED)

	move_and_slide()

func _input(event: InputEvent) -> void:
	if event.is_action_pressed("Shoot") and %ShootCooldown.is_stopped():
		shoot() 
	

func shoot() -> void:
	%ShootCooldown.start()
	var new_bullet: Bullet = BULLET_RESOURCE.instantiate()
	
	new_bullet.set_direction(Vector2.UP)
	new_bullet.set_mask(1)
	new_bullet.set_mask(2)
	
	new_bullet.global_position = %ShootingPoint.global_position
	
	%ShootingPoint.add_child(new_bullet)
	

func on_bullet_hit(_damage: int) -> void:
	destroyed.emit(false)
	
	
