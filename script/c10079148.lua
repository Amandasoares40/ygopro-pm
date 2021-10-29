--Tate & Liza (Celestial Storm 148/168)
local scard,sid=aux.GetID()
function scard.initial_effect(c)
	--choose one (to deck, draw or switch)
	aux.PlayTrainerFunction(c,scard.tg1,scard.op1)
end
scard.trainer_supporter=true
--choose one (to deck, draw or switch)
function scard.tg1(e,tp,eg,ep,ev,re,r,rp,chk)
	local b1=Duel.IsExistingMatchingCard(Card.IsAbleToDeck,tp,LOCATION_HAND,0,1,e:GetHandler())
		or Duel.IsPlayerCanDraw(tp,1)
	local b2=Duel.GetActivePokemon(tp) and Duel.GetBenchedPokemon(tp):GetCount()>0
	if chk==0 then return b1 or b2 end
	local option_list={}
	local t={}
	if b1 then
		table.insert(option_list,aux.Stringid(sid,0))
		table.insert(t,1)
	end
	if b2 then
		table.insert(option_list,aux.Stringid(sid,1))
		table.insert(t,2)
	end
	local opt=t[Duel.SelectOption(tp,table.unpack(option_list))+1]
	e:SetLabel(opt)
end
function scard.op1(e,tp,eg,ep,ev,re,r,rp)
	local opt=e:GetLabel()
	if opt==1 then
		local g=Duel.GetFieldGroup(tp,LOCATION_HAND,0)
		Duel.SendtoDeck(g,PLAYER_OWNER,SEQ_DECKSHUFFLE,REASON_EFFECT)
		Duel.ShuffleDeck(tp)
		Duel.BreakEffect()
		Duel.Draw(tp,5,REASON_EFFECT)
	elseif opt==2 then
		Duel.SwitchPokemon(tp,tp)
	end
end
