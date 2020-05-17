--Aerodactyl ex (Sandstorm 94/100)
local scard,sid=aux.GetID()
function scard.initial_effect(c)
	--pokemon
	aux.EnablePokemonAttribute(c)
	--evolution
	aux.EnableEvolutionAttribute(c)
	--poke-body (cannot play pokemon tool, remove pokemon tool)
	local e1=Effect.CreateEffect(c)
	e1:SetCategory(CATEGORY_POKEBODY)
	e1:SetType(EFFECT_TYPE_FIELD)
	e1:SetCode(EFFECT_CANNOT_ACTIVATE)
	e1:SetProperty(EFFECT_FLAG_PLAYER_TARGET)
	e1:SetRange(LOCATION_INPLAY)
	e1:SetTargetRange(0,1)
	e1:SetValue(scard.val1)
	c:RegisterEffect(e1)
	local e2=Effect.CreateEffect(c)
	e2:SetDescription(aux.Stringid(sid,0))
	e2:SetCategory(CATEGORY_POKEBODY)
	e2:SetType(EFFECT_TYPE_FIELD+EFFECT_TYPE_CONTINUOUS)
	e2:SetCode(EVENT_ADJUST)
	e2:SetRange(LOCATION_INPLAY)
	e2:SetOperation(scard.op1)
	c:RegisterEffect(e2)
	--confused
	local e3=aux.AddPokemonAttack(c,1,nil,scard.op2)
	e3:SetAttackCost(ENERGY_C)
	--damage
	local e4=aux.AddPokemonAttack(c,2,nil,aux.AttackDamageOperation(60))
	e4:SetAttackCost(ENERGY_C,ENERGY_C,ENERGY_C)
end
scard.pokemon_evolution=TYPE_STAGE_1
scard.pokemon_restored=true
scard.pokemon_ex_old=true
scard.evolves_from=CARD_MYSTERIOUS_FOSSIL
scard.evolution_list2={["Basic"]=CARD_MYSTERIOUS_FOSSIL,["Stage 1"]=CARD_AERODACTYL_EX_OLD}
scard.weakness_x2={ENERGY_L}
scard.resistance_30={ENERGY_F}
--poke-body (cannot play pokemon tool, remove pokemon tool)
function scard.val1(e,re,tp)
	return re:GetHandler():IsPokemonTool()
end
function scard.op1(e,tp,eg,ep,ev,re,r,rp)
	local g=Duel.GetAttachedGroup(tp,0,1):Filter(Card.IsPokemonTool,nil)
	if g:GetCount()==0 then return end
	Duel.Hint(HINT_CARD,0,e:GetHandler():GetOriginalCode())
	Duel.Hint(HINT_OPSELECTED,1-tp,e:GetDescription())
	Duel.SendtoDPile(g,REASON_EFFECT)
end
--confused
function scard.op2(e,tp,eg,ep,ev,re,r,rp)
	local tc=Duel.GetActivePokemon(1-tp)
	Duel.AttackDamage(e,10)
	if tc:IsInPlay() then
		tc:ApplySpecialCondition(tp,SPC_CONFUSED)
	end
end
