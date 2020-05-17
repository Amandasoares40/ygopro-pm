--_____'s Pikachu (Black Star Promo Wizards of the Coast 24)
local scard,sid=aux.GetID()
function scard.initial_effect(c)
	--pokemon
	aux.EnablePokemonAttribute(c)
	--damage
	local e1=aux.AddPokemonAttack(c,0,nil,scard.op1)
	e1:SetAttackCost(ENERGY_L,ENERGY_L)
end
scard.pokemon_basic=true
scard.length=1.40
scard.weakness_x2={ENERGY_F}
--damage
function scard.op1(e,tp,eg,ep,ev,re,r,rp)
	local dam=30
	Duel.Hint(HINT_SELECTMSG,tp,aux.Stringid(sid,1))
	local month=Duel.AnnounceNumber(tp,1,2,3,4,5,6,7,8,9,10,11,12)
	Duel.Hint(HINT_SELECTMSG,tp,aux.Stringid(sid,2))
	local day=Duel.AnnounceNumber(tp,1,2,3,4,5,6,7,8,9,10,11,12,13,14,15,16,17,18,19,20,21,22,23,24,25,26,27,28,29,30,31)
	local m,d=scard.GetDate()
	if m==month and d==day and Duel.TossCoin(tp,1)==RESULT_HEADS then dam=dam+50 end
	Duel.AttackDamage(e,dam)
end
function scard.GetDate()
	local date=os.date("*t")
	return date.month,date.day
end
