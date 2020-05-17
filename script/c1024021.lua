--Honedge (Kalos Starter Set 21/39)
local scard,sid=aux.GetID()
function scard.initial_effect(c)
	--pokemon
	aux.EnablePokemonAttribute(c)
	--damage
	local e1=aux.AddPokemonAttack(c,0,nil,scard.op1)
	e1:SetAttackCost(ENERGY_M,ENERGY_C)
end
scard.pokemon_basic=true
scard.height=2.07
scard.weakness_x2={ENERGY_R}
scard.resistance_20={ENERGY_P}
--damage
function scard.op1(e,tp,eg,ep,ev,re,r,rp)
	local dam=0
	repeat
		local res=Duel.TossCoin(tp,1)
		if res==RESULT_HEADS then dam=dam+1 end
	until res==RESULT_TAILS
	Duel.AttackDamage(e,30*dam)
end
