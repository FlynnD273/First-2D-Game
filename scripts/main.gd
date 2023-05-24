extends Node

@export var mob_scene: PackedScene
@export var mob_spawn: PathFollow2D
var mob_spawn_parent: Path2D
var score: int

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	mob_spawn_parent = mob_spawn.get_parent()
	return

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass


func game_over() -> void:
	$ScoreTimer.stop()
	$MobTimer.stop()
	$HUD.show_game_over()
	get_tree().call_group("mobs", "queue_free")
	$Music.stop()
	$DeathSound.play()

func new_game() -> void:
	score = 0
	$Player.start($StartPosition.position)
	$StartTimer.start()
	$HUD.update_score(score)
	$HUD.show_message("Get Ready")
	$Music.play()

func _on_start_timer_timeout() -> void:
	$ScoreTimer.start()
	$MobTimer.start()

func _on_score_timer_timeout() -> void:
	score += 1
	$HUD.update_score(score)

func _on_mob_timer_timeout() -> void:
	var mob: RigidBody2D = mob_scene.instantiate()
	mob_spawn.progress_ratio = randf()
	
	var direction: float = mob_spawn.rotation + PI / 2
	direction += randf_range(-PI / 4, PI / 4)
	
	mob.position = mob_spawn.global_position
	mob.rotation = direction
	
	var velocity: Vector2 = Vector2(randf_range(150, 250), 0)
	mob.linear_velocity = velocity.rotated(direction)
	
	add_child(mob)
