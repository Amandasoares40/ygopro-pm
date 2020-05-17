--Arceus (Arceus AR2)
--BUG: Due to having consecutive ids, this card is treated as Arceus (Arceus AR1)
local scard,sid=aux.GetID()
function scard.initial_effect(c)
	--pokemon
	aux.EnablePokemonAttribute(c)
	--remove counter
	local e1=aux.AddPokemonAttack(c,0,nil,scard.op1)
	e1:SetAttackCost(ENERGY_G,ENERGY_C)
end
scard.pokemon_basic=true
scard.height=10.06
scard.weakness_x2={ENERGY_R}
scard.resistance_20={ENERGY_W}
--remove counter
function scard.op1(e,tp,eg,ep,ev,re,r,rp)
	Duel.AttackDamage(e,30)
	local g=Duel.GetBenchedPokemon(tp)
	for tc in aux.Next(g) do
		tc:RemoveCounter(tp,COUNTER_DAMAGE,3,REASON_ATTACK)
	end
end
