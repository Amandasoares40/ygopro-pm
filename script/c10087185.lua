--Vitality Band (Sword & Shield 185/202)
local scard,sid=aux.GetID()
function scard.initial_effect(c)
	--pokemon tool
	aux.EnablePokemonToolAttribute(c)
	--increase damage
	aux.AddSingleAttachedEffect(c,EFFECT_UPDATE_ATTACK_ACTIVE_BEFORE,10)
	aux.AddAttachedDescription(c,DESC_DO_MORE_DAMAGE)
end
scard.trainer_item=TYPE_POKEMON_TOOL
--[[
	Note: This card's effect is similar to that of "Muscle Band".
]]
