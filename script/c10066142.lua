--Houndoom Spirit Link (BREAKthrough 142/162)
local scard,sid=aux.GetID()
function scard.initial_effect(c)
	--pokemon tool
	aux.EnablePokemonToolAttribute(c)
	--spirit link
	aux.EnableSpiritLink(c,CARD_M_HOUNDOOM_EX)
	aux.AddAttachedDescription(c,DESC_DONOT_END_TURN_MEGA,aux.SelfCardCodeCondition(CARD_M_HOUNDOOM_EX))
end
scard.trainer_item=TYPE_POKEMON_TOOL
