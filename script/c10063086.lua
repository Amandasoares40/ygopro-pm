--Primal Groudon-EX (Primal Clash 86/160)
local scard,sid=aux.GetID()
function scard.initial_effect(c)
	--pokemon
	aux.EnablePokemonAttribute(c)
	--evolution
	aux.EnableEvolutionAttribute(c)
	--ancient trait (immune to effects)
	local e1=Effect.CreateEffect(c)
	e1:SetType(EFFECT_TYPE_SINGLE)
	e1:SetCode(EFFECT_IMMUNE_EFFECT)
	e1:SetRange(LOCATION_INPLAY)
	e1:SetValue(scard.val1)
	c:RegisterEffect(e1)
	--discard stadium
	local e2=aux.AddPokemonAttack(c,0,nil,scard.op1)
	e2:SetAttackCost(ENERGY_F,ENERGY_F,ENERGY_F,ENERGY_C)
end
scard.pokemon_evolution=TYPE_MEGA
scard.pokemon_ex=true
scard.evolves_from=CARD_GROUDON_EX
scard.mega_evolution_list={CARD_GROUDON_EX,CARD_PRIMAL_GROUDON_EX}
scard.weakness_x2={ENERGY_G}
--ancient trait (immune to effects)
function scard.val1(e,te)
	local tc=te:GetHandler()
	if tc:IsPokemonTool() or tc:IsStadium() then return false end
	return te:IsActiveType(TYPE_TRAINER) and te:GetOwnerPlayer()~=e:GetHandlerPlayer()
end
--discard stadium
function scard.op1(e,tp,eg,ep,ev,re,r,rp)
	local dam=100
	local tc=Duel.GetStadiumCard()
	if tc then dam=dam+100 end
	Duel.AttackDamage(e,dam)
	Duel.SendtoDPile(tc,REASON_ATTACK+REASON_DISCARD)
end
