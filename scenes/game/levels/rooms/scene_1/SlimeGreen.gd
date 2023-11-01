extends CharacterBody2D

# Variables de animación de la poción y audio
@onready var _slimeBasic = $SlimeBasic

func _ready():
	if _slimeBasic:
		_slimeBasic.play()

func _process(delta):
	pass

func _on_area_2d_body_entered(body):
	if body.is_in_group("player"):
		print(body.name, " slime: body")

		var player = body
		var player_script = player.get_node("MainCharacterMovement")		
		var jumpBefore = player_script.jump

		if player_script:			
			player_script.hit(1)
			player_script.jump = jumpBefore + 100
			await get_tree().create_timer(2).timeout
			player_script.jump = jumpBefore 
		else:
			print("Player: null")			
		# HealthDashboard.add_life(5)
		self.queue_free()  # Liberamos la memoria




