--Moo-Moo Milk (HeartGold & SoulSilver 94/123)
local scard,sid=aux.GetID()
function scard.initial_effect(c)
	--heal
	aux.PlayTrainerFunction(c,aux.CheckCardFunction(scard.healfilter,LOCATION_INPLAY,0),scard.op1)
end
scard.trainer_item=true
--heal
function scard.healfilter(c)
	return c:IsFaceup() and c:IsPokemon() and c:IsCanBeHealed()
end
function scard.op1(e,tp,eg,ep,ev,re,r,rp)
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_HEAL)
	local g=Duel.SelectMatchingCard(tp,scard.healfilter,tp,LOCATION_INPLAY,0,1,1,nil)
	if g:GetCount()==0 then return end
	Duel.HintSelection(g)
	local c1,c2=Duel.TossCoin(tp,2)
	local ct=c1+c2
	if ct~=RESULT_TAILS then
		Duel.HealDamage(tp,g,30*ct,REASON_EFFECT)
	end
end
--[[
	Rulings
		Due to the fact that this card's HeartGold & SoulSilver print's name and effect slightly differ from the original,
		it was ruled that "Moo-Moo Milk" and "Moomoo Milk" were not the same card in the English-language printings. A
		similar situation exists surrounding Energy Charge and Power Charge.
		https://bulbapedia.bulbagarden.net/wiki/Moo-Moo_Milk_(Neo_Genesis_101)
]]
