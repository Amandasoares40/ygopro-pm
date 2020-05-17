--Technical Machine TS-2 (Legends Awakened 137/146)
local scard,sid=aux.GetID()
function scard.initial_effect(c)
	--technical machine
	aux.EnableTechnicalMachineAttribute(c)
	--gain attack (devolve - return)
	local e1=aux.AddTrainerAttack(c,0,nil,scard.op1)
	e1:SetAttackCost()
	aux.AddAttachedDescription(c,aux.Stringid(sid,1))
end
scard.trainer_item=TYPE_TECHNICAL_MACHINE
--gain attack (devolve - return)
function scard.devfilter(c)
	return c:IsFaceup() and c:IsPokemon() and c:IsEvolved() and c:IsAbleToHand()
end
function scard.op1(e,tp,eg,ep,ev,re,r,rp)
	Duel.AttackDamage(e,0)
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_DEVOLVE)
	local g=Duel.SelectMatchingCard(tp,scard.devfilter,tp,0,LOCATION_INPLAY,1,1,nil)
	if g:GetCount()==0 then return end
	Duel.HintSelection(g)
	Duel.Devolve(g,LOCATION_HAND,nil,REASON_EFFECT)
end
--[[
	Rulings
		Q. Technical Machine TS-2's "Devoluter" attack says to choose an opponent's evolved pokemon (excluding Lv.X). Does
		this mean I remove the Stage 2 but leave the Level X card?
		A. No. It means that you cannot target any Pokemon that has a Level X Pokemon attached to it. You can't use
		Devoluter against it at all. (Aug 28, 2008 PUI Rules Team)
		http://compendium.pokegym.net/compendium-lvx.html#282
]]
