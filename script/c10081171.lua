--Custom Catcher (Lost Thunder 171/214)
local scard,sid=aux.GetID()
function scard.initial_effect(c)
	--play multiple copies (draw or switch)
	aux.PlayTrainerFunction(c,scard.tg1,scard.op1)
end
scard.trainer_item=true
--play multiple copies (draw or switch)
function scard.tg1(e,tp,eg,ep,ev,re,r,rp,chk)
	local c=e:GetHandler()
	local ct=3-Duel.GetMatchingGroupCount(nil,tp,LOCATION_HAND,0,c)
	local b1=ct>0 and Duel.IsPlayerCanDraw(tp,1)
	local b2=Duel.GetActivePokemon(1-tp) and Duel.GetBenchedPokemon(1-tp):GetCount()>0
		and Duel.IsExistingMatchingCard(Card.IsCode,tp,LOCATION_HAND,0,1,c,c:GetOriginalCode())
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
		local ct=3-Duel.GetFieldGroupCount(tp,LOCATION_HAND,0)
		if ct>0 then
			Duel.Draw(tp,ct,REASON_EFFECT)
		end
	elseif opt==2 then
		Duel.SwitchPokemon(tp,1-tp)
		local tc=Duel.GetFirstMatchingCard(Card.IsCode,tp,LOCATION_HAND,0,nil,e:GetHandler():GetOriginalCode())
		Duel.SendtoDPile(tc,REASON_RULE+REASON_DISCARD)
	end
end
