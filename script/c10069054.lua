--Zygarde-EX (Fates Collide 54/124)
local scard,sid=aux.GetID()
function scard.initial_effect(c)
	--pokemon
	aux.EnablePokemonAttribute(c)
	--damage
	local e1=aux.AddPokemonAttack(c,0,nil,scard.op1)
	e1:SetAttackCost(ENERGY_F)
	--heal
	local e2=aux.AddPokemonAttack(c,1,nil,scard.op2)
	e2:SetAttackCost(ENERGY_F,ENERGY_C)
	--damage
	local e3=aux.AddPokemonAttack(c,2,nil,aux.AttackDamageOperation(100))
	e3:SetAttackCost(ENERGY_F,ENERGY_F,ENERGY_C)
end
scard.pokemon_basic=true
scard.pokemon_ex=true
scard.weakness_x2={ENERGY_G}
--damage
function scard.op1(e,tp,eg,ep,ev,re,r,rp)
	local dam=20
	if Duel.GetStadiumCard() then dam=dam+20 end
	Duel.AttackDamage(e,dam)
end
--heal
function scard.op2(e,tp,eg,ep,ev,re,r,rp)
	Duel.AttackDamage(e,60)
	Duel.HealDamage(tp,e:GetHandler(),30,REASON_ATTACK)
end
