extends KinematicBody2D

onready var player:KinematicBody2D = get_parent().get_node("Player");
onready var hitSfx = get_node("HitSfx");
onready var fishDeadRes = load("res://Objects/FishBreak.tscn");
export var speed = 50;
export var health = 10;

func _process(delta):
	look_at(player.position);
	move_and_collide(transform.x * delta * speed)
	if rotation_degrees <= 180:
		get_node("Sprite").flip_v = true;
	else:
		get_node("Sprite").flip_v = false;
	pass

func die():
	var fishDeadFx = fishDeadRes.instance();
	get_parent().add_child(fishDeadFx);
	fishDeadFx.position = position;
	queue_free();

func _on_HitBox_body_entered(body):
	if body.is_in_group("bullet"):
		body.queue_free();
		hitSfx.play();
		health -= body.damage;
	if health <= 0:
		get_parent().get_node("Player").points += 5;
		die();
