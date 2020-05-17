--Lance Prism Star (Dragon Majesty 61/70)
local scard,sid=aux.GetID()
function scard.initial_effect(c)
	aux.AddSetcode(c,SETNAME_PRISM_STAR)
	--search (to bench)
	aux.PlayTrainerFunction(c,scard.tg1,scard.op1,scard.con1)
	if not scard.global_check then
		scard.global_check=true
		--check for knocked out pokemon
		local ge1=Effect.CreateEffect(c)
		ge1:SetType(EFFECT_TYPE_FIELD+EFFECT_TYPE_CONTINUOUS)
		ge1:SetCode(EVENT_KNOCKED_OUT)
		ge1:SetOperation(scard.regop1)
		Duel.RegisterEffect(ge1,0)
	end
end
scard.trainer_supporter=true
--check for knocked out pokemon
function scard.regop1(e,tp,eg,ep,ev,re,r,rp)
	local p1=false
	local p2=false
	for ec in aux.Next(eg) do
		if ec:IsPokemon() and Duel.GetTurnPlayer()==1 then
			if ec:GetPreviousControler()==0 then p1=true else p2=true end
		end
	end
	if p1 then Duel.RegisterFlagEffect(0,sid,RESET_PHASE+EVENT_PHASE_START+PHASE_DRAW,0,2) end
	if p2 then Duel.RegisterFlagEffect(1,sid,RESET_PHASE+EVENT_PHASE_START+PHASE_DRAW,0,2) end
end
--search (to bench)
function scard.con1(e,tp,eg,ep,ev,re,r,rp)
	return Duel.GetFlagEffect(tp,sid)>0
end
function scard.tg1(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return Duel.IsNotBenchFull(tp) and Duel.GetFieldGroupCount(tp,LOCATION_DECK,0)>0 end
end
function scard.tbfilter(c,e,tp)
	return c:IsPokemon() and c:IsEnergyType(ENERGY_N) and c:IsCanBePlayed(e,0,tp,true,false)
end
function scard.op1(e,tp,eg,ep,ev,re,r,rp)
	if Duel.IsBenchFull(tp) then return end
	local ct=Duel.GetFreeBenchCount(tp)
	if ct>2 then ct=2 end
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_TOBENCH)
	local g=Duel.SelectMatchingCard(tp,scard.tbfilter,tp,LOCATION_DECK,0,0,ct,nil,e,tp)
	if g:GetCount()>0 then
		Duel.PlayPokemon(g,0,tp,tp,true,false,POS_FACEUP_UPSIDE)
	else
		Duel.ShuffleDeck(tp)
	end
end
