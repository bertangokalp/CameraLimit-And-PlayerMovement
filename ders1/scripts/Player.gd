extends KinematicBody2D


export (int) var speed = 120
export (int) var gravity = 400


var velocity = Vector2.ZERO

export (float,0,1.0) var friction = 10
export (float,0,1.0) var acceleration = 25

enum state {IDLE, RUNNING}

var player_state = state.IDLE

func get_input():
	var dir = Input.get_action_strength("ui_right") - Input.get_action_strength("ui_left")
	if dir != 0:
		velocity.x = move_toward(velocity.x, dir * speed, acceleration)
	else:
		velocity.x = move_toward(velocity.x, 0, friction)

func update_animation():
	if velocity.x < 0:
		$Sprite.flip_h = true
	if velocity.x > 0:
		$Sprite.flip_h = false
	match(player_state):
		state.IDLE:
			$AnimationPlayer.play("idle")
		state.RUNNING:
			$AnimationPlayer.play("run")

func _physics_process(delta):
	get_input()
	if velocity.x == 0:
		velocity.x = 0
		player_state = state.IDLE
	elif velocity.x != 0:
		player_state = state.RUNNING
	
	

	velocity = move_and_slide(velocity, Vector2.UP)
	update_animation()
	
