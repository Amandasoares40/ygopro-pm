--Stunfisk (BREAKthrough 56/162)
local scard,sid=aux.GetID()
function scard.initial_effect(c)
	--pokemon
	aux.EnablePokemonAttribute(c)
	--damage
	local e1=aux.AddPokemonAttack(c,0,nil,scard.op1)
	e1:SetAttackCost(ENERGY_L,ENERGY_C)
	--discard energy
	local e2=aux.AddPokemonAttack(c,1,nil,scard.op2)
	e2:SetAttackCost(ENERGY_L,ENERGY_L,ENERGY_C)
	if not scard.global_check then
		scard.global_check=true
		--check for knocked out pokemon
		local ge1=Effect.CreateEffect(c)
		ge1:SetType(EFFECT_TYPE_FIELD+EFFECT_TYPE_CONTINUOUS)
		ge1:SetCode(EVENT_KNOCKED_OUT)
		ge1:SetOperation(scard.regop1)
		Duel.RegisterEffect(ge1,0)
	end
end
scard.pokemon_basic=true
scard.height=2.04
scard.weakness_x2={ENERGY_F}
scard.resistance_20={ENERGY_M}
--check for knocked out pokemon
function scard.regop1(e,tp,eg,ep,ev,re,r,rp)
	local p1=false
	local p2=false
	for ec in aux.Next(eg) do
		if ec:IsPokemon() and Duel.GetTurnPlayer()==1
			and rp==1-tp and bit.band(ec:GetReason(),REASON_ATTACK+REASON_DAMAGE)~=0 then
			if ec:GetPreviousControler()==0 then p1=true else p2=true end
		end
	end
	if p1 then Duel.RegisterFlagEffect(0,sid,RESET_PHASE+EVENT_PHASE_START+PHASE_DRAW,0,2) end
	if p2 then Duel.RegisterFlagEffect(1,sid,RESET_PHASE+EVENT_PHASE_START+PHASE_DRAW,0,2) end
end
--damage
function scard.op1(e,tp,eg,ep,ev,re,r,rp)
	local dam=20
	if Duel.GetFlagEffect(tp,sid)>0 then dam=dam+80 end
	Duel.AttackDamage(e,dam)
end
--discard energy
function scard.op2(e,tp,eg,ep,ev,re,r,rp)
	Duel.AttackDamage(e,80)
	Duel.DiscardAttached(tp,e:GetHandler(),Card.IsEnergy,1,1,REASON_ATTACK)
end
