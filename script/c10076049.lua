--Nihilego-GX (Crimson Invasion 49/111)
local scard,sid=aux.GetID()
function scard.initial_effect(c)
	--pokemon
	aux.EnablePokemonAttribute(c)
	--ability (confused, poisoned)
	local e1=Effect.CreateEffect(c)
	e1:SetDescription(aux.Stringid(sid,0))
	e1:SetCategory(CATEGORY_ABILITY)
	e1:SetType(EFFECT_TYPE_SINGLE+EFFECT_TYPE_TRIGGER_F)
	e1:SetCode(EVENT_PLAY)
	e1:SetCondition(aux.AND(aux.PlayedFromHandCondition(),aux.TurnPlayerCondition(PLAYER_SELF)))
	e1:SetTarget(aux.HintTarget)
	e1:SetOperation(scard.op1)
	c:RegisterEffect(e1)
	--get effect
	local e2=aux.AddPokemonAttack(c,1,nil,scard.op2)
	e2:SetAttackCost(ENERGY_P,ENERGY_P,ENERGY_P)
	--gx attack (to prize)
	local e3=aux.AddPokemonAttack(c,2,CATEGORY_GX_ATTACK,scard.op3)
	e3:SetAttackCost(ENERGY_P,ENERGY_P,ENERGY_P)
end
scard.pokemon_basic=true
scard.pokemon_gx=true
scard.pokemon_ultra_beast=true
scard.weakness_x2={ENERGY_P}
--ability (confused, poisoned)
function scard.op1(e,tp,eg,ep,ev,re,r,rp)
	if not Duel.GetActivePokemon():IsExists(Card.IsImmuneToSpecialCondition,1,nil)
		and Duel.SelectYesNo(tp,YESNOMSG_CONFUSEDPOISONED) then
		Duel.GetActivePokemon(tp):ApplySpecialCondition(tp,SPC_CONFUSED+SPC_POISONED)
		Duel.GetActivePokemon(1-tp):ApplySpecialCondition(tp,SPC_CONFUSED+SPC_POISONED)
	end
end
--get effect
function scard.op2(e,tp,eg,ep,ev,re,r,rp)
	local tc=Duel.GetActivePokemon(1-tp)
	Duel.AttackDamage(e,120)
	if not tc:IsInPlay() then return end
	--cannot retreat
	aux.AddTempEffectCustom(e:GetHandler(),tc,DESC_CANNOT_RETREAT,EFFECT_CANNOT_RETREAT,RESET_PHASE+PHASE_END,2)
end
--gx attack (to prize)
function scard.op3(e,tp,eg,ep,ev,re,r,rp)
	Duel.AttackDamage(e,0)
	local g=Duel.GetDecktopGroup(1-tp,2)
	Duel.SendtoPrize(g,REASON_ATTACK)
end
