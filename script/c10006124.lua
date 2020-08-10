--Narrow Gym (Gym Heroes 124/132)
local scard,sid=aux.GetID()
function scard.initial_effect(c)
	--return, gain effect
	aux.EnableStadiumAttribute(c,nil,scard.op1)
end
--return, gain effect
function scard.op1(e,tp,eg,ep,ev,re,r,rp)
	local c=e:GetHandler()
	local g1=Duel.GetBenchedPokemon(1-tp)
	local ct1=g1:GetCount()-4
	if g1:GetCount()>4 then
		Duel.Hint(HINT_SELECTMSG,1-tp,HINTMSG_RTOHAND)
		local sg1=g1:Select(1-tp,ct1,ct1,nil)
		Duel.HintSelection(sg1)
		for tc1 in aux.Next(sg1) do
			sg1:Merge(tc1:GetAttachedGroup())
		end
		Duel.SendtoHand(sg1,PLAYER_OWNER,REASON_EFFECT)
	end
	local dis1=Duel.SelectDisableBenchZone(1-tp,4)
	e:SetLabel(dis1)
	local g2=Duel.GetBenchedPokemon(tp)
	local ct2=g2:GetCount()-4
	if g2:GetCount()>4 then
		Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_RTOHAND)
		local sg2=g2:Select(tp,ct2,ct2,nil)
		Duel.HintSelection(sg2)
		for tc2 in aux.Next(sg2) do
			sg2:Merge(tc2:GetAttachedGroup())
		end
		Duel.SendtoHand(sg2,PLAYER_OWNER,REASON_EFFECT)
	end
	local dis2=Duel.SelectDisableBenchZone(tp,4)
	e:SetLabel(dis2)
	--limit bench
	local e1=Effect.CreateEffect(c)
	e1:SetType(EFFECT_TYPE_FIELD)
	e1:SetCode(EFFECT_DISABLE_FIELD)
	e1:SetRange(LOCATION_STADIUM)
	e1:SetOperation(scard.op2(dis1))
	e1:SetReset(RESET_EVENT+RESETS_STANDARD)
	c:RegisterEffect(e1)
	local e2=e1:Clone()
	e2:SetOperation(scard.op2(dis2))
	c:RegisterEffect(e2)
end
function scard.op2(label)
	return	function(e,tp)
				return label
			end
end
