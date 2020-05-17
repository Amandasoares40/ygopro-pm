--Bench Shield (Arceus 83/99)
local scard,sid=aux.GetID()
function scard.initial_effect(c)
	--pokemon tool
	aux.EnablePokemonToolAttribute(c)
	--immune to attack damage
	aux.AddSingleAttachedEffect(c,EFFECT_IMMUNE_ATTACK_DAMAGE,nil,aux.SelfBenchedCondition)
	aux.AddAttachedDescription(c,DESC_IMMUNE_ATTACK_DAMAGE,aux.SelfBenchedCondition)
end
scard.trainer_item=TYPE_POKEMON_TOOL
