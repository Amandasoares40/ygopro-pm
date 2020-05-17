--Jamming Net Team Flare Hyper Gear (Phantom Forces 98/119)
local scard,sid=aux.GetID()
function scard.initial_effect(c)
	--pokemon tool
	aux.EnablePokemonToolAttribute(c,aux.FilterBoolFunction(Card.IsPokemonEX),nil,true)
	--reduce damage
	aux.AddSingleAttachedEffect(c,EFFECT_UPDATE_ATTACK_BEFORE,-20,aux.SelfPokemonEXCondition)
	aux.AddAttachedDescription(c,DESC_DO_LESS_DAMAGE,aux.SelfPokemonEXCondition)
end
scard.trainer_item=TYPE_POKEMON_TOOL
