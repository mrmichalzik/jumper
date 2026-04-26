extends Area2D

@onready var animated_sprite_2d: AnimatedSprite2D = $AnimatedSprite2D

func _on_body_entered(body: Node2D) -> void:
	print(GameManager.fruits)
	GameManager.fruits += 1
	animated_sprite_2d.play("collected")
	await animated_sprite_2d.animation_finished
	queue_free() #Entfernt die Frücht komplett
