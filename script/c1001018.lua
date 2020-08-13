--Team Rocket's Meowth (Black Star Promo Wizards of the Coast 18)
local scard,sid=aux.GetID()
function scard.initial_effect(c)
	aux.AddSetcode(c,SETNAME_ROCKETS,SETNAME_OWNER)
	aux.AddLength(c,1.40)
	--pokemon
	aux.EnablePokemonAttribute(c)
	--damage
	local e1=aux.AddPokemonAttack(c,0,nil,scard.op1)
	e1:SetAttackCost(ENERGY_C)
end
scard.pokemon_basic=true
scard.weakness_x2={ENERGY_F}
scard.resistance_30={ENERGY_P}
--damage
function scard.op1(e,tp,eg,ep,ev,re,r,rp)
	local ct1=0
	local ct2=0
	for i=1,Duel.GetInPlayPokemon():GetCount() do
		local res=Duel.TossCoin(tp,1)
		if res==RESULT_HEADS then
			ct1=ct1+1
		elseif res==RESULT_TAILS then
			ct2=ct2+1
		end
	end
	Duel.AttackDamage(e,10*ct1)
	Duel.AttackDamage(e,10*ct2,e:GetHandler())
end
