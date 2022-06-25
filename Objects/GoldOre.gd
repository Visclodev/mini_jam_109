extends Node2D

export var health = 20;
export var gold = 20;
onready var hitSfx : AudioStreamPlayer2D = get_node("HitSfx");
onready var goldBreakRes = load("res://Objects/GoldBreak.tscn");
var goldSpawnPoint;
var goldSpawner;
var rng = RandomNumberGenerator.new();

func _ready():
	goldSpawner = get_parent().get_node("GoldSpawner");
	for i in goldSpawner.get_children():
		if i.hasGold and i.position == position:
			goldSpawnPoint = i;

func _on_Area2D_body_entered(body):
	if (body.is_in_group("bullet")):
		health -= 1;
		body.queue_free();
		hitSfx.pitch_scale = rng.randf_range(0.5, 1.5);
		hitSfx.play();
	if (health <= 0):
		get_parent().get_node("Player").gold += gold;
		goldSpawner.goldOres -= 1;
		goldSpawnPoint.hasGold = false;
		var goldBreakFX = goldBreakRes.instance();
		goldBreakFX.position = position;
		get_parent().add_child(goldBreakFX);
		queue_free();
