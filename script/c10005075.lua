--Digger (Team Rocket 75/82)
local scard,sid=aux.GetID()
function scard.initial_effect(c)
	--damage
	aux.PlayTrainerFunction(c,scard.tg1,scard.op1)
end
scard.trainer_rockets_secret_machine=true
--damage
function scard.tg1(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return Duel.GetActivePokemon(tp) or Duel.GetActivePokemon(1-tp) end
end
function scard.op1(e,tp,eg,ep,ev,re,r,rp)
	local p=1-tp
	repeat
		p=1-p
	until (Duel.TossCoin(p,1)==RESULT_TAILS)
	local c=(p==tp) and Duel.GetActivePokemon(tp) or Duel.GetActivePokemon(1-tp)
	Duel.EffectDamage(e,10,e:GetHandler(),c)
end
