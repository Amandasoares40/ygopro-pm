--Eneporter (Forbidden Light 106/131)
local scard,sid=aux.GetID()
function scard.initial_effect(c)
	--move energy
	aux.PlayTrainerFunction(c,scard.tg1,scard.op1)
end
scard.trainer_item=true
--move energy
function scard.cfilter1(c,tp)
	return c:GetAttachedGroup():IsExists(scard.cfilter2,1,nil,tp)
end
function scard.cfilter2(c,tp)
	return c:IsSpecialEnergy() and Duel.GetInPlayPokemon(tp):IsExists(scard.mefilter,1,c:GetAttachedTarget(),c)
end
function scard.mefilter(c,tc)
	return true--tc:CheckAttachedTarget(c)
end
function scard.tg1(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return Duel.GetInPlayPokemon(1-tp):IsExists(scard.cfilter1,1,nil,1-tp) end
end
function scard.op1(e,tp,eg,ep,ev,re,r,rp)
	local g=Duel.GetInPlayPokemon(1-tp):Filter(scard.cfilter1,nil,1-tp)
	if g:GetCount()==0 then return end
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_REMOVEENERGYFROM)
	local sg1=g:Select(tp,1,1,nil)
	Duel.HintSelection(sg1)
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_MOVEENERGY)
	local sg2=sg1:GetFirst():GetAttachedGroup():FilterSelect(tp,scard.cfilter2,1,1,nil,1-tp)
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_MOVEENERGYTO)
	local sg3=Duel.GetInPlayPokemon(1-tp):FilterSelect(tp,scard.mefilter,1,1,sg1,sg2:GetFirst())
	Duel.HintSelection(sg3)
	Duel.MoveEnergy(sg3:GetFirst(),sg2)
end
--[[
	Rulings
	Q. Can I play Eneporter to try and fail to move a Special Energy onto a Pyroar that is protected by its "Unnerve"
	Ability, or would I not be able to play Eneporter at all?
	A. The fact that its effect will be blocked by another effect such as Unnerve does not prevent an Item or Supporter
	card from being played. For example, your opponent may play Eneporter to try moving a Special Energy and Pyroar is a
	valid target, but Unnerve blocks the effect even though Eneporter was played. Playing a card for no effect happens
	when the game state itself prevents any effect from taking place and in that case the card would not be played, but
	that is not what this example is referring to. (Forbidden Light FAQ; May 3, 2018 TPCi Rules Team)
	https://compendium.pokegym.net/compendium-bw.html#583
]]
