--Lugia LEGEND (HeartGold & SoulSilver 114/123)
local scard,sid=aux.GetID()
function scard.initial_effect(c)
	--no retreat cost
	c:SetStatus(STATUS_NO_RETREAT_COST,true)
end
scard.pokemon_legend=true
scard.legend_bottom_half=CARD_LUGIA_LEGEND
scard.weakness_x2={ENERGY_L}
scard.resistance_20={ENERGY_F}
