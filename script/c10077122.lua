--Escape Board (Ultra Prism 122/156)
local scard,sid=aux.GetID()
function scard.initial_effect(c)
	--pokemon tool
	aux.EnablePokemonToolAttribute(c)
	--reduce retreat cost
	aux.AddSingleAttachedEffect(c,EFFECT_UPDATE_RETREAT_COST,-1)
	aux.AddAttachedDescription(c,DESC_RETREAT_COST_CHANGED)
	--asleep retreat
	aux.AddSingleAttachedEffect(c,EFFECT_ASLEEP_RETREAT)
	aux.AddAttachedDescription(c,DESC_RETREAT_ASLEEP)
	--paralyzed retreat
	aux.AddSingleAttachedEffect(c,EFFECT_PARALYZED_RETREAT)
	aux.AddAttachedDescription(c,DESC_RETREAT_PARALYZED)
end
scard.trainer_item=TYPE_POKEMON_TOOL
