--Wally (Roaring Skies 94/108)
local scard,sid=aux.GetID()
function scard.initial_effect(c)
	--search (evolve)
	aux.PlayTrainerFunction(c,scard.tg1,scard.op1)
end
scard.trainer_supporter=true
--search (evolve)
function scard.cfilter(c,e,tp)
	return c:IsFaceup() and c:IsPokemon() and not c:IsPokemonEX() and c:IsCanEvolve(e,tp,true,true)
end
function scard.tg1(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return Duel.GetFreeBenchCount(tp)>-1
		and Duel.IsExistingMatchingCard(scard.cfilter,tp,LOCATION_INPLAY,0,1,nil,e,tp)
		and Duel.GetFieldGroupCount(tp,LOCATION_DECK,0)>0 end
end
function scard.evofilter(c,e,tp,code)
	return c.evolves_from==code and c:IsCanBePlayed(e,SUMMON_TYPE_EVOLVE,tp,true,false)
end
function scard.op1(e,tp,eg,ep,ev,re,r,rp)
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_EVOLVE)
	local g1=Duel.SelectMatchingCard(tp,scard.cfilter,tp,LOCATION_INPLAY,0,1,1,nil,e,tp)
	if g1:GetCount()==0 then return end
	Duel.HintSelection(g1)
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_EVOLVETO)
	local g2=Duel.SelectMatchingCard(tp,scard.evofilter,tp,LOCATION_DECK,0,0,1,nil,e,tp,g1:GetFirst():GetCode())
	if g2:GetCount()>0 then
		Duel.Evolve(g2:GetFirst(),g1,tp)
	else
		Duel.ShuffleDeck(tp)
	end
end
--[[
	Rulings
	https://compendium.pokegym.net/compendium-bw.html#500
]]
