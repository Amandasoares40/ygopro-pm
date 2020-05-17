--Rayquaza & Deoxys LEGEND (Undaunted 89/90)
local scard,sid=aux.GetID()
function scard.initial_effect(c)
	aux.AddSetcode(c,SETNAME_DEOXYS)
	--pokemon
	aux.EnablePokemonAttribute(c)
	--legend
	aux.EnablePokemonLEGENDAttribute(c)
	--poke-body (increase prize)
	local e1=Effect.CreateEffect(c)
	e1:SetCategory(CATEGORY_POKEBODY)
	e1:SetType(EFFECT_TYPE_SINGLE)
	e1:SetCode(EFFECT_ATTACK_UPDATE_PRIZE)
	e1:SetRange(LOCATION_INPLAY)
	e1:SetValue(1)
	c:RegisterEffect(e1)
	--discard energy
	local e2=aux.AddPokemonAttack(c,0,nil,scard.op1)
	e2:SetAttackCost(ENERGY_R,ENERGY_R,ENERGY_L,ENERGY_C)
end
scard.pokemon_legend=true
scard.legend_top_half=CARD_RAYQUAZA_DEOXYS_LEGEND
scard.weakness_x2={ENERGY_P,ENERGY_C}
--discard energy
function scard.op1(e,tp,eg,ep,ev,re,r,rp)
	Duel.AttackDamage(e,150)
	local g=e:GetHandler():GetAttachedGroup():Filter(Card.IsEnergy,nil,ENERGY_R)
	Duel.SendtoDPile(g,REASON_ATTACK+REASON_DISCARD)
end
