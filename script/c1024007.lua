--Pansear (Kalos Starter Set 7/39)
local scard,sid=aux.GetID()
function scard.initial_effect(c)
	aux.AddHeight(c,2.00)
	--pokemon
	aux.EnablePokemonAttribute(c)
	--draw
	local e1=aux.AddPokemonAttack(c,0,nil,scard.op1)
	e1:SetAttackCost(ENERGY_C)
	--damage
	local e2=aux.AddPokemonAttack(c,1,nil,scard.op2)
	e2:SetAttackCost(ENERGY_C,ENERGY_C)
end
scard.pokemon_basic=true
scard.evolution_list1={["Basic"]=CARD_PANSEAR,["Stage 1"]=CARD_SIMISEAR}
scard.weakness_x2={ENERGY_W}
--draw
function scard.op1(e,tp,eg,ep,ev,re,r,rp)
	Duel.AttackDamage(e,0)
	Duel.Draw(tp,1,REASON_ATTACK)
end
--damage
function scard.op2(e,tp,eg,ep,ev,re,r,rp)
	local c1,c2,c3=Duel.TossCoin(tp,3)
	local dam=c1+c2+c3
	Duel.AttackDamage(e,10*dam)
end
