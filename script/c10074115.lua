--Guzma (Burning Shadows 115/147)
local scard,sid=aux.GetID()
function scard.initial_effect(c)
	--switch
	aux.PlayTrainerFunction(c,aux.SwitchTarget(PLAYER_OPPO),scard.op1)
end
scard.trainer_supporter=true
--switch
function scard.op1(e,tp,eg,ep,ev,re,r,rp)
	if Duel.SwitchPokemon(tp,1-tp) then
		Duel.SwitchPokemon(tp,tp)
	end
end
--[[
	Rulings
	Q. If I play "Guzma", who chooses which Pokemon to switch for each player?
	A. You make all of those choices. (Burning Shadows FAQ; Aug 3, 2017 TPCi Rules Team)

	Q. Can I play Guzma if my opponent doesn't have any Pokemon on their Bench?
	A. No, you cannot. If the opponent doesn't have a bench there's no way to do the second part of the trainer, and you
	cannot play a Trainer card for no effect. (Aug 31, 2017 TPCi Rules Team)

	Q. If I use Guzma and choose my opponent's Primal Groudon-EX that has the "Omega Barrier" Ancient Trait, do I still
	get to switch my own Pokemon?
	A. Since Omega Barrier prevents the first effect of Guzma, you do not get to switch your Pokemon.
	(Aug 31, 2017 TPCi Rules Team)
	https://compendium.pokegym.net/compendium-bw.html#537
]]
