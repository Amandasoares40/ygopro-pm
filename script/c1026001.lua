--Team Magma's Numel (Double Crisis 1/34)
local scard,sid=aux.GetID()
function scard.initial_effect(c)
	aux.AddSetcode(c,SETNAME_TEAM_MAGMA,SETNAME_OWNER)
	--pokemon
	aux.EnablePokemonAttribute(c)
	--discard energy
	local e1=aux.AddPokemonAttack(c,0,nil,scard.op1)
	e1:SetAttackCost(ENERGY_R,ENERGY_C)
end
scard.pokemon_basic=true
scard.height=2.04
scard.evolution_list1={["Basic"]=CARD_TEAM_MAGMAS_NUMEL,["Stage 1"]=CARD_TEAM_MAGMAS_CAMERUPT}
scard.weakness_x2={ENERGY_W}
--discard energy
function scard.op1(e,tp,eg,ep,ev,re,r,rp)
	Duel.AttackDamage(e,30)
	Duel.DiscardAttached(tp,e:GetHandler(),Card.IsEnergy,1,1,REASON_ATTACK)
end
