--Magikarp (Base Set 35/102)
local scard,sid=aux.GetID()
function scard.initial_effect(c)
	--pokemon
	aux.EnablePokemonAttribute(c)
	--damage
	local e1=aux.AddPokemonAttack(c,0,nil,aux.AttackDamageOperation(10))
	e1:SetAttackCost(ENERGY_C)
	--damage
	local e2=aux.AddPokemonAttack(c,1,nil,scard.op1)
	e2:SetAttackCost(ENERGY_W)
end
scard.pokemon_basic=true
scard.length=2.11
scard.evolution_list1={["Basic"]=CARD_MAGIKARP,["Stage 1"]=CARD_GYARADOS}
scard.weakness_x2={ENERGY_L}
--damage
function scard.op1(e,tp,eg,ep,ev,re,r,rp)
	local dam=e:GetHandler():GetCounter(COUNTER_DAMAGE)
	Duel.AttackDamage(e,10*dam)
end
