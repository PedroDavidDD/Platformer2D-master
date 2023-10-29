extends CharacterBody2D

# Variables de animación de la poción y audio
@onready var _slimeBasic = $SlimeBasic

func _ready():
	_slimeBasic.play()

func _process(delta):
	pass

func _on_area_2d_body_entered(body):
	if body.is_in_group("player"):
		print(body.name, " slime: body")

		# Accede al nodo del jugador y almacena su script
		var player = body
		var player_script = player.get_node("MainCharacterMovement")		
		var jumpBefore = player_script.jump

		# Verifica si player_script no es nulo
		if player_script:
			player_script.jump = jumpBefore + 100
			await get_tree().create_timer(2).timeout
			player_script.jump = jumpBefore 
		else:
			print("Player script is null")			
		# HealthDashboard.add_life(5)
		player_script.hit(1)
		self.queue_free()  # Liberamos la memoria




