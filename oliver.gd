extends KinematicBody2D


export var fall_gravity_scale := 100
export var low_jump_gravity_scale := 80
export var jump_power := 55
var jump_released = false
var velocity = Vector2()
var gravity := 60
var on_floor = false
var speed = 50

func player_die():
	queue_free()

func _physics_process(delta):
	if Input.is_action_pressed("ui_right"):
		velocity.x = speed
		$sprite.scale.x = 1
	elif Input.is_action_pressed("ui_left"):
		velocity.x = -speed
		$sprite.scale.x = -1
	else:
		velocity.x = 0
	if Input.is_action_just_released("ui_up"):
		jump_released = true

	velocity += Vector2.DOWN * gravity * delta

	if velocity.y > 0:
		velocity += Vector2.DOWN * fall_gravity_scale * delta 

	elif velocity.y < 0 && jump_released: 
		velocity += Vector2.DOWN * low_jump_gravity_scale * delta

	if is_on_floor():
		if Input.is_action_just_pressed("ui_up"): 
			velocity = Vector2.UP * jump_power
			jump_released = false
		if velocity.x > 0:
			$sprite.play("walk")
		elif velocity.x < 0:
			$sprite.play("walk")
		else:
			$sprite.play("idle")
	else:
		if velocity.y < 0:
			$sprite.play("jump")
		else:
			$sprite.play("fall")

	velocity = move_and_slide(velocity, Vector2.UP) 


#const SPEED = 50
#const GRAVITY = 20
#const JUMP_HEIGHT = -20
#const UP = Vector2(0, -1)
#var movement = Vector2()
#var snap = Vector2(0, 1)
#var fall_gravity_scale := 8
#var low_jump_gravity_scale := 8
#var jump_power := 10
#var jump_released = false
#var on_floor = false
#
#func _physics_process(delta):
##	movement.y += GRAVITY
#	if Input.is_action_pressed("ui_right"):
#		movement.x = SPEED
#		$sprite.scale.x = 1
#	elif Input.is_action_pressed("ui_left"):
#		movement.x = -SPEED
#		$sprite.scale.x = -1
#	else:
#		movement.x = 0
#	if Input.is_action_just_released("ui_up"):
#		jump_released = true
#		$sprite.play("fall")
#	movement += Vector2.DOWN * GRAVITY * delta
#	if movement.y > 0:
#		movement += Vector2.DOWN * fall_gravity_scale * delta 
#	elif movement.y < 0 && jump_released:
#		movement += Vector2.DOWN * low_jump_gravity_scale * delta
#	if on_floor:
#		if Input.is_action_just_pressed("ui_up"): 
#			movement = Vector2.UP * jump_power
#			snap = Vector2(0, -1)
#			jump_released = false
#			$sprite.play("jump")
##	if is_on_floor():
##		if Input.is_action_just_pressed("ui_up"):
##			movement.y = JUMP_HEIGHT
##			snap = Vector2(0, -1)
#		else:
#			snap = Vector2(0, 1)
#		if movement.x > 0:
#			$sprite.play("walk")
#		elif movement.x < 0:
#			$sprite.play("walk")
##		else:
##			$sprite.play("idle")
##	else:
##		if movement.y < 0:
##			$sprite.play("jump")
##		else:
##			$sprite.play("fall")
##
#	movement = move_and_slide_with_snap(movement, snap, UP)
