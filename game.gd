extends Node2D
@onready var AmmoCounter = $"UI/Ammo Counter"
@onready var playerGun = $"Player/Arm"

#All the variables that need to be saved between rooms
var maxAmmo = 5
var maxHealth

var currentAmmo = 1
var currentHealth
#slows the game by timescale and lasts for duration
func frame_freeze(timescale: float, duration: float) -> void:
	Engine.time_scale = timescale
	await get_tree().create_timer(duration, true, false, true).timeout
	Engine.time_scale = 1.0


func _ready() -> void:
	AmmoCounter.maxAmmo = maxAmmo
	AmmoCounter.currentAmmo = currentAmmo
	playerGun.maxAmmo = maxAmmo
	playerGun.currentAmmo = currentAmmo
	AmmoCounter._load_Ammo_UI()
	
func _process(delta: float) -> void:
	if Input.is_action_just_pressed("shoot"):
		frame_freeze(0, 0.02)
	#Temp solution to having UI display ammo proper
	AmmoCounter.maxAmmo = playerGun.maxAmmo
	currentAmmo = playerGun.currentAmmo
	AmmoCounter.currentAmmo = playerGun.currentAmmo
	
	
