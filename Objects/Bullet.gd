extends RigidBody2D

export var damage = 1;
var lifetime = 5;

func _process(delta):
	lifetime -= delta;
	if (lifetime <= 0):
		queue_free();
