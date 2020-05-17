--Arceus (Arceus AR6)
--BUG: Due to having consecutive ids, this card is treated as Arceus (Arceus AR1)
local scard,sid=aux.GetID()
function scard.initial_effect(c)
	--pokemon
	aux.EnablePokemonAttribute(c)
	--switch
	local e1=aux.AddPokemonAttack(c,0,nil,scard.op1)
	e1:SetAttackCost(ENERGY_L,ENERGY_C)
end
scard.pokemon_basic=true
scard.height=10.06
scard.weakness_x2={ENERGY_F}
scard.resistance_20={ENERGY_M}
--switch
function scard.op1(e,tp,eg,ep,ev,re,r,rp)
	Duel.AttackDamage(e,30)
	Duel.SwitchPokemon(tp,tp)
end
