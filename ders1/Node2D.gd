extends Node2D


func _ready():
	$Button/AnimationPlayer.play("idle")



func _on_Button_mouse_entered():
	$Button/AnimationPlayer.play("bigger")


func _on_Button_mouse_exited():
		$Button/AnimationPlayer.play("lost")
