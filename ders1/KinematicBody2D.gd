extends KinematicBody2D

export (int) var speed = 150
export (int) var gravity = 600
export (int) var jump_speed = -200

var velocity = Vector2.ZERO

var on_ground = false

func _ready():
	var tilemap_rect = get_parent().get_node("TileMap").get_used_rect() #limit
	var tilemap_cell_size = get_parent().get_node("TileMap").cell_size #limit
	$Camera2D.limit_left = tilemap_rect.position.x * tilemap_cell_size.x #limit
	$Camera2D.limit_right = tilemap_rect.end.x * tilemap_cell_size.x #limit
	$Camera2D.limit_top = tilemap_rect.position.y * tilemap_cell_size.y #limit
	$Camera2D.limit_bottom = tilemap_rect.end.y * tilemap_cell_size.y #limit
	$AnimationPlayer.play("idle")

func get_input():
	velocity.x = 0
	if Input.is_action_pressed("right"):
		velocity.x += speed
		$Sprite.flip_h = false
		$AnimationPlayer.play("run")
	if Input.is_action_pressed("left"):
		velocity.x -= speed
		$Sprite.flip_h = true
		$AnimationPlayer.play("run")

func _physics_process(delta):
	get_input()
	velocity.y += gravity * delta
	velocity = move_and_slide(velocity, Vector2.UP)
	if Input.is_action_just_pressed("up"):
		if on_ground == true:
			velocity.y = jump_speed
			on_ground = false
		if is_on_floor():
			on_ground = true
		else:
			on_ground = false
			if velocity.y < 0:
				$AnimationPlayer.play("jump")
			else: 
				$AnimationPlayer.play("fall")
	if not is_on_floor(): #jump ve fall animasyonu fix
		if velocity.y < 0: #jump ve fall animasyonu fix
			$AnimationPlayer.play("jump") #jump animasyonu
		else:
			$AnimationPlayer.play("fall") #fall animasyonu
			yield($AnimationPlayer, "animation_finished") #animasyon bittikten sonra. yield: getiri
			_ready()
	if Input.is_action_just_released("right"):
		_ready()
	if Input.is_action_just_released("left"):
		_ready()



