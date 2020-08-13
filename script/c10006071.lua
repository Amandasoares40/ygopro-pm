--Brock's Sandshrew (Gym Heroes 71/132)
local scard,sid=aux.GetID()
function scard.initial_effect(c)
	aux.AddSetcode(c,SETNAME_BROCK,SETNAME_OWNER)
	aux.AddLength(c,2.00)
	--pokemon
	aux.EnablePokemonAttribute(c)
	--gain effect
	local e1=aux.AddPokemonAttack(c,0,nil,scard.op1)
	e1:SetAttackCost(ENERGY_C)
	--damage
	local e2=aux.AddPokemonAttack(c,1,nil,aux.AttackDamageOperation(20))
	e2:SetAttackCost(ENERGY_F,ENERGY_C)
end
scard.pokemon_basic=true
scard.evolution_list1={["Basic"]=CARD_BROCKS_SANDSHREW,["Stage 1"]=CARD_BROCKS_SANDSLASH}
scard.weakness_x2={ENERGY_G}
scard.resistance_30={ENERGY_L}
--gain effect
function scard.op1(e,tp,eg,ep,ev,re,r,rp)
	local c=e:GetHandler()
	Duel.AttackDamage(e,0)
	if Duel.TossCoin(tp,1)==RESULT_HEADS then
		--immune to damage
		aux.AddTempEffectCustom(c,c,DESC_IMMUNE_DAMAGE,EFFECT_CANNOT_BE_DAMAGED,RESET_PHASE+PHASE_END+RESET_OPPO_TURN)
	end
end
