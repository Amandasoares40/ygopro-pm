--Balloon Berry (Neo Revelation 60/64)
local scard,sid=aux.GetID()
function scard.initial_effect(c)
	--pokemon tool
	aux.EnablePokemonToolAttribute(c)
	--0 retreat cost
	aux.AddSingleAttachedEffect(c,EFFECT_CHANGE_RETREAT_COST,0)
	aux.AddAttachedDescription(c,DESC_RETREAT_COST_CHANGED)
	--discard self
	local e1=Effect.CreateEffect(c)
	e1:SetDescription(aux.Stringid(sid,0))
	e1:SetType(EFFECT_TYPE_ATTACHED+EFFECT_TYPE_CONTINUOUS)
	e1:SetCode(EVENT_CUSTOM+EVENT_RETREAT)
	e1:SetProperty(EFFECT_FLAG_CANNOT_DISABLE+EFFECT_FLAG_UNCOPYABLE)
	e1:SetOperation(scard.op1)
	c:RegisterEffect(e1)
end
scard.trainer_item=TYPE_POKEMON_TOOL
--discard self
function scard.op1(e,tp,eg,ep,ev,re,r,rp)
	local g=e:GetHandler():GetAttachedGroup():Filter(Card.IsCode,nil,sid)
	Duel.SendtoDPile(g,REASON_EFFECT+REASON_DISCARD)
end
--[[
	Rulings
		* In the Japanese card, there is a text saying "If Balloon Berry is attached to one of your Pokémon., the
		Pokémon.'s retreat cost is 0". So, you should play Balloon Berry as if it negates the Pokémon.'s retreat cost
		while attached to that Pokémon., not just when it actually attempts to retreat. For example, Muk-EX's "Slimy
		Water" attack damage will be reduced to only 40 against a Pokémon. with Balloon Berry attached to it.
		(Nov 13, 2003 PUI Rules Team)
		http://compendium.pokegym.net/compendium-bw.html#46
]]
