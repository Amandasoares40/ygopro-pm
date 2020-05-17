--Gyarados (Black Star Promo XY60)
local scard,sid=aux.GetID()
function scard.initial_effect(c)
	--pokemon
	aux.EnablePokemonAttribute(c)
	--evolution
	aux.EnableEvolutionAttribute(c)
	--ancient trait (double pokemon tool)
	local e1=Effect.CreateEffect(c)
	e1:SetType(EFFECT_TYPE_SINGLE)
	e1:SetCode(EFFECT_DOUBLE_POKEMON_TOOL)
	c:RegisterEffect(e1)
	--damage
	local e2=aux.AddPokemonAttack(c,0,nil,scard.op1)
	e2:SetAttackCost(ENERGY_C,ENERGY_C)
	--damage
	local e3=aux.AddPokemonAttack(c,1,nil,scard.op2)
	e3:SetAttackCost(ENERGY_W,ENERGY_W,ENERGY_C,ENERGY_C)
end
scard.pokemon_evolution=TYPE_STAGE_1
scard.evolves_from=CARD_MAGIKARP
scard.evolution_list1={["Basic"]=CARD_MAGIKARP,["Stage 1"]=CARD_GYARADOS}
scard.weakness_x2={ENERGY_L}
--damage
function scard.op1(e,tp,eg,ep,ev,re,r,rp)
	local dam=30
	local g=Duel.GetBenchedPokemon(tp):Filter(Card.IsCode,nil,CARD_MAGIKARP)
	for tc in aux.Next(g) do
		local ct=tc:GetCounter(COUNTER_DAMAGE)
		if ct>0 then dam=dam+(ct*30) end
	end
	Duel.AttackDamage(e,dam)
end
--damage
function scard.op2(e,tp,eg,ep,ev,re,r,rp)
	local dam=100
	local self_damage=false
	if Duel.TossCoin(tp,1)==RESULT_HEADS then dam=dam+30 else self_damage=true end
	Duel.AttackDamage(e,dam)
	if self_damage then Duel.AttackDamage(e,30,e:GetHandler()) end
end
