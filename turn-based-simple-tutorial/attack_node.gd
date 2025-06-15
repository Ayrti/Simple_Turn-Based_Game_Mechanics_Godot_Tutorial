extends Node

var Skills:Array = []
var Cooldowns:Array = []

signal AttackSig

func Attack(skill):
	var index = Skills.find(skill)
	if Cooldowns[index] == 0:
		var Targets = get_parent().CurrentTargets
		var Damage = CalculateDamage(skill)
		for target in Targets:
			if target == null or not is_instance_valid(target):
				continue
			target.ReceiveDamage(Damage,skill.SkillType)
		RefreshCooldowns()
		Cooldowns[index] = Skills[index].SkillCooldown
		AttackSig.emit()

func MobAttack():
	if randi_range(0,1) == 1 and Cooldowns[1] == 0:
		Attack(Skills[1])
	else:
		Attack(Skills[0])
	


func CalculateDamage(skill):
	var Damage:float = get_parent().get(skill.SkillType)
	Damage = (Damage/100)*skill.SkillPower
	return Damage

func LoadSkills(skills):
	for skill in skills:
		Skills.append(skill)
		Cooldowns.append(skill.SkillCooldown)

func RefreshCooldowns():
	for i in len(Cooldowns):
		Cooldowns[i] = max(Cooldowns[i]-1,0)
