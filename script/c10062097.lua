--Head Ringer Team Flare Hyper Gear (Phantom Forces 97/119)
local scard,sid=aux.GetID()
function scard.initial_effect(c)
	--pokemon tool
	aux.EnablePokemonToolAttribute(c,aux.FilterBoolFunction(Card.IsPokemonEX),nil,true)
	--increase attack cost
	aux.AddSingleAttachedEffect(c,EFFECT_ATTACK_COST_INCREASE_C,nil,aux.SelfPokemonEXCondition)
	aux.AddAttachedDescription(c,DESC_ATTACK_COST_INCREASED,aux.SelfPokemonEXCondition)
end
scard.trainer_item=TYPE_POKEMON_TOOL
