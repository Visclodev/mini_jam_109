extends KinematicBody2D

onready var bulletRes = load("res://Objects/Bullet.tscn")
onready var shootingPointA = get_node("ShootingPointA");
onready var shootingPointB = get_node("ShootingPointB");

export var speed = 500;

func _ready():
	pass

func _movement(delta):
	var step = delta * speed;
	if Input.is_action_pressed("walk_up"):
		position.y -= step;
	if Input.is_action_pressed("walk_down"):
		position.y += step;
	if Input.is_action_pressed("walk_left"):
		position.x -= step;
	if Input.is_action_pressed("walk_right"):
		position.x += step;

func _fire(delta):
	if Input.is_action_pressed("fire"):
		var bulletA = bulletRes.instance();
		var bulletB = bulletRes.instance();
		bulletA.position = shootingPointA.position;
		bulletB.position = shootingPointB.position;
		get_parent().add_child(bulletA);
		get_parent().add_child(bulletB);
		print("fire");

func _process(delta):
	look_at(get_global_mouse_position());
	_movement(delta);
	_fire(delta);
	pass
