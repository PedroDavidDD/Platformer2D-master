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
	_area.body_entered.connect(_load_nex_level)

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
func _load_nex_level(body):
	# Cambiamos de escena si la ruta no está vacía y el personaje principa entra en contacto
	if body.is_in_group("player"):
			var living_enemies = get_tree().get_nodes_in_group("enemy").size()
			var number_keys_accept = 0
			
			if living_enemies == 0:
				if body.get_node("MainCharacterMovement").playerKeys.size() > 0:
					for i in range(body.get_node("MainCharacterMovement").playerKeys.size()):
						if (body.get_node("MainCharacterMovement").playerKeys[i] == door_keys[i]):
							# if (number_keys_accept == door_keys.size()):
							is_open_door = true
							if _path_to_scene != "":
								SceneTransition.change_scene(_path_to_scene)			
			else: 
				print("Enemies: {str}".format({"str": living_enemies}))

func _on_area_2d_body_entered(body):
	if body.is_in_group("player"):
		_add_door_keys()
