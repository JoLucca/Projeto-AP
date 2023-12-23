extends AnimatableBody2D

@onready var anim := $anim as AnimationPlayer
@onready var respawn := $respawn as Timer
@onready var respawn_position := global_position

@export var reset_timer := 3.0

var velocity := Vector2.ZERO
var gravity = ProjectSettings.get_setting("physics/2d/default_gravity")
var is_triggered := false

# Called when the node enters the scene tree for the first time.
func _ready():
	set_physics_process(false)


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _physics_process(delta):
	velocity.y += gravity * delta
	position += velocity * delta
	
func has_collided_with(collision: KinematicCollision2D, collider: CharacterBody2D):
	if !is_triggered:
		is_triggered = true
		anim.play("shake")
		velocity = Vector2.ZERO


func _on_anim_animation_finished(anim_name):
	set_physics_process(true)
	respawn.start(reset_timer)

func _on_respawn_timeout():
	set_physics_process(false)
	global_position = respawn_position 
	if is_triggered:
		var spawn_tween = create_tween().set_trans(Tween.TRANS_BACK).set_ease(Tween.EASE_OUT)
		spawn_tween.tween_property($texture, "scale", Vector2(1.0, 1.0), 0.5).from(Vector2(0.1, 0.1))
	is_triggered = false
