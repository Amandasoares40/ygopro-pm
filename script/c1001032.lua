--Smeargle (Black Star Promo Wizards of the Coast 32)
local scard,sid=aux.GetID()
function scard.initial_effect(c)
	aux.AddLength(c,3.11)
	--pokemon
	aux.EnablePokemonAttribute(c)
	--add counter, gain effect
	local e1=aux.AddPokemonAttack(c,0,nil,scard.op1)
	e1:SetAttackCost(ENERGY_C)
end
scard.pokemon_basic=true
scard.weakness_x2={ENERGY_F}
scard.resistance_30={ENERGY_P}
--add counter, gain effect
function scard.op1(e,tp,eg,ep,ev,re,r,rp)
	local tc=Duel.GetActivePokemon(1-tp)
	if not tc:IsInPlay() or Duel.TossCoin(tp,1)==RESULT_TAILS then return end
	Duel.AttackDamage(e,0)
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_ENERGYTYPE)
	local energy_type=Duel.SelectEnergyType(tp)
	tc:AddCounter(tp,COUNTER_COLORING,1,REASON_ATTACK)
	--change energy type
	aux.AddTempEffectChangeEnergyType(e:GetHandler(),tc,energy_type)
end
