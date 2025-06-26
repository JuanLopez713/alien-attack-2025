extends Area2D

### Global Variables
@export var speed = 300

### Child Nodes
@onready var visible_notifier = $VisibleOnScreenNotifier2D

### LIfecycle Functions
func _ready():
	# Connect Signals to Handler Function
	self.area_entered.connect(process_enemy_entered_area)
	visible_notifier.screen_exited.connect(process_screen_exited)

func _physics_process(delta): 
	global_position.x = global_position.x + speed * delta
	

### Signal Handler Functions

# Rocket (self) Area2D - Area_Entered Handler
func process_enemy_entered_area(area: Area2D) -> void:
	if area.is_in_group("Enemy"):
		queue_free() #deletes the rocket
		area.die() #deletes the enemy

# Visible Notifier - Screen_Exited Handler
func process_screen_exited():
	queue_free()
	
