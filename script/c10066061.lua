--Mewtwo-EX (BREAKthrough 61/162)
local scard,sid=aux.GetID()
function scard.initial_effect(c)
	--pokemon
	aux.EnablePokemonAttribute(c)
	--gain effect
	local e1=aux.AddPokemonAttack(c,0,nil,scard.op1)
	e1:SetAttackCost(ENERGY_C,ENERGY_C)
	--damage
	local e2=aux.AddPokemonAttack(c,1,nil,aux.AttackDamageOperation(120))
	e2:SetAttackCost(ENERGY_P,ENERGY_P,ENERGY_C,ENERGY_C)
end
scard.pokemon_basic=true
scard.pokemon_ex=true
scard.mega_evolution_list={CARD_MEWTWO_EX,CARD_M_MEWTWO_EX}
scard.weakness_x2={ENERGY_P}
--gain effect
function scard.op1(e,tp,eg,ep,ev,re,r,rp)
	local tc=Duel.GetActivePokemon(1-tp)
	Duel.AttackDamage(e,30)
	if not tc:IsInPlay() then return end
	--reduce damage
	aux.AddTempEffectUpdateDamage(e:GetHandler(),tc,DESC_DO_LESS_DAMAGE,EFFECT_UPDATE_ATTACK_BEFORE,-30,RESET_PHASE+PHASE_END+RESET_SELF_TURN)
end
