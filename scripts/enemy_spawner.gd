extends Node2D

### Signals
signal enemy_spawned(enemy)

### Child Nodes
@onready var enemy_scene = preload("res://scenes/enemy.tscn")
@onready var spawn_positions = $SpawnPositions
@onready var timer = $Timer

### Lifecycle Functions
func _ready():
	# Connect Signals to Handler Function
	timer.timeout.connect(process_timer_timeout)

### Enemy Spawner Functions
# Sets the wait time to a random number between 1 and 4 
func randomize_timer():
	randomize()
	var random_number = randi() % 4 + 1
	timer.wait_time = random_number
	
# Adds an enemy instance to the scene
func spawn_enemy():
	# Get all the spawn positions
	var spawn_position_list = spawn_positions.get_children() 
	
	# Choose a random spawn position from the list
	var random_spawn_position = spawn_position_list.pick_random()
	
	# Create an instance of an enemy
	var enemy = enemy_scene.instantiate()
	
	# Set the coordinates of the enemy instance
	enemy.global_position = random_spawn_position.global_position
	enemy.global_position.y += randi_range(-25, 25)
	
	# Add the enemy to the EnemySpawner scene
	add_child(enemy)
	
	# Emit signal that enemy spawned with a copy of the enemy
	emit_signal("enemy_spawned", enemy)
	
	# Reset the timer
	randomize_timer()
	
### Signal Handler Functions

# Timer - Timemout Handler
func process_timer_timeout():
	spawn_enemy()
