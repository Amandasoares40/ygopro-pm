--Groudon Spirit Link (Primal Clash 131/160)
local scard,sid=aux.GetID()
function scard.initial_effect(c)
	--pokemon tool
	aux.EnablePokemonToolAttribute(c)
	--spirit link
	aux.EnableSpiritLink(c,CARD_PRIMAL_GROUDON_EX)
	aux.AddAttachedDescription(c,DESC_DONOT_END_TURN_MEGA,aux.SelfCardCodeCondition(CARD_PRIMAL_GROUDON_EX))
end
scard.trainer_item=TYPE_POKEMON_TOOL
