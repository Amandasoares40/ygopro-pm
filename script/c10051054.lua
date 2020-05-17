--Mewtwo-EX (Next Destinies 54/99)
local scard,sid=aux.GetID()
function scard.initial_effect(c)
	--pokemon
	aux.EnablePokemonAttribute(c)
	--damage
	local e1=aux.AddPokemonAttack(c,0,nil,scard.op1)
	e1:SetAttackCost(ENERGY_C,ENERGY_C)
	--discard energy
	local e2=aux.AddPokemonAttack(c,1,nil,scard.op2)
	e2:SetAttackCost(ENERGY_P,ENERGY_P,ENERGY_C)
end
scard.pokemon_basic=true
scard.pokemon_ex=true
scard.mega_evolution_list={CARD_MEWTWO_EX,CARD_M_MEWTWO_EX}
scard.weakness_x2={ENERGY_P}
--damage
function scard.op1(e,tp,eg,ep,ev,re,r,rp)
	local g1=e:GetHandler():GetAttachedGroup()
	local g2=Duel.GetActivePokemon(1-tp):GetAttachedGroup()
	local dam=g1:GetSum(Card.GetEnergyCount,nil)+g2:GetSum(Card.GetEnergyCount,nil)
	Duel.AttackDamage(e,20*dam)
end
--discard energy
function scard.op2(e,tp,eg,ep,ev,re,r,rp)
	Duel.AttackDamage(e,120)
	Duel.DiscardAttached(tp,e:GetHandler(),Card.IsEnergy,1,1,REASON_ATTACK)
end
