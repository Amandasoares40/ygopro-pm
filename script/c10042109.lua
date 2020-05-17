--Arceus (Arceus AR7)
--BUG: Due to having consecutive ids, this card is treated as Arceus (Arceus AR1)
local scard,sid=aux.GetID()
function scard.initial_effect(c)
	--pokemon
	aux.EnablePokemonAttribute(c)
	--confused
	local e1=aux.AddPokemonAttack(c,0,nil,scard.op1)
	e1:SetAttackCost(ENERGY_P,ENERGY_C,ENERGY_C)
end
scard.pokemon_basic=true
scard.height=10.06
scard.weakness_x2={ENERGY_P}
--confused
function scard.op1(e,tp,eg,ep,ev,re,r,rp)
	local tc=Duel.GetActivePokemon(1-tp)
	Duel.AttackDamage(e,40)
	if tc:IsInPlay() then
		tc:ApplySpecialCondition(tp,SPC_CONFUSED)
	end
end
