--Choice Band (Guardians Rising 121/145)
local scard,sid=aux.GetID()
function scard.initial_effect(c)
	--pokemon tool
	aux.EnablePokemonToolAttribute(c)
	--increase damage
	aux.AddSingleAttachedEffect(c,EFFECT_UPDATE_ATTACK_ACTIVE_GX_EX_BEFORE,30)
	aux.AddAttachedDescription(c,DESC_DO_MORE_DAMAGE)
end
scard.trainer_item=TYPE_POKEMON_TOOL
