--Darkrai & Cresselia LEGEND (Triumphant 99/102)
local scard,sid=aux.GetID()
function scard.initial_effect(c)
	--pokemon
	aux.EnablePokemonAttribute(c)
	--legend
	aux.EnablePokemonLEGENDAttribute(c)
	--move counter
	local e1=aux.AddPokemonAttack(c,0,nil,scard.op1)
	e1:SetAttackCost(ENERGY_P)
	--get effect
	local e2=aux.AddPokemonAttack(c,1,nil,scard.op2)
	e2:SetAttackCost(ENERGY_D,ENERGY_D,ENERGY_C,ENERGY_C)
end
scard.pokemon_legend=true
scard.legend_top_half=CARD_DARKRAI_CRESSELIA_LEGEND
scard.weakness_x2={ENERGY_F,ENERGY_P}
--move counter
function scard.ctfilter1(c)
	return c:IsFaceup() and c:IsPokemon() and c:IsDamaged()
end
function scard.ctfilter2(c)
	return c:IsFaceup() and c:IsPokemon()
end
function scard.op1(e,tp,eg,ep,ev,re,r,rp)
	Duel.AttackDamage(e,0)
	local g1=Duel.GetMatchingGroup(scard.ctfilter1,tp,0,LOCATION_INPLAY,nil)
	local g2=Duel.GetMatchingGroup(scard.ctfilter2,tp,0,LOCATION_INPLAY,nil)
	if g1:GetCount()==0 or not Duel.SelectYesNo(tp,YESNOMSG_REMOVECOUNTER) then return end
	repeat
		Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_REMOVECOUNTERFROM)
		local sg1=g1:Select(tp,1,1,nil)
		Duel.HintSelection(sg1)
		local tc1=sg1:GetFirst()
		local ct=tc1:GetCounter(COUNTER_DAMAGE)
		local t={}
		for i=1,ct do t[i]=i end
		Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_ANNOUNCECOUNTER)
		local damc=Duel.AnnounceNumber(tp,table.unpack(t))
		tc1:RemoveCounter(tp,COUNTER_DAMAGE,damc,REASON_ATTACK)
		g1:RemoveCard(tc1)
		Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_MOVECOUNTERTO)
		local sg2=g2:Select(tp,1,1,tc1)
		Duel.HintSelection(sg2)
		local tc2=sg2:GetFirst()
		tc2:AddCounter(tp,COUNTER_DAMAGE,damc,REASON_ATTACK)
	until g1:GetCount()==0 or not Duel.SelectYesNo(tp,YESNOMSG_REMOVECOUNTERAGAIN)
end
--get effect
function scard.tlfilter(c)
	return c:IsEnergy() and c:IsAbleToLost()
end
function scard.op2(e,tp,eg,ep,ev,re,r,rp)
	local c=e:GetHandler()
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_TOLZONE)
	local g=c:GetAttachedGroup():FilterSelect(tp,scard.tlfilter,2,2,nil)
	if g:GetCount()==0 then return end
	Duel.SendtoLost(g,REASON_ATTACK)
	--send replace (to lost zone)
	local e1=Effect.CreateEffect(c)
	e1:SetType(EFFECT_TYPE_SINGLE+EFFECT_TYPE_CONTINUOUS)
	e1:SetCode(EFFECT_SEND_REPLACE)
	e1:SetTarget(scard.tg1)
	e1:SetOperation(scard.op3)
	e1:SetReset(RESET_EVENT+RESETS_STANDARD+RESET_PHASE+PHASE_DAMAGE)
	Duel.GetActivePokemon(1-tp):RegisterEffect(e1)
	Duel.AttackDamage(e,100)
end
--send replace (to lost zone)
function scard.tg1(e,tp,eg,ep,ev,re,r,rp,chk)
	local c=e:GetHandler()
	if chk==0 then return c:GetDestination()==LOCATION_DPILE and c:IsReason(REASON_ATTACK) end
	local g=Group.FromCards(c)
	g:Merge(c:GetAttachedGroup())
	g:KeepAlive()
	e:SetLabelObject(g)
	return true
end
function scard.op3(e,tp,eg,ep,ev,re,r,rp)
	Duel.SendtoLost(e:GetLabelObject(),REASON_ATTACK)
end
--[[
	Rulings
		This card's Japanese name doesn't contain わるい (Dark).

		Q. When using Darkrai & Cresselia LEGEND's "Moon's Invite" attack, can you move damage counters to/from more than
		one Pokemon?
		A. Yes. Basically the attack let's you rearrange your opponent's damage counters any way you want, as long as
		other effects, Poke-POWERs, Poke-BODYs, etc. will allow. (HS:Triumphant FAQ; Nov 4, 2010 PUI Rules Team)

		Q. When using Darkrai & Cresselia LEGEND's "Moon's Invite" attack, can you put more damage counters on a Pokemon
		than it has HP left?
		A. Yes, you can put as many on a Pokemon as you want to, as long as you have enough to move, of course.
		(HS:Triumphant FAQ; Nov 4, 2010 PUI Rules Team)
		http://compendium.pokegym.net/compendium-bw.html#63
]]
