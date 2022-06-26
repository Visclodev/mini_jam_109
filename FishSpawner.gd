extends Node2D

onready var fishRes = load("res://Objects/Fish.tscn");
var spawnRate = 1;
var nextSpawn = 0;
var rng = RandomNumberGenerator.new();

func _process(delta):
	if nextSpawn <= 0:
		print("spawn");
		var fish = fishRes.instance();
		var spawnPoints = get_children();
		fish.position = spawnPoints[rng.randi_range(0, spawnPoints.size() -1)].position;
		get_parent().add_child(fish)
		nextSpawn = spawnRate;
	nextSpawn -= delta
