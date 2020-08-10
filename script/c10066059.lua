--Haunter (BREAKthrough 59/162)
local scard,sid=aux.GetID()
function scard.initial_effect(c)
	--pokemon
	aux.EnablePokemonAttribute(c)
	--evolution
	aux.EnableEvolutionAttribute(c)
	--ability (confused)
	local e1=Effect.CreateEffect(c)
	e1:SetDescription(aux.Stringid(sid,0))
	e1:SetCategory(CATEGORY_ABILITY)
	e1:SetType(EFFECT_TYPE_SINGLE+EFFECT_TYPE_TRIGGER_F)
	e1:SetCode(EVENT_PLAY)
	e1:SetCountLimit(1)
	e1:SetCondition(aux.PlayedFromHandCondition(SUMMON_TYPE_EVOLVE))
	e1:SetTarget(aux.HintTarget)
	e1:SetOperation(scard.op1)
	c:RegisterEffect(e1)
	--poisoned, gain effect
	local e2=aux.AddPokemonAttack(c,1,nil,scard.op2)
	e2:SetAttackCost(ENERGY_P,ENERGY_C)
end
scard.pokemon_evolution=TYPE_STAGE_1
scard.height=5.03
scard.evolves_from=CARD_GASTLY
scard.evolution_list1={["Basic"]=CARD_GASTLY,["Stage 1"]=CARD_HAUNTER,["Stage 2"]=CARD_GENGAR}
scard.weakness_x2={ENERGY_D}
scard.resistance_20={ENERGY_F}
--ability (confused)
function scard.op1(e,tp,eg,ep,ev,re,r,rp)
	if not Duel.GetActivePokemon():IsExists(Card.IsImmuneToSpecialCondition,1,nil)
		and Duel.SelectYesNo(tp,YESNOMSG_CONFUSED) then
		Duel.GetActivePokemon(tp):ApplySpecialCondition(tp,SPC_CONFUSED)
		Duel.GetActivePokemon(1-tp):ApplySpecialCondition(tp,SPC_CONFUSED)
	end
end
--poisoned, gain effect
function scard.op2(e,tp,eg,ep,ev,re,r,rp)
	local tc=Duel.GetActivePokemon(1-tp)
	Duel.AttackDamage(e,0)
	if not tc:IsInPlay() then return end
	tc:ApplySpecialCondition(tp,SPC_POISONED)
	--cannot retreat
	aux.AddTempEffectCustom(e:GetHandler(),tc,DESC_CANNOT_RETREAT,EFFECT_CANNOT_RETREAT,RESET_PHASE+PHASE_END,2)
end
