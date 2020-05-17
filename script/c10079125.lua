--Beast Ball (Celestial Storm 125/168)
local scard,sid=aux.GetID()
function scard.initial_effect(c)
	aux.AddSetcode(c,SETNAME_BALL)
	--confirm prize (to hand, to prize)
	aux.PlayTrainerFunction(c,scard.tg1,scard.op1)
end
scard.trainer_item=true
--confirm prize (to hand, to prize)
function scard.tg1(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return Duel.GetPrizeCount(tp)>0 end
end
function scard.thfilter(c)
	return c:IsUltraBeast() and c:IsAbleToHand()
end
function scard.op1(e,tp,eg,ep,ev,re,r,rp)
	local g=Duel.GetPrize(tp)
	if g:GetCount()==0 then return end
	Duel.ConfirmCards(tp,g)
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_ATOHAND)
	local sg=g:FilterSelect(tp,scard.thfilter,0,1,nil)
	if sg:GetCount()>0 then
		Duel.SendtoHand(sg,PLAYER_OWNER,REASON_EFFECT)
		Duel.ConfirmCards(1-tp,sg)
		e:GetHandler():CancelToDPile()
		Duel.SendtoPrize(e:GetHandler(),REASON_EFFECT)
	end
	Duel.ShufflePrize(tp)
end
--[[
	Rulings
		Q. Does using Beast Ball count as "taking a prize" for the purpose of calculating damage for Stakataka GX's
		"Assembly GX" attack?
		A. No, it does not. You are switching cards, not taking a prize. (Aug 16, 2018 TPCi Rules Team)
		https://compendium.pokegym.net/compendium-bw.html#611
]]
