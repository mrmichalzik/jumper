extends CharacterBody2D

var direction = 0
const SPEED = 600.0
const SPEED_SPRINT = 1200.0
var speed = SPEED
const JUMP_VELOCITY = -800.0

@onready var skin: AnimatedSprite2D = $Skin
@onready var jump_air: AnimatedSprite2D = $jump_air
@onready var sprint_air: AnimatedSprite2D = $sprint_air
#onready stellt sicher, dass die Variable erst deklariert wird, wenn ready() durchgelaufen ist

var double_jump_enabled
var general_animation_enabled = false

func reset(startposition) -> void:
	general_animation_enabled = false
	print("Player wird reseted")
	velocity = Vector2(0,0)
	print(startposition)
	position = startposition
	skin.play("appear")
	await skin.animation_finished
	general_animation_enabled = true

func _physics_process(delta: float) -> void:
	
	# Sprinten
	if Input.is_action_just_pressed("sprint"):
		speed = SPEED * 2
		if direction == 1:
			sprint_air.rotation_degrees = 90
			sprint_air.play("air")
		elif direction == -1:
			sprint_air.rotation_degrees = -90
			sprint_air.play("air")
	elif Input.is_action_just_released("sprint"):
		speed = SPEED
	
	# Add the gravity.
	if not is_on_floor():
		velocity += get_gravity() * delta

	# Jumping
	if Input.is_action_just_pressed("ui_accept"):
		if is_on_floor():
			velocity.y = JUMP_VELOCITY
			double_jump_enabled = true
			jump_air.rotation_degrees = 0
			$JumpSound.play()
		# Double Jump
		elif double_jump_enabled:
			general_animation_enabled = false
			velocity.y = JUMP_VELOCITY
			$JumpSound.play()
			
			if velocity.x > 0:
				jump_air.rotation_degrees = 30
			elif velocity.x < 0:
				jump_air.rotation_degrees = -30
			jump_air.play("air")
			
			skin.play("double_jump")
			await skin.animation_finished
			general_animation_enabled = true
			double_jump_enabled = false
			
		
	# Get the input direction and handle the movement/deceleration.
	# As good practice, you should replace UI actions with custom gameplay actions.
	direction = Input.get_axis("ui_left", "ui_right")
	if direction:
		velocity.x = direction * speed
	else:
		velocity.x = move_toward(velocity.x, 0, speed)

	move_and_slide()
	update_animations()
	
func update_animations():
	if general_animation_enabled:
		if velocity.x < 0:
			skin.flip_h = true
		elif velocity.x > 0:
			skin.flip_h = false
			
		if velocity.x == 0 and velocity.y == 0:
			skin.play("idle")
		elif velocity.x != 0 and velocity.y == 0:
			skin.play("run")
		elif velocity.y < 0:
			skin.play("jump")
		elif velocity.y > 0:
			skin.play("fall")
		
func jumppadpush():
	velocity.y = JUMP_VELOCITY * 1.2
	double_jump_enabled = true
	jump_air.rotation_degrees = 0
