extends Node2D

var weapon_sprite : AnimatedSprite2D
var rotation_speed : float = 5.0
var rotation_degrees : float = 0.0

func _ready():
	# Obtener la referencia al AnimatedSprite2D
	weapon_sprite = $AnimatedSprite2D

func _process(delta):
	# Obtener la posición del mouse en relación con la ventana del juego
	var mouse_position = get_viewport().get_mouse_position()

	# Obtener la posición del arma en relación con la pantalla
	var weapon_position = global_position

	# Calcular la dirección desde el arma hasta la posición del mouse
	var direction = (mouse_position - weapon_position).normalized()

	# Calcular el ángulo de rotación en radianes
	var rotation_angle = atan2(direction.y, direction.x)

	# Convertir el ángulo a grados y ajustar la rotación del arma gradualmente
	var target_rotation_degrees = rad2deg(rotation_angle) - 90  # Ajuste según la orientación de la textura del arma
	target_rotation_degrees = fmod(target_rotation_degrees + 360, 360)  # Asegurar que la rotación esté en el rango [0, 360]

	rotation_degrees = lerp_angle(rotation_degrees, target_rotation_degrees, rotation_speed * delta)

	# Aplicar la rotación al nodo del arma
	rotate_object_local(Vector3(0, 0, 1), deg2rad(rotation_degrees))

func lerp_angle(start: float, end: float, weight: float) -> float:
	# Función de interpolación lineal para ángulos
	var result = (1.0 - weight) * start + weight * end
	if abs(end - start) > 180.0:
		# Ajustar la interpolación para tomar el camino más corto
		result += 360.0 if start > end else -360.0
	return result
