extends Area2D
class_name Bullet

const BULLET_SPEED := 200.00
const BULLET_DAMAGE := 1
const BULLET_EXPLOSION := preload(("res://bullet/bullet_explosion.tscn"))

var direction := Vector2.UP
var layer = 1

func _physics_process(delta: float) -> void:
	position += direction * BULLET_SPEED * delta

func set_direction(new_dir: Vector2) -> void:
	direction = new_dir
	
func set_mask(new_mask: int):
	#collision_mask = new_mask
	set_collision_mask_value(new_mask, true)

func bullet_hit(node_hit: Node2D) -> void:
	if node_hit.has_method("on_bullet_hit"):
		delete_bullet()
		
		var explosion := BULLET_EXPLOSION.instantiate()
		
		explosion.global_position = global_position

		node_hit.add_sibling(explosion)
		
		node_hit.on_bullet_hit(BULLET_DAMAGE)

func _on_body_entered(body: Node2D) -> void:
	bullet_hit(body)

func _on_area_entered(area: Area2D) -> void:
	bullet_hit(area)

func delete_bullet() -> void:
	queue_free()
