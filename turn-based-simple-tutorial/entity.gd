extends Control

# Nodes
@export var HealthNode:Node
@export var AttackNode:Node
@onready var entity_sprite = $EntitySprite
@onready var health_bar = $HealthBar

# Target
var CurrentTargets:Array


# Stats
var Str:int
var Dex:int
var Int:int



func _ready():
	entity_sprite.play("idle")
	AttackNode.AttackSig.connect(AttackAnim)

func _process(delta):
	health_bar.value = HealthNode.CurrentHP/HealthNode.MaxHP

func LoadEntity(TargetRes):
	if TargetRes != PlayerStats:
		entity_sprite.flip_h = true
	Str = TargetRes.Str
	Dex = TargetRes.Dex
	Int = TargetRes.Int
	HealthNode.MaxHP = TargetRes.MaxHP
	HealthNode.CurrentHP = TargetRes.MaxHP
	
	AttackNode.LoadSkills(TargetRes.Skills)
	HealthNode.Death.connect(Death)

func ReceiveDamage(amount,type):
	HealthNode.TakeDamage(amount,type)
	entity_sprite.play("hurt")



func Death():
	queue_free()


func _on_entity_sprite_animation_finished():
	print_debug(HealthNode.CurrentHP)
	if HealthNode.CurrentHP > 0:
		print_debug("SHould Play")
		entity_sprite.play("idle")

func AttackAnim():
	entity_sprite.play("hit")

func MobAttack():
	AttackNode.MobAttack()
