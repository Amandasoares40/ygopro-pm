--Giovanni's Meowth (Gym Challenge 74/132)
local scard,sid=aux.GetID()
function scard.initial_effect(c)
	aux.AddSetcode(c,SETNAME_GIOVANNI,SETNAME_OWNER)
	--pokemon
	aux.EnablePokemonAttribute(c)
	--confused
	local e1=aux.AddPokemonAttack(c,0,nil,scard.op1)
	e1:SetAttackCost(ENERGY_C)
	--damage
	local e2=aux.AddPokemonAttack(c,1,nil,aux.AttackDamageOperation(30))
	e2:SetAttackCost(ENERGY_C,ENERGY_C,ENERGY_C)
end
scard.pokemon_basic=true
scard.length=1.40
scard.evolution_list1={["Basic"]=CARD_GIOVANNIS_MEOWTH,["Stage 1"]=CARD_GIOVANNIS_PERSIAN}
scard.weakness_x2={ENERGY_F}
scard.resistance_30={ENERGY_P}
--confused
function scard.op1(e,tp,eg,ep,ev,re,r,rp)
	local tc=Duel.GetActivePokemon(1-tp)
	Duel.AttackDamage(e,0)
	if tc:IsInPlay() and Duel.TossCoin(tp,1)==RESULT_HEADS then
		tc:ApplySpecialCondition(tp,SPC_CONFUSED)
	end
end
