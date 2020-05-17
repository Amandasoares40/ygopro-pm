--Reshiram-EX (Next Destinies 22/99)
local scard,sid=aux.GetID()
function scard.initial_effect(c)
	--pokemon
	aux.EnablePokemonAttribute(c)
	--damage
	local e1=aux.AddPokemonAttack(c,0,nil,scard.op1)
	e1:SetAttackCost(ENERGY_R,ENERGY_C,ENERGY_C)
	--damage
	local e2=aux.AddPokemonAttack(c,1,nil,scard.op2)
	e2:SetAttackCost(ENERGY_R,ENERGY_R,ENERGY_C,ENERGY_C)
end
scard.pokemon_basic=true
scard.pokemon_ex=true
scard.weakness_x2={ENERGY_W}
--damage
function scard.op1(e,tp,eg,ep,ev,re,r,rp)
	local dam=50
	if Duel.TossCoin(tp,1)==RESULT_HEADS then dam=dam+30 end
	Duel.AttackDamage(e,dam)
end
--damage
function scard.op2(e,tp,eg,ep,ev,re,r,rp)
	Duel.AttackDamage(e,150)
	if Duel.TossCoin(tp,1)==RESULT_TAILS then
		Duel.AttackDamage(e,50,e:GetHandler())
	end
end
