--Retro Energy (Skyridge 144/144)
--Note: EVENT_BECOME_ATTACHED won't be raised if SetType is EFFECT_TYPE_TRIGGER
local scard,sid=aux.GetID()
function scard.initial_effect(c)
	--energy
	aux.EnableEnergyAttribute(c)
	--provide energy
	aux.EnableProvideEnergy(c,ENERGY_C)
	--remove counter, devolve (discard pokemon)
	local e1=Effect.CreateEffect(c)
	e1:SetDescription(aux.Stringid(sid,0))
	e1:SetType(EFFECT_TYPE_SINGLE+EFFECT_TYPE_CONTINUOUS)
	e1:SetCode(EVENT_CUSTOM+EVENT_BECOME_ATTACHED)
	e1:SetCondition(scard.con1)
	e1:SetOperation(scard.op1)
	c:RegisterEffect(e1)
end
scard.energy_special=true
--remove counter, devolve (discard pokemon)
function scard.con1(e,tp,eg,ep,ev,re,r,rp)
	local c=e:GetHandler()
	local tc=c:GetAttachedTarget()
	return c:IsPlayedFromHand() and tc and tc:IsEvolved()
end
function scard.op1(e,tp,eg,ep,ev,re,r,rp)
	local c=e:GetHandler()
	local tc=c:GetAttachedTarget()
	Duel.Hint(HINT_CARD,0,c:GetOriginalCode())
	local ct=tc:GetCounter(COUNTER_DAMAGE)
	if ct>0 and Duel.SelectYesNo(ep,YESNOMSG_REMOVECOUNTER) then
		if ct>2 then ct=2 end
		local t={}
		for i=1,ct do t[i]=i end
		Duel.Hint(HINT_SELECTMSG,ep,HINTMSG_ANNOUNCECOUNTER)
		local damc=Duel.AnnounceNumber(ep,table.unpack(t))
		tc:RemoveCounter(ep,COUNTER_DAMAGE,damc,REASON_EFFECT)
	end
	Duel.BreakEffect()
	Duel.Devolve(tc,LOCATION_DPILE,nil,REASON_EFFECT)
end
--[[
	Rulings
		Q. If you remove 2 damage counters with Retro Engery do you [have to] devolve since it seems linked to each other.
		A. It is poorly worded isn't it. Since every other of the new special energies has an effect that you MUST do, I
		will say for tournament purposes that you MUST devolve the Pokemon it is attached to (if it is possible). The "you
		may" has to do with how much damage is removed (if any). (May 22, 2003 WotC Chat, Q1634)
		http://compendium.pokegym.net/compendium.html#trainers
]]
