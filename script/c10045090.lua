--Rayquaza & Deoxys LEGEND (Undaunted 90/90)
local scard,sid=aux.GetID()
function scard.initial_effect(c)
	aux.AddSetcode(c,SETNAME_DEOXYS)
	--no retreat cost
	c:SetStatus(STATUS_NO_RETREAT_COST,true)
end
scard.pokemon_legend=true
scard.legend_bottom_half=CARD_RAYQUAZA_DEOXYS_LEGEND
scard.weakness_x2={ENERGY_P,ENERGY_C}
