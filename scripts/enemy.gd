extends Area2D

### Signals
signal died

### Global Variables
static var speed = 100

### Lifecycle Functions
func _ready():
	# Connect Signals to Handler Function
	self.body_entered.connect(process_body_entered)
	# Add self to Group
	self.add_to_group("Enemy")

func _physics_process(delta):
	# Move the enemy to the left
	global_position.x = global_position.x - speed * delta
	
### Enemy Functions
func die():
	queue_free() # Remove the child node from the scene
	emit_signal("died", self) # Send a message that the enemy died and itself
	speed_up_enemies()
	
func speed_up_enemies():
	speed = speed + 10

### Signal Handler Functions

# Enemy (self) Area2D - Body Entered Hangler
func process_body_entered(player: CharacterBody2D) -> void:
	player.take_damage()
	die()
