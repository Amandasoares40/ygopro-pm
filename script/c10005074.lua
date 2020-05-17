--Challenge! (Team Rocket 74/82)
local scard,sid=aux.GetID()
function scard.initial_effect(c)
	--draw or search (to bench)
	aux.PlayTrainerFunction(c,scard.tg1,scard.op1)
end
scard.trainer_item=true
--draw or search (to bench)
function scard.tg1(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return (Duel.IsNotBenchFull(tp) and Duel.GetFieldGroupCount(tp,LOCATION_DECK,0)>0)
		or (Duel.IsNotBenchFull(1-tp) and Duel.GetFieldGroupCount(tp,0,LOCATION_DECK)>0)
		or Duel.IsPlayerCanDraw(tp,1) end
end
function scard.op1(e,tp,eg,ep,ev,re,r,rp)
	if Duel.IsBenchFull(tp) and Duel.IsBenchFull(1-tp) or not Duel.SelectYesNo(1-tp,aux.Stringid(sid,0)) then
		Duel.Draw(tp,2,REASON_EFFECT)
	else
		local ct1=Duel.GetFreeBenchCount(tp)
		local ct2=Duel.GetFreeBenchCount(1-tp)
		local g=Group.CreateGroup()
		if ct1>0 then
			Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_TOBENCH)
			local sg1=Duel.SelectMatchingCard(tp,Card.IsBasicPokemon,tp,LOCATION_DECK,0,0,ct1,nil)
			if sg1:GetCount()>0 then
				for tc1 in aux.Next(sg1) do
					Duel.MoveToField(tc1,tp,tp,LOCATION_BENCH,POS_FACEDOWN_UPSIDE,true)
					g:AddCard(tc1)
				end
			else
				Duel.ShuffleDeck(tp)
			end
		end
		if ct2>0 then
			Duel.Hint(HINT_SELECTMSG,1-tp,HINTMSG_TOBENCH)
			local sg2=Duel.SelectMatchingCard(1-tp,Card.IsBasicPokemon,1-tp,LOCATION_DECK,0,0,ct2,nil)
			if sg2:GetCount()>0 then
				for tc2 in aux.Next(sg2) do
					Duel.MoveToField(tc2,1-tp,1-tp,LOCATION_BENCH,POS_FACEDOWN_UPSIDE,true)
					g:AddCard(tc2)
				end
			else
				Duel.ShuffleDeck(1-tp)
			end
		end
		Duel.ChangePosition(g,POS_FACEUP_UPSIDE)
	end
end
