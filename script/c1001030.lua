--Togepi (Black Star Promo Wizards of the Coast 30)
--WORK IN PROGRESS: Choosing a Pokemon's attack to copy it
local scard,sid=aux.GetID()
function scard.initial_effect(c)
	aux.AddLength(c,1.00)
	--pokemon
	aux.EnablePokemonAttribute(c)
	--gain effect
	local e1=aux.AddPokemonAttack(c,0,nil,scard.op1)
	e1:SetAttackCost(ENERGY_C)
	--copy attack
	local e2=aux.AddPokemonAttack(c,1,nil,scard.op2)
	e2:SetAttackCost(ENERGY_C,ENERGY_C)
end
scard.pokemon_basic=true
scard.evolution_list1={["Basic"]=CARD_TOGEPI,["Stage 1"]=CARD_TOGETIC,["Stage 2"]=CARD_TOGEKISS}
scard.resistance_30={ENERGY_P}
--gain effect
function scard.op1(e,tp,eg,ep,ev,re,r,rp)
	local c=e:GetHandler()
	Duel.AttackDamage(e,0)
	--reduce damage
	local e1=Effect.CreateEffect(c)
	e1:SetDescription(DESC_TAKE_LESS_DAMAGE)
	e1:SetType(EFFECT_TYPE_SINGLE)
	e1:SetCode(EFFECT_UPDATE_DAMAGE_BEFORE)
	e1:SetProperty(EFFECT_FLAG_CLIENT_HINT)
	e1:SetValue(-20)
	e1:SetReset(RESET_EVENT+RESETS_STANDARD+RESET_PHASE+PHASE_END+RESET_OPPO_TURN)
	c:RegisterEffect(e1)
end
--copy attack
function scard.op2(e,tp,eg,ep,ev,re,r,rp)
end
