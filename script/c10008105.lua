--Recycle Energy (Neo Genesis 105/111)
local scard,sid=aux.GetID()
function scard.initial_effect(c)
	--energy
	aux.EnableEnergyAttribute(c)
	--provide energy
	aux.EnableProvideEnergy(c,ENERGY_C)
	if not scard.global_check then
		scard.global_check=true
		--redirect (return)
		local ge1=Effect.GlobalEffect()
		ge1:SetType(EFFECT_TYPE_FIELD)
		ge1:SetCode(EFFECT_TO_DPILE_REDIRECT)
		ge1:SetTargetRange(LOCATION_ATTACHED,LOCATION_ATTACHED)
		ge1:SetTarget(aux.TargetBoolFunction(Card.IsCode,sid))
		ge1:SetValue(LOCATION_HAND)
		Duel.RegisterEffect(ge1,0)
	end
end
scard.energy_special=true
--[[
	Rulings
	Q. Does "Recycle Energy" go back into your hand if you discard it as part of a retreat cost? Does it go back into your
	hand if it's attached to a Pokémon that gets knocked out?
	A. Yes in both cases. Don't be discarding it for Item Finder and expecting to get it back though...
	(Dec 21, 2000 WotC Chat, Q16)
	https://compendium.pokegym.net/compendium.html#ecards

	References
	* Gimmick Puppet Shadow Feeler
	https://github.com/Fluorohydride/ygopro-scripts/blob/6324c1c/c34620088.lua#L25
]]
