extends Node2D

onready var bulletRes = load("res://Objects/Bullet.tscn")
onready var shootingPointA = get_node("Body").get_node("ShootingPointA");
onready var shootingPointB = get_node("Body").get_node("ShootingPointB");
onready var energyLabel = get_node("EnergyLabel");
onready var body = get_node("Body");

export var speed = 500;
export var fireRate = 0.1;
var nextFire = 0;
export var firePower = 750;
export var energy = 100;

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
	if Input.is_action_pressed("fire") and nextFire <= 0:
		var bulletA:RigidBody2D = bulletRes.instance();
		var bulletB:RigidBody2D = bulletRes.instance();
		bulletA.position = shootingPointA.global_position;
		bulletB.position = shootingPointB.global_position;
		bulletA.look_at(get_global_mouse_position());
		bulletB.look_at(get_global_mouse_position());
		bulletA.apply_central_impulse(bulletA.transform.x * firePower);
		bulletB.apply_central_impulse(bulletB.transform.x * firePower);
		get_parent().add_child(bulletA);
		get_parent().add_child(bulletB);
		nextFire = fireRate;
		energy -= 1;
	if nextFire > 0:
		nextFire -= delta;

func _process(delta):
	energyLabel.text = "Energy: " + String(energy);
	if energy <= 0:
		energyLabel.text = "DEAD"
	# movement
	body.look_at(get_global_mouse_position());
	_movement(delta);
	
	# shooting
	_fire(delta);
	pass
