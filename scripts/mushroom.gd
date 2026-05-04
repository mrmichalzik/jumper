extends CharacterBody2D


const SPEED = 70
var movingRight = 1
var canSwitch = true
@onready var skin: AnimatedSprite2D = $AnimatedSprite2D
@onready var ray_cast_floor: RayCast2D = $RayCastFloor
@onready var ray_cast_wall: RayCast2D = $RayCastWall

func _physics_process(delta: float) -> void:
	
	if (!ray_cast_floor.is_colliding() or ray_cast_wall.is_colliding()) and canSwitch:
		movingRight *= -1
		canSwitch = false
	else:
		canSwitch = true
		
	
	if movingRight < 0:
		velocity.x = SPEED * -1.0
		skin.flip_h = false
		ray_cast_wall.target_position = Vector2(-12,7)
		ray_cast_floor.target_position = Vector2(-6,20)
	else:
		velocity.x = SPEED * 1
		skin.flip_h = true
		ray_cast_wall.target_position = Vector2(14,7)
		ray_cast_floor.target_position = Vector2(6,20)
	
	move_and_slide()



func _on_area_2d_body_entered(body: Node2D) -> void:
	if body.is_in_group("Player"):
		var y_delta = position.y - body.position.y
		# Differenz zwischen Gegner- und Spieler-Position.
		# Wenn Spieler von der Seite berührt, ist die Differenz klein,
		# von oben ist die Differenz groß:
		if y_delta < 10: #Ge
			await body.delete()
			body.reset(GameManager.LevelStartZone)
		else: #Gegner stirbt
			skin.play("hit")
			body.bounce(0.8)
			await skin.animation_finished
			queue_free() #Entfernt Gegner aus dem Spiel


func jumppadpush():
	velocity.y = 50
