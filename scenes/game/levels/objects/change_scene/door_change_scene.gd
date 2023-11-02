extends Node2D
## Script de objeto para cambio de escena.
##
## Es un nodo que representa un objeto y al entrar en contacto cambia a una siguiente escena
## Cambio de escenas: https://docs.google.com/document/d/1eIBtgr8wln1pT0aZ4c-YWk_pqngyBg4HDsgdYLAXv28/edit?usp=sharing
## Uso de señales: https://docs.google.com/document/d/1vFSOuJkBy7xr5jksgCBNaTpqJHE_K87ZNafB5ZJ_I0M/edit?usp=sharing
## Uso de objetos para cambio de escena: https://docs.google.com/document/d/1DeAuU4dYa7DsWs-ht5Aiq4mFraOOu7hraNgIeSZn4lA/edit?usp=sharing
var _number_1: TextureRect

@onready var crabby_group = $EnemyGroup/Crabby
# Ruta de la escena a cargar
@export var _path_to_scene = ""

# Referencia al area
@onready var _area = $Area2D

var door_keys = [] # C0, C1, ...
var is_open_door = false

# Función de inicialización
func _ready():
	_area.body_entered.connect(_load_next_level)
	# Llaves que necesita esta puerta
	_add_door_keys()

func _process(delta):
	pass

func _add_door_keys():
	var parent_node = get_parent()
	var keys_group = parent_node.get_tree().get_nodes_in_group("key")
	if keys_group.size() > 0:
		for i in range(keys_group.size()):  
			door_keys.push_back(keys_group[i].idKey)
			print(door_keys[i]) # C0, C1, ...

# Cargamos el siguiente nivel (la siguiente escena)
func _load_next_level(body):
	if body.is_in_group("player"):
		var living_enemies = get_tree().get_nodes_in_group("enemy").size()
		var enemies_died = false
		
		if living_enemies == 0:
			enemies_died = true
		else:
			enemies_died = false
			print("Te falta eliminar enemigos: " + str(living_enemies))
		
		if enemies_died:
			var player_keys = body.get_node("MainCharacterMovement").playerKeys
			
			print("door_keys: " + str(door_keys.size()) + "\n" + "player_keys: " + str(player_keys.size()))
			
			if door_keys.size() > 0 and player_keys.size() > 0:
				var keys_accepted = 0
				
				# Si un elemento de 'player_keys' está en door_keys.
				for i in player_keys.size():
					if player_keys[i] in door_keys: 
						keys_accepted += 1
				
				var keys_in_possession = player_keys.filter(func(player_key):
					return door_keys.has(player_key)
				)
				var missing_keys = door_keys.filter(func(door_key):
					return not keys_in_possession.has(door_key)
				)
				
				if keys_accepted == door_keys.size():
					is_open_door = true
					if _path_to_scene != "":
						SceneTransition.change_scene(_path_to_scene)
				else:
					print("Tengo las llaves: " + str(keys_in_possession) + "/"+ str(door_keys)+"")
					print("Necesito más llaves de la puerta: " + str(missing_keys))
			else:
				print("Consigue llaves")
