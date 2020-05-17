--Exp. Share (Next Destinies 87/99) (Alias)
local scard,sid=aux.GetID()
function scard.initial_effect(c)
	--pokemon tool
	aux.EnablePokemonToolAttribute(c)
	--move energy
	local e1=Effect.CreateEffect(c)
	e1:SetType(EFFECT_TYPE_ATTACHED+EFFECT_TYPE_FIELD+EFFECT_TYPE_CONTINUOUS)
	e1:SetCode(EVENT_ADJUST)
	e1:SetProperty(EFFECT_FLAG_CANNOT_DISABLE+EFFECT_FLAG_UNCOPYABLE)
	e1:SetOperation(scard.regop1)
	c:RegisterEffect(e1)
	local e2=Effect.CreateEffect(c)
	e2:SetDescription(aux.Stringid(sid,0))
	e2:SetType(EFFECT_TYPE_ATTACHED+EFFECT_TYPE_FIELD+EFFECT_TYPE_TRIGGER_F)
	e2:SetCode(EVENT_KNOCKED_OUT)
	e2:SetProperty(EFFECT_FLAG_CANNOT_DISABLE+EFFECT_FLAG_UNCOPYABLE+EFFECT_FLAG_DAMAGE_STEP)
	e2:SetCondition(scard.con1)
	e2:SetTarget(aux.HintTarget)
	e2:SetOperation(scard.op1)
	c:RegisterEffect(e2)
end
scard.trainer_item=TYPE_POKEMON_TOOL
--move energy
function scard.regop1(e,tp,eg,ep,ev,re,r,rp)
	local c=e:GetHandler()
	if not c or c:IsActive() or c:IsStatus(STATUS_KNOCK_OUT_CONFIRMED) then return end
	local tc=Duel.GetActivePokemon(c:GetControler())
	if tc and tc:GetFlagEffect(sid)==0 then
		tc:RegisterFlagEffect(sid,RESET_EVENT+RESET_TOFIELD,0,1)
	end
	local g=tc:GetAttachedGroup()
	for ac in aux.Next(g) do
		if ac:GetFlagEffect(sid)==0 then
			ac:RegisterFlagEffect(sid,RESET_EVENT+RESET_ATTACH,0,1)
		end
	end
end
function scard.cfilter(c)
	return c:IsReason(REASON_ATTACK+REASON_DAMAGE) and c:GetFlagEffect(sid)>0
end
function scard.con1(e,tp,eg,ep,ev,re,r,rp)
	return rp==1-tp and eg:IsExists(scard.cfilter,1,e:GetHandler())
end
function scard.mefilter(c,tc)
	return c:IsBasicEnergy() and c:GetFlagEffect(sid)>0 --and c:CheckAttachedTarget(tc)
end
function scard.op1(e,tp,eg,ep,ev,re,r,rp)
	local g=Duel.GetMatchingGroup(scard.mefilter,tp,LOCATION_ALL,0,nil,e:GetHandler())
	if g:GetCount()==0 or not Duel.SelectYesNo(tp,YESNOMSG_MOVEENERGY) then return end
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_MOVEENERGY)
	local sg=g:Select(tp,1,1,nil)
	if sg:GetCount()>0 then
		Duel.MoveEnergy(e:GetHandler(),sg)
	end
end
--[[
	Rulings
		Despite the change in the card's name for the Next Destinies print, it was ruled that "EXP.ALL" and "Exp. Share"
		are the same card in the English-language printings, with all old "EXP.ALL" printings considered to have the name
		of "Exp. Share".
		https://bulbapedia.bulbagarden.net/wiki/EXP.ALL_(Neo_Destiny_93)

		Q. If a player with Exp. Share on a benched Pokemon has discarded their Active Pokemon and its attached energy due
		to KO from an attack and already promoted a new Active Pokemon, have they missed the opportunity to use Exp.
		Share?
		A. Promoting a new Active Pokemon takes place after the knockout, so at that point it would be too late to use
		Exp. Share. (Oct 27, 2016 TPCi Rules Team)

		Q. If my Yveltal with "Fright Night" Ability gets KO'd, am I then able to use Exp.Share on one of my Benched
		Pokemon to recover one of Yveltal's Basic Energy cards?
		A. Sorry, but no. Fright Night would still be working so Exp.Share would not enable before Yveltal hits the
		Discard Pile. (Jan 5, 2017 TPCi Rules Team)

		Q. Yveltal with "Fright Night" Ability knocks out Wobbuffet with the "Bide Barricade" Ability which was turning
		"Fright Night" off. Does Exp. Share on the Benched Pokemon behind Wobbuffet work?
		A. Yes, since Wobbuffet was not yet in the Discard Pile, Fright Night remains off and Exp. Share works.
		(Apr 20, 2017 TPCi Rules Team)

		Q. Say I have an Active Pokemon with Energy Pouch attached and a Benched Pokemon with Exp. Share attached. If the
		Active Pokemon is KO'd, how do the effects of the tools resolve?
		A. You may choose the order in which the tools' effects resolve. There is no preference of one tool over the other
		in this situation. (Apr 20, 2017 TPCi Rules Team)
		https://compendium.pokegym.net/compendium-bw.html#490
]]
