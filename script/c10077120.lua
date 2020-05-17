--Cyrus Prism Star (Ultra Prism 120/156)
local scard,sid=aux.GetID()
function scard.initial_effect(c)
	aux.AddSetcode(c,SETNAME_PRISM_STAR)
	--to deck
	aux.PlayTrainerFunction(c,scard.tg1,scard.op1,scard.con1)
end
scard.trainer_supporter=true
--to deck
function scard.con1(e,tp,eg,ep,ev,re,r,rp)
	local tc=Duel.GetActivePokemon(tp)
	return tc and tc:IsEnergyType(ENERGY_W+ENERGY_M)
end
function scard.tg1(e,tp,eg,ep,ev,re,r,rp,chk)
	local g=Duel.GetBenchedPokemon(1-tp)
	if chk==0 then return g:GetCount()>=3 and g:IsExists(Card.IsAbleToDeck,1,nil) end
end
function scard.op1(e,tp,eg,ep,ev,re,r,rp)
	local g=Duel.GetBenchedPokemon(1-tp)
	if g:GetCount()==0 then return end
	Duel.Hint(HINT_SELECTMSG,1-tp,HINTMSG_NTODECK)
	local sg=g:Select(1-tp,2,2,nil)
	Duel.HintSelection(sg)
	g:Sub(sg)
	for tc in aux.Next(g) do
		g:Merge(tc:GetAttachedGroup())
	end
	Duel.SendtoDeck(g,PLAYER_OWNER,SEQ_DECK_SHUFFLE,REASON_EFFECT)
end
--[[
	Rulings
		Q. When using Cyrus{*} does my opponent shuffle in their Active Pokemon too?
		A. No, your opponent only shuffles in their Benched Pokemon except for the 2 that were chosen.
		(Ultra Prism FAQ; Feb 1, 2018 TPCi Rules Team)

		Q. I have 3 Pokemon on my Bench, and 1 of them has the "Omega Barrier" Ancient Trait. My opponent plays Cyrus {*},
		and I choose to keep the 2 Pokemon that don't have "Omega Barrier". Does the Pokemon with "Omega Barrier" get
		shuffled into my deck?
		A. Yes, it does. The effect of Cyrus {*} is on the player, not on the Pokemon with Omega Barrier.
		(May 31, 2018 TPCi Rules Team)
		https://compendium.pokegym.net/compendium-bw.html#555
]]
