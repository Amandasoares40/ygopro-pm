--Helix Fossil (Majestic Dawn 91/100)
local scard,sid=aux.GetID()
function scard.initial_effect(c)
	aux.AddSetcode(c,SETNAME_FOSSIL)
	--play trainer as pokemon
	aux.PlayTrainerFunction(c,aux.PlayTrainerPokemonTarget(50,SETNAME_FOSSIL),aux.PlayTrainerPokemonOperation(50,SETNAME_FOSSIL,true,true,false))
	--poke-body (search - evolve)
	local e1=Effect.CreateEffect(c)
	e1:SetDescription(aux.Stringid(sid,0))
	e1:SetCategory(CATEGORY_POKEBODY)
	e1:SetType(EFFECT_TYPE_FIELD+EFFECT_TYPE_TRIGGER_F)
	e1:SetCode(EVENT_CUSTOM+EVENT_ATTACH)
	e1:SetRange(LOCATION_INPLAY)
	e1:SetCondition(scard.con1)
	e1:SetTarget(aux.HintTarget)
	e1:SetOperation(scard.op1)
	c:RegisterEffect(e1)
end
scard.trainer_item=true
scard.evolution_list1={["Basic"]=CARD_HELIX_FOSSIL,["Stage 1"]=CARD_OMANYTE_MD69,["Stage 2"]=CARD_OMASTAR}
scard.break_evolution_list={CARD_OMASTAR,CARD_OMASTAR_BREAK}
--poke-body (search - evolve)
function scard.cfilter(c,tc)
	return c:IsEnergy(ENERGY_W) and c:IsPlayedFromHand() and c:GetAttachedTarget()==tc
end
function scard.con1(e,tp,eg,ep,ev,re,r,rp)
	return eg:IsExists(scard.cfilter,1,nil,e:GetHandler())
		and not re:IsHasCategory(CATEGORY_POKEPOWER+CATEGORY_POKEMON_ATTACK)
end
function scard.evofilter(c,e,tp,code)
	return c.evolves_from==code and c:IsCanBePlayed(e,SUMMON_TYPE_EVOLVE,tp,true,false)
end
function scard.op1(e,tp,eg,ep,ev,re,r,rp)
	local c=e:GetHandler()
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_EVOLVETO)
	local g=Duel.SelectMatchingCard(tp,scard.evofilter,tp,LOCATION_DECK,0,0,1,nil,e,tp,c:GetCode())
	if g:GetCount()>0 then
		Duel.Evolve(g:GetFirst(),c,tp)
	else
		Duel.ShuffleDeck(tp)
	end
end
