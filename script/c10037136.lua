--Technical Machine TS-1 (Legends Awakened 136/146)
local scard,sid=aux.GetID()
function scard.initial_effect(c)
	--technical machine
	aux.EnableTechnicalMachineAttribute(c)
	--gain attack (search - evolve)
	local e1=aux.AddTrainerAttack(c,0,nil,scard.op1)
	e1:SetAttackCost()
	aux.AddAttachedDescription(c,aux.Stringid(sid,1))
end
scard.trainer_item=TYPE_TECHNICAL_MACHINE
--gain attack (search - evolve)
function scard.cfilter(c,e,tp)
	return c:IsFaceup() and c:IsPokemon() and c:IsCanEvolve(e,tp,false,false)
end
function scard.evofilter(c,e,tp,code)
	return c.evolves_from==code and c:IsCanBePlayed(e,SUMMON_TYPE_EVOLVE,tp,true,false)
end
function scard.op1(e,tp,eg,ep,ev,re,r,rp)
	Duel.AttackDamage(e,0)
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_EVOLVE)
	local g1=Duel.SelectMatchingCard(tp,scard.cfilter,tp,LOCATION_INPLAY,0,1,1,nil,e,tp)
	if g1:GetCount()==0 then return end
	Duel.HintSelection(g1)
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_EVOLVETO)
	local g2=Duel.SelectMatchingCard(tp,scard.evofilter,tp,LOCATION_DECK,0,0,1,nil,e,tp,g1:GetFirst():GetCode())
	if g2:GetCount()>0 then
		Duel.Evolve(g2:GetFirst(),g1,tp)
	else
		Duel.ShuffleDeck(tp)
	end
end
--[[
	Rulings
	Q. Can I use Technical Machine TS-1's "Evoluter" attack to search through my deck if I don't have any Pokemon in play
	that can evolve any further?
	A. Yes you could use Evoluter, because contents of a deck search cannot be deduced, even on the basis of public
	knowledge. As long as you meet the requirements to use an attack, you follow what it does (in this case, searching
	your deck). (Dec 4, 2008 PUI Rules Team)
	https://compendium.pokegym.net/compendium-lvx.html#322
]]
