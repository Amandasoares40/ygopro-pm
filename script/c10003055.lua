--Slowpoke (Fossil 55/62)
local scard,sid=aux.GetID()
function scard.initial_effect(c)
	--pokemon
	aux.EnablePokemonAttribute(c)
	--heal
	local e1=aux.AddPokemonAttack(c,0,nil,scard.op1)
	e1:SetAttackCost(ENERGY_C)
	--to hand
	local e2=aux.AddPokemonAttack(c,1,nil,scard.op2,aux.DiscardAttachedCost(Card.IsEnergy,1,1,ENERGY_P))
	e2:SetAttackCost(ENERGY_P,ENERGY_P)
end
scard.pokemon_basic=true
scard.length=3.11
scard.evolution_list1={["Basic"]=CARD_SLOWPOKE,["Stage 1"]=CARD_SLOWBRO}
scard.evolution_list2={["Basic"]=CARD_SLOWPOKE,["Stage 1"]=CARD_LIGHT_SLOWBRO}
scard.weakness_x2={ENERGY_P}
--heal
function scard.op1(e,tp,eg,ep,ev,re,r,rp)
	local c=e:GetHandler()
	Duel.AttackDamage(e,0)
	if c:IsCanBeHealed() and Duel.TossCoin(tp,1)==RESULT_HEADS then
		Duel.HealDamage(tp,c,10,REASON_ATTACK)
	end
end
--to hand
function scard.thfilter(c)
	return c:IsItem() and c:IsAbleToHand()
end
function scard.op2(e,tp,eg,ep,ev,re,r,rp)
	Duel.AttackDamage(e,0)
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_ATOHAND)
	local g=Duel.SelectMatchingCard(tp,scard.thfilter,tp,LOCATION_DPILE,0,1,1,nil)
	if g:GetCount()==0 then return end
	Duel.SendtoHand(g,PLAYER_OWNER,REASON_ATTACK)
	Duel.ConfirmCards(1-tp,g)
end
