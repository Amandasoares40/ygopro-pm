--Sabrina's Psychic Control (Gym Challenge 121/132)
--Not yet implemented:
--1. Doesn't copy a Trainer that attaches to a Pokemon correctly.
--2. Doesn't copy the energy and HP of the Trainer it copies that can be played as if it were a Pokemon.local scard,sid=aux.GetID()
function scard.initial_effect(c)
	aux.AddSetcode(c,SETNAME_SABRINA)
	--copy trainer
	aux.PlayTrainerFunction(c,scard.tg1,scard.op1)
end
scard.trainer_item=true
--copy trainer
function scard.copyfilter(c)
	return c:IsTrainer() --and c.trainer_item==PSEUDO_POKEMON_TOOL
end
function scard.tg1(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return Duel.IsExistingMatchingCard(scard.copyfilter,tp,0,LOCATION_DPILE,1,nil) end
	if Duel.TossCoin(tp,1)==RESULT_TAILS then return end
	Duel.Hint(HINT_SELECTMSG,tp,568) --"Select a Trainer card to apply its effect."
	local g=Duel.SelectMatchingCard(tp,scard.copyfilter,tp,0,LOCATION_DPILE,1,1,nil)
	local te,ceg,cep,cev,cre,cr,crp=g:GetFirst():CheckActivateEffect(false,false,true)
	e:SetProperty(te:GetProperty())
	local tg=te:GetTarget()
	if tg then tg(e,tp,ceg,cep,cev,cre,cr,crp,1) end
	te:SetLabelObject(e:GetLabelObject())
	e:SetLabelObject(te)
end
function scard.op1(e,tp,eg,ep,ev,re,r,rp)
	local te=e:GetLabelObject()
	if not te then return end
	e:SetLabelObject(te:GetLabelObject())
	local op=te:GetOperation()
	if op then op(e,tp,eg,ep,ev,re,r,rp) end
end
