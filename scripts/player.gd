extends Area2D

signal hit

@export var speed: float = 400 # Speed of the player in pixels per second
var screen_size: Vector2 # The size of the game window

# Called when the node enters the scene tree for the first time.
func _ready():
	hide()
	$CollisionShape2D.disabled = true
	screen_size = get_viewport_rect().size
	
func start(pos : Vector2):
	position = pos
	show()
	$CollisionShape2D.disabled = false


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	var velocity: Vector2 = Vector2.ZERO
	
	velocity = Input.get_vector("move_left", "move_right", "move_up", "move_down")
		
	if velocity.length() > 0:
		if velocity.length() > 1:
			velocity = velocity.normalized()
		velocity *= speed
		$AnimatedSprite2D.play()
		if abs(velocity.x) > abs(velocity.y):
			$AnimatedSprite2D.flip_v = false
			$AnimatedSprite2D.flip_h = velocity.x < 0
			$AnimatedSprite2D.animation = "walk"
		else:
			$AnimatedSprite2D.flip_v = velocity.y > 0
			$AnimatedSprite2D.flip_h = false
			$AnimatedSprite2D.animation = "walk"
	else:
		$AnimatedSprite2D.stop()
	
	position += velocity * delta
	position.x = clamp(position.x, 0, screen_size.x)
	position.y = clamp(position.y, 0, screen_size.y)

func _on_body_entered(body: Node2D) -> void:
	hide()
	hit.emit()
	$CollisionShape2D.set_deferred("disabled", true)
