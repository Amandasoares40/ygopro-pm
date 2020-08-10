--Double Gust (Neo Genesis 100/111)
local scard,sid=aux.GetID()
function scard.initial_effect(c)
	--switch
	aux.PlayTrainerFunction(c,aux.SwitchTarget(PLAYER_ALL),scard.op1)
end
scard.trainer_item=true
--switch
function scard.op1(e,tp,eg,ep,ev,re,r,rp)
	Duel.SwitchPokemon(1-tp,tp)
	Duel.BreakEffect()
	Duel.SwitchPokemon(tp,1-tp)
end
--[[
	Rulings
	Q. Can I use Double Gust if I don't have any Pokemon on my bench? The first sentence reads, "If you have any Benched
	Pokemon..."; so what if I don't? And does it matter if the opponent has any on their bench or not?
	A. Yes, you can. No, it does not. (Oct 4, 2001 WotC Chat, Q3)
	https://compendium.pokegym.net/compendium.html#trainers
]]
