extends Control

var PlayerEntity
var EnemyEntity
@onready var player_skill_box = $PlayerSkillBox

const ENTITY = preload("res://entity.tscn")
const BLOB = preload("res://rsc/mobs/Blob.tres")

var CurrentTurn

signal PlayerTurn(boolean)

func _ready():
	PlayerEntity = ENTITY.instantiate()
	add_child(PlayerEntity)
	PlayerEntity.LoadEntity(PlayerStats)
	PlayerEntity.position = Vector2(200,200)
	player_skill_box.initiate(PlayerEntity)


	EnemyEntity = ENTITY.instantiate()
	add_child(EnemyEntity)
	EnemyEntity.LoadEntity(BLOB)
	EnemyEntity.position = Vector2(1000,200)

	PlayerEntity.CurrentTargets.append(EnemyEntity)
	EnemyEntity.CurrentTargets.append(PlayerEntity)
	PlayerEntity.AttackNode.AttackSig.connect(ChangeTurn.bind(EnemyEntity))
	EnemyEntity.AttackNode.AttackSig.connect(ChangeTurn.bind(PlayerEntity))
	SelectTurn()


func ChangeTurn(target):
	CurrentTurn = target
	if target == PlayerEntity:
		PlayerTurn.emit(false)
	else:
		PlayerTurn.emit(true)
		await get_tree().create_timer(1).timeout
		if not is_instance_valid(EnemyEntity):
			EnemyEntity = null
		if EnemyEntity:
			EnemyEntity.MobAttack()
		

func SelectTurn():
	if randi_range(0,1) == 0:
		ChangeTurn(PlayerEntity)
	else:
		ChangeTurn(EnemyEntity)
