--Team Galactic's Invention G-103 Power Spray (Platinum 117/127)
local scard,sid=aux.GetID()
function scard.initial_effect(c)
	aux.AddSetcode(c,SETNAME_TEAM_GALACTICS_INVENTION)
	--prevent effects
	local e1=Effect.CreateEffect(c)
	e1:SetType(EFFECT_TYPE_ACTIVATE)
	e1:SetCode(EVENT_CHAINING)
	e1:SetCondition(scard.con1)
	e1:SetOperation(scard.op1)
	c:RegisterEffect(e1)
end
scard.trainer_item=true
--prevent effects
function scard.cfilter(c)
	return c:IsFaceup() and c:IsPokemonSP()
end
function scard.con1(e,tp,eg,ep,ev,re,r,rp)
	return Duel.IsExistingMatchingCard(scard.cfilter,tp,LOCATION_INPLAY,0,3,nil)
		and Duel.GetTurnPlayer()~=tp and re:IsActiveType(TYPE_POKEMON) and re:IsHasCategory(CATEGORY_POKEPOWER)
end
function scard.op1(e,tp,eg,ep,ev,re,r,rp)
	Duel.NegateEffect(ev)
end
--[[
	Rulings
		* Poké-Powers that end your turn are receiving errata to make it clear that you still end your turn if the
		Poké-Power is canceled, such as with Team Galactic's Invention G-103 Power Spray or by Alakazam's "Power Cancel"
		Poké-Power. (May 1, 2009 Pokemon Organized Play News; May 7, 2009 PUI Rules Team)

		Q. If it is the very first turn of the game and my opponent tries to use a Poke-POWER, can I use "Team Galactic's
		Invention G-103 Power Spray" to block it?
		A. Yes. Only the player going first is restricted from playing Trainers, Supporters, and Stadiums. The opponent is
		not restricted. (Feb 26, 2009 PUI Rules Team)
		http://compendium.pokegym.net/compendium-lvx.html#355
]]
