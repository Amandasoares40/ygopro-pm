--Kahili (Lost Thunder 179/214)
local scard,sid=aux.GetID()
function scard.initial_effect(c)
	--draw, return
	aux.PlayTrainerFunction(c,aux.DrawTarget(PLAYER_SELF),scard.op1)
end
scard.trainer_supporter=true
--draw, return
function scard.op1(e,tp,eg,ep,ev,re,r,rp)
	Duel.Draw(tp,2,REASON_EFFECT)
	Duel.BreakEffect()
	local c=e:GetHandler()
	if c:IsRelateToEffect(e) and e:IsHasType(EFFECT_TYPE_ACTIVATE) and Duel.TossCoin(tp,1)==RESULT_HEADS then
		c:CancelToDPile()
		Duel.SendtoHand(c,PLAYER_OWNER,REASON_EFFECT)
	end
end
--[[
	Rulings
	Q. Can I play Kahili if there's only one card left in my deck?
	A. If you can draw at least 1 card from your deck, you can use Kahili and do the coin flip part. But if you can’t draw
	any cards, you can’t use it. (Lost Thunder FAQ; Nov 1, 2018 TPCi Rules Team)
	https://compendium.pokegym.net/compendium-bw.html#625
]]
