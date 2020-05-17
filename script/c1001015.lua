--Cool Porygon (Black Star Promo Wizards of the Coast 15)
local scard,sid=aux.GetID()
function scard.initial_effect(c)
	--pokemon
	aux.EnablePokemonAttribute(c)
	--get effect
	local e1=aux.AddPokemonAttack(c,0,nil,scard.op1)
	e1:SetAttackCost(ENERGY_C,ENERGY_C,ENERGY_C)
	--damage
	local e2=aux.AddPokemonAttack(c,1,nil,scard.op2)
	e2:SetAttackCost(ENERGY_C,ENERGY_C,ENERGY_C)
end
scard.pokemon_basic=true
scard.length=2.70
scard.weakness_x2={ENERGY_F}
scard.resistance_30={ENERGY_P}
--get effect
function scard.op1(e,tp,eg,ep,ev,re,r,rp)
	local c=e:GetHandler()
	local tc=Duel.GetActivePokemon(1-tp)
	Duel.AttackDamage(e,0)
	if c:IsHasResistance() and Duel.SelectYesNo(tp,aux.Stringid(sid,2)) then
		Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_ENERGYTYPE)
		local resist_type=Duel.SelectEnergyType(tp)
		--change resistance type
		local e1=Effect.CreateEffect(c)
		e1:SetDescription(DESC_RESISTANCE_TYPE_CHANGED)
		e1:SetType(EFFECT_TYPE_SINGLE)
		e1:SetCode(EFFECT_CHANGE_RESISTANCE_TYPE)
		e1:SetProperty(EFFECT_FLAG_CANNOT_DISABLE+EFFECT_FLAG_UNCOPYABLE+EFFECT_FLAG_CLIENT_HINT)
		e1:SetValue(resist_type)
		e1:SetReset(RESET_EVENT+RESETS_STANDARD)
		c:RegisterEffect(e1,nil,true)
	end
	if tc:IsInPlay() and tc:IsHasWeakness() and Duel.SelectYesNo(tp,aux.Stringid(sid,3)) then
		Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_ENERGYTYPE)
		local weak_type=Duel.SelectEnergyType(tp)
		--change weakness type
		local e1=Effect.CreateEffect(c)
		e1:SetDescription(DESC_WEAKNESS_TYPE_CHANGED)
		e1:SetType(EFFECT_TYPE_SINGLE)
		e1:SetCode(EFFECT_CHANGE_WEAKNESS_TYPE)
		e1:SetProperty(EFFECT_FLAG_CANNOT_DISABLE+EFFECT_FLAG_UNCOPYABLE+EFFECT_FLAG_CLIENT_HINT)
		e1:SetValue(weak_type)
		e1:SetReset(RESET_EVENT+RESETS_STANDARD)
		tc:RegisterEffect(e1,nil,true)
	end
end
--damage
function scard.op2(e,tp,eg,ep,ev,re,r,rp)
	local c1,c2,c3=Duel.TossCoin(tp,3)
	local dam=c1+c2+c3
	Duel.AttackDamage(e,20*dam)
end
