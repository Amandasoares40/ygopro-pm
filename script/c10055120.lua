--Escape Rope (Plasma Storm 120/135)
local scard,sid=aux.GetID()
function scard.initial_effect(c)
	--switch
	aux.PlayTrainerFunction(c,aux.SwitchTarget(PLAYER_ALL),scard.op1)
end
scard.trainer_item=true
--switch
function scard.op1(e,tp,eg,ep,ev,re,r,rp)
	Duel.SwitchPokemon(1-tp,1-tp)
	Duel.SwitchPokemon(tp,tp)
end
--[[
	Rulings
		Q. If I use Escape Rope but my opponent's Active Pokemon has the "Omega Barrier" Ancient Trait does he or she have
		to switch it? Or if they have a Pokemon with "Omega Barrier" on the bench can he or she choose that and not switch
		it to Active?
		A. If your opponent has an Active Pokemon with "Omega Barrier", then Escape Rope's effect will be blocked. If a
		Pokemon with "Omega Barrier" is on the bench, choosing that Pokemon will not stop the effect as the Active was the
		target of Escape Rope. (Primal Clash FAQ; Feb 5, 2015 TPCi Rules Team)
		https://compendium.pokegym.net/compendium-bw.html#390
	Note: This card's effect is identical to that of "Warp Point".
]]
