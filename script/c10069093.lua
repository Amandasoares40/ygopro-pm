--Bent Spoon (Fates Collide 93/124)
local scard,sid=aux.GetID()
function scard.initial_effect(c)
	--pokemon tool
	aux.EnablePokemonToolAttribute(c)
	--immune to effects
	aux.AddSingleAttachedEffect(c,EFFECT_IMMUNE_EFFECT,aux.AttackImmuneOppoFilter)
	aux.AddSingleAttachedEffect(c,EFFECT_IMMUNE_ATTACK_EFFECT_NONDAMAGE)
	aux.AddAttachedDescription(c,DESC_IMMUNE_ATTACK_EFFECT_OPPO)
end
scard.trainer_item=TYPE_POKEMON_TOOL
