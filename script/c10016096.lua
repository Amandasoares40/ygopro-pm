--Chansey ex (Ruby & Sapphire 96/109)
local scard,sid=aux.GetID()
function scard.initial_effect(c)
	--pokemon
	aux.EnablePokemonAttribute(c)
	--remove counter
	local e1=aux.AddPokemonAttack(c,0,nil,scard.op1)
	e1:SetAttackCost(ENERGY_C,ENERGY_C)
	--damage
	local e2=aux.AddPokemonAttack(c,1,nil,scard.op2)
	e2:SetAttackCost(ENERGY_C,ENERGY_C,ENERGY_C)
end
scard.pokemon_basic=true
scard.pokemon_ex_old=true
scard.weakness_x2={ENERGY_F}
--remove counter
function scard.ctfilter(c)
	return c:IsFaceup() and c:IsPokemon() and c:IsDamaged()
end
function scard.op1(e,tp,eg,ep,ev,re,r,rp)
	Duel.AttackDamage(e,0)
	local g=Duel.GetMatchingGroup(scard.ctfilter,tp,LOCATION_INPLAY,0,e:GetHandler())
	for tc in aux.Next(g) do
		tc:RemoveCounter(tp,COUNTER_DAMAGE,2,REASON_ATTACK)
	end
end
--damage
function scard.op2(e,tp,eg,ep,ev,re,r,rp)
	Duel.AttackDamage(e,80)
	Duel.AttackDamage(e,60,e:GetHandler())
end
