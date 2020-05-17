--Snorlax-GX (Black Star Promo SM05)
local scard,sid=aux.GetID()
function scard.initial_effect(c)
	--pokemon
	aux.EnablePokemonAttribute(c)
	--asleep
	local e1=aux.AddPokemonAttack(c,0,nil,scard.op1)
	e1:SetAttackCost(ENERGY_C,ENERGY_C,ENERGY_C)
	--damage
	local e2=aux.AddPokemonAttack(c,1,nil,scard.op2)
	e2:SetAttackCost(ENERGY_C,ENERGY_C,ENERGY_C,ENERGY_C,ENERGY_C)
	e2:SetProperty(EFFECT_FLAG_ATTACK_IGNORE_ASLEEP)
	--gx attack (asleep)
	local e3=aux.AddPokemonAttack(c,2,CATEGORY_GX_ATTACK,scard.op3)
	e3:SetAttackCost(ENERGY_C,ENERGY_C,ENERGY_C,ENERGY_C,ENERGY_C)
end
scard.pokemon_basic=true
scard.pokemon_gx=true
scard.weakness_x2={ENERGY_F}
--asleep
function scard.op1(e,tp,eg,ep,ev,re,r,rp)
	Duel.AttackDamage(e,80)
	e:GetHandler():ApplySpecialCondition(tp,SPC_ASLEEP)
end
--damage
function scard.op2(e,tp,eg,ep,ev,re,r,rp)
	if not e:GetHandler():IsAsleep() then return end
	Duel.AttackDamage(e,180)
end
--gx attack (asleep)
function scard.op3(e,tp,eg,ep,ev,re,r,rp)
	Duel.AttackDamage(e,210)
	e:GetHandler():ApplySpecialCondition(tp,SPC_ASLEEP)
end
