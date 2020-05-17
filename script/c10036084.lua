--Old Amber (Majestic Dawn 84/100)
local scard,sid=aux.GetID()
function scard.initial_effect(c)
	--play trainer as pokemon
	aux.PlayTrainerFunction(c,aux.PlayTrainerPokemonTarget(50),aux.PlayTrainerPokemonOperation(50,0,true,true,false))
	--poke-body (immune to attack damage)
	local e1=Effect.CreateEffect(c)
	e1:SetCategory(CATEGORY_POKEBODY)
	e1:SetType(EFFECT_TYPE_SINGLE)
	e1:SetCode(EFFECT_IMMUNE_ATTACK_DAMAGE)
	e1:SetRange(LOCATION_INPLAY)
	e1:SetCondition(aux.SelfBenchedCondition)
	c:RegisterEffect(e1)
end
scard.trainer_item=true
scard.evolution_list1={["Basic"]=CARD_OLD_AMBER,["Stage 1"]=CARD_AERODACTYL_MD15}
