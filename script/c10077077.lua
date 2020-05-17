--Darkrai Prism Star (Ultra Prism 77/156)
local scard,sid=aux.GetID()
function scard.initial_effect(c)
	aux.AddSetcode(c,SETNAME_PRISM_STAR)
	--pokemon
	aux.EnablePokemonAttribute(c)
	--ability (attach)
	local e1=Effect.CreateEffect(c)
	e1:SetDescription(aux.Stringid(sid,0))
	e1:SetCategory(CATEGORY_ABILITY)
	e1:SetType(EFFECT_TYPE_SINGLE+EFFECT_TYPE_TRIGGER_F)
	e1:SetCode(EVENT_PLAY)
	e1:SetCondition(aux.AND(aux.PlayedFromHandCondition(),aux.TurnPlayerCondition(PLAYER_SELF)))
	e1:SetTarget(aux.HintTarget)
	e1:SetOperation(scard.op1)
	c:RegisterEffect(e1)
	--asleep
	local e2=aux.AddPokemonAttack(c,1,nil,scard.op2)
	e2:SetAttackCost(ENERGY_D,ENERGY_D,ENERGY_D,ENERGY_D)
end
scard.pokemon_basic=true
scard.weakness_x2={ENERGY_F}
scard.resistance_20={ENERGY_P}
--ability (attach)
function scard.atfilter(c,tc)
	return c:IsEnergy(ENERGY_D) and c:CheckAttachedTarget(tc)
end
function scard.op1(e,tp,eg,ep,ev,re,r,rp)
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_ATTACHENERGY)
	local g=Duel.SelectMatchingCard(tp,scard.atfilter,tp,LOCATION_HAND,0,0,2,nil,e:GetHandler())
	if g:GetCount()>0 then
		Duel.Attach(e,e:GetHandler(),g)
	end
end
--asleep
function scard.op2(e,tp,eg,ep,ev,re,r,rp)
	local tc=Duel.GetActivePokemon(1-tp)
	Duel.AttackDamage(e,120)
	if not tc:IsInPlay() then return end
	tc:ApplySpecialCondition(tp,SPC_ASLEEP)
	local c=e:GetHandler()
	--increase coin flip
	local e1=Effect.CreateEffect(c)
	e1:SetDescription(DESC_DARKRAI_PRISM_STAR_UPR77)
	e1:SetType(EFFECT_TYPE_FIELD)
	e1:SetCode(EFFECT_ASLEEP_TOSS_EXTRA_COIN)
	e1:SetProperty(EFFECT_FLAG_CANNOT_DISABLE+EFFECT_FLAG_UNCOPYABLE+EFFECT_FLAG_PLAYER_TARGET+EFFECT_FLAG_CLIENT_HINT)
	e1:SetTargetRange(0,1)
	e1:SetValue(1)
	Duel.RegisterEffect(e1,tp)
	--end effect
	local e2=Effect.CreateEffect(c)
	e2:SetType(EFFECT_TYPE_FIELD+EFFECT_TYPE_CONTINUOUS)
	e2:SetCode(EVENT_ADJUST)
	e2:SetProperty(EFFECT_FLAG_CANNOT_DISABLE+EFFECT_FLAG_UNCOPYABLE)
	e2:SetCondition(scard.rstcon)
	e2:SetOperation(scard.rstop)
	e2:SetLabelObject(e1)
	Duel.RegisterEffect(e2,tp)
	tc:RegisterFlagEffect(sid,RESET_EVENT+RESETS_STANDARD,0,1)
end
--end effect
function scard.rstcon(e)
	local tc=Duel.GetActivePokemon(1-e:GetHandlerPlayer())
	return tc and tc:GetFlagEffect(sid)>0 and not tc:IsAsleep()
end
function scard.rstop(e,tp,eg,ep,ev,re,r,rp)
	local tc=Duel.GetActivePokemon(1-tp)
	tc:ResetFlagEffect(sid)
	local e1=e:GetLabelObject()
	e1:Reset()
	e:Reset()
	Duel.HintSelection(Group.FromCards(tc))
	Duel.Hint(HINT_OPSELECTED,1-tp,DESC_END_ATTACK_EFFECT)
end
--[[
	Rulings
		Q. If Darkrai attacks with "Abyssal Sleep", can Pokemon Ranger clear the effect of flipping 2 coins when Asleep?
		A. Asleep, Poisoned, etc. are Special Conditions, regardless of how many coins you need to flip or how much damage
		the poison condition does. Therefore they are not altered by Pokemon Ranger.
		(Nov 10, 2016 TPCi Rules Team; Dec 8, 2016 TPCi Rules Team)
		https://compendium.pokegym.net/compendium-bw.html#492
]]
