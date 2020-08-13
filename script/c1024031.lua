--Fletchling (Kalos Starter Set 31/39)
local scard,sid=aux.GetID()
function scard.initial_effect(c)
	aux.AddHeight(c,1.00)
	--pokemon
	aux.EnablePokemonAttribute(c)
	--damage
	local e1=aux.AddPokemonAttack(c,0,nil,scard.op1)
	e1:SetAttackCost(ENERGY_C)
end
scard.pokemon_basic=true
scard.weakness_x2={ENERGY_L}
scard.resistance_20={ENERGY_F}
--damage
function scard.op1(e,tp,eg,ep,ev,re,r,rp)
	if Duel.TossCoin(tp,1)==RESULT_TAILS then return end
	Duel.AttackDamage(e,20)
end
