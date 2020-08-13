--Frogadier (Kalos Starter Set 13/39)
local scard,sid=aux.GetID()
function scard.initial_effect(c)
	aux.AddHeight(c,2.00)
	--pokemon
	aux.EnablePokemonAttribute(c)
	--evolution
	aux.EnableEvolutionAttribute(c)
	--damage
	local e1=aux.AddPokemonAttack(c,0,nil,aux.AttackDamageOperation(20))
	e1:SetAttackCost(ENERGY_W)
	--damage
	local e2=aux.AddPokemonAttack(c,1,nil,scard.op1)
	e2:SetAttackCost(ENERGY_W,ENERGY_W,ENERGY_C)
end
scard.pokemon_evolution=TYPE_STAGE_1
scard.evolves_from=CARD_FROAKIE
scard.evolution_list1={["Basic"]=CARD_FROAKIE,["Stage 1"]=CARD_FROGADIER,["Stage 2"]=CARD_GRENINJA}
scard.break_evolution_list={CARD_GRENINJA,CARD_GRENINJA_BREAK}
scard.weakness_x2={ENERGY_G}
--damage
function scard.op1(e,tp,eg,ep,ev,re,r,rp)
	local c1,c2=Duel.TossCoin(tp,2)
	local dam=(c1+c2)*20
	Duel.AttackDamage(e,40+dam)
end
