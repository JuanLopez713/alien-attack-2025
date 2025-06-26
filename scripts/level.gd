extends Node2D

### Global Variables
@export var lives = 3
@export var score = 100

### Child Nodes
@onready var ui = $UI
@onready var hud = $UI/HUD
@onready var player = $Player
@onready var enemy_spawner = $EnemySpawner
@onready var deathzone = $DeathZone

### Lifecycle Functions
func _ready():
	# Connect Signals to Handler Function
	player.took_damage.connect(process_player_took_damage)
	deathzone.area_entered.connect(process_deathzone_area_entered)
	enemy_spawner.enemy_spawned.connect(process_enemy_spawned)
	
	# Initialize Score Label
	hud.set_score_label(score)

### Signal Handler Functions

# Player - Took_Damage Handler
func process_player_took_damage():
	lives = lives - 1;
	print("Lives Remaining: " + str(lives))
	
# Deathzone - Area_Entered Handler
func process_deathzone_area_entered(enemy: Area2D) -> void:
	enemy.die()
	lives = lives - 1;
	print("Lives Remaining: " + str(lives))

# Enemy Spawner - Enemy_Spawned Handler
func process_enemy_spawned(enemy: Area2D) -> void:
	# Enemies emit a died signal and also pass the instance of themselves
	enemy.died.connect(process_enemy_died)

# Enemy - Died Handler
func process_enemy_died() -> void:
	score += 100
	# Update Hud labels
	hud.set_score_label(score)
	print("Score: " + str(score))
	
	# Update Player Stats
	# The player's speed is increased by tenth of the score)
	player.speed = player.base_speed + score / 10
	print("Speed: " + str(player.speed))
	
	# Ammo limit increases by 1 every 1000 points
	player.ammo_limit = 3 + score / 1000
	
	
	
	
	
	
