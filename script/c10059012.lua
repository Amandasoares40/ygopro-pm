--Chespin (XY 12/146)
local scard,sid=aux.GetID()
function scard.initial_effect(c)
	aux.AddHeight(c,1.04)
	--pokemon
	aux.EnablePokemonAttribute(c)
	--damage
	local e1=aux.AddPokemonAttack(c,0,nil,scard.op1)
	e1:SetAttackCost(ENERGY_G)
end
scard.pokemon_basic=true
scard.evolution_list1={["Basic"]=CARD_CHESPIN,["Stage 1"]=CARD_QUILLADIN,["Stage 2"]=CARD_CHESNAUGHT}
scard.break_evolution_list={CARD_CHESNAUGHT,CARD_CHESNAUGHT_BREAK}
scard.weakness_x2={ENERGY_R}
--damage
function scard.op1(e,tp,eg,ep,ev,re,r,rp)
	local c1,c2,c3,c4=Duel.TossCoin(tp,4)
	local dam=c1+c2+c3+c4
	Duel.AttackDamage(e,10*dam)
end
