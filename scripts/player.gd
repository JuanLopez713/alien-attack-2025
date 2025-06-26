extends CharacterBody2D
### Signals
signal took_damage

### Global Variables
@export var base_speed = 20000;
var speed = base_speed
@export var ammo_limit = 3;

### Child Nodes
@onready var rocket_scene = preload("res://scenes/rocket.tscn")
@onready var rocket_container = $RocketContainer

### Lifecycle Functions
func _process(_delta):
	if Input.is_action_pressed("shoot"):
		shoot()

func _physics_process(delta):
	velocity = Vector2(0,0)
	if Input.is_action_pressed("right"):
		velocity.x = speed * delta
	if Input.is_action_pressed("left"):
		velocity.x = -speed * delta
	if Input.is_action_pressed("up"):
		velocity.y = -speed * delta
	if Input.is_action_pressed("down"):
		velocity.y = speed * delta
	move_and_slide()
	
	var screen_size = get_viewport_rect().size
	global_position.x = clampf(global_position.x, 0, screen_size.x);
	global_position.y = clampf(global_position.y, 0, screen_size.y)
	
### Player Functions
func shoot():
	var rocket = rocket_scene.instantiate()
	rocket.global_position = self.global_position
	rocket.global_position.x = rocket.global_position.x + 80
	rocket_container.add_child(rocket)
	
func take_damage():
	print("Player was hit!")
	emit_signal("took_damage")
