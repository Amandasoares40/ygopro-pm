--Arceus (Arceus AR1)
local scard,sid=aux.GetID()
function scard.initial_effect(c)
	--pokemon
	aux.EnablePokemonAttribute(c)
	--damage
	local e1=aux.AddPokemonAttack(c,0,nil,scard.op1)
	e1:SetAttackCost(ENERGY_D,ENERGY_C)
end
scard.pokemon_basic=true
scard.height=10.06
scard.weakness_x2={ENERGY_F}
scard.resistance_20={ENERGY_P}
--damage
function scard.op1(e,tp,eg,ep,ev,re,r,rp)
	local dam=20
	if Duel.GetPrizeCount(tp)>Duel.GetPrizeCount(1-tp) then dam=dam+60 end
	Duel.AttackDamage(e,dam)
end
