--Torchic (Primal Clash 26/126)
local scard,sid=aux.GetID()
function scard.initial_effect(c)
	--pokemon
	aux.EnablePokemonAttribute(c)
	--ancient trait (extra attack)
	local e1=Effect.CreateEffect(c)
	e1:SetType(EFFECT_TYPE_SINGLE)
	e1:SetCode(EFFECT_EXTRA_ATTACK)
	e1:SetValue(1)
	c:RegisterEffect(e1)
	--draw
	local e2=aux.AddPokemonAttack(c,0,nil,scard.op1)
	e2:SetAttackCost(ENERGY_R)
	--damage
	local e3=aux.AddPokemonAttack(c,1,nil,scard.op2)
	e3:SetAttackCost(ENERGY_R)
end
scard.pokemon_basic=true
scard.weakness_x2={ENERGY_W}
--draw
function scard.op1(e,tp,eg,ep,ev,re,r,rp)
	Duel.AttackDamage(e,0)
	if Duel.DiscardHand(tp,Card.IsEnergy,1,1,REASON_ATTACK+REASON_DISCARD,nil,ENERGY_R)>0 then
		Duel.Draw(tp,2,REASON_ATTACK)
	end
end
--damage
function scard.op2(e,tp,eg,ep,ev,re,r,rp)
	if Duel.TossCoin(tp,1)==RESULT_TAILS then return end
	Duel.AttackDamage(e,20)
end
