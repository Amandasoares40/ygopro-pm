--Max Elixir (BREAKpoint 102/122)
local scard,sid=aux.GetID()
function scard.initial_effect(c)
	--attach
	aux.PlayTrainerFunction(c,scard.tg1,scard.op1)
end
scard.trainer_item=true
--attach
function scard.tg1(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return Duel.GetFieldGroupCount(tp,LOCATION_DECK,0)>0
		and Duel.GetBenchedPokemon(tp):IsExists(Card.IsBasicPokemon,1,nil) end
end
function scard.cfilter(c,tp)
	return c:IsBasicEnergy() and Duel.GetBenchedPokemon(tp):IsExists(scard.atfilter,1,nil,c)
end
function scard.atfilter(c,tc)
	return c:IsBasicPokemon() and tc:CheckAttachedTarget(c)
end
function scard.op1(e,tp,eg,ep,ev,re,r,rp)
	if Duel.GetFieldGroupCount(tp,LOCATION_DECK,0)<=0 then return end
	local g=Duel.GetDecktopGroup(tp,6)
	Duel.ConfirmCards(tp,g)
	g=g:Filter(scard.cfilter,nil,tp)
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_ATTACHENERGY)
	local sg1=g:Select(tp,0,1,nil)
	if sg1:GetCount()>0 then
		Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_ATTACHENERGYTO)
		local sg2=Duel.GetBenchedPokemon(tp):FilterSelect(tp,scard.atfilter,1,1,nil,sg1:GetFirst())
		Duel.HintSelection(sg2)
		Duel.Attach(e,sg2:GetFirst(),sg1)
	else
		Duel.ShuffleDeck(tp)
	end
end
