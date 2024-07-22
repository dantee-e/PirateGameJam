extends CharacterBody2D

"""
layer 1 eh agua
layer 2 eh fogo
layer 3 eh terra
layer 4 eh ar
"""








@export var speed = 30
@export var rotation_speed = 2.5
@export var cons_atenuacao_vol = 1



@onready var game_manager = %GameManager
@onready var detector_paredes = $DetectorParedes
@onready var player_collision = $CollisionShape2D
@onready var animated_sprite = $AnimatedSprite2D
@onready var tile_map = $"../TileMap"

# assets dos sons
@onready var water_sounds = $"../Sounds/WaterSounds2D"
@onready var fire_sounds = $"../Sounds/FireSounds2D"
@onready var earth_sounds = $"../Sounds/EarthSounds2D"
@onready var air_sounds = $"../Sounds/AirSounds2D"



var left_right
var up_down

var n_to_str = {1:'water', 2:'fire', 3:'earth', 4:'air'}
var str_to_n = {'water':1, 'fire':2, 'earth':3, 'air':4}

var tipo_tile_custom_data = "tipo"
var collider
var colliding : bool
var elemento_atual = 1
var current_level = 1

func pos(value):
	if (value):
		return value
	else:
		return -value

func get_inputs():
	left_right = Input.get_axis("turn_left", "turn_right")
	up_down = Input.get_axis("front", "back")
	if (Input.is_action_just_pressed("change_element")):
		elemento_atual = elemento_atual+1 if elemento_atual < 4 else 1
		change_element(elemento_atual)


func change_element(new_element):
	for i in range(1, 5):
		set_collision_mask_value(i, false)
	set_collision_mask_value(new_element, true)
	elemento_atual = new_element
	match new_element:
		1:
			animated_sprite.play("water")
		2:
			animated_sprite.play("fire")
		3:
			animated_sprite.play("earth")
		4:
			animated_sprite.play("air")

func get_distances(origin, blocos_proximos):
	# para cada colisor
	for i in range(detector_paredes.get_collision_count()):
		collider = detector_paredes.get_collider(i)
		if collider is TileMap:
			# checa distancia e coordenadas e ve qual eh o tipo de bloco
			# precisa da normal pq o get_collision_point eh estranho
			var collision_point = detector_paredes.get_collision_point(i) - detector_paredes.get_collision_normal(i)*0.5
			var distance = origin.distance_to(collision_point)
			var cell_coords = collider.local_to_map(collision_point)
			
			var td = collider.get_cell_tile_data(0, cell_coords)

			if td:
				var tipo = td.get_custom_data(tipo_tile_custom_data)
				if tipo == n_to_str[elemento_atual]:
					continue
				# ve qual eh a menor distancia entre os blocos de tipo x
				match tipo:
					'water':
						if distance<blocos_proximos['water']:
							blocos_proximos['water'] = distance
					'fire':
						if distance<blocos_proximos['fire']:
							blocos_proximos['fire'] = distance
					'earth':
						if distance<blocos_proximos['earth']:
							blocos_proximos['earth'] = distance
					'air':
						if distance<blocos_proximos['air']:
							blocos_proximos['air'] = distance
			
	return blocos_proximos

func manage_sounds(blocos_proximos):
	for i in blocos_proximos:
		match i:
			'water':
				water_sounds.volume_db = -blocos_proximos['water']*cons_atenuacao_vol if blocos_proximos['water']!=0 else 0.0001
			'fire':
				fire_sounds.volume_db = -blocos_proximos['fire']*cons_atenuacao_vol if blocos_proximos['fire']!=0 else 0.0001
			'earth':
				earth_sounds.volume_db = -blocos_proximos['earth']*cons_atenuacao_vol if blocos_proximos['earth']!=0 else 0.0001
			'air':
				air_sounds.volume_db = -blocos_proximos['air']*cons_atenuacao_vol if blocos_proximos['air']!=0 else 0.0001
			
func _physics_process(delta):
	var blocos_proximos 
	
	get_inputs()
	#position += -transform.y * int(gas) * delta * speed
	#rotation += yaw * rotation_speed * delta
	position.y += up_down * delta * speed
	position.x += left_right * delta * speed
	
	if detector_paredes.is_colliding():
		colliding = 1
		var origin = detector_paredes.global_transform.origin
		blocos_proximos = {'water': 100, 'fire': 100, 'earth': 100, 'air': 100}
		get_distances(origin, blocos_proximos)
		manage_sounds(blocos_proximos)
	
	elif colliding:
		blocos_proximos = {'water': 100, 'fire': 100, 'earth': 100, 'air': 100}
		colliding = 0	
		manage_sounds(blocos_proximos)
		
	# player position
	var cell_coords = tile_map.local_to_map(position)
	var td = tile_map.get_cell_tile_data(0, cell_coords)
	if td:
		var tipo = td.get_custom_data(tipo_tile_custom_data)
		if tipo == 'checkpoint':
			game_manager.change_level(current_level+1)
		
	
			
	
	
	move_and_slide()
	
	


#func _on_water_sounds_finished():
	#water_sounds.play() # Replace with function body.



# logica de morte
	""""if is_colliding():
		collider = get_collider(0)
		var collision_point = get_collision_point(0) - get_collision_normal(0)*0.5
		var cell_coords = collider.local_to_map(collision_point)
		var td = collider.get_cell_tile_data(0, cell_coords)
		
		var match_tipos = {'water': 1, 'fire': 2, 'earth': 3, 'air': 4}
		if td:
			var tipo = td.get_custom_data(tipo_tile_custom_data)
			if match_tipos[tipo] != elemento_atual:
				print('morreu')"""








func _on_water_gem_gem_collected(element):
	print('mudando para elemento ', element)
	change_element(element)


func _on_fire_gem_gem_collected(element):
	print('mudando para elemento ', element)
	change_element(element)
