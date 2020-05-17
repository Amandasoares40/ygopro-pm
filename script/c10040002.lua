--Bastiodon GL (Rising Rivals 2/111)
local scard,sid=aux.GetID()
function scard.initial_effect(c)
	--pokemon
	aux.EnablePokemonAttribute(c)
	--switch
	local e1=aux.AddPokemonAttack(c,0,nil,scard.op1)
	e1:SetAttackCost(ENERGY_M,ENERGY_C,ENERGY_C)
	--remove counter
	local e2=aux.AddPokemonAttack(c,1,nil,scard.op2)
	e2:SetAttackCost(ENERGY_M,ENERGY_C,ENERGY_C,ENERGY_C)
end
scard.pokemon_basic=true
scard.pokemon_sp=true
scard.weakness_x2={ENERGY_R}
scard.resistance_20={ENERGY_P}
--switch
function scard.op1(e,tp,eg,ep,ev,re,r,rp)
	Duel.AttackDamage(e,30)
	Duel.SwitchPokemon(1-tp,1-tp)
end
--remove counter
function scard.op2(e,tp,eg,ep,ev,re,r,rp)
	Duel.AttackDamage(e,60)
	e:GetHandler():RemoveCounter(tp,COUNTER_DAMAGE,1,REASON_ATTACK)
end
