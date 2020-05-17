--Entei & Raikou LEGEND (Unleashed 91/95)
local scard,sid=aux.GetID()
function scard.initial_effect(c)
	--no retreat cost
	c:SetStatus(STATUS_NO_RETREAT_COST,true)
end
scard.pokemon_legend=true
scard.legend_bottom_half=CARD_ENTEI_RAIKOU_LEGEND
scard.weakness_x2={ENERGY_W,ENERGY_F}
