--Maxie's Hidden Ball Trick (Primal Clash 133/160)
local scard,sid=aux.GetID()
function scard.initial_effect(c)
	--to bench, draw
	aux.PlayTrainerFunction(c,scard.tg1,scard.op1,scard.con1)
end
scard.trainer_supporter=true
--to bench, draw
function scard.con1(e,tp,eg,ep,ev,re,r,rp)
	return Duel.GetFieldGroupCount(tp,LOCATION_HAND,0)==1
end
function scard.tbfilter(c,e,tp)
	return c:IsPokemon() and c:IsEnergyType(ENERGY_F) and c:IsCanBePlayed(e,0,tp,true,false)
end
function scard.tg1(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return Duel.IsNotBenchFull(tp)
		and Duel.IsExistingMatchingCard(scard.tbfilter,tp,LOCATION_DPILE,0,1,nil,e,tp) end
end
function scard.op1(e,tp,eg,ep,ev,re,r,rp)
	if Duel.IsBenchFull(tp) then return end
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_TOBENCH)
	local g=Duel.SelectMatchingCard(tp,scard.tbfilter,tp,LOCATION_DPILE,0,1,1,nil,e,tp)
	if g:GetCount()==0 or Duel.PlayPokemon(g,0,tp,tp,true,false,POS_FACEUP_UPSIDE)==0 then return end
	Duel.BreakEffect()
	Duel.Draw(tp,5,REASON_EFFECT)
end
--[[
	Rulings
	Q. Can I use "Archie's Ace in the Hole" or "Maxie's Hidden Ball Trick" to put a Stage 2 or Mega Pokemon directly onto
	my bench?
	A. Yes, they're very sneaky like that. (Primal Clash FAQ; Feb 5, 2015 TPCi Rules Team)

	Q. With "Archie's Ace in the Hole" and "Maxie's Hidden Ball Trick", does a Stage 2 Pokemon put on the bench count as a
	Basic Pokemon?
	A. No, it is an unevolved Stage 2 Pokemon. It is still considered an "Evolution Pokemon", but it is not a "Basic
	Pokemon". (Apr 27, 2017 TPCi Rules Team)

	Q. Can I play "Archie's Ace in the Hole" or "Maxie's Hidden Ball Trick" if I don't have a Water/Fighting Pokemon in my
	discard pile?
	A. No, you cannot. If you can't put one of those Pokemon onto your bench you don't get to draw 5 cards.
	(Feb 26, 2015 TPCi Rules Team)
	https://compendium.pokegym.net/compendium-bw.html#389

	Note: This card's effect is similar to that of "Archie's Ace in the Hole".
]]
