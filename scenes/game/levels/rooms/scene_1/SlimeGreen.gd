extends Node2D

# Variables de animación de la poción y audio
@onready var _slimeBasic = $SlimeBasic
# Called when the node enters the scene tree for the first time.
func _ready():
	_slimeBasic.play()

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass

func _on_area_2d_body_entered(body):
	if body.is_in_group("player"):
		print(body.name,"slime: body")

func _on_area_2d_area_entered(area):
	if area.is_in_group("player"):
		print(area.name,"slime: area")
