--Float Stone (Plasma Freeze 99/116)
local scard,sid=aux.GetID()
function scard.initial_effect(c)
	--pokemon tool
	aux.EnablePokemonToolAttribute(c)
	--0 retreat cost
	aux.AddSingleAttachedEffect(c,EFFECT_CHANGE_RETREAT_COST,0)
	aux.AddAttachedDescription(c,DESC_RETREAT_COST_CHANGED)
end
scard.trainer_item=TYPE_POKEMON_TOOL
