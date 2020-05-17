--Mr. Mime (Mysterious Treasures 30/123)
local scard,sid=aux.GetID()
function scard.initial_effect(c)
	--pokemon
	aux.EnablePokemonAttribute(c)
	--poke-body (immune to attack damage)
	local e1=Effect.CreateEffect(c)
	e1:SetCategory(CATEGORY_POKEBODY)
	e1:SetType(EFFECT_TYPE_SINGLE)
	e1:SetCode(EFFECT_IMMUNE_ATTACK_DAMAGE)
	e1:SetRange(LOCATION_INPLAY)
	e1:SetCondition(scard.con1)
	c:RegisterEffect(e1)
	--poke-body (immune to attacks)
	local e2=e1:Clone()
	e2:SetCode(EFFECT_IMMUNE_EFFECT)
	e2:SetCondition(scard.con2)
	e2:SetValue(aux.AttackImmuneFilter)
	c:RegisterEffect(e2)
	--guess coin (damage)
	local e3=aux.AddPokemonAttack(c,0,nil,scard.op1)
	e3:SetAttackCost(ENERGY_P,ENERGY_C)
end
scard.pokemon_basic=true
scard.height=4.03
scard.evolution_list1={["Baby"]=CARD_MIME_JR,["Basic"]=CARD_MR_MIME}
scard.weakness_20={ENERGY_P}
--poke-body (immune to attack damage)
function scard.con1(e)
	local tp=e:GetHandlerPlayer()
	local tc=Duel.GetActivePokemon(1-tp)
	return Duel.GetTurnPlayer()~=tp and tc and tc:GetAttachedGroup():FilterCount(Card.IsEnergy,nil)<=2
end
--poke-body (immune to attacks)
function scard.con2(e)
	return scard.con1(e) and e:GetHandler():GetAttachedGroup():IsExists(Card.IsCode,1,nil,CARD_MIME_JR)
end
--guess coin (damage)
function scard.op1(e,tp,eg,ep,ev,re,r,rp)
	local opt1=1
	if Duel.SelectYesNo(tp,YESNOMSG_HEADS) then opt1=0 end
	Duel.Hint(HINT_SELECTMSG,1-tp,HINTMSG_COIN)
	local opt2=Duel.SelectOption(1-tp,OPTION_HEADS,OPTION_TAILS)
	local guessed_wrong=opt2~=opt1
	if guessed_wrong then
		Duel.AttackDamage(e,50,Duel.GetActivePokemon(1-tp))
	else
		Duel.AttackDamage(e,20,e:GetHandler(),false,false)
	end
end
