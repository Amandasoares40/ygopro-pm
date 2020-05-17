--Mixed Herbs (Lost Thunder 184/214)
local scard,sid=aux.GetID()
function scard.initial_effect(c)
	--play multiple copies (remove special condition or heal, remove all special conditions)
	aux.PlayTrainerFunction(c,scard.tg1,scard.op1)
end
scard.trainer_item=true
--play multiple copies (remove special condition or heal, remove all special conditions)
function scard.tg1(e,tp,eg,ep,ev,re,r,rp,chk)
	local c=e:GetHandler()
	local tc=Duel.GetActivePokemon(tp)
	local b1=tc and tc:IsAffectedBySpecialCondition()
	local b2=tc and (tc:IsCanBeHealed() or tc:IsAffectedBySpecialCondition())
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
	local tc1=Duel.GetActivePokemon(tp)
	local opt=e:GetLabel()
	if opt==1 then
		Duel.SelectRemoveSpecialCondition(tp,tc1)
	elseif opt==2 then
		Duel.HealDamage(tp,tc1,90,REASON_EFFECT)
		tc1:RemoveSpecialCondition(tp,SPC_ALL)
		local tc2=Duel.GetFirstMatchingCard(Card.IsCode,tp,LOCATION_HAND,0,nil,e:GetHandler():GetOriginalCode())
		Duel.SendtoDPile(tc2,REASON_RULE+REASON_DISCARD)
	end
end
