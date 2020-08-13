--Noivern (XY Trainer Kit: Sylveon and Noivern 13/30)
local scard,sid=aux.GetID()
function scard.initial_effect(c)
	aux.AddHeight(c,4.11)
	--pokemon
	aux.EnablePokemonAttribute(c)
	--evolution
	aux.EnableEvolutionAttribute(c)
	--damage
	local e1=aux.AddPokemonAttack(c,0,nil,scard.op1)
	e1:SetAttackCost(ENERGY_C,ENERGY_C)
	--confused
	local e2=aux.AddPokemonAttack(c,1,nil,scard.op2)
	e2:SetAttackCost(ENERGY_P,ENERGY_D,ENERGY_C)
end
scard.pokemon_evolution=TYPE_STAGE_1
scard.evolves_from=CARD_NOIBAT
scard.evolution_list1={["Basic"]=CARD_NOIBAT,["Stage 1"]=CARD_NOIVERN}
scard.break_evolution_list={CARD_NOIVERN,CARD_NOIVERN_BREAK}
scard.weakness_x2={ENERGY_Y}
--damage
function scard.op1(e,tp,eg,ep,ev,re,r,rp)
	local dam=20
	local ct=Duel.GetActivePokemon(1-tp):GetCounter(COUNTER_DAMAGE)
	if ct>0 then dam=dam+(ct*10) end
	Duel.AttackDamage(e,dam)
end
--confused
function scard.op2(e,tp,eg,ep,ev,re,r,rp)
	local dam=60
	local confused=false
	if Duel.TossCoin(tp,1)==RESULT_HEADS then
		dam=dam+30
		confused=true
	end
	local tc=Duel.GetActivePokemon(1-tp)
	Duel.AttackDamage(e,dam)
	if tc:IsInPlay() and confused then tc:ApplySpecialCondition(tp,SPC_CONFUSED) end
end
