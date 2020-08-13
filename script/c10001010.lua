--Mewtwo (Base Set 10/102)
local scard,sid=aux.GetID()
function scard.initial_effect(c)
	aux.AddLength(c,6.70)
	--pokemon
	aux.EnablePokemonAttribute(c)
	--damage
	local e1=aux.AddPokemonAttack(c,0,nil,scard.op1)
	e1:SetAttackCost(ENERGY_P,ENERGY_C)
	--gain effect
	local e2=aux.AddPokemonAttack(c,1,nil,scard.op2,aux.DiscardAttachedCost(Card.IsEnergy,1,1,ENERGY_P))
	e2:SetAttackCost(ENERGY_P,ENERGY_P)
end
scard.pokemon_basic=true
scard.level_up_list={CARD_MEWTWO,CARD_CARD_MEWTWO_LV_X}
scard.weakness_x2={ENERGY_P}
--damage
function scard.op1(e,tp,eg,ep,ev,re,r,rp)
	local g=Duel.GetActivePokemon(1-tp):GetAttachedGroup()
	local dam=g:GetSum(Card.GetEnergyCount,nil)*10
	Duel.AttackDamage(e,10+dam)
end
--gain effect
function scard.op2(e,tp,eg,ep,ev,re,r,rp)
	local c=e:GetHandler()
	Duel.AttackDamage(e,0)
	--immune to attacks
	aux.AddTempEffectImmune(c,c,DESC_IMMUNE_ATTACK,aux.AttackImmuneFilter,RESET_PHASE+PHASE_END+RESET_OPPO_TURN)
end
