extends Node2D

onready var robotoSprite = get_node("Roboto")

func _ready():
	var sceneCount = get_parent().get_child_count();
	if sceneCount > 1:
		get_parent().get_node("DeathScene").queue_free();

func _process(delta):
	robotoSprite.rotation_degrees += delta * 10;
	if (robotoSprite.rotation_degrees >= 360):
		robotoSprite.rotation_degrees = 0;

func _on_Quit_button_up():
	get_tree().quit();

func _on_Play_button_up():
	get_node("HowToPlay").visible = true;

func _on_HowToPlay_button_up():
	get_tree().change_scene("res://Scenes/Main.tscn")

func _on_Button_button_up():
	get_node("HowToPlay").visible = false;
