extends Sprite2D

var idKey = "C" + str(randi() % 100)  # Genera un número aleatorio entre 0 y 99 y lo concatena con "C".

@onready var textKey = $TextKey

func _ready():
	textKey.text = str(idKey)

func _process(delta):
	pass

func _on_area_2d_body_entered(body):
	if body.is_in_group("player"):
		var player_keys = body.get_node("MainCharacterMovement").playerKeys
		player_keys.push_back(idKey)
		self.queue_free()
