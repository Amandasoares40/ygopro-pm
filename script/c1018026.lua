--Axew (Black Star Promo BW26)
local scard,sid=aux.GetID()
function scard.initial_effect(c)
	aux.AddHeight(c,2.00)
	--pokemon
	aux.EnablePokemonAttribute(c)
	--gain effect
	local e1=aux.AddPokemonAttack(c,0,nil,scard.op1)
	e1:SetAttackCost(ENERGY_C,ENERGY_C)
end
scard.pokemon_basic=true
scard.evolution_list1={["Basic"]=CARD_AXEW,["Stage 1"]=CARD_FRAXURE,["Stage 2"]=CARD_HAXORUS}
--gain effect
function scard.op1(e,tp,eg,ep,ev,re,r,rp)
	local tc=Duel.GetActivePokemon(1-tp)
	Duel.AttackDamage(e,20)
	if not tc:IsInPlay() then return end
	--cannot retreat
	aux.AddTempEffectCustom(e:GetHandler(),tc,DESC_CANNOT_RETREAT,EFFECT_CANNOT_RETREAT,RESET_PHASE+PHASE_END,2)
end
