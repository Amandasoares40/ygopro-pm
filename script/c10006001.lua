--Blaine's Moltres (Gym Heroes 1/132)
local scard,sid=aux.GetID()
function scard.initial_effect(c)
	aux.AddSetcode(c,SETNAME_BLAINE,SETNAME_OWNER)
	--pokemon
	aux.EnablePokemonAttribute(c)
	--to deck
	local e1=aux.AddPokemonAttack(c,0,nil,scard.op1)
	e1:SetAttackCost(ENERGY_R,ENERGY_R,ENERGY_R,ENERGY_R,ENERGY_R)
end
scard.pokemon_basic=true
scard.length=6.70
scard.resistance_30={ENERGY_F}
--to deck
function scard.op1(e,tp,eg,ep,ev,re,r,rp)
	Duel.AttackDamage(e,90)
	if Duel.TossCoin(tp,1)==RESULT_TAILS then
		local c=e:GetHandler()
		local g=Group.FromCards(c)
		g:Merge(c:GetAttachedGroup())
		Duel.SendtoDeck(g,PLAYER_OWNER,SEQ_DECK_SHUFFLE,REASON_ATTACK)
	end
end
