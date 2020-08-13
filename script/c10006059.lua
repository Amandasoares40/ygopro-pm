--Sabrina's Jynx (Gym Heroes 59/132)
local scard,sid=aux.GetID()
function scard.initial_effect(c)
	aux.AddSetcode(c,SETNAME_SABRINA,SETNAME_OWNER)
	aux.AddLength(c,4.70)
	--pokemon
	aux.EnablePokemonAttribute(c)
	--asleep
	local e1=aux.AddPokemonAttack(c,0,nil,scard.op1)
	e1:SetAttackCost(ENERGY_P)
	--remove asleep
	local e2=aux.AddPokemonAttack(c,1,nil,scard.op2)
	e2:SetAttackCost(ENERGY_P,ENERGY_C)
end
scard.pokemon_basic=true
scard.weakness_x2={ENERGY_P}
--asleep
function scard.op1(e,tp,eg,ep,ev,re,r,rp)
	Duel.AttackDamage(e,10)
	Duel.GetActivePokemon(1-tp):ApplySpecialCondition(tp,SPC_ASLEEP)
end
--remove asleep
function scard.op2(e,tp,eg,ep,ev,re,r,rp)
	local tc=Duel.GetActivePokemon(1-tp)
	Duel.AttackDamage(e,20)
	if tc:IsInPlay() then
		tc:RemoveSpecialCondition(tp,SPC_ASLEEP)
	end
end
