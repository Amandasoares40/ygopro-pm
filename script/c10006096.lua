--Sabrina's Venonat (Gym Heroes 96/132)
local scard,sid=aux.GetID()
function scard.initial_effect(c)
	aux.AddSetcode(c,SETNAME_SABRINA,SETNAME_OWNER)
	aux.AddLength(c,3.30)
	--pokemon
	aux.EnablePokemonAttribute(c)
	--poisoned
	local e1=aux.AddPokemonAttack(c,0,nil,scard.op1)
	e1:SetAttackCost(ENERGY_G)
	--discard energy
	local e2=aux.AddPokemonAttack(c,1,nil,scard.op2)
	e2:SetAttackCost(ENERGY_P,ENERGY_C)
end
scard.pokemon_basic=true
scard.evolution_list1={["Basic"]=CARD_SABRINAS_VENONAT,["Stage 1"]=CARD_SABRINAS_VENOMOTH}
scard.weakness_x2={ENERGY_R}
--poisoned
function scard.op1(e,tp,eg,ep,ev,re,r,rp)
	local tc=Duel.GetActivePokemon(1-tp)
	Duel.AttackDamage(e,0)
	if tc:IsInPlay() then
		tc:ApplySpecialCondition(tp,SPC_POISONED)
	end
end
--discard energy
function scard.op2(e,tp,eg,ep,ev,re,r,rp)
	local tc=Duel.GetActivePokemon(1-tp)
	Duel.AttackDamage(e,20)
	if tc:IsInPlay() and tc:GetAttachedGroup():IsExists(Card.IsEnergy,1,nil) and Duel.TossCoin(tp,1)==RESULT_HEADS then
		Duel.DiscardAttached(tp,tc,Card.IsEnergy,1,1,REASON_ATTACK)
	end
end
