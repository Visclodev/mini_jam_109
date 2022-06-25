extends Area2D

export var chargeRate = 1;
var nextCharge = 0;
export var chargeAmount = 10;
onready var player = get_parent().get_node("Player");
var shouldCharge = false;

func _process(delta):
	if shouldCharge and nextCharge <= 0:
		player.energy += chargeAmount;
		if (player.energy > player.maxEnergy):
			player.energy = player.maxEnergy;
		nextCharge = chargeRate;
	if nextCharge > 0:
		nextCharge -= delta;

func _on_Charger_body_entered(body):
	if body == player:
		shouldCharge = true;

func _on_Charger_body_exited(body):
	if body == player:
		shouldCharge = false;
