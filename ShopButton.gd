extends Button

export var cost:int;

func _ready():
	text = get_name() + "+ :" + String(cost) + "Gold";

func _pressed():
	text = get_name() + "+ :" + String(cost) + "Gold";
