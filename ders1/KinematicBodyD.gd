extends KinematicBody2D

export (int) var speed = 150
export (int) var gravity = 1800
export (int) var jump_speed = -200

var velocity = Vector2.ZERO

func _ready():
	$AnimationPlayer2D.play("idle")

func get_input():
	velocity.x = 0
	if Input.is_action_pressed("right"):
		velocity.x += speed
		$Sprite.flip_h = false
		$AnimationPlayer2D.play("run")
	if Input.is_action_pressed("left"):
		velocity.x -= speed
		$Sprite.flip_h = true
		$AnimationPlayer2D.play("run")

func _physics_process(delta):
	get_input()
	velocity.y += gravity * delta
	velocity = move_and_slide(velocity, Vector2.UP)
	if Input.is_action_just_pressed("up"):
		if is_on_floor():
			velocity.y = jump_speed
	if not is_on_floor():
		if velocity.y < 0:
			$AnimationPlayer2D.play("jump")
		else:
			$AnimationPlayer2D.play("fall")
			yield($AnimationPlayer2D, "animation_finished")
			_ready()
	if Input.is_action_just_released("right"):
		_ready()
	if Input.is_action_just_released("left"):
		_ready()
