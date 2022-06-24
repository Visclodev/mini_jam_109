extends KinematicBody2D

onready var player = get_parent().get_node("Player");
export var speed = 50;

func _process(delta):
	look_at(player.position);
	move_and_collide(transform.x * delta * speed)
	if rotation_degrees <= 180:
		get_node("Sprite").flip_v = true;
	else:
		get_node("Sprite").flip_v = false;
	pass


func _on_HitBox_body_entered(body):
	if body.is_in_group("bullet"):
		body.queue_free();
		queue_free();
