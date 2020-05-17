--Giant Cape (Dragons Exalted 114/124)
local scard,sid=aux.GetID()
function scard.initial_effect(c)
	--pokemon tool
	aux.EnablePokemonToolAttribute(c)
	--gain hp
	aux.AddSingleAttachedEffect(c,EFFECT_UPDATE_MAX_HP,20)
	aux.AddAttachedDescription(c,DESC_MAX_HP_UP)
end
scard.trainer_item=TYPE_POKEMON_TOOL
