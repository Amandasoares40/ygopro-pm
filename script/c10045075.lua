--Legend Box (Undaunted 75/91)
local scard,sid=aux.GetID()
function scard.initial_effect(c)
	--to bench, attach
	aux.PlayTrainerFunction(c,scard.tg1,scard.op1)
end
scard.trainer_item=true
--to bench, attach
function scard.tg1(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return Duel.IsNotBenchFull(tp) and Duel.GetFieldGroupCount(tp,LOCATION_DECK,0)>0 end
end
function scard.tbfilter1(c,g,e,tp)
	return c:IsPokemonLEGEND() and c.legend_top_half and c:IsCanBePlayed(e,0,tp,true,false)
		and g:IsExists(scard.tbfilter2,1,nil,c.legend_top_half)
end
function scard.tbfilter2(c,code)
	return c.legend_bottom_half==code
end
function scard.atfilter(c,tc)
	return c:IsEnergy() and c:CheckAttachedTarget(tc)
end
function scard.op1(e,tp,eg,ep,ev,re,r,rp)
	if Duel.IsBenchFull(tp) or Duel.GetFieldGroupCount(tp,LOCATION_DECK,0)<=0 then return end
	Duel.ConfirmDecktop(tp,10)
	local g=Duel.GetDecktopGroup(tp,10)
	local sg=g:Filter(scard.tbfilter1,nil,g,e,tp)
	if sg:GetCount()>0 then
		Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_TOBENCH)
		local tc1=sg:Select(tp,1,1,nil):GetFirst()
		local tc2=g:Filter(scard.tbfilter2,nil,tc1.legend_top_half):GetFirst()
		local ag=g:Filter(scard.atfilter,nil,tc1)
		Duel.DisableShuffleCheck()
		Duel.PlayPokemon(tc1,0,tp,tp,true,false,POS_FACEUP_UPSIDE)
		Duel.DisableShuffleCheck()
		Duel.Attach(e,tc1,tc2)
		Duel.DisableShuffleCheck()
		Duel.Attach(e,tc1,ag)
	end
	Duel.ShuffleDeck(tp)
end
--[[
	Rulings
	Q. On the part of Legend Box where it talks about "you can play only 1 Pokemon LEGEND in this way", is that just for
	the play of the card, or for the entire game?
	A. It only lasts for as long as the Trainer is being used. It just means that if you reveal two or more complete
	Pokemon LEGENDs that you can only put one of them onto your bench for that trainer card played.
	(Sep 23, 2010 PUI Rules Team)
	https://compendium.pokegym.net/compendium-bw.html#158
]]
