--Cyndaquil (Neo Genesis 56/111)
local scard,sid=aux.GetID()
function scard.initial_effect(c)
	--pokemon
	aux.EnablePokemonAttribute(c)
	--gain effect
	local e1=aux.AddPokemonAttack(c,0,nil,scard.op1)
	e1:SetAttackCost(ENERGY_C)
	--damage
	local e2=aux.AddPokemonAttack(c,1,nil,aux.AttackDamageOperation(20,false,false,false))
	e2:SetAttackCost(ENERGY_R,ENERGY_C)
end
scard.pokemon_basic=true
scard.length=1.80
scard.evolution_list1={["Basic"]=CARD_CYNDAQUIL,["Stage 1"]=CARD_QUILAVA,["Stage 2"]=CARD_TYPHLOSION}
scard.weakness_x2={ENERGY_W}
--gain effect
function scard.op1(e,tp,eg,ep,ev,re,r,rp)
	local tc=Duel.GetActivePokemon(1-tp)
	Duel.AttackDamage(e,0)
	if not tc:IsInPlay() or Duel.TossCoin(tp,1)==RESULT_TAILS then return end
	local c=e:GetHandler()
	--cannot attack
	local e1=Effect.CreateEffect(c)
	e1:SetDescription(DESC_CANNOT_ATTACK)
	e1:SetType(EFFECT_TYPE_SINGLE)
	e1:SetCode(EFFECT_CANNOT_ATTACK)
	e1:SetProperty(EFFECT_FLAG_CLIENT_HINT)
	e1:SetReset(RESET_EVENT+RESETS_STANDARD+RESET_PHASE+PHASE_END+RESET_SELF_TURN)
	tc:RegisterEffect(e1,nil,true)
	--end effect
	local e2=Effect.CreateEffect(c)
	e2:SetDescription(DESC_END_ATTACK_EFFECT)
	e2:SetType(EFFECT_TYPE_FIELD+EFFECT_TYPE_CONTINUOUS)
	e2:SetCode(EVENT_ADJUST)
	e2:SetProperty(EFFECT_FLAG_CANNOT_DISABLE+EFFECT_FLAG_UNCOPYABLE)
	e2:SetCountLimit(1)
	e2:SetLabelObject(e1)
	e2:SetCondition(scard.rstcon(c))
	e2:SetOperation(scard.rstop(tc))
	Duel.RegisterEffect(e2,tp)
end
--end effect
function scard.rstcon(c)
		return	function(e)
					return c:IsBenched() or not c:IsInPlay()
				end
end
function scard.rstop(tc)
	return	function(e,tp,eg,ep,ev,re,r,rp)
				local c=e:GetHandler()
				local e1=e:GetLabelObject()
				e1:Reset()
				e:Reset()
				Duel.HintSelection(Group.FromCards(tc))
				Duel.Hint(HINT_OPSELECTED,1-tp,e:GetDescription())
			end
end
