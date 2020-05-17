--Electabuzz ex (Ruby & Sapphire 97/109)
local scard,sid=aux.GetID()
function scard.initial_effect(c)
	--pokemon
	aux.EnablePokemonAttribute(c)
	--paralyzed
	local e1=aux.AddPokemonAttack(c,0,nil,scard.op1)
	e1:SetAttackCost(ENERGY_L)
	--damage
	local e2=aux.AddPokemonAttack(c,1,nil,scard.op2)
	e2:SetAttackCost(ENERGY_L,ENERGY_L,ENERGY_C)
end
scard.pokemon_basic=true
scard.pokemon_ex_old=true
scard.weakness_x2={ENERGY_F}
scard.resistance_30={ENERGY_M}
--paralyzed
function scard.op1(e,tp,eg,ep,ev,re,r,rp)
	local tc=Duel.GetActivePokemon(1-tp)
	Duel.AttackDamage(e,10)
	if tc:IsInPlay() and Duel.TossCoin(tp,1)==RESULT_HEADS then
		tc:ApplySpecialCondition(tp,SPC_PARALYZED)
	end
end
--damage
function scard.op2(e,tp,eg,ep,ev,re,r,rp)
	local dam=40
	if Duel.TossCoin(tp,1)==RESULT_HEADS then dam=dam+20 end
	Duel.AttackDamage(e,dam)
end
