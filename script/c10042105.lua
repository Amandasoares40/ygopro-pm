--Arceus (Arceus AR3)
--BUG: Due to having consecutive ids, this card is treated as Arceus (Arceus AR1)
local scard,sid=aux.GetID()
function scard.initial_effect(c)
	--pokemon
	aux.EnablePokemonAttribute(c)
	--discard energy
	local e1=aux.AddPokemonAttack(c,0,nil,scard.op1)
	e1:SetAttackCost(ENERGY_R,ENERGY_C,ENERGY_C)
end
scard.pokemon_basic=true
scard.height=10.06
scard.weakness_x2={ENERGY_W}
--discard energy
function scard.op1(e,tp,eg,ep,ev,re,r,rp)
	local c=e:GetHandler()
	Duel.AttackDamage(e,80)
	if c:GetAttachedGroup():IsExists(Card.IsEnergy,1,nil) and Duel.TossCoin(tp,1)==RESULT_TAILS then
		Duel.DiscardAttached(tp,c,Card.IsEnergy,2,2,REASON_ATTACK)
	end
end
