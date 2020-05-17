--Pow! Hand Extension (Team Rocket Returns 85/109)
local scard,sid=aux.GetID()
function scard.initial_effect(c)
	--choose one (move energy or switch)
	aux.PlayTrainerFunction(c,scard.tg1,scard.op1,scard.con1)
end
scard.trainer_rockets_secret_machine=true
--choose one (move energy or switch)
function scard.con1(e,tp,eg,ep,ev,re,r,rp)
	return Duel.GetPrizeCount(tp)>Duel.GetPrizeCount(1-tp)
end
function scard.cfilter1(c,tp)
	return Duel.GetActivePokemon(tp):GetAttachedGroup():IsExists(scard.cfilter2,1,nil,tp)
end
function scard.cfilter2(c,tp)
	return c:IsEnergy() and Duel.GetInPlayPokemon(tp):IsExists(scard.mefilter,1,c:GetAttachedTarget(),c)
end
function scard.mefilter(c,tc)
	return true--tc:CheckAttachedTarget(c)
end
function scard.tg1(e,tp,eg,ep,ev,re,r,rp,chk)
	local b1=Duel.GetInPlayPokemon(1-tp):IsExists(scard.cfilter1,1,nil,1-tp)
	local b2=Duel.GetActivePokemon(1-tp) and Duel.GetBenchedPokemon(1-tp):GetCount()>0
	if chk==0 then return b1 or b2 end
	local option_list={}
	local t={}
	if b1 then
		table.insert(option_list,aux.Stringid(sid,0))
		table.insert(t,1)
	end
	if b2 then
		table.insert(option_list,aux.Stringid(sid,1))
		table.insert(t,2)
	end
	local opt=t[Duel.SelectOption(tp,table.unpack(option_list))+1]
	e:SetLabel(opt)
end
function scard.op1(e,tp,eg,ep,ev,re,r,rp)
	local opt=e:GetLabel()
	if opt==1 then
		if not Duel.GetInPlayPokemon(1-tp):IsExists(scard.cfilter1,1,nil,1-tp) then return end
		Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_MOVEENERGY)
		local g1=Duel.GetActivePokemon(1-tp):GetAttachedGroup():FilterSelect(tp,scard.cfilter2,1,1,nil,1-tp)
		Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_MOVEENERGYTO)
		local g2=Duel.GetBenchedPokemon(1-tp):FilterSelect(tp,scard.mefilter,1,1,nil,g1:GetFirst())
		Duel.HintSelection(g2)
		Duel.MoveEnergy(g2:GetFirst(),g1)
	elseif opt==2 then
		Duel.SwitchPokemon(1-tp,1-tp)
	end
end
