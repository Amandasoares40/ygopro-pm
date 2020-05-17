--Heavy Boots (BREAKthrough 141/162)
local scard,sid=aux.GetID()
function scard.initial_effect(c)
	--pokemon tool
	aux.EnablePokemonToolAttribute(c)
	--gain hp
	aux.AddSingleAttachedEffect(c,EFFECT_UPDATE_MAX_HP,20,aux.SelfRCAboveCondition(3))
	aux.AddAttachedDescription(c,DESC_MAX_HP_UP,aux.SelfRCAboveCondition(3))
	--cannot be confused
	aux.AddSingleAttachedEffect(c,EFFECT_IMMUNE_CONFUSED,nil,aux.SelfRCAboveCondition(3))
	aux.AddAttachedDescription(c,DESC_IMMUNE_CONFUSED,aux.SelfRCAboveCondition(3))
end
scard.trainer_item=TYPE_POKEMON_TOOL
