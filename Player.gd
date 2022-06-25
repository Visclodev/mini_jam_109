extends KinematicBody2D

onready var bulletRes = load("res://Objects/Bullet.tscn")
onready var shootingPointA = get_node("ShootingPointA");
onready var shootingPointB = get_node("ShootingPointB");
onready var energyLabel = get_node("EnergyLabel");
onready var goldLabel = get_node("GoldLabel");

export var speed = 500;
export var fireRate = 0.1;
var nextFire = 0;
export var firePower = 750;
export var energy = 100;
export var gold = 0;

func _ready():
	pass

func _movement(delta):
	var step = speed;
	if Input.is_action_pressed("walk_up"):
		move_and_slide(Vector2(0, -1) * speed);
	if Input.is_action_pressed("walk_down"):
		move_and_slide(Vector2(0, 1) * speed);
	if Input.is_action_pressed("walk_left"):
		move_and_slide(Vector2(-1, 0) * speed);
	if Input.is_action_pressed("walk_right"):
		move_and_slide(Vector2(1, 0) * speed);

func _fire(delta):
	if Input.is_action_pressed("fire") and nextFire <= 0:
		var bulletA:RigidBody2D = bulletRes.instance();
		var bulletB:RigidBody2D = bulletRes.instance();
		bulletA.position = shootingPointA.global_position;
		bulletB.position = shootingPointB.global_position;
		get_parent().add_child(bulletA);
		get_parent().add_child(bulletB);
		bulletA.look_at(get_global_mouse_position());
		bulletB.look_at(get_global_mouse_position());
		bulletA.apply_central_impulse(bulletA.transform.x * firePower);
		bulletB.apply_central_impulse(bulletB.transform.x * firePower);
		nextFire = fireRate;
		energy -= 1;
	if nextFire > 0:
		nextFire -= delta;

func _process(delta):
	# labels
	energyLabel.text = "Energy: " + String(energy);
	if energy <= 0:
		energyLabel.text = "DEAD"
	goldLabel.text = "Gold: " + String(gold);

	# movement
	look_at(get_global_mouse_position());
	_movement(delta);

	# shooting
	_fire(delta);
