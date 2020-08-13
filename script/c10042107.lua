--Arceus (Arceus AR5)
--BUG: Due to having consecutive ids, this card is treated as Arceus (Arceus AR1)
local scard,sid=aux.GetID()
function scard.initial_effect(c)
	aux.AddHeight(c,10.06)
	--pokemon
	aux.EnablePokemonAttribute(c)
	--search (attach)
	local e1=aux.AddPokemonAttack(c,0,nil,scard.op1)
	e1:SetAttackCost()
	--damage, to lost zone
	local e2=aux.AddPokemonAttack(c,1,nil,scard.op2)
	e2:SetAttackCost(ENERGY_C,ENERGY_C,ENERGY_C)
end
scard.pokemon_basic=true
scard.weakness_x2={ENERGY_F}
--search (attach)
function scard.cfilter(c,tp)
	return c:IsBasicEnergy() and Duel.GetInPlayPokemon(tp):IsExists(scard.atfilter,1,nil,c)
end
function scard.atfilter(c,tc)
	return c:IsCode(CARD_ARCEUS) and tc:CheckAttachedTarget(c)
end
function scard.op1(e,tp,eg,ep,ev,re,r,rp)
	Duel.AttackDamage(e,0)
	local g1=Duel.GetMatchingGroup(scard.cfilter,tp,LOCATION_DECK,0,nil,tp)
	local g2=Duel.GetInPlayPokemon(tp):Filter(Card.IsCode,nil,CARD_ARCEUS)
	if g2:GetClassCount(Card.GetEnergyType)<6 then return end
	local count=6
	repeat
		Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_ATTACHENERGY)
		local sg1=g1:Select(tp,0,1,nil)
		if sg1:GetCount()==0 then break end
		Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_ATTACHENERGYTO)
		local sg2=g2:FilterSelect(tp,scard.atfilter,1,1,nil,sg1:GetFirst())
		Duel.HintSelection(sg2)
		Duel.DisableShuffleCheck()
		Duel.Attach(e,sg2:GetFirst(),sg1)
		g1:Sub(sg1)
		g2:Sub(sg2)
		count=count-1
	until count==0 or g1:GetCount()==0 or g2:GetClassCount(Card.GetEnergyType)==0 or not Duel.SelectYesNo(tp,YESNOMSG_ATTACHENERGYAGAIN)
	Duel.ShuffleDeck(tp)
end
--damage, to lost zone
function scard.op2(e,tp,eg,ep,ev,re,r,rp)
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_DAMAGE)
	local g1=Duel.GetInPlayPokemon(1-tp):Select(tp,1,1,nil)
	if g1:GetCount()==0 then return end
	Duel.HintSelection(g1)
	Duel.AttackDamage(e,80,g1:GetFirst())
	local g2=e:GetHandler():GetAttachedGroup():Filter(Card.IsEnergy,nil)
	Duel.SendtoLost(g2,REASON_ATTACK)
end
