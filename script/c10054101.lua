--Black Kyurem-EX (Boundaries Crossed 101/149)
local scard,sid=aux.GetID()
function scard.initial_effect(c)
	--pokemon
	aux.EnablePokemonAttribute(c)
	--paralyzed
	local e1=aux.AddPokemonAttack(c,0,nil,scard.op1)
	e1:SetAttackCost(ENERGY_L,ENERGY_C,ENERGY_C)
	--gain effect
	local e2=aux.AddPokemonAttack(c,1,nil,scard.op2)
	e2:SetAttackCost(ENERGY_W,ENERGY_L,ENERGY_L,ENERGY_C)
end
scard.pokemon_basic=true
scard.pokemon_ex=true
scard.weakness_x2={ENERGY_N}
--paralyzed
function scard.op1(e,tp,eg,ep,ev,re,r,rp)
	local tc=Duel.GetActivePokemon(1-tp)
	Duel.AttackDamage(e,60)
	if tc:IsInPlay() and Duel.TossCoin(tp,1)==RESULT_HEADS then
		tc:ApplySpecialCondition(tp,SPC_PARALYZED)
	end
end
--gain effect
function scard.op2(e,tp,eg,ep,ev,re,r,rp)
	Duel.AttackDamage(e,150)
	local c=e:GetHandler()
	--cannot attack
	aux.AddTempEffectCustom(c,c,DESC_CANNOT_ATTACK,EFFECT_CANNOT_ATTACK,RESET_PHASE+PHASE_END+RESET_SELF_TURN,2)
end
