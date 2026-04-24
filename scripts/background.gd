extends ParallaxBackground

var scroll_speed = 15

@onready var sprite_2d: Sprite2D = $ParallaxLayer/Sprite2D

func _process(delta):
	sprite_2d.region_rect.position += delta * Vector2(scroll_speed, scroll_speed)
	if sprite_2d.region_rect.position >= Vector2(64,64):
		sprite_2d.region_rect.position = Vector2(0,0)
