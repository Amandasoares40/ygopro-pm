--Mareep (Neo Genesis 65/111)
local scard,sid=aux.GetID()
function scard.initial_effect(c)
	aux.AddLength(c,2.00)
	--pokemon
	aux.EnablePokemonAttribute(c)
	--search (attach)
	local e1=aux.AddPokemonAttack(c,0,nil,scard.op1)
	e1:SetAttackCost(ENERGY_L)
	--paralyzed
	local e2=aux.AddPokemonAttack(c,1,nil,scard.op2)
	e2:SetAttackCost(ENERGY_L,ENERGY_L)
end
scard.pokemon_basic=true
scard.evolution_list1={["Basic"]=CARD_MAREEP,["Stage 1"]=CARD_FLAAFFY,["Stage 2"]=CARD_AMPHAROS}
scard.weakness_x2={ENERGY_F}
--search (attach)
function scard.atfilter(c,tc)
	return c:IsEnergy(ENERGY_L) and c:CheckAttachedTarget(tc)
end
function scard.op1(e,tp,eg,ep,ev,re,r,rp)
	Duel.AttackDamage(e,0)
	local ct=Duel.GetInPlayPokemon(tp):FilterCount(Card.IsCode,nil,sid)
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_ATTACHENERGY)
	local g=Duel.SelectMatchingCard(tp,scard.atfilter,tp,LOCATION_DECK,0,0,ct,nil,e:GetHandler())
	if g:GetCount()>0 then
		Duel.Attach(e,e:GetHandler(),g)
	else
		Duel.ShuffleDeck(tp)
	end
end
--paralyzed
function scard.op2(e,tp,eg,ep,ev,re,r,rp)
	local tc=Duel.GetActivePokemon(1-tp)
	Duel.AttackDamage(e,20)
	if tc:IsInPlay() and Duel.TossCoin(tp,1)==RESULT_HEADS then
		tc:ApplySpecialCondition(tp,SPC_PARALYZED)
	end
end
