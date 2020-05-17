--Regigigas-EX (Next Destinies 82/99)
local scard,sid=aux.GetID()
function scard.initial_effect(c)
	--pokemon
	aux.EnablePokemonAttribute(c)
	--damage
	local e1=aux.AddPokemonAttack(c,0,nil,scard.op1)
	e1:SetAttackCost(ENERGY_C,ENERGY_C,ENERGY_C)
	--damage
	local e2=aux.AddPokemonAttack(c,1,nil,scard.op2)
	e2:SetAttackCost(ENERGY_C,ENERGY_C,ENERGY_C,ENERGY_C)
end
scard.pokemon_basic=true
scard.pokemon_ex=true
scard.weakness_x2={ENERGY_F}
--damage
function scard.op1(e,tp,eg,ep,ev,re,r,rp)
	local dam=60
	local self_damage=false
	if Duel.SelectYesNo(tp,YESNOMSG_MOREDAMAGE) then
		dam=dam+20
		self_damage=true
	end
	Duel.AttackDamage(e,dam)
	if self_damage then Duel.AttackDamage(e,20,e:GetHandler()) end
end
--damage
function scard.op2(e,tp,eg,ep,ev,re,r,rp)
	local dam=50
	local ct=e:GetHandler():GetCounter(COUNTER_DAMAGE)
	if ct>0 then dam=dam+(ct*10) end
	Duel.AttackDamage(e,dam)
end
