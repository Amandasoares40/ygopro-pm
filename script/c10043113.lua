--Lugia LEGEND (HeartGold & SoulSilver 113/123)
local scard,sid=aux.GetID()
function scard.initial_effect(c)
	--pokemon
	aux.EnablePokemonAttribute(c)
	--legend
	aux.EnablePokemonLEGENDAttribute(c)
	--poke-power (attach)
	local e1=Effect.CreateEffect(c)
	e1:SetDescription(aux.Stringid(sid,0))
	e1:SetCategory(CATEGORY_POKEPOWER)
	e1:SetType(EFFECT_TYPE_SINGLE+EFFECT_TYPE_TRIGGER_F)
	e1:SetCode(EVENT_PLAY)
	e1:SetTarget(aux.HintTarget)
	e1:SetOperation(scard.op1)
	c:RegisterEffect(e1)
	--discard energy
	local e2=aux.AddPokemonAttack(c,1,nil,scard.op2)
	e2:SetAttackCost(ENERGY_R,ENERGY_W,ENERGY_L)
end
scard.pokemon_legend=true
scard.legend_top_half=CARD_LUGIA_LEGEND
scard.weakness_x2={ENERGY_L}
scard.resistance_20={ENERGY_F}
--poke-power (attach)
function scard.atfilter(c,tc)
	return c:IsEnergy() and c:CheckAttachedTarget(tc)
end
function scard.op1(e,tp,eg,ep,ev,re,r,rp)
	if Duel.GetFieldGroupCount(tp,LOCATION_DECK,0)<=0
		or not Duel.SelectYesNo(tp,YESNOMSG_CONFIRMDECKTOP) then return end
	local g=Duel.GetDecktopGroup(tp,5)
	Duel.ConfirmCards(tp,g)
	local sg=g:Filter(scard.atfilter,nil,e:GetHandler())
	if sg:GetCount()>0 then
		Duel.DisableShuffleCheck()
		Duel.Attach(e,e:GetHandler(),sg)
		g:Sub(sg)
	end
	Duel.DisableShuffleCheck()
	Duel.SendtoDPile(g,REASON_ATTACK+REASON_DISCARD)
end
--discard energy
function scard.op2(e,tp,eg,ep,ev,re,r,rp)
	local c=e:GetHandler()
	Duel.AttackDamage(e,200)
	Duel.DiscardAttached(tp,c,Card.IsEnergy,1,1,REASON_ATTACK,nil,ENERGY_R)
	Duel.DiscardAttached(tp,c,Card.IsEnergy,1,1,REASON_ATTACK,nil,ENERGY_W)
	Duel.DiscardAttached(tp,c,Card.IsEnergy,1,1,REASON_ATTACK,nil,ENERGY_L)
end
