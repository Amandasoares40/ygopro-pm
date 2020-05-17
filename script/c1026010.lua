--Team Magma's Baltoy (Double Crisis 10/34)
local scard,sid=aux.GetID()
function scard.initial_effect(c)
	aux.AddSetcode(c,SETNAME_TEAM_MAGMA,SETNAME_OWNER)
	--pokemon
	aux.EnablePokemonAttribute(c)
	--damage
	local e1=aux.AddPokemonAttack(c,0,nil,scard.op1)
	e1:SetAttackCost(ENERGY_P,ENERGY_C)
end
scard.pokemon_basic=true
scard.height=1.08
scard.evolution_list1={["Basic"]=CARD_TEAM_MAGMAS_BALTOY,["Stage 1"]=CARD_TEAM_MAGMAS_CLAYDOL}
scard.weakness_x2={ENERGY_P}
--damage
function scard.op1(e,tp,eg,ep,ev,re,r,rp)
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_DAMAGE)
	local g=Duel.GetInPlayPokemon(1-tp):Select(tp,1,1,nil)
	if g:GetCount()==0 then return end
	Duel.HintSelection(g)
	Duel.AttackDamage(e,20,g:GetFirst(),false,false)
end
