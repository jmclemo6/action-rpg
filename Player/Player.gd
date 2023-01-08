extends KinematicBody2D

onready var ANIMATION_PLAYER = $AnimationPlayer
onready var ANIMATION_TREE = $AnimationTree
onready var ANIMATION_STATE = ANIMATION_TREE.get("parameters/playback")

var velocity = Vector2.ZERO
const WALK_SPEED = 50
const RUN_SPEED = 75
const WALK_ACCELERATION = 100
const SPRINT_ACCELERATION = 200

func _physics_process(delta):
	var input_vector = Vector2(
		Input.get_axis("player_left", "player_right"),
		Input.get_axis("player_up", "player_down")
	)
	input_vector = input_vector.normalized()

	if input_vector != Vector2.ZERO:
		var acceleration;
		var max_speed
		if Input.is_action_pressed("player_sprint"):
			acceleration = SPRINT_ACCELERATION
			max_speed = RUN_SPEED
		else:
			acceleration = WALK_ACCELERATION
			max_speed = WALK_SPEED
		velocity = velocity.move_toward(input_vector * max_speed, acceleration * delta)
		ANIMATION_TREE.set("parameters/Idle/blend_position",input_vector)
		ANIMATION_TREE.set("parameters/Run/blend_position", input_vector)
		ANIMATION_STATE.travel("Run")
	else:
		velocity = Vector2.ZERO
		ANIMATION_STATE.travel("Idle")
	
	velocity = move_and_slide(velocity)
	
