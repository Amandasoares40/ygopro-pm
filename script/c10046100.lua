--Darkrai & Cresselia LEGEND (Triumphant 100/102)
local scard,sid=aux.GetID()
function scard.initial_effect(c)
	--no retreat cost
	c:SetStatus(STATUS_NO_RETREAT_COST,true)
end
scard.pokemon_legend=true
scard.legend_bottom_half=CARD_DARKRAI_CRESSELIA_LEGEND
scard.weakness_x2={ENERGY_F,ENERGY_P}
--[[
	Rulings
		This card's Japanese name doesn't contain わるい (Dark).
]]
