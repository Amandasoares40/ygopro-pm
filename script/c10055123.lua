--Hypnotoxic Laser (Plasma Storm 123/135)
local scard,sid=aux.GetID()
function scard.initial_effect(c)
	aux.AddSetcode(c,SETNAME_TEAM_PLASMA)
	--poisoned, asleep
	aux.PlayTrainerFunction(c,scard.tg1,scard.op1)
end
scard.trainer_item=true
--poisoned, asleep
function scard.tg1(e,tp,eg,ep,ev,re,r,rp,chk)
	local tc=Duel.GetActivePokemon(1-tp)
	if chk==0 then return tc and tc:IsCanBePoisoned() and tc:IsCanBeAsleep() end
end
function scard.op1(e,tp,eg,ep,ev,re,r,rp)
	local tc=Duel.GetActivePokemon(1-tp)
	tc:ApplySpecialCondition(tp,SPC_POISONED)
	if Duel.TossCoin(tp,1)==RESULT_HEADS then
		tc:ApplySpecialCondition(tp,SPC_ASLEEP)
	end
end
--[[
	Rulings
	Q. If the Defending Pokemon is already Asleep & Poisoned, can you use Hypnotoxic Laser or not?
	A. No, you cannot. (Feb 21, 2013 TPCi Rules Team)

	Q. If the Defending Pokemon is already Asleep & Poisoned with a condition that places more than one damage counter in
	between turns, can you use Hypnotoxic Laser to change the number of counters to be placed?
	A. Yes, the new single-counter Poison condition replaces the multi-counter Poison condition.
	(Feb 21, 2013 TPCi Rules Team)
	https://compendium.pokegym.net/compendium-bw.html#291
]]
