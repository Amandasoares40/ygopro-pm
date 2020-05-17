--Double Magma Energy (Double Crisis 34/34)
local scard,sid=aux.GetID()
function scard.initial_effect(c)
	--energy
	aux.EnableEnergyAttribute(c,aux.FilterBoolFunction(Card.IsSetCard,SETNAME_TEAM_MAGMA),1)
	--provide energy
	aux.EnableProvideEnergy(c,ENERGY_F,2,aux.FilterBoolFunction(Card.IsSetCard,SETNAME_TEAM_MAGMA))
end
scard.energy_special=true
--[[
	Rulings
		* Most Special Energy cards that provide a particular energy type do not provide that type when it is in the deck,
		the discard pile, or in your hand. Please read the text of the Special Energy card for clarification.
		(Jul 6, 2017 TPCi Rules Team)

		* The [default or normal] amount of energy an Energy card provides is equal to the number of energy symbols in the
		upper right or left corner of the card, regardless of how many different types of energy is provided.
		(Apr 8, 2004 PUI Rules Team)
		http://compendium.pokegym.net/compendium-bw.html#c7
]]
