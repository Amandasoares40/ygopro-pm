--Zekrom-EX (Next Destinies 51/99)
local scard,sid=aux.GetID()
function scard.initial_effect(c)
	--pokemon
	aux.EnablePokemonAttribute(c)
	--damage
	local e1=aux.AddPokemonAttack(c,0,nil,scard.op1)
	e1:SetAttackCost(ENERGY_L,ENERGY_C,ENERGY_C)
	--discard energy
	local e2=aux.AddPokemonAttack(c,1,nil,scard.op2)
	e2:SetAttackCost(ENERGY_L,ENERGY_L,ENERGY_C,ENERGY_C)
end
scard.pokemon_basic=true
scard.pokemon_ex=true
scard.weakness_x2={ENERGY_F}
--damage
function scard.op1(e,tp,eg,ep,ev,re,r,rp)
	local dam=50
	if Duel.TossCoin(tp,1)==RESULT_HEADS then dam=dam+30 end
	Duel.AttackDamage(e,dam)
end
--discard energy
function scard.op2(e,tp,eg,ep,ev,re,r,rp)
	Duel.AttackDamage(e,150)
	Duel.DiscardAttached(tp,e:GetHandler(),Card.IsEnergy,2,2,REASON_ATTACK)
end
