--Rotom (Great Encounters 7/106)
local scard,sid=aux.GetID()
function scard.initial_effect(c)
	aux.AddSetcode(c,SETNAME_ROTOM)
	--pokemon
	aux.EnablePokemonAttribute(c)
	--confirm hand, to deck
	local e1=aux.AddPokemonAttack(c,0,nil,scard.op1)
	e1:SetAttackCost(ENERGY_C,ENERGY_C)
	--paralyzed
	local e2=aux.AddPokemonAttack(c,1,nil,scard.op2)
	e2:SetAttackCost(ENERGY_L,ENERGY_L)
end
scard.pokemon_basic=true
scard.height=1.00
scard.weakness_20={ENERGY_D}
scard.resistance_20={ENERGY_C}
--confirm hand, to deck
function scard.op1(e,tp,eg,ep,ev,re,r,rp)
	Duel.AttackDamage(e,20)
	local g=Duel.GetFieldGroup(tp,0,LOCATION_HAND)
	if g:GetCount()==0 then return end
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_TODECK)
	local sg=g:Select(tp,1,1,nil)
	if not sg:GetFirst():IsPublic() then Duel.ConfirmCards(tp,sg) end
	Duel.SendtoDeck(sg,PLAYER_OWNER,SEQ_DECK_SHUFFLE,REASON_ATTACK)
	Duel.ShuffleHand(1-tp)
end
--paralyzed
function scard.op2(e,tp,eg,ep,ev,re,r,rp)
	local dam=30
	local paralyzed=false
	if Duel.TossCoin(tp,1)==RESULT_HEADS then
		dam=dam+30
		paralyzed=true
	end
	local tc=Duel.GetActivePokemon(1-tp)
	Duel.AttackDamage(e,dam)
	if tc:IsInPlay() and paralyzed then tc:ApplySpecialCondition(tp,SPC_PARALYZED) end
end
