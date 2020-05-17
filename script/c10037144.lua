--Mewtwo LV.X (Legends Awakened 144/146)
local scard,sid=aux.GetID()
function scard.initial_effect(c)
	--pokemon
	aux.EnablePokemonAttribute(c)
	--level up
	aux.EnableLevelUpAttribute(c)
	--poke-body (immune to attacks)
	local e1=Effect.CreateEffect(c)
	e1:SetCategory(CATEGORY_POKEBODY)
	e1:SetType(EFFECT_TYPE_SINGLE)
	e1:SetCode(EFFECT_IMMUNE_EFFECT)
	e1:SetRange(LOCATION_INPLAY)
	e1:SetValue(scard.val1)
	c:RegisterEffect(e1)
	--discard energy
	local e2=aux.AddPokemonAttack(c,0,nil,scard.op1)
	e2:SetAttackCost(ENERGY_P,ENERGY_P,ENERGY_C)
end
scard.pokemon_lvx=true
scard.levels_up_from=CARD_MEWTWO
scard.level_up_list={CARD_MEWTWO,CARD_CARD_MEWTWO_LV_X}
scard.weakness_x2={ENERGY_P}
--poke-body (immune to attacks)
function scard.val1(e,te)
	return te:IsHasCategory(CATEGORY_POKEMON_ATTACK)
		and te:GetOwnerPlayer()~=e:GetHandlerPlayer() and not te:GetHandler():IsEvolved()
end
--discard energy
function scard.op1(e,tp,eg,ep,ev,re,r,rp)
	Duel.AttackDamage(e,120)
	local g=e:GetHandler():GetAttachedGroup():Filter(Card.IsEnergy,nil)
	Duel.SendtoDPile(g,REASON_ATTACK+REASON_DISCARD)
end
