extends Node2D

onready var fishRes = load("res://Objects/Fish.tscn");
var spawnRate = 1;
var nextSpawn = 0;
var rng = RandomNumberGenerator.new();

func _process(delta):
	if nextSpawn <= 0:
		print("spawn");
		var fish = fishRes.instance();
		var direction = rng.randi_range(0, 3);
		if direction == 0:
			fish.position = Vector2(-20, rng.randi_range(0, 720));
		if direction == 1:
			fish.position = Vector2(1300, rng.randi_range(0, 720));
		if direction == 2:
			fish.position = Vector2(rng.randi_range(0, 1280), -20);
		if direction == 3:
			fish.position = Vector2(rng.randi_range(0, 1280), 760);
		get_parent().get_parent().get_parent().add_child(fish)
		nextSpawn = spawnRate;
	nextSpawn -= delta
