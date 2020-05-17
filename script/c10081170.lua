--Counter Gain (Lost Thunder 170/214)
local scard,sid=aux.GetID()
function scard.initial_effect(c)
	--pokemon tool
	aux.EnablePokemonToolAttribute(c)
	--reduce attack cost
	aux.AddSingleAttachedEffect(c,EFFECT_ATTACK_COST_REDUCE_C,nil,scard.con1)
	aux.AddAttachedDescription(c,DESC_ATTACK_COST_REDUCED,scard.con1)
end
scard.trainer_item=TYPE_POKEMON_TOOL
--reduce attack cost
function scard.con1(e)
	local tp=e:GetHandlerPlayer()
	return Duel.GetPrizeCount(tp)>Duel.GetPrizeCount(1-tp)
end
