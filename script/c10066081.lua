--Piloswine (BREAKthrough 81/162)
local scard,sid=aux.GetID()
function scard.initial_effect(c)
	--pokemon
	aux.EnablePokemonAttribute(c)
	--evolution
	aux.EnableEvolutionAttribute(c)
	--switch
	local e1=aux.AddPokemonAttack(c,0,nil,scard.op1)
	e1:SetAttackCost(ENERGY_F,ENERGY_C)
	--damage
	local e2=aux.AddPokemonAttack(c,1,nil,scard.op2)
	e2:SetAttackCost(ENERGY_F,ENERGY_C,ENERGY_C)
end
scard.pokemon_evolution=TYPE_STAGE_1
scard.height=3.07
scard.evolves_from=CARD_SWINUB
scard.evolution_list1={["Basic"]=CARD_SWINUB,["Stage 1"]=CARD_PILOSWINE,["Stage 2"]=CARD_MAMOSWINE}
scard.weakness_x2={ENERGY_G}
--switch
function scard.op1(e,tp,eg,ep,ev,re,r,rp)
	Duel.AttackDamage(e,0)
	Duel.SwitchPokemon(1-tp,1-tp)
end
--damage
function scard.op2(e,tp,eg,ep,ev,re,r,rp)
	local g=Duel.GetInPlayPokemon(tp):Filter(Card.IsCode,nil,CARD_SWINUB,CARD_PILOSWINE,CARD_MAMOSWINE)
	local dam=10*g:GetSum(Card.GetRetreatCost,nil)
	Duel.AttackDamage(e,30+dam)
end
