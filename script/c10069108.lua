--Power Memory (Fates Collide 108/124)
local scard,sid=aux.GetID()
function scard.initial_effect(c)
	--pokemon tool
	aux.EnablePokemonToolAttribute(c)
	--gain attack (discard energy)
	local e1=aux.AddTrainerAttack(c,0,nil,scard.op1,nil,aux.SelfCardCodeCondition(CARD_ZYGARDE_EX))
	e1:SetAttackCost(ENERGY_F,ENERGY_F,ENERGY_C)
	aux.AddAttachedDescription(c,aux.Stringid(sid,1),aux.SelfCardCodeCondition(CARD_ZYGARDE_EX))
end
scard.trainer_item=TYPE_POKEMON_TOOL
--gain attack (discard energy)
function scard.op1(e,tp,eg,ep,ev,re,r,rp)
	Duel.AttackDamage(e,200)
	Duel.DiscardAttached(tp,e:GetHandler(),Card.IsEnergy,3,3,REASON_ATTACK)
end
