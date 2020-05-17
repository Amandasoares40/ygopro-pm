--Scyther ex (Ruby & Sapphire 102/109)
local scard,sid=aux.GetID()
function scard.initial_effect(c)
	--pokemon
	aux.EnablePokemonAttribute(c)
	--get effect
	local e1=aux.AddPokemonAttack(c,0,nil,scard.op1)
	e1:SetAttackCost(ENERGY_G)
	--damage
	local e2=aux.AddPokemonAttack(c,1,nil,aux.AttackDamageOperation(50))
	e2:SetAttackCost(ENERGY_G,ENERGY_G,ENERGY_C)
end
scard.pokemon_basic=true
scard.pokemon_ex_old=true
scard.weakness_x2={ENERGY_R}
scard.resistance_30={ENERGY_F}
--get effect
function scard.op1(e,tp,eg,ep,ev,re,r,rp)
	Duel.AttackDamage(e,10)
	if Duel.TossCoin(tp,1)==RESULT_HEADS then
		local c=e:GetHandler()
		--immune to attacks
		aux.AddTempEffectImmune(c,c,DESC_IMMUNE_ATTACK,aux.AttackImmuneFilter,RESET_PHASE+PHASE_END+RESET_OPPO_TURN)
	end
end
