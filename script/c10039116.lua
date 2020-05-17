--Team Galactic's Invention G-101 Energy Gain (Platinum 116/127)
local scard,sid=aux.GetID()
function scard.initial_effect(c)
	aux.AddSetcode(c,SETNAME_TEAM_GALACTICS_INVENTION)
	--pokemon tool
	aux.EnablePokemonToolAttribute(c,aux.FilterBoolFunction(Card.IsPokemonSP))
	--reduce attack cost
	aux.AddSingleAttachedEffect(c,EFFECT_ATTACK_COST_REDUCE_C,nil,aux.SelfPokemonSPCondition)
	aux.AddAttachedDescription(c,DESC_ATTACK_COST_REDUCED,aux.SelfPokemonSPCondition)
end
scard.trainer_item=TYPE_POKEMON_TOOL
--[[
	Rulings
		Q. Team Galactic's Invention G-101 Energy Gain reduces attacks' Energy costs by 1 Colorless Energy. What happens
		if the attack requires energy to be all of a particular color?
		A. It only reduces a colorless energy cost; if the attack requires nothing but specific energy types, then there
		is no reduction. (Feb 12, 2009 PUI Rules Team)

		Q. If I have "Energy Gain" attached to one of my SP Pokemon, can I use an attack that only costs one energy
		without having any energy attached to that Pokemon?
		A. Yes, as long as that attack costs one Colorless energy. If the attack costs only one non-colorless energy (i.e.
		one Fire Energy), then you would not be able to use that attack. (Jun 4, 2009 PUI Rules Team)

		Q. If I have "Team Galactic's Invention G-107 Technical Machine G" attached to a SP Pokemon and also "Team
		Galactic's Invention G-101 Energy Gain", can I use the attack "Damage Porter" if I just have two energy attached
		to my SP Pokemon?
		A. Yes, Energy Gain reduces the attack cost of Damage Porter by one colorless energy. (Jun 4, 2009 PUI Rules Team)
		http://compendium.pokegym.net/compendium-lvx.html#354
]]
