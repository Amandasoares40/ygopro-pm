--Sparkling Robe (Furious Fists 99/111)
local scard,sid=aux.GetID()
function scard.initial_effect(c)
	--pokemon tool
	aux.EnablePokemonToolAttribute(c)
	--immune to special conditions
	aux.AddSingleAttachedEffect(c,EFFECT_IMMUNE_SPECIAL_CONDITION)
	aux.AddAttachedDescription(c,DESC_IMMUNE_SPC)
end
scard.trainer_item=TYPE_POKEMON_TOOL
