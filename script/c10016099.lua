--Lapras ex (Ruby & Sapphire 99/109)
local scard,sid=aux.GetID()
function scard.initial_effect(c)
	--pokemon
	aux.EnablePokemonAttribute(c)
	--damage
	local e1=aux.AddPokemonAttack(c,0,nil,scard.op1)
	e1:SetAttackCost(ENERGY_W)
	--confused
	local e2=aux.AddPokemonAttack(c,1,nil,scard.op2)
	e2:SetAttackCost(ENERGY_W,ENERGY_W,ENERGY_C)
end
scard.pokemon_basic=true
scard.pokemon_ex_old=true
scard.weakness_x2={ENERGY_L}
--damage
function scard.op1(e,tp,eg,ep,ev,re,r,rp)
	local g=e:GetHandler():GetAttachedGroup():Filter(Card.IsEnergy,nil)
	local add=g:GetSum(Card.GetEnergyCount,nil)*10-10
	if add>20 then add=20 end
	local dam=10+add
	Duel.AttackDamage(e,dam)
end
--confused
function scard.op2(e,tp,eg,ep,ev,re,r,rp)
	local tc=Duel.GetActivePokemon(1-tp)
	Duel.AttackDamage(e,30)
	if tc:IsInPlay() then
		tc:ApplySpecialCondition(tp,SPC_CONFUSED)
	end
end
