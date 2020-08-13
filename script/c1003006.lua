--Dark Ivysaur (Best of Game 6)
local scard,sid=aux.GetID()
function scard.initial_effect(c)
	aux.AddSetcode(c,SETNAME_DARK)
	aux.AddLength(c,3.30)
	--pokemon
	aux.EnablePokemonAttribute(c)
	--evolution
	aux.EnableEvolutionAttribute(c)
	--poke-body (switch)
	local e1=Effect.CreateEffect(c)
	e1:SetDescription(aux.Stringid(sid,0))
	e1:SetCategory(CATEGORY_POKEBODY)
	e1:SetType(EFFECT_TYPE_SINGLE+EFFECT_TYPE_CONTINUOUS)
	e1:SetCode(EVENT_CUSTOM+EVENT_RETREAT)
	e1:SetCondition(aux.TurnPlayerCondition(PLAYER_SELF))
	e1:SetOperation(scard.op1)
	c:RegisterEffect(e1)
	--add marker
	local e2=aux.AddPokemonAttack(c,1,nil,scard.op2)
	e2:SetAttackCost(ENERGY_G,ENERGY_G)
end
scard.pokemon_evolution=TYPE_STAGE_1
scard.evolves_from=CARD_BULBASAUR
scard.evolution_list1={["Basic"]=CARD_BULBASAUR,["Stage 1"]=CARD_IVYSAUR,["Stage 2"]=CARD_VENUSAUR}
scard.weakness_x2={ENERGY_R}
--poke-body (switch)
function scard.op1(e,tp,eg,ep,ev,re,r,rp)
	Duel.Hint(HINT_CARD,0,e:GetHandler():GetOriginalCode())
	Duel.Hint(HINT_OPSELECTED,1-tp,e:GetDescription())
	Duel.SwitchPokemon(tp,1-tp)
end
--add marker
function scard.markfilter(c)
	return c:IsFaceup() and c:IsPokemon()
end
function scard.damfilter(c)
	return c:GetMarker(MARKER_DARK_IVYSAUR)>0
end
function scard.op2(e,tp,eg,ep,ev,re,r,rp)
	local c=e:GetHandler()
	local fid=c:GetFieldID()
	local rg=Group.CreateGroup()
	for i=1,3 do
		Duel.Hint(HINT_SELECTMSG,1-tp,HINTMSG_ADDMARKER)
		local g1=Duel.SelectMatchingCard(1-tp,scard.markfilter,1-tp,LOCATION_INPLAY,0,1,1,nil)
		if g1:GetCount()==0 then break end
		local tc1=g1:GetFirst()
		Duel.HintSelection(g1)
		tc1:AddMarker(1-tp,MARKER_DARK_IVYSAUR,1,REASON_ATTACK)
		tc1:RegisterFlagEffect(sid,RESET_EVENT+RESETS_STANDARD+RESET_PHASE+PHASE_END,0,1,fid)
		rg:AddCard(tc1)
	end
	Duel.BreakEffect()
	local g2=Duel.GetInPlayPokemon():Filter(scard.damfilter,nil)
	for tc2 in aux.Next(g2) do
		local dam=tc2:GetMarker(MARKER_DARK_IVYSAUR)
		Duel.AttackDamage(e,10*dam,tc2,false,false)
	end
	rg:KeepAlive()
	--remove marker
	local e1=Effect.CreateEffect(c)
	e1:SetType(EFFECT_TYPE_FIELD+EFFECT_TYPE_CONTINUOUS)
	e1:SetCode(EVENT_PHASE+PHASE_END)
	e1:SetProperty(EFFECT_FLAG_IGNORE_IMMUNE)
	e1:SetCountLimit(1)
	e1:SetLabel(fid)
	e1:SetLabelObject(rg)
	e1:SetCondition(scard.con1)
	e1:SetOperation(scard.op3)
	Duel.RegisterEffect(e1,tp)
end
--remove marker
function scard.rmfilter(c,fid)
	return c:GetFlagEffectLabel(sid)==fid
end
function scard.con1(e,tp,eg,ep,ev,re,r,rp)
	local g=e:GetLabelObject()
	if not g:IsExists(scard.rmfilter,1,nil,e:GetLabel()) then
		g:DeleteGroup()
		e:Reset()
		return false
	else return true end
end
function scard.op3(e,tp,eg,ep,ev,re,r,rp)
	local g=e:GetLabelObject()
	local sg=g:Filter(scard.rmfilter,nil,e:GetLabel())
	for tc in aux.Next(sg) do
		local ct=tc:GetMarker(MARKER_DARK_IVYSAUR)
		tc:RemoveCounter(tp,MARKER_DARK_IVYSAUR,ct,REASON_ATTACK)
	end
end
