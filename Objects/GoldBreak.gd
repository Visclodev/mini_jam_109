extends CPUParticles2D

var objLifetime = 6;

func _ready():
	emitting = true;

func _process(delta):
	objLifetime -= delta;
	if objLifetime <= 0:
		queue_free();
