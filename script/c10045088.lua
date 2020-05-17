--Kyogre & Groudon LEGEND (Undaunted 88/90)
local scard,sid=aux.GetID()
function scard.initial_effect(c)
	--no retreat cost
	c:SetStatus(STATUS_NO_RETREAT_COST,true)
end
scard.pokemon_legend=true
scard.legend_bottom_half=CARD_KYOGRE_GROUDON_LEGEND
scard.weakness_x2={ENERGY_G,ENERGY_L}
