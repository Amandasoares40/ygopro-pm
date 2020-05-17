--Star Piece (Skyridge 139/144)
local scard,sid=aux.GetID()
function scard.initial_effect(c)
	--pokemon tool
	aux.EnablePokemonToolAttribute(c)
	--search (evolve)
	local e1=Effect.CreateEffect(c)
	e1:SetDescription(aux.Stringid(sid,0))
	e1:SetType(EFFECT_TYPE_ATTACHED+EFFECT_TYPE_FIELD+EFFECT_TYPE_TRIGGER_F)
	e1:SetCode(EVENT_PHASE+PHASE_END)
	e1:SetProperty(EFFECT_FLAG_CANNOT_DISABLE+EFFECT_FLAG_UNCOPYABLE)
	e1:SetLabelObject(c)
	e1:SetCondition(scard.con1)
	e1:SetTarget(aux.HintTarget)
	e1:SetOperation(scard.op1)
	c:RegisterEffect(e1)
	aux.AddAttachedDescription(c,DESC_EVOLVE_SELF_EOT,scard.con1)
end
scard.trainer_item=TYPE_POKEMON_TOOL
--search (evolve)
function scard.con1(e,tp,eg,ep,ev,re,r,rp)
	local c=e:GetHandler()
	return c:IsBenched() and c:GetCounter(COUNTER_DAMAGE)>=2 and c:IsCanEvolve(e,tp,false,false)
end
function scard.evofilter(c,e,tp,code)
	return c.evolves_from==code and c:IsCanBePlayed(e,SUMMON_TYPE_EVOLVE,tp,true,false)
end
function scard.op1(e,tp,eg,ep,ev,re,r,rp)
	local c=e:GetHandler()
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_EVOLVETO)
	local g=Duel.SelectMatchingCard(tp,scard.evofilter,tp,LOCATION_DECK,0,0,1,nil,e,tp,c:GetCode())
	if g:GetCount()>0 then
		Duel.Evolve(g:GetFirst(),c,tp)
	else
		Duel.ShuffleDeck(tp)
	end
	Duel.BreakEffect()
	Duel.SendtoDPile(e:GetLabelObject(),REASON_EFFECT+REASON_DISCARD)
end
--[[
	Rulings
		Q. If there are 2 damage counters and Star Piece on a baby Pokémon, can you use it to search for its evolution?
		A. No, you cannot. Star Piece looks for an Evolution card, where Babies evolve into Basic Pokémon (and only
		treated as an Evolved Pokémon, when it is actually in play). (Nov 6, 2003 PUI Rules Team)

		Q. What happens if Star Piece is used to search your deck for an evolution Pokémon, but there aren't any left in
		there? Does Star Piece remain attached or does it get discarded?
		A. It gets discarded because you used it to perform a search; it doesn't matter whether you found the card or not.
		(Jul 15, 2004 PUI Rules Team)
		http://compendium.pokegym.net/compendium-ex.html#trainers
]]
