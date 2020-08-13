--Team Aqua's Sharpedo (Double Crisis 21/34)
local scard,sid=aux.GetID()
function scard.initial_effect(c)
	aux.AddSetcode(c,SETNAME_TEAM_AQUA,SETNAME_OWNER)
	aux.AddHeight(c,5.11)
	--pokemon
	aux.EnablePokemonAttribute(c)
	--evolution
	aux.EnableEvolutionAttribute(c)
	--ability (search - to hand)
	local e1=Effect.CreateEffect(c)
	e1:SetDescription(aux.Stringid(sid,0))
	e1:SetCategory(CATEGORY_ABILITY)
	e1:SetType(EFFECT_TYPE_IGNITION)
	e1:SetRange(LOCATION_INPLAY)
	e1:SetCountLimit(1)
	e1:SetTarget(aux.CheckDeckFunction(PLAYER_SELF))
	e1:SetOperation(scard.op1)
	c:RegisterEffect(e1)
	--damage
	local e2=aux.AddPokemonAttack(c,1,nil,aux.AttackDamageOperation(70))
	e2:SetAttackCost(ENERGY_D,ENERGY_C,ENERGY_C)
end
scard.pokemon_evolution=TYPE_STAGE_1
scard.evolves_from=CARD_TEAM_AQUAS_CARVANHA
scard.evolution_list1={["Basic"]=CARD_TEAM_AQUAS_CARVANHA,["Stage 1"]=CARD_TEAM_AQUAS_SHARPEDO}
scard.weakness_x2={ENERGY_L}
--ability (search - to hand)
function scard.thfilter(c)
	return c:IsPokemon() and c:IsSetCard(SETNAME_TEAM_AQUA) and c:IsAbleToHand()
end
function scard.op1(e,tp,eg,ep,ev,re,r,rp)
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_ATOHAND)
	local g=Duel.SelectMatchingCard(tp,scard.thfilter,tp,LOCATION_DECK,0,0,1,nil)
	if g:GetCount()>0 then
		Duel.SendtoHand(g,PLAYER_OWNER,REASON_ABILITY)
		Duel.ConfirmCards(1-tp,g)
	else
		Duel.ShuffleDeck(tp)
	end
end
