--Swirlix (Kalos Starter Set 24/39)
local scard,sid=aux.GetID()
function scard.initial_effect(c)
	aux.AddHeight(c,1.04)
	--pokemon
	aux.EnablePokemonAttribute(c)
	--heal
	local e1=aux.AddPokemonAttack(c,0,nil,scard.op1)
	e1:SetAttackCost(ENERGY_Y)
end
scard.pokemon_basic=true
scard.weakness_x2={ENERGY_M}
scard.resistance_20={ENERGY_D}
--heal
function scard.op1(e,tp,eg,ep,ev,re,r,rp)
	Duel.AttackDamage(e,10)
	Duel.HealDamage(tp,e:GetHandler(),10,REASON_ATTACK)
end
