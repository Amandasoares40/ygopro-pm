--Weakness Policy (Primal Clash 142/160)
local scard,sid=aux.GetID()
function scard.initial_effect(c)
	--pokemon tool
	aux.EnablePokemonToolAttribute(c)
	--no weakness
	aux.AddSingleAttachedEffect(c,EFFECT_NO_WEAKNESS)
	aux.AddAttachedDescription(c,DESC_NO_WEAKNESS)
end
scard.trainer_item=TYPE_POKEMON_TOOL
--[[
	Note: This card's effect is almost identical to that of "Weakness Guard".
]]
