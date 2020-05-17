--Giovanni's Meowth (Gym Challenge 43/132)
local scard,sid=aux.GetID()
function scard.initial_effect(c)
	aux.AddSetcode(c,SETNAME_GIOVANNI,SETNAME_OWNER)
	--pokemon
	aux.EnablePokemonAttribute(c)
	--confirm deck (discard deck or to hand)
	local e1=aux.AddPokemonAttack(c,0,nil,scard.op1)
	e1:SetAttackCost(ENERGY_C)
	--damage
	local e2=aux.AddPokemonAttack(c,1,nil,scard.op2)
	e2:SetAttackCost(ENERGY_C,ENERGY_C)
end
scard.pokemon_basic=true
scard.length=1.40
scard.evolution_list1={["Basic"]=CARD_GIOVANNIS_MEOWTH,["Stage 1"]=CARD_GIOVANNIS_PERSIAN}
scard.weakness_x2={ENERGY_F}
scard.resistance_30={ENERGY_P}
--confirm deck (discard deck or to hand)
function scard.op1(e,tp,eg,ep,ev,re,r,rp)
	Duel.AttackDamage(e,0)
	if Duel.GetFieldGroupCount(tp,0,LOCATION_DECK)<=0 or Duel.TossCoin(tp,1)==RESULT_TAILS then return end
	local tc=Duel.GetDecktopGroup(1-tp,1):GetFirst()
	Duel.ConfirmCards(tp,tc)
	Duel.DisableShuffleCheck()
	if tc:IsTrainer() then
		Duel.SendtoDPile(tc,REASON_ATTACK)
	else
		Duel.SendtoHand(tc,PLAYER_OWNER,REASON_ATTACK)
		Duel.ConfirmCards(tp,tc)
		Duel.ShuffleHand(1-tp)
	end
end
--damage
function scard.op2(e,tp,eg,ep,ev,re,r,rp)
	local c1,c2=Duel.TossCoin(tp,2)
	local dam=c1+c2
	Duel.AttackDamage(e,20*dam)
end
