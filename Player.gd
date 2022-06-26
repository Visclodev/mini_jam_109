extends KinematicBody2D

onready var bulletRes = load("res://Objects/Bullet.tscn")
onready var hitParticlesRes = load("res://Objects/HitParticles.tscn")
onready var shootingPointA = get_node("ShootingPointA");
onready var shootingPointB = get_node("ShootingPointB");
onready var energyLabel = get_node("EnergyLabel");
onready var pointsLabel = get_node("PointsLabel");
onready var goldLabel = get_node("GoldLabel");
onready var hider = get_node("Camera/Hider");

export var speed = 500;
export var fireRate = 0.1;
var nextFire = 0;
export var firePower = 750;
export var maxEnergy = 100;
export var energy = 100;
export var gold = 0;
var damage = 1;
export var points = 0;
export var regenergy = 1;
var nextDeathParticle = 0;
var isDead = false;

func _ready():
	pass

func _movement(delta):
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
		bulletA.damage = damage;
		bulletB.damage = damage;
		nextFire = fireRate;
		energy -= 1;
	if nextFire > 0:
		nextFire -= delta;

func _process(delta):
	# labels
	energyLabel.text = String(energy);
	goldLabel.text = String(gold);
	pointsLabel.text = String(points);
	if energy <= 0:
		isDead = true;
	if isDead:
		energyLabel.text = "NO MORE ENERGY!!"
		hider.modulate.a += 0.5 * delta;
		if nextDeathParticle <= 0:
			_hitParticle();
			nextDeathParticle = 0.5;
		else:
			nextDeathParticle -= delta;
		if hider.modulate.a >= 2:
			var deathScene = load("res://Scenes/DeathScene.tscn").instance();
			deathScene.get_node("Score").text = String(points);
			get_parent().get_parent().add_child(deathScene);
			get_tree().change_scene_to(deathScene);
		return;
		

	# movement
	look_at(get_global_mouse_position());
	_movement(delta);

	# shooting
	_fire(delta);

func _hitParticle():
	var hitParticles = hitParticlesRes.instance();
	hitParticles.position = position;
	get_parent().add_child(hitParticles);

func _on_Area2D_body_entered(body):
	if body.is_in_group("enemy"):
		energy -= 20;
		_hitParticle();
		body.die();

func _on_FirePower_button_down():
	var cost = get_parent().get_node("Shop/FirePower").cost
	if (gold >= cost):
		gold -= cost;
		damage += 1;
		get_parent().get_node("Shop/FirePower").cost += 50;

func _on_RegEnergy_button_down():
	var cost = get_parent().get_node("Shop/RegEnergy").cost
	if (gold >= cost):
		gold -= cost;
		regenergy += 1;
		get_parent().get_node("Shop/RegEnergy").cost += 50;


func _on_FireRate_button_down():
	var cost = get_parent().get_node("Shop/FireRate").cost
	if (gold >= cost):
		gold -= cost;
		fireRate -= 0.05;
		get_parent().get_node("Shop/FireRate").cost += 50;


func _on_EnergyMax_button_down():
	var cost = get_parent().get_node("Shop/EnergyMax").cost;
	if (gold >= cost):
		gold -= cost;
		maxEnergy += 50;
		get_parent().get_node("Shop/EnergyMax").cost += 50;
