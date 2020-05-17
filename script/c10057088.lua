--Silver Bangle (Plasma Blast 88/101)
local scard,sid=aux.GetID()
function scard.initial_effect(c)
	--pokemon tool
	aux.EnablePokemonToolAttribute(c)
	--increase damage
	aux.AddSingleAttachedEffect(c,EFFECT_UPDATE_ATTACK_ACTIVE_EX_BEFORE,30,aux.NOT(aux.SelfPokemonEXCondition))
	aux.AddAttachedDescription(c,DESC_DO_MORE_DAMAGE,aux.NOT(aux.SelfPokemonEXCondition))
end
scard.trainer_item=TYPE_POKEMON_TOOL
