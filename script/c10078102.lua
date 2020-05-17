--Beast Ring (Forbidden Light 102/131)
local scard,sid=aux.GetID()
function scard.initial_effect(c)
	--search (attach)
	aux.PlayTrainerFunction(c,scard.tg1,scard.op1,scard.con1)
end
scard.trainer_item=true
--search (attach)
function scard.con1(e,tp,eg,ep,ev,re,r,rp)
	local ct=Duel.GetPrizeCount(1-tp)
	return ct==3 or ct==4
end
function scard.tg1(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return Duel.GetFieldGroupCount(tp,LOCATION_DECK,0)>0
		and Duel.GetInPlayPokemon(tp):IsExists(Card.IsUltraBeast,1,nil) end
end
function scard.cfilter(c,tp)
	return c:IsBasicEnergy() and Duel.GetInPlayPokemon(tp):IsExists(scard.atfilter,1,nil,c)
end
function scard.atfilter(c,tc)
	return c:IsUltraBeast() and tc:CheckAttachedTarget(c)
end
function scard.op1(e,tp,eg,ep,ev,re,r,rp)
	local g=Duel.GetMatchingGroup(scard.cfilter,tp,LOCATION_DECK,0,nil,tp)
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_ATTACHENERGY)
	local sg1=g:Select(tp,0,2,nil)
	if sg1:GetCount()>0 then
		Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_ATTACHENERGYTO)
		local sg2=Duel.GetInPlayPokemon(tp):FilterSelect(tp,scard.atfilter,1,1,nil,sg1:GetFirst())
		Duel.HintSelection(sg2)
		Duel.Attach(e,sg2:GetFirst(),sg1)
	else
		Duel.ShuffleDeck(tp)
	end
end
