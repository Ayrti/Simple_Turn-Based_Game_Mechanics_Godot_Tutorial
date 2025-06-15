extends Node

var MaxHP:float = 100
var CurrentHP:float
var Str:int = 2
var Dex:int = 2
var Int:int = 1

var Skills:Array[Resource]

var Experience:int
var Level:int

func _ready():
	for skill in ["res://rsc/skills/Attack.tres","res://rsc/skills/S_Attack.tres","res://rsc/skills/U_Attack.tres"]:
		var CurrentSkill = load(skill)
		Skills.append(CurrentSkill)
