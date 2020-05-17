--Muscle Band (XY 121/146)
local scard,sid=aux.GetID()
function scard.initial_effect(c)
	--pokemon tool
	aux.EnablePokemonToolAttribute(c)
	--increase damage
	aux.AddSingleAttachedEffect(c,EFFECT_UPDATE_ATTACK_ACTIVE_BEFORE,20)
	aux.AddAttachedDescription(c,DESC_DO_MORE_DAMAGE)
end
scard.trainer_item=TYPE_POKEMON_TOOL
