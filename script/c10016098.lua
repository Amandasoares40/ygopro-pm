--Hitmonchan ex (Ruby & Sapphire 98/109)
local scard,sid=aux.GetID()
function scard.initial_effect(c)
	--pokemon
	aux.EnablePokemonAttribute(c)
	--damage
	local e1=aux.AddPokemonAttack(c,0,nil,scard.op1)
	e1:SetAttackCost(ENERGY_F)
	--damage
	local e2=aux.AddPokemonAttack(c,1,nil,aux.AttackDamageOperation(50,true,false))
	e2:SetAttackCost(ENERGY_F,ENERGY_F,ENERGY_C)
end
scard.pokemon_basic=true
scard.pokemon_ex_old=true
scard.weakness_x2={ENERGY_P}
--damage
function scard.op1(e,tp,eg,ep,ev,re,r,rp)
	local dam=10
	if Duel.TossCoin(tp,1)==RESULT_HEADS then dam=dam+10 end
	Duel.AttackDamage(e,dam)
end
