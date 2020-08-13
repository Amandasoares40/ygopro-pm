--Miltank (Kalos Starter Set 27/39)
local scard,sid=aux.GetID()
function scard.initial_effect(c)
	aux.AddHeight(c,3.11)
	--pokemon
	aux.EnablePokemonAttribute(c)
	--damage
	local e1=aux.AddPokemonAttack(c,0,nil,scard.op1)
	e1:SetAttackCost(ENERGY_C,ENERGY_C,ENERGY_C)
end
scard.pokemon_basic=true
scard.weakness_x2={ENERGY_F}
--damage
function scard.op1(e,tp,eg,ep,ev,re,r,rp)
	local dam=50
	if Duel.TossCoin(tp,1)==RESULT_HEADS then dam=dam+20 end
	Duel.AttackDamage(e,dam)
end
