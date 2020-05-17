--Type: Null (Crimson Invasion 89/111)
local scard,sid=aux.GetID()
function scard.initial_effect(c)
	--pokemon
	aux.EnablePokemonAttribute(c)
	--get effect
	local e1=aux.AddPokemonAttack(c,0,nil,scard.op1)
	e1:SetAttackCost(ENERGY_C,ENERGY_C)
	--damage
	local e2=aux.AddPokemonAttack(c,1,nil,aux.AttackDamageOperation(70))
	e2:SetAttackCost(ENERGY_C,ENERGY_C,ENERGY_C)
end
scard.pokemon_basic=true
scard.height=6.03
scard.evolution_list1={["Basic"]=CARD_TYPE_NULL,["Stage 1"]=CARD_SILVALLY}
scard.evolution_list2={["Basic"]=CARD_TYPE_NULL,["Stage 1"]=CARD_SILVALLY_GX}
scard.weakness_x2={ENERGY_F}
--get effect
function scard.op1(e,tp,eg,ep,ev,re,r,rp)
	Duel.AttackDamage(e,30)
	local c=e:GetHandler()
	--reduce damage
	aux.AddTempEffectUpdateDamage(c,c,DESC_TAKE_LESS_DAMAGE,EFFECT_UPDATE_DEFEND_AFTER,-30,RESET_PHASE+PHASE_END+RESET_OPPO_TURN)
end
