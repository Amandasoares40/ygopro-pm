--Gardevoir ex (Dragon Frontiers 93/101)
local scard,sid=aux.GetID()
function scard.initial_effect(c)
	aux.AddSetcode(c,SETNAME_DELTA)
	--pokemon
	aux.EnablePokemonAttribute(c)
	--evolution
	aux.EnableEvolutionAttribute(c)
	--poke-power (add marker, get effect)
	local e1=Effect.CreateEffect(c)
	e1:SetDescription(aux.Stringid(sid,0))
	e1:SetCategory(CATEGORY_POKEPOWER)
	e1:SetType(EFFECT_TYPE_IGNITION)
	e1:SetRange(LOCATION_ACTIVE)
	e1:SetCountLimit(1)
	e1:SetCondition(aux.AND(aux.NotAffectedBySpecialCondition,aux.SelfActiveCondition))
	e1:SetTarget(aux.CheckCardFunction(scard.markfilter,0,LOCATION_INPLAY))
	e1:SetOperation(scard.op1)
	c:RegisterEffect(e1)
	--move energy
	local e2=aux.AddPokemonAttack(c,1,nil,scard.op2)
	e2:SetAttackCost(ENERGY_R,ENERGY_C,ENERGY_C)
end
scard.pokemon_evolution=TYPE_STAGE_2
scard.pokemon_ex_old=true
scard.evolves_from=CARD_KIRLIA
scard.evolution_list2={["Basic"]=CARD_RALTS,["Stage 1"]=CARD_KIRLIA,["Stage 2"]=CARD_GARDEVOIR_EX_OLD}
scard.weakness_x2={ENERGY_P}
--poke-power (add marker, get effect)
function scard.markfilter(c)
	return c:IsFaceup() and c:IsPokemon()
end
function scard.op1(e,tp,eg,ep,ev,re,r,rp)
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_ADDMARKER)
	local g=Duel.SelectMatchingCard(tp,scard.markfilter,tp,0,LOCATION_INPLAY,1,1,nil)
	if g:GetCount()==0 then return end
	Duel.HintSelection(g)
	local tc=g:GetFirst()
	tc:AddMarker(tp,MARKER_IMPRISON,1,REASON_EFFECT)
	--disable poke-power
	local e1=Effect.CreateEffect(e:GetHandler())
	e1:SetDescription(DESC_CANNOT_USE_POKEPOWER)
	e1:SetType(EFFECT_TYPE_SINGLE)
	e1:SetCode(EFFECT_DISABLE_POKEPOWER)
	e1:SetProperty(EFFECT_FLAG_CLIENT_HINT)
	e1:SetCondition(scard.con1)
	e1:SetReset(RESET_EVENT+RESETS_STANDARD)
	tc:RegisterEffect(e1)
	--disable poke-body
	local e2=e1:Clone()
	e2:SetDescription(DESC_CANNOT_USE_POKEBODY)
	e2:SetCode(EFFECT_DISABLE_POKEBODY)
	e2:SetCondition(scard.con2)
	tc:RegisterEffect(e2)
end
--disable poke-power
function scard.con1(e)
	local c=e:GetHandler()
	return c:GetMarker(MARKER_IMPRISON)>0 and c:IsHasPokePower()
end
--disable poke-body
function scard.con2(e)
	local c=e:GetHandler()
	return c:GetMarker(MARKER_IMPRISON)>0 and c:IsHasPokeBody()
end
--move energy
function scard.cfilter(c,tp)
	return c:IsEnergy(ENERGY_R) and Duel.GetBenchedPokemon(tp):IsExists(scard.mefilter,1,nil,c)
end
function scard.mefilter(c,tc)
	return true--tc:CheckAttachedTarget(c)
end
function scard.op2(e,tp,eg,ep,ev,re,r,rp)
	Duel.AttackDamage(e,80)
	local g=e:GetHandler():GetAttachedGroup():Filter(scard.cfilter,nil,tp)
	if g:GetCount()==0 or not Duel.SelectYesNo(tp,YESNOMSG_REMOVEENERGY) then return end
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_MOVEENERGY)
	local sg1=g:Select(tp,1,1,nil)
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_MOVEENERGYTO)
	local sg2=Duel.GetBenchedPokemon(tp):FilterSelect(tp,scard.mefilter,1,1,nil,sg1:GetFirst())
	Duel.HintSelection(sg2)
	Duel.MoveEnergy(sg2:GetFirst(),sg1)
end
--[[
	Rulings
		Q. I realize that Imprison markers remain if Garvevoir-EX leaves play, but does the effect of "Imprison" still
		remain in that the Pokémon cannot use any Poké-POWERS or Poké-BODIES?
		A. Yes, even if Gardevoir-EX leaves play the effects of "Imprison" still apply to any Pokémon that have Imprison
		markers on them. (Nov 16, 2006 PUI Rules Team)
		http://compendium.pokegym.net/compendium-ex.html#ppowers
]]
