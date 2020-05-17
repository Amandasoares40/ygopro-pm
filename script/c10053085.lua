--Rayquaza-EX (Dragons Exalted 85/124)
local scard,sid=aux.GetID()
function scard.initial_effect(c)
	--pokemon
	aux.EnablePokemonAttribute(c)
	--discard deck, attach
	local e1=aux.AddPokemonAttack(c,0,nil,scard.op1)
	e1:SetAttackCost(ENERGY_C)
	--discard energy
	local e2=aux.AddPokemonAttack(c,1,nil,scard.op2)
	e2:SetAttackCost(ENERGY_R,ENERGY_L)
end
scard.pokemon_basic=true
scard.pokemon_ex=true
scard.mega_evolution_list={CARD_RAYQUAZA_EX,CARD_M_RAYQUAZA_EX}
scard.weakness_x2={ENERGY_N}
--discard deck, attach
function scard.atfilter(c,tc)
	return c:IsEnergy() and c:CheckAttachedTarget(tc)
end
function scard.op1(e,tp,eg,ep,ev,re,r,rp)
	Duel.DiscardDeck(tp,3,REASON_ATTACK)
	local g=Duel.GetOperatedGroup():Filter(scard.atfilter,nil,e:GetHandler())
	if g:GetCount()>0 then
		Duel.Attach(e,e:GetHandler(),g)
	end
end
--discard energy
function scard.cfilter(c,energy)
	return c:IsBasicEnergy() and c:IsEnergy(energy)
end
function scard.op2(e,tp,eg,ep,ev,re,r,rp)
	local dam=60
	local c=e:GetHandler()
	local b1=c:GetAttachedGroup():IsExists(scard.cfilter,1,nil,ENERGY_R)
	local b2=c:GetAttachedGroup():IsExists(scard.cfilter,1,nil,ENERGY_L)
	local option_list={}
	local t={}
	if b1 then
		table.insert(option_list,aux.Stringid(sid,2))
		table.insert(t,1)
	end
	if b2 then
		table.insert(option_list,aux.Stringid(sid,3))
		table.insert(t,2)
	end
	local opt=t[Duel.SelectOption(tp,table.unpack(option_list))+1]
	local g=nil
	if opt==1 then
		g=c:GetAttachedGroup():Filter(scard.cfilter,nil,ENERGY_R)
	elseif opt==2 then
		g=c:GetAttachedGroup():Filter(scard.cfilter,nil,ENERGY_L)
	end
	dam=dam*Duel.SendtoDPile(g,REASON_ATTACK+REASON_DISCARD)
	Duel.AttackDamage(e,dam)
end
