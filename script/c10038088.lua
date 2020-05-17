--Poke Blower + (Stormfront 88/100)
local scard,sid=aux.GetID()
function scard.initial_effect(c)
	--play multiple copies (add counter or switch)
	aux.PlayTrainerFunction(c,scard.tg1,scard.op1)
end
scard.trainer_item=true
--play multiple copies (add counter or switch)
function scard.ctfilter(c)
	return c:IsFaceup() and c:IsPokemon()
end
function scard.tg1(e,tp,eg,ep,ev,re,r,rp,chk)
	local c=e:GetHandler()
	local b1=Duel.IsExistingMatchingCard(scard.ctfilter,tp,0,LOCATION_INPLAY,1,nil)
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
		if Duel.TossCoin(tp,1)==RESULT_TAILS then return end
		Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_ADDCOUNTER)
		local g=Duel.SelectMatchingCard(tp,scard.ctfilter,tp,0,LOCATION_INPLAY,1,1,nil)
		if g:GetCount()==0 then return end
		Duel.HintSelection(g)
		g:GetFirst():AddCounter(tp,COUNTER_DAMAGE,1,REASON_EFFECT)
	elseif opt==2 then
		Duel.SwitchPokemon(tp,1-tp)
		local tc=Duel.GetFirstMatchingCard(Card.IsCode,tp,LOCATION_HAND,0,nil,e:GetHandler():GetOriginalCode())
		Duel.SendtoDPile(tc,REASON_RULE+REASON_DISCARD)
	end
end
