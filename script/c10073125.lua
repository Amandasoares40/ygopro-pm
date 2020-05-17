--Field Blower (Guardians Rising 125/145)
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
	Note: This card's effect is identical to that of "Windstorm".
]]
