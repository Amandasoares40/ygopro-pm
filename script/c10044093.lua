--Raikou & Suicune LEGEND (Unleashed 93/95)
local scard,sid=aux.GetID()
function scard.initial_effect(c)
	--no retreat cost
	c:SetStatus(STATUS_NO_RETREAT_COST,true)
end
scard.pokemon_legend=true
scard.legend_bottom_half=CARD_RAIKOU_SUICUNE_LEGEND
scard.weakness_x2={ENERGY_F,ENERGY_L}
