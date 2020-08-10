--Primal Kyogre-EX (Primal Clash 55/160)
local scard,sid=aux.GetID()
function scard.initial_effect(c)
	--pokemon
	aux.EnablePokemonAttribute(c)
	--evolution
	aux.EnableEvolutionAttribute(c)
	--ancient trait (attach)
	local e1=Effect.CreateEffect(c)
	e1:SetDescription(aux.Stringid(sid,0))
	e1:SetType(EFFECT_TYPE_SINGLE+EFFECT_TYPE_CONTINUOUS)
	e1:SetCode(EVENT_CUSTOM+EVENT_ATTACH)
	e1:SetCondition(scard.con1)
	e1:SetOperation(scard.op1)
	c:RegisterEffect(e1)
	--move energy
	local e2=aux.AddPokemonAttack(c,1,nil,scard.op2)
	e2:SetAttackCost(ENERGY_W,ENERGY_W,ENERGY_W,ENERGY_C)
end
scard.pokemon_evolution=TYPE_MEGA
scard.pokemon_ex=true
scard.evolves_from=CARD_KYOGRE_EX
scard.mega_evolution_list={CARD_KYOGRE_EX,CARD_PRIMAL_KYOGRE_EX}
scard.weakness_x2={ENERGY_G}
--ancient trait (attach)
function scard.con1(e,tp,eg,ep,ev,re,r,rp)
	local rc=re:GetHandler()
	return rc:IsEnergy() and rc:IsPlayedFromHand()
		and not re:IsHasCategory(CATEGORY_POKEMON_ATTACK+CATEGORY_ABILITY)
end
function scard.atfilter(c,tc)
	return c:IsEnergy() and c:CheckAttachedTarget(tc)
end
function scard.op1(e,tp,eg,ep,ev,re,r,rp)
	local c=e:GetHandler()
	local g=Duel.GetMatchingGroup(scard.atfilter,tp,LOCATION_HAND,0,nil,c)
	if g:GetCount()==0 or not Duel.SelectYesNo(tp,YESNOMSG_ATTACHENERGYAGAIN) then return end
	Duel.Hint(HINT_CARD,0,c:GetOriginalCode())
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_ATTACHENERGY)
	local sg=g:Select(tp,1,1,nil)
	Duel.Attach(e,c,sg)
end
--move energy
function scard.cfilter(c,tp)
	return c:IsEnergy() and Duel.GetBenchedPokemon(tp):IsExists(scard.mefilter,1,nil,c)
end
function scard.mefilter(c,tc)
	return true--tc:CheckAttachedTarget(c)
end
function scard.op2(e,tp,eg,ep,ev,re,r,rp)
	Duel.AttackDamage(e,150)
	local g1=e:GetHandler():GetAttachedGroup():Filter(scard.cfilter,nil,tp)
	if g1:GetCount()==0 then return end
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_MOVEENERGY)
	local sg1=g1:Select(tp,2,2,nil)
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_MOVEENERGYTO)
	local sg2=Duel.GetBenchedPokemon(tp):FilterSelect(tp,scard.mefilter,1,1,nil,sg1:GetFirst())
	Duel.HintSelection(sg2)
	Duel.MoveEnergy(sg2:GetFirst(),sg1)
	local g2=Duel.GetBenchedPokemon(1-tp):Filter(Card.IsPokemonEX,nil)
	for tc in aux.Next(g2) do
		Duel.AttackDamage(e,30,tc)
	end
end
--[[
	Rulings
	Q. The "Alpha Growth" Ancient Trait says "When you attach an Energy card from your hand to this Pokemon... you may
	attach 2 Energy cards." Does that mean I get to attach one additional Energy card or two additional Energy cards?
	A. You only get to attach one additional Energy card, for a total of two cards attached at that time.
	(Primal Clash FAQ; Feb 5, 2015 TPCi Rules Team)
	https://compendium.pokegym.net/compendium-bw.html#380
]]
