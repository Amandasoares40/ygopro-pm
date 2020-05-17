--Team Aqua Belt (Team Magma vs Team Aqua 76/95)
local scard,sid=aux.GetID()
function scard.initial_effect(c)
	aux.AddSetcode(c,SETNAME_TEAM_AQUA)
	--pokemon tool
	aux.EnablePokemonToolAttribute(c,aux.FilterBoolFunction(Card.IsSetCard,SETNAME_TEAM_AQUA))
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
	return c:IsActive() and c:IsCanEvolve(e,tp,false,true) and c:IsSetCard(SETNAME_TEAM_AQUA)
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
		Q. Can I really double-evolve a Team Aqua Pokémon with two Team Aqua Belts on the same turn?
		A. No, for a couple of reasons. First, Team Aqua Belt is a Pokémon Tool, and you couldn't attach a second Pokémon
		Tool. Next, the evolution happens between turns - you wouldn't have time to attach a second Pokémon Tool after the
		first one resolved. (Team Magma vs Team Aqua Prerelease FAQ, Q5)

		Q. Does "Team Aqua Belt" work if attached on the first turn of the game, before the second player's first turn?
		A. Yes, that will work. (Mar 4, 2004 PUI Rules Team; Jul 22, 2004 PUI Rules Team)

		Q. Say I attach a Team Magma Belt to a benched TM's Aron. During my next turn I evolve it naturally into TM's
		Lairon, and then the following turn into TM's Aggron - all while on the bench. When I eventually move TM's Aggron
		into the active slot, what happens with the Team Magma Belt?
		A. Unfortunately, since you cannot evolve any higher than Aggron, the Team Magma Belt would remain attached until
		the Pokémon leaves play or otherwise devolves to the point that it could evolve again (i.e. Devolution Spray,
		Omastar's "Pull Down" attack, etc.). You would not be able to search, therefore you would not discard the Team
		Magma Belt. (Apr 22, 2004 PUI Rules Team)
		http://compendium.pokegym.net/compendium-ex.html#trainers
]]
