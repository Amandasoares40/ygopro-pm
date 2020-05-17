--Bronzong 4 (Rising Rivals 16/111)
local scard,sid=aux.GetID()
function scard.initial_effect(c)
	--pokemon
	aux.EnablePokemonAttribute(c)
	--to deck, draw
	local e1=aux.AddPokemonAttack(c,0,nil,scard.op1)
	e1:SetAttackCost()
	--confused
	local e2=aux.AddPokemonAttack(c,1,nil,scard.op2)
	e2:SetAttackCost(ENERGY_P,ENERGY_C)
end
scard.pokemon_basic=true
scard.pokemon_sp=true
scard.weakness_x2={ENERGY_P}
scard.resistance_20={ENERGY_R}
--to deck, draw
function scard.op1(e,tp,eg,ep,ev,re,r,rp)
	Duel.AttackDamage(e,0)
	local g=Duel.GetFieldGroup(tp,LOCATION_HAND,LOCATION_HAND)
	Duel.SendtoDeck(g,PLAYER_OWNER,SEQ_DECK_SHUFFLE,REASON_ATTACK)
	Duel.ShuffleDeck(tp)
	Duel.ShuffleDeck(1-tp)
	Duel.BreakEffect()
	Duel.DrawUpTo(tp,4,REASON_ATTACK,true)
	Duel.DrawUpTo(1-tp,4,REASON_ATTACK,true)
end
--confused
function scard.op2(e,tp,eg,ep,ev,re,r,rp)
	local dam=10
	local confused=false
	if Duel.GetPrizeCount(1-tp)==1 then
		dam=dam+50
		confused=true
	end
	local tc=Duel.GetActivePokemon(1-tp)
	Duel.AttackDamage(e,dam)
	if tc:IsInPlay() and confused then tc:ApplySpecialCondition(tp,SPC_CONFUSED) end
end
