--Fire Memory (Ultra Prism 123/156)
local scard,sid=aux.GetID()
function scard.initial_effect(c)
	--pokemon tool
	aux.EnablePokemonToolAttribute(c)
	--add energy type
	aux.AddSingleAttachedEffect(c,EFFECT_ADD_ENERGY_TYPE,ENERGY_R,aux.SelfCardCodeCondition(CARD_SILVALLY_GX))
	aux.AddAttachedDescription(c,DESC_TYPE_CHANGED,aux.SelfCardCodeCondition(CARD_SILVALLY_GX))
end
scard.trainer_item=TYPE_POKEMON_TOOL
