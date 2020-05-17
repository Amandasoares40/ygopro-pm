--Windstorm (Crystal Guardians 85/100)
local scard,sid=aux.GetID()
function scard.initial_effect(c)
	--discard trainer
	aux.PlayTrainerFunction(c,scard.tg1,scard.op1)
end
scard.trainer_item=true
--discard trainer
function scard.dtfilter1(c)
	return c:IsFaceup() and c:IsStadium()
end
function scard.dtfilter2(c)
	return c:GetAttachedGroup():IsExists(Card.IsPokemonTool,1,nil)
end
function scard.tg1(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return Duel.IsExistingMatchingCard(scard.dtfilter1,tp,LOCATION_INPLAY,LOCATION_INPLAY,1,nil)
		or Duel.IsExistingMatchingCard(scard.dtfilter2,tp,LOCATION_INPLAY,LOCATION_INPLAY,1,nil) end
end
function scard.op1(e,tp,eg,ep,ev,re,r,rp)
	local g1=Duel.GetMatchingGroup(scard.dtfilter1,tp,LOCATION_INPLAY,LOCATION_INPLAY,nil)
	local g2=Duel.GetAttachedGroup(tp,1,1):Filter(Card.IsPokemonTool,nil)
	g1:Merge(g2)
	if g1:GetCount()==0 then return end
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_DISCARD)
	local sg=g1:Select(tp,1,2,nil)
	Duel.HintSelection(sg)
	Duel.SendtoDPile(sg,REASON_EFFECT+REASON_DISCARD)
end
--[[
	Rulings
		Q. What if you play Windstorm and your opponent only has a stadium in play? Can you play Windstorm and not discard
		the stadium?
		A. No. You must discard at least 1 card in play, or you can't play the card. (Sep 21, 2006 PUI Rules Team)
		http://compendium.pokegym.net/compendium-lvx.html#195
]]
