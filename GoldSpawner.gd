extends Node2D

onready var goldOreRes = load("res://Objects/GoldOre.tscn");
var rng = RandomNumberGenerator.new();

export var maxGoldOres = 5;
export var goldOres = 0;
export var spawnRate = 5;
var nextSpawn = 0;

func  _spawnGoldOre(spawnPoint):
	var goldOre = goldOreRes.instance();
	goldOre.global_position = spawnPoint.position;
	spawnPoint.hasGold = true;
	get_parent().add_child(goldOre);
	goldOres += 1;

func _process(delta):
	if (nextSpawn <= 0 and goldOres < maxGoldOres):
		nextSpawn = spawnRate;
		var spawnPoints = get_children();
		var freeSpawnPoints = [];
		for i in spawnPoints:
			if not i.hasGold:
				freeSpawnPoints.append(i);
		if freeSpawnPoints.size() != 0:
			_spawnGoldOre(freeSpawnPoints[rng.randi_range(0, freeSpawnPoints.size() - 1)]);
	else:
		nextSpawn -= delta;
