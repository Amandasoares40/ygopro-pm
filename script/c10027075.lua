--Giant Stump (Legend Maker 75/92)
local scard,sid=aux.GetID()
function scard.initial_effect(c)
	--discard pokemon, gain effect
	aux.EnableStadiumAttribute(c,nil,scard.op1)
end
--discard pokemon, gain effect
function scard.op1(e,tp,eg,ep,ev,re,r,rp)
	scard.discard(tp)
	local dis1=Duel.SelectDisableBenchZone(tp,3)
	e:SetLabel(dis1)
	scard.discard(1-tp)
	local dis2=Duel.SelectDisableBenchZone(1-tp,3)
	e:SetLabel(dis2)
	local c=e:GetHandler()
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
function scard.discard(tp)
	local g=Duel.GetBenchedPokemon(tp)
	local ct=g:GetCount()-3
	if g:GetCount()>3 then
		Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_DISCARD)
		local sg=g:Select(tp,ct,ct,nil)
		Duel.HintSelection(sg)
		Duel.SendtoDPile(sg,REASON_EFFECT+REASON_DISCARD)
	end
end
--[[
	Rulings
	Q. When you discard benched Pokémon as Giant Stump comes into play, does the opponent get to take prizes for my
	discarded Pokémon?
	A. No, the Pokémon get discarded but they are not KO'd, so the opponent does not get to take any prizes for them.
	(Feb 16, 2006 PUI Rules Team)

	Q. My opponent has 5 benched Pokémon with two of them being Rocket's Sneasel-EX with 100hp of damage on each of them
	and 10HP remaining due to Rocket's Hideout stadium being in play. If I play Giant Stump, are they knocked out because
	they no longer have the +20 bonus or can my opponent choose to discard them before getting KO'd.
	A. When you play Giant Stump, resolve all effects in play before removing Knocked Out Pokémon. So the Rocket's
	Sneasel-EX's could be discarded before being Knocked Out. (Jul 13, 2006 PUI Rules Team) Save the Sneasel!(tm)
	https://compendium.pokegym.net/compendium-ex.html#trainers
]]
