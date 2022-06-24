extends KinematicBody2D

onready var player = get_parent().get_node("Player");
export var speed = 50;

func _process(delta):
	look_at(player.position);
	move_and_collide(transform.x * delta * speed)
	pass
