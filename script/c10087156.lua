--Air Balloon (Sword & Shield 156/202)
local scard,sid=aux.GetID()
function scard.initial_effect(c)
	--pokemon tool
	aux.EnablePokemonToolAttribute(c)
	--reduce retreat cost
	aux.AddSingleAttachedEffect(c,EFFECT_UPDATE_RETREAT_COST,-2)
	aux.AddAttachedDescription(c,DESC_RETREAT_COST_CHANGED)
end
scard.trainer_item=TYPE_POKEMON_TOOL
