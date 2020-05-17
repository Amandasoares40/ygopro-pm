--Big Charm (Sword & Shield 158/202)
local scard,sid=aux.GetID()
function scard.initial_effect(c)
	--pokemon tool
	aux.EnablePokemonToolAttribute(c)
	--gain hp
	aux.AddSingleAttachedEffect(c,EFFECT_UPDATE_MAX_HP,30)
	aux.AddAttachedDescription(c,DESC_MAX_HP_UP)
end
scard.trainer_item=TYPE_POKEMON_TOOL
--[[
	Note: This card's effect is almost identical to that of "Giant Cape".
]]
