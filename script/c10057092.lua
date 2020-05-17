--G Booster (Plasma Blast 92/101)
local scard,sid=aux.GetID()
function scard.initial_effect(c)
	aux.AddSetcode(c,SETNAME_TEAM_PLASMA)
	--pokemon tool
	aux.EnablePokemonToolAttribute(c)
	--gain attack (discard energy)
	local e1=aux.AddTrainerAttack(c,0,nil,scard.op1,nil,aux.SelfCardCodeCondition(CARD_GENESECT_EX))
	e1:SetAttackCost(ENERGY_G,ENERGY_G,ENERGY_C)
	aux.AddAttachedDescription(c,aux.Stringid(sid,1),aux.SelfCardCodeCondition(CARD_GENESECT_EX))
end
scard.trainer_item=TYPE_POKEMON_TOOL
scard.trainer_ace_spec=true
--gain attack (discard energy)
function scard.op1(e,tp,eg,ep,ev,re,r,rp)
	Duel.AttackDamage(e,200,Duel.GetActivePokemon(1-tp),true,true,false)
	Duel.DiscardAttached(tp,e:GetHandler(),Card.IsEnergy,2,2,REASON_ATTACK)
end
