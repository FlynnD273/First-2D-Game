extends RigidBody2D


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	var animations: PackedStringArray = $AnimatedSprite2D.get_sprite_frames().get_animation_names()
	$AnimatedSprite2D.play(animations[randi() % animations.size()])

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass


func _on_visible_on_screen_notifier_2d_screen_exited() -> void:
	queue_free()
