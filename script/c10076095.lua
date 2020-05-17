--Gladion (Crimson Invasion 95/111)
local scard,sid=aux.GetID()
function scard.initial_effect(c)
	--confirm prize (to hand, to prize)
	aux.PlayTrainerFunction(c,scard.tg1,scard.op1)
end
scard.trainer_supporter=true
--confirm prize (to hand, to prize)
function scard.tg1(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return Duel.GetPrizeCount(tp)>0 and e:IsHasType(EFFECT_TYPE_ACTIVATE) end
end
function scard.op1(e,tp,eg,ep,ev,re,r,rp)
	local g=Duel.GetPrize(tp)
	if g:GetCount()==0 or not e:IsHasType(EFFECT_TYPE_ACTIVATE) then return end
	Duel.ConfirmCards(tp,g)
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_ATOHAND)
	local sg=g:FilterSelect(tp,Card.IsAbleToHand,1,1,nil)
	if sg:GetCount()>0 then
		Duel.SendtoHand(sg,PLAYER_OWNER,REASON_EFFECT)
		Duel.BreakEffect()
		e:GetHandler():CancelToDPile()
		Duel.SendtoPrize(e:GetHandler(),REASON_EFFECT)
	end
	Duel.ShufflePrize(tp)
end
--[[
	Rulings
		Q. If I use Gladion can I choose Greedy Dice from my prizes and play it right then?
		A. Greedy Dice can be played only if it's taken as a face-down Prize card. Gladion doesn’t count as "taking a
		Prize card." (Mar 1, 2018 TPCi Rules Team)

		Q. If I use Gladion and choose to put Jirachi {*} into my hand, can I use Jirachi {*}'s "Wish Upon a Star"
		Ability?
		A. Sorry, but Wish Upon a Star only triggers when you are taking it as a face-down prize card, not when you are
		trading it with another card. (Aug 2, 2018 TPCi Rules Team)
		https://compendium.pokegym.net/compendium-bw.html#570
]]
