--Call Energy (Majestic Dawn 92/100)
local scard,sid=aux.GetID()
function scard.initial_effect(c)
	--energy
	aux.EnableEnergyAttribute(c)
	--provide energy
	aux.EnableProvideEnergy(c,ENERGY_C)
	--search (to bench), end turn
	local e1=Effect.CreateEffect(c)
	e1:SetDescription(aux.Stringid(sid,0))
	e1:SetType(EFFECT_TYPE_ATTACHED+EFFECT_TYPE_IGNITION)
	e1:SetProperty(EFFECT_FLAG_CANNOT_DISABLE+EFFECT_FLAG_UNCOPYABLE)
	e1:SetCountLimit(1)
	e1:SetCondition(aux.SelfActiveCondition)
	e1:SetTarget(scard.tg1)
	e1:SetOperation(scard.op1)
	c:RegisterEffect(e1)
end
scard.energy_special=true
--search (to bench), end turn
function scard.tg1(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return Duel.IsNotBenchFull(tp) and Duel.GetFieldGroupCount(tp,LOCATION_DECK,0)>0 end
	Duel.Hint(HINT_OPSELECTED,1-tp,e:GetDescription())
end
function scard.tbfilter(c,e,tp)
	return c:IsBasicPokemon() and c:IsCanBePlayed(e,0,tp,true,false)
end
function scard.op1(e,tp,eg,ep,ev,re,r,rp)
	if Duel.IsBenchFull(tp) then return end
	local ct=Duel.GetFreeBenchCount(tp)
	if ct>2 then ct=2 end
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_TOBENCH)
	local g=Duel.SelectMatchingCard(tp,scard.tbfilter,tp,LOCATION_DECK,0,0,ct,nil,e,tp)
	if g:GetCount()>0 then
		if Duel.PlayPokemon(g,0,tp,tp,true,false,POS_FACEUP_UPSIDE)>0 then
			Duel.EndTurn()
		end
	else
		Duel.ShuffleDeck(tp)
	end
end
--[[
	Rulings
		Q. If my bench if full can I still use "Call Energy" to search my deck?
		A. Yes, you could search your deck, but not put out any Pokemon. (Feb 17, 2011 PUI Rules Team)
		http://compendium.pokegym.net/compendium-lvx.html#250
]]
