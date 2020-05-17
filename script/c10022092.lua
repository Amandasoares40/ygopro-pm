--Swoop! Teleporter (Team Rocket Returns 92/109)
local scard,sid=aux.GetID()
function scard.initial_effect(c)
	--search (switch), to discard pile
	aux.PlayTrainerFunction(c,scard.tg1,scard.op1)
end
scard.trainer_rockets_secret_machine=true
--search (switch), to discard pile
function scard.swfilter(c)
	return c:IsBasicPokemon() and not c:IsPokemonex()
end
function scard.tgfilter(c)
	return c:IsFaceup() and c:IsBasicPokemon() and not c:IsPokemonex() and c:IsAbleToDPile()
end
function scard.tg1(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return Duel.GetFieldGroupCount(tp,LOCATION_DECK,0)>0
		and Duel.IsExistingMatchingCard(scard.tgfilter,tp,LOCATION_INPLAY,0,1,nil) end
end
function scard.op1(e,tp,eg,ep,ev,re,r,rp)
	local g=Duel.GetMatchingGroup(scard.tgfilter,tp,LOCATION_INPLAY,0,nil)
	if g:GetCount()==0 then return end
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_PROMOTE)
	local sg1=Duel.SelectMatchingCard(tp,scard.swfilter,tp,LOCATION_DECK,0,0,1,nil)
	if sg1:GetCount()>0 then
		Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_TODPILE)
		local sg2=g:Select(tp,1,1,nil)
		Duel.HintSelection(sg2)
		Duel.SwitchPokemonOffField(tp,sg2,sg1,LOCATION_DPILE,nil,REASON_EFFECT,true)
	else
		Duel.ShuffleDeck(tp)
	end
end
