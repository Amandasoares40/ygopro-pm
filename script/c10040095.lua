--Team Galactic's Invention G-107 Technical Machine G (Rising Rivals 95/111)
local scard,sid=aux.GetID()
function scard.initial_effect(c)
	aux.AddSetcode(c,SETNAME_TEAM_GALACTICS_INVENTION)
	--technical machine
	aux.EnableTechnicalMachineAttribute(c,Card.IsPokemonSP)
	--gain attack (damage)
	local e1=aux.AddTrainerAttack(c,0,nil,scard.op1,nil,aux.SelfPokemonSPCondition)
	e1:SetAttackCost(ENERGY_C,ENERGY_C,ENERGY_C)
	aux.AddAttachedDescription(c,aux.Stringid(sid,1),aux.SelfPokemonSPCondition)
end
scard.trainer_item=TYPE_TECHNICAL_MACHINE
--gain attack (damage)
function scard.op1(e,tp,eg,ep,ev,re,r,rp)
	local dam=e:GetHandler():GetCounter(COUNTER_DAMAGE)
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_DAMAGE)
	local g=Duel.GetInPlayPokemon(1-tp):Select(tp,1,1,nil)
	if g:GetCount()==0 then return end
	Duel.HintSelection(g)
	Duel.AttackDamage(e,10*dam,g:GetFirst())
end
