local combat = Combat()
combat:setParameter(COMBAT_PARAM_TYPE, COMBAT_DEATHDAMAGE)
combat:setParameter(COMBAT_PARAM_EFFECT, CONST_ME_MORTAREA)
combat:setParameter(COMBAT_PARAM_DISTANCEEFFECT, CONST_ANI_DEATH)

function onGetFormulaValues(player, level, maglevel)
	local min = (level / 5) + (maglevel * 0.4) + 3
	local max = (level / 5) + (maglevel * 0.7) + 5
	return -min, -max
end

combat:setCallback(CALLBACK_PARAM_LEVELMAGICVALUE, "onGetFormulaValues")

local spell = Spell("instant")

function spell.onCastSpell(creature, var)
	local level = creature:getLevel()
	local maglevel = creature:getMagicLevel()
	local minDamage, maxDamage = onGetFormulaValues(nil, level, maglevel)
	local manaCost = (maxDamage - minDamage) * 0.5
	
	combat:setFormula(-minDamage, -maxDamage)
	spell:setMana(math.floor(manaCost))

	return combat:execute(creature, var)
end

spell:group("attack")
spell:id(12345) -- Replace with the desired spell ID
spell:name("Shadow Bolt") -- Replace with the desired spell name
spell:words("shadow bolt") -- Replace with the desired spell words
spell:castSound(SOUND_EFFECT_TYPE_SPELL) -- Replace with the desired cast sound
spell:impactSound(SOUND_EFFECT_TYPE_MAGIC) -- Replace with the desired impact sound
spell:level(8)
spell:mana(6) -- Set initial mana cost
spell:isPremium(false)
spell:range(3)
spell:needCasterTargetOrDirection(true)
spell:blockWalls(true)
spell:cooldown(2 * 1000)
spell:groupCooldown(2 * 1000)
spell:needLearn(false)
spell:vocation("druid;true", "elder druid;true", "sorcerer;true", "master sorcerer;true")
spell:register()
