--Ho-Oh LEGEND (HeartGold & SoulSilver 111/123)
local scard,sid=aux.GetID()
function scard.initial_effect(c)
	--pokemon
	aux.EnablePokemonAttribute(c)
	--legend
	aux.EnablePokemonLEGENDAttribute(c)
	--poke-body (change attached energy)
	local e1=Effect.CreateEffect(c)
	e1:SetCategory(CATEGORY_POKEBODY)
	e1:SetType(EFFECT_TYPE_SINGLE)
	e1:SetCode(sid)
	e1:SetRange(LOCATION_INPLAY)
	c:RegisterEffect(e1)
	if not scard.global_check then
		scard.global_check=true
		local ge1=Effect.GlobalEffect()
		ge1:SetType(EFFECT_TYPE_FIELD)
		ge1:SetCode(EFFECT_CHANGE_ENERGY_TYPE)
		ge1:SetTargetRange(LOCATION_ATTACHED,LOCATION_ATTACHED)
		ge1:SetTarget(scard.tg1)
		ge1:SetValue(ENERGY_R)
		Duel.RegisterEffect(ge1,0)
	end
	--discard energy
	local e2=aux.AddPokemonAttack(c,0,nil,scard.op1)
	e2:SetAttackCost(ENERGY_R,ENERGY_R,ENERGY_R,ENERGY_R)
end
scard.pokemon_legend=true
scard.legend_top_half=CARD_HO_OH_LEGEND
scard.weakness_x2={ENERGY_W}
scard.resistance_20={ENERGY_F}
--poke-body (change attached energy)
function scard.tg1(e,c)
	return c:IsEnergy() and c:GetAttachedTarget():IsHasEffect(sid)
end
--discard energy
function scard.op1(e,tp,eg,ep,ev,re,r,rp)
	Duel.AttackDamage(e,100)
	Duel.DiscardAttached(tp,e:GetHandler(),Card.IsEnergy,1,1,REASON_ATTACK)
end
