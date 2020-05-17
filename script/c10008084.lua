--Ecogym (Neo Genesis 84/111)
local scard,sid=aux.GetID()
function scard.initial_effect(c)
	--stadium
	aux.EnableStadiumAttribute(c)
	--to hand
	local e0=Effect.CreateEffect(c)
	e0:SetType(EFFECT_TYPE_FIELD+EFFECT_TYPE_CONTINUOUS)
	e0:SetCode(EVENT_ADJUST)
	e0:SetProperty(EFFECT_FLAG_CANNOT_DISABLE+EFFECT_FLAG_UNCOPYABLE)
	e0:SetRange(LOCATION_STADIUM)
	e0:SetOperation(scard.regop)
	c:RegisterEffect(e0)
	local e1=Effect.CreateEffect(c)
	e1:SetDescription(aux.Stringid(sid,0))
	e1:SetType(EFFECT_TYPE_FIELD+EFFECT_TYPE_TRIGGER_F)
	e1:SetCode(EVENT_TO_DPILE)
	e1:SetRange(LOCATION_STADIUM)
	e1:SetCondition(scard.con1)
	e1:SetOperation(scard.op1)
	c:RegisterEffect(e1)
	local g=Group.CreateGroup()
	g:KeepAlive()
	e1:SetLabelObject(g)
end
--to hand
function scard.cfilter1(c)
	return c:IsEnergy() and c:GetEnergyType()~=ENERGY_C and c:GetFlagEffect(sid)==0
end
function scard.regop(e,tp,eg,ep,ev,re,r,rp)
	local g=Duel.GetAttachedGroup(tp,1,1):Filter(scard.cfilter1,nil)
	for tc in aux.Next(g) do
		tc:RegisterFlagEffect(sid,RESET_EVENT+RESET_ATTACH,0,1)
	end
end
function scard.cfilter2(c,tp)
	return c:GetFlagEffect(sid)>0 and c:IsReason(REASON_DISCARD) and c:IsControler(tp)
end
function scard.con1(e,tp,eg,ep,ev,re,r,rp)
	local g=e:GetLabelObject()
	g:Merge(eg:Filter(scard.cfilter2,nil,1-rp))
	return g:GetCount()>0 and re and rp
end
function scard.op1(e,tp,eg,ep,ev,re,r,rp)
	local g=e:GetLabelObject()
	if e:GetHandler():IsRelateToEffect(e) then
		Duel.SendtoHand(g,PLAYER_OWNER,REASON_EFFECT)
		for tc in aux.Next(g) do
			Duel.ConfirmCards(1-tc:GetControler(),tc)
		end
	end
	g:Clear()
end
--[[
	Rulings
		Q. On Ecogym, would an attack of yours that discarded an energy still be discarded?
		A. Yes, it would. [Ed. Note: The energy is only returned to your hand when it's discarded by the opposing player,
		not by yourself] (Dec 21, 2000 WotC Chat, Q132)

		Q. Does DCE get put back in your hand with Eco Gym or not? Eco Gym just says any non [*]
		A. No, any card that provides colorless energy is considered a colorless energy card even if it provides 2.
		(Dec 21, 2000 WotC Chat, Q77)

		Q. If the EcoGym Trainer is in play, how many non-colorless energy cards can be returned to my hand if my opponent
		used an SER on one of my Pokémon (2 or 1)?
		A. Yes, both. (Dec 21, 2000 WotC Chat, Q54)

		Q. If EcoGym is in play, can a Rainbow Energy card be returned to my hand?
		A. Yes it can. (Dec 21, 2000 WotC Chat, Q66)

		Q. If Ecogym is in play, could an energy that is normally considered as colorless (DCE, Full Heal Energy, Potion
		Energy, etc.) be returned to your hand if it were attached to an Active Ditto?
		A. Only if an affect from your opponent causes you to discard it of course, but yes. (Jan 4, 2001 WotC Chat, Q8)

		Q. With Ecogym in play,would a Colorless Energy on Charizard that was Energy Burned to fire be returned to your
		hand if you attacked a Koga's Muk (Pokémon Power: Energy Drain) and he flipped a heads for the Pokémon Power?
		A. Yes it would. (Jan 4, 2001 WotC Chat, Q39)

		Q. If Ecogym is in play, how many non-colorless Energy cards can be returned to your hand at the same time and/or
		during your turn?
		A. As many as get put in the discard pile by your opponent. (Jan 4, 2001 WotC Chat, Q49 & Q51)

		Q. When Ecogym is in play and I knock out another Pokémon, will its energy cards go back to the proper owner?
		A. Nope, the attack did not discard the energy cards, it Knocked out the Pokémon and then the energy cards were
		discarded. Not the same thing. (Jan 11, 2001 WotC Chat, Q30)

		Q. Did you solve my little Hyper Beam KOing a Pokemon with Ecogym in play problem?
		A. Sure its easy. The damage is applied first, if that is enough to Knock out the Defending Pokemon you are done,
		it is Knocked Out BEFORE any energy is removed due to the rest of the attack's effects. So, there is no issue in
		that case. (Aug 9, 2001 WotC Chat, Q246)

		Q. Can you save a Buzzaped Electrode with Ecogym?
		A. Yes, but it is no longer an energy card when it leaves play and goes back to your hand. It is a plain old
		electrode again. (Jan 18, 2001 WotC Chat, Q17b & Q49b)

		Q. If Ditto has converted a Colorless Energy card to a Basic type, will Ecogym return that card to your hand if
		the conditions of Ecogym are met?
		A. Yes you could do that. (Jan 18, 2001 WotC Chat, Q43b)
		https://compendium.pokegym.net/compendium.html#trainers
]]
