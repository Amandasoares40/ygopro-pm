--Solid Rage (Dragon 92/97)
local scard,sid=aux.GetID()
function scard.initial_effect(c)
	--pokemon tool
	aux.EnablePokemonToolAttribute(c,scard.toolfilter)
	--increase damage
	aux.AddSingleAttachedEffect(c,EFFECT_UPDATE_ATTACK_ACTIVE_BEFORE,20,scard.con1)
	aux.AddAttachedDescription(c,DESC_DO_MORE_DAMAGE,scard.con1)
end
scard.trainer_item=TYPE_POKEMON_TOOL
--pokemon tool
function scard.toolfilter(c)
	return c:IsEvolved() and not c:IsPokemonex()
end
--increase damage
function scard.con1(e)
	local tp=e:GetHandlerPlayer()
	return Duel.GetPrizeCount(tp)>Duel.GetPrizeCount(1-tp) and scard.toolfilter(e:GetHandler())
end
