--Level Max (Platinum 107/127)
local scard,sid=aux.GetID()
function scard.initial_effect(c)
	--search (level up)
	aux.PlayTrainerFunction(c,scard.tg1,scard.op1)
end
scard.trainer_item=true
--search (level up)
function scard.cfilter(c,e,tp)
	return c:IsFaceup() and c:IsCanLevelUp(e,tp,true,true)
end
function scard.tg1(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return Duel.GetFreeBenchCount(tp)>-1
		and Duel.IsExistingMatchingCard(scard.cfilter,tp,LOCATION_INPLAY,0,1,nil,e,tp)
		and Duel.GetFieldGroupCount(tp,LOCATION_DECK,0)>0 end
end
function scard.lvfilter(c,e,tp,code)
	return c.levels_up_from==code and c:IsCanBePlayed(e,SUMMON_TYPE_LEVEL_UP,tp,true,false)
end
function scard.op1(e,tp,eg,ep,ev,re,r,rp)
	if Duel.TossCoin(tp,1)==RESULT_TAILS then return end
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_LEVELUP)
	local g1=Duel.SelectMatchingCard(tp,scard.cfilter,tp,LOCATION_INPLAY,0,1,1,nil,e,tp)
	if g1:GetCount()==0 then return end
	Duel.HintSelection(g1)
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_LEVELUPTO)
	local g2=Duel.SelectMatchingCard(tp,scard.lvfilter,tp,LOCATION_DECK,0,0,1,nil,e,tp,g1:GetFirst():GetCode())
	if g2:GetCount()>0 then
		Duel.LevelUp(g2:GetFirst(),g1,tp,true)
	else
		Duel.ShuffleDeck(tp)
	end
end
--[[
	Rulings
	Q. Can I use Level MAX to level up a Benched Pokemon?
	A. Yes, you can. (Feb 12, 2009 PUI Rules Team)

	Q. Can I use Level MAX on a Pokemon that I just put into play or evolved this turn?
	A. Yes, you can. (Feb 12, 2009 PUI Rules Team)

	Q. If you play Level Max to level up one of your benched Pokemon while the Battle Tower stadium is in play, do you get
	to remove 4 damage counters from that Pokemon or not?
	A. No, you cannot remove any damage counters. Level Max has you search your deck for the Lv.X Pokemon, but Battle
	Tower only works when you play the Lv.X card from your hand. (Sep 24, 2009 PUI Rules Team)
	https://compendium.pokegym.net/compendium-lvx.html#351
]]
