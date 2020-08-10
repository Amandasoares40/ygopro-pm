--Silent Lab (Primal Clash 140/160)
local scard,sid=aux.GetID()
function scard.initial_effect(c)
	--stadium
	aux.EnableStadiumAttribute(c)
	--disable ability
	aux.EnableEffectCustom(c,EFFECT_DISABLE_ABILITY,LOCATION_STADIUM,LOCATIONS_PHDP,LOCATIONS_PHDP,scard.tg1)
end
--disable ability
function scard.tg1(e,c)
	return c:IsBasicPokemon() and c:IsHasAbility()
end
--[[
	Rulings
	Q. If Silent Lab stadium is in play and one of my Basic Pokemon evolves into a BREAK Pokemon, would it be able to use
	the Ability from the underlying Basic Pokemon or not?
	A. When it evolves into a BREAK Pokemon it is no longer a Basic Pokemon, so Silent Lab no longer affects it and you
	would be able to use the underlying Basic Pokemon's Abilities. (Jun 23, 2016 TPCi Rules Team)

	Q. Does "Silent Lab" stadium shut off "Alpha" and "Omega" abilities?
	A. No, those are considered Ancient Traits, they are not Abilities. (Primal Clash FAQ; Feb 5, 2015 TPCi Rules Team)

	Q. If Klefki with the "Wonder Lock" Ability is attached to a Pokemon as a Tool card, what happens if "Silent Lab"
	stadium comes into play? Does "Wonder Lock" shut off and Klefki get discarded, or does it remain attached to the
	Pokemon?
	A. Once Klefki is attached as a Pokemon Tool card it retains its effect even when its Ability has been disabled. Once
	it's attached, it is essentially treated as a Tool with that text, so shutting off its Ability doesn't matter at that
	point. However, if something such as Lysandre Labs is in effect, Klefki won't be discarded at the end of your
	opponent’s turn. (Jan 3, 2019 TPCi Rules Team)
	https://compendium.pokegym.net/compendium-bw.html#392
]]
