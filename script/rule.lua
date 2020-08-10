Rule={}
--register rules
--Not fully implemented: Cannot change turn counter to 1 during sudden death
function Rule.RegisterRules(c)
	local e1=Effect.CreateEffect(c)
	e1:SetProperty(EFFECT_FLAG_CANNOT_DISABLE+EFFECT_FLAG_UNCOPYABLE+EFFECT_FLAG_IGNORE_IMMUNE+EFFECT_FLAG_NO_TURN_RESET)
	e1:SetType(EFFECT_TYPE_FIELD+EFFECT_TYPE_CONTINUOUS)
	e1:SetCode(EVENT_ADJUST)
	e1:SetRange(LOCATION_ALL)
	e1:SetCountLimit(1)
	e1:SetOperation(Rule.ApplyRules)
	c:RegisterEffect(e1)
end
function Rule.LegendFilter1(c,tp)
	return Duel.IsExistingMatchingCard(Rule.LegendFilter2,tp,LOCATION_HAND+LOCATION_DECK,0,1,nil,c:GetOriginalCode())
end
function Rule.LegendFilter2(c,code)
	return c:IsPokemonLEGEND() and c.legend_top_half==code
end
function Rule.LegendFilter3(c,tp)
	return Duel.IsExistingMatchingCard(Rule.LegendFilter4,tp,LOCATION_HAND+LOCATION_DECK,0,1,nil,c:GetOriginalCode())
end
function Rule.LegendFilter4(c,code)
	return c:IsPokemonLEGEND() and c.legend_bottom_half==code
end
function Rule.ApplyRules(e,tp,eg,ep,ev,re,r,rp)
	if Duel.GetFlagEffect(PLAYER_ONE,10000000)>0 then return end
	Duel.RegisterFlagEffect(PLAYER_ONE,10000000,0,0,0)
	--remove rules
	Rule.remove_rules(PLAYER_ONE)
	Rule.remove_rules(PLAYER_TWO)
	--check deck size
	local ct1=Duel.GetFieldGroupCount(PLAYER_ONE,LOCATION_HAND,0)+Duel.GetFieldGroupCount(PLAYER_ONE,LOCATION_DECK,0)
	local ct2=Duel.GetFieldGroupCount(PLAYER_TWO,LOCATION_HAND,0)+Duel.GetFieldGroupCount(PLAYER_TWO,LOCATION_DECK,0)
	local b1=(ct1~=60 and ct1~=30) or (ct1==60 and ct2==30)
	local b2=(ct2~=60 and ct2~=30) or (ct1==60 and ct2==30)
	--check for basic pokemon
	local b3=Duel.GetMatchingGroupCount(Card.IsBasicPokemon,PLAYER_ONE,LOCATION_HAND+LOCATION_DECK,0,nil)==0
	local b4=Duel.GetMatchingGroupCount(Card.IsBasicPokemon,PLAYER_TWO,LOCATION_HAND+LOCATION_DECK,0,nil)==0
	--check for restricted cards
	local b5=Duel.GetMatchingGroupCount(Card.IsCode,PLAYER_ONE,LOCATION_HAND+LOCATION_DECK,0,nil,CARD_MIRACLE_ENERGY)>1
	local b6=Duel.GetMatchingGroupCount(Card.IsCode,PLAYER_TWO,LOCATION_HAND+LOCATION_DECK,0,nil,CARD_MIRACLE_ENERGY)>1
	local b7=Duel.GetMatchingGroupCount(Card.IsPokemonStar,PLAYER_ONE,LOCATION_HAND+LOCATION_DECK,0,nil)>1
	local b8=Duel.GetMatchingGroupCount(Card.IsPokemonStar,PLAYER_TWO,LOCATION_HAND+LOCATION_DECK,0,nil)>1
	local b9=Duel.GetMatchingGroupCount(Card.IsACESPEC,PLAYER_ONE,LOCATION_HAND+LOCATION_DECK,0,nil)>1
	local b10=Duel.GetMatchingGroupCount(Card.IsACESPEC,PLAYER_TWO,LOCATION_HAND+LOCATION_DECK,0,nil)>1
	--check for pokemon legend
	local lct1=Duel.GetMatchingGroupCount(Rule.LegendFilter1,PLAYER_ONE,LOCATION_HAND+LOCATION_DECK,0,nil,0)
	local lct2=Duel.GetMatchingGroupCount(Rule.LegendFilter3,PLAYER_ONE,LOCATION_HAND+LOCATION_DECK,0,nil,0)
	local b11=lct1+lct2>4
	local lct3=Duel.GetMatchingGroupCount(Rule.LegendFilter1,PLAYER_TWO,LOCATION_HAND+LOCATION_DECK,0,nil,1)
	local lct4=Duel.GetMatchingGroupCount(Rule.LegendFilter3,PLAYER_TWO,LOCATION_HAND+LOCATION_DECK,0,nil,1)
	local b12=lct3+lct4>4
	--check for clone cards
	local f=function(c)
		return c.clone
	end
	local b13=Duel.GetMatchingGroup(f,PLAYER_ONE,LOCATION_HAND+LOCATION_DECK,0,nil):GetClassCount(Card.GetCode)>1
	local b14=Duel.GetMatchingGroup(f,PLAYER_TWO,LOCATION_HAND+LOCATION_DECK,0,nil):GetClassCount(Card.GetCode)>1
	if b1 then Duel.Hint(HINT_MESSAGE,PLAYER_ONE,ERROR_DECKCOUNT) end
	if b2 then Duel.Hint(HINT_MESSAGE,PLAYER_TWO,ERROR_DECKCOUNT) end
	if b3 then Duel.Hint(HINT_MESSAGE,PLAYER_ONE,ERROR_BASICCOUNT) end
	if b4 then Duel.Hint(HINT_MESSAGE,PLAYER_TWO,ERROR_BASICCOUNT) end
	if b5 then Duel.Hint(HINT_MESSAGE,PLAYER_ONE,ERROR_MIRACLECOUNT) end
	if b6 then Duel.Hint(HINT_MESSAGE,PLAYER_TWO,ERROR_MIRACLECOUNT) end
	if b7 then Duel.Hint(HINT_MESSAGE,PLAYER_ONE,ERROR_STARCOUNT) end
	if b8 then Duel.Hint(HINT_MESSAGE,PLAYER_TWO,ERROR_STARCOUNT) end
	if b9 then Duel.Hint(HINT_MESSAGE,PLAYER_ONE,ERROR_ACESPECCOUNT) end
	if b10 then Duel.Hint(HINT_MESSAGE,PLAYER_TWO,ERROR_ACESPECCOUNT) end
	if b11 then Duel.Hint(HINT_MESSAGE,PLAYER_ONE,ERROR_LEGENDCOUNT) end
	if b12 then Duel.Hint(HINT_MESSAGE,PLAYER_TWO,ERROR_LEGENDCOUNT) end
	if b13 then Duel.Hint(HINT_MESSAGE,PLAYER_ONE,ERROR_CLONECOUNT) end
	if b14 then Duel.Hint(HINT_MESSAGE,PLAYER_TWO,ERROR_CLONECOUNT) end
	if (b1 and b2) or (b3 and b4) or (b5 and b6)
		or (b7 and b8) or (b9 and b10) or (b11 and b12) or (b13 and b14) then
		Duel.Win(PLAYER_NONE,WIN_REASON_INVALID)
		return
	elseif b1 or b3 or b5 or b7 or b9 or b11 or b13 then
		Duel.Win(PLAYER_TWO,WIN_REASON_INVALID)
		return
	elseif b2 or b4 or b6 or b8 or b10 or b12 or b14 then
		Duel.Win(PLAYER_ONE,WIN_REASON_INVALID)
		return
	end
	local c=e:GetHandler()
	--raise event for "Before you flip a coin to decide who goes first in a game"
	Duel.RaiseEvent(c,EVENT_CUSTOM+EVENT_PRE_GAME_START,e,0,0,0,0)
	--draw starting hand
	Rule.draw_starting_hand(PLAYER_ONE)
	Rule.draw_starting_hand(PLAYER_TWO)
	--check for basic pokemon
	Rule.check_basic_pokemon(PLAYER_ONE)
	Rule.check_basic_pokemon(PLAYER_TWO)
	--bench pokemon
	Rule.bench_pokemon(PLAYER_ONE)
	Rule.bench_pokemon(PLAYER_TWO)
	--check deck size to decide prize count
	local pct=6
	if ct1==30 and ct2==30 then pct=3 end
	--set prize cards
	Rule.set_prize_cards(PLAYER_ONE,pct)
	Rule.set_prize_cards(PLAYER_TWO,pct)
	--flip pokemon
	Rule.flip_pokemon()
	--draw extra cards
	Rule.draw_extra(PLAYER_ONE)
	Rule.draw_extra(PLAYER_TWO)
	--adjust hp
	local e1=Effect.GlobalEffect()
	e1:SetProperty(EFFECT_FLAG_IGNORE_IMMUNE)
	e1:SetType(EFFECT_TYPE_FIELD)
	e1:SetCode(EFFECT_SET_REMAINING_HP_FINAL)
	e1:SetTargetRange(LOCATION_INPLAY,LOCATION_INPLAY)
	e1:SetTarget(aux.NOT(aux.TargetBoolFunction(Card.IsHasEffect,EFFECT_SET_REMAINING_HP)))
	e1:SetValue(Rule.AdjustHPValue)
	Duel.RegisterEffect(e1,0)
	--promote
	local e2=Effect.GlobalEffect()
	e2:SetProperty(EFFECT_FLAG_IGNORE_IMMUNE)
	e2:SetDescription(DESC_PROMOTE)
	e2:SetType(EFFECT_TYPE_FIELD+EFFECT_TYPE_CONTINUOUS)
	e2:SetCode(EVENT_LEAVE_FIELD)
	e2:SetCondition(Rule.PromoteCondition)
	e2:SetOperation(Rule.PromoteOperation)
	Duel.RegisterEffect(e2,0)
	--take prize
	local e3=e2:Clone()
	e3:SetDescription(DESC_WIN_PRIZE)
	e3:SetCode(EVENT_KNOCKED_OUT)
	e3:SetCondition(Rule.TakePrizeCondition)
	e3:SetOperation(Rule.TakePrizeOperation)
	Duel.RegisterEffect(e3,0)
	--adjust lp
	local e4=Effect.GlobalEffect()
	e4:SetType(EFFECT_TYPE_FIELD+EFFECT_TYPE_CONTINUOUS)
	e4:SetCode(EVENT_ADJUST)
	e4:SetOperation(Rule.AdjustLPOperation)
	Duel.RegisterEffect(e4,0)
	--limit supporter
	local e5=Effect.GlobalEffect()
	e5:SetType(EFFECT_TYPE_FIELD+EFFECT_TYPE_CONTINUOUS)
	e5:SetCode(EVENT_CHAINING)
	e5:SetOperation(Rule.RegisterSupporter)
	Duel.RegisterEffect(e5,0)
	local e6=e5:Clone()
	e6:SetCode(EVENT_CHAIN_NEGATED)
	e6:SetOperation(Rule.ResetSupporter)
	Duel.RegisterEffect(e6,0)
	local e7=Effect.GlobalEffect()
	e7:SetProperty(EFFECT_FLAG_PLAYER_TARGET)
	e7:SetType(EFFECT_TYPE_FIELD)
	e7:SetCode(EFFECT_CANNOT_ACTIVATE)
	e7:SetTargetRange(1,0)
	e7:SetCondition(Rule.LimitSupporterCondition1)
	e7:SetValue(Rule.LimitSupporter)
	Duel.RegisterEffect(e7,0)
	local e8=e7:Clone()
	e8:SetTargetRange(0,1)
	e8:SetCondition(Rule.LimitSupporterCondition2)
	Duel.RegisterEffect(e8,0)
	--adjust special conditions
	local e9=Effect.GlobalEffect()
	e9:SetProperty(EFFECT_FLAG_IGNORE_IMMUNE)
	e9:SetType(EFFECT_TYPE_FIELD+EFFECT_TYPE_CONTINUOUS)
	e9:SetCode(EVENT_ADJUST)
	e9:SetOperation(Rule.AdjustSPCOperation1)
	Duel.RegisterEffect(e9,0)
	local e10=e9:Clone()
	e10:SetOperation(Rule.AdjustSPCOperation2)
	Duel.RegisterEffect(e10,0)
	--attack
	local e11=Effect.GlobalEffect()
	e11:SetProperty(EFFECT_FLAG_IGNORE_IMMUNE)
	e11:SetType(EFFECT_TYPE_FIELD+EFFECT_TYPE_CONTINUOUS)
	e11:SetCode(EVENT_PRE_ATTACK)
	e11:SetCondition(Rule.AttackCondition)
	e11:SetOperation(Rule.AttackOperation)
	Duel.RegisterEffect(e11,0)
	--end turn (attacked)
	local e12=Effect.GlobalEffect()
	e12:SetDescription(DESC_ATTACK_END_TURN)
	e12:SetType(EFFECT_TYPE_FIELD+EFFECT_TYPE_CONTINUOUS)
	e12:SetCode(EVENT_ATTACKED)
	e12:SetCondition(Rule.EndTurnCondition1)
	e12:SetOperation(Rule.EndTurnOperation)
	Duel.RegisterEffect(e12,0)
	--end turn (evolved)
	local e13=e12:Clone()
	e13:SetDescription(DESC_EVOLVE_END_TURN)
	e13:SetCode(EVENT_PLAY)
	e13:SetCondition(Rule.EndTurnCondition2)
	Duel.RegisterEffect(e13,0)
	--register gx attack
	local e14=e12:Clone()
	e14:SetCondition(Rule.RegisterGXAttackCondition)
	e14:SetOperation(Rule.RegisterGXAttackOperation)
	Duel.RegisterEffect(e14,0)
	--discard incompatible attached card
	local e15=Effect.GlobalEffect()
	e15:SetProperty(EFFECT_FLAG_IGNORE_IMMUNE)
	e15:SetType(EFFECT_TYPE_FIELD+EFFECT_TYPE_CONTINUOUS)
	e15:SetCode(EVENT_ADJUST)
	e15:SetOperation(Rule.DiscardAttachedOperation)
	Duel.RegisterEffect(e15,0)
	--prism star redirect
	local e16=Effect.GlobalEffect()
	e16:SetProperty(EFFECT_FLAG_IGNORE_IMMUNE+EFFECT_FLAG_SET_AVAILABLE+EFFECT_FLAG_IGNORE_RANGE)
	e16:SetType(EFFECT_TYPE_FIELD)
	e16:SetCode(EFFECT_TO_DPILE_REDIRECT)
	e16:SetTargetRange(LOCATION_ALL,LOCATION_ALL)
	e16:SetTarget(aux.TargetBoolFunction(Card.IsSetCard,SETNAME_PRISM_STAR))
	e16:SetValue(LOCATION_LZONE)
	Duel.RegisterEffect(e16,0)
	--win game
	local e17=Effect.GlobalEffect()
	e17:SetType(EFFECT_TYPE_FIELD+EFFECT_TYPE_CONTINUOUS)
	e17:SetCode(EVENT_ADJUST)
	e17:SetOperation(Rule.WinOperation)
	Duel.RegisterEffect(e17,0)
	--override yugioh rules
	--draw first turn
	Rule.draw_first_turn()
	--cannot summon
	Rule.cannot_summon()
	--cannot mset
	Rule.cannot_mset()
	--cannot sset
	Rule.cannot_sset()
	--activate quick-play in non-turn player's hand
	Rule.activate_quick_in_ntphand()
	--infinite hand
	Rule.infinite_hand()
	--cannot conduct battle phase
	Rule.cannot_battle_phase()
	--cannot change position
	Rule.cannot_change_position()
	--no battle damage
	Rule.avoid_battle_damage()
	--indestructible
	Rule.indestructible()
	--clear extra deck
	Rule.clear_extra_deck()
end
--remove rules
function Rule.remove_rules(tp)
	local g=Duel.GetMatchingGroup(Card.IsCode,tp,LOCATION_ALL,0,nil,10000000)
	if g:GetCount()==0 then return end
	Duel.DisableShuffleCheck()
	Duel.SendtoDeck(g,PLAYER_OWNER,SEQ_DECK_UNEXIST,REASON_RULE)
end
--draw starting hand
function Rule.draw_starting_hand(tp)
	local ct=Duel.GetFieldGroupCount(tp,LOCATION_HAND,0)
	if ct<7 then
		Duel.Draw(tp,7-ct,REASON_RULE)
	end
end
--play active pokemon
function Rule.play_active_pokemon(tp)
	if not Duel.CheckLocation(tp,LOCATION_ACTIVE,SEQ_MZONE_EX_LEFT) then return end
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_STARTACTIVE)
	local g=Duel.SelectMatchingCard(tp,Card.IsBasicPokemon,tp,LOCATION_HAND,0,1,1,nil)
	if g:GetCount()>0 then
		Duel.MoveToField(g:GetFirst(),tp,tp,LOCATION_ACTIVE,POS_FACEDOWN_UPSIDE,true,ZONE_MZONE_EX_LEFT)
	end
end
--check for basic pokemon
function Rule.check_basic_pokemon(tp)
	if not Duel.IsExistingMatchingCard(Card.IsBasicPokemon,tp,LOCATION_HAND,0,1,nil) then
		repeat
			local g=Duel.GetFieldGroup(tp,LOCATION_HAND,0)
			Duel.ConfirmCards(1-tp,g)
			Duel.SendtoDeck(g,PLAYER_OWNER,SEQ_DECK_SHUFFLE,REASON_RULE)
			Duel.ShuffleDeck(tp)
			Duel.BreakEffect()
			Duel.Draw(tp,7,REASON_RULE)
			--register mulligan
			Duel.RegisterFlagEffect(tp,EFFECT_MULLIGAN_CHECK,RESET_PHASE+PHASE_END,0,1)
		until Duel.IsExistingMatchingCard(Card.IsBasicPokemon,tp,LOCATION_HAND,0,1,nil)
	end
	Rule.play_active_pokemon(tp)
end
--bench pokemon
function Rule.bench_pokemon(tp)
	local ct=Duel.GetFreeBenchCount(tp)
	local g=Duel.GetMatchingGroup(Card.IsBasicPokemon,tp,LOCATION_HAND,0,nil)
	if ct<=0 or g:GetCount()==0 or not Duel.SelectYesNo(tp,YESNOMSG_STARTBENCH) then return end
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_STARTBENCH)
	local sg=g:Select(tp,1,ct,nil)
	for tc in aux.Next(sg) do
		Duel.MoveToField(tc,tp,tp,LOCATION_BENCH,POS_FACEDOWN_UPSIDE,true)
	end
end
--set prize cards
function Rule.set_prize_cards(tp,ct)
	local g=Duel.GetDecktopGroup(tp,ct)
	Duel.SendtoPrize(g,REASON_RULE)
end
--flip pokemon
function Rule.flip_pokemon()
	local g=Duel.GetMatchingGroup(Card.IsFacedown,0,LOCATION_INPLAY,LOCATION_INPLAY,nil)
	Duel.ChangePosition(g,POS_FACEUP_UPSIDE)
end
--draw extra cards
function Rule.draw_extra(tp)
	local mulligan_count=Duel.GetFlagEffect(1-tp,EFFECT_MULLIGAN_CHECK)
	if mulligan_count==0 or not Duel.SelectYesNo(tp,YESNOMSG_MULLIGAN) then return end
	local deck_count=Duel.GetFieldGroupCount(tp,LOCATION_DECK,0)
	if deck_count>mulligan_count then deck_count=mulligan_count end
	local t={}
	for i=1,deck_count do t[i]=i end
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_ANNOUNCEDRAW)
	local draw_count=Duel.AnnounceNumber(tp,table.unpack(t))
	Duel.Draw(tp,draw_count,REASON_RULE)
end
--adjust hp
function Rule.AdjustHPValue(e,c)
	return c:GetMaxHP()-c:GetDamage()
end
--promote
function Rule.PromoteFilter(c)
	return c:IsPreviousActive() and not c:IsRetreating()
end
function Rule.PromoteCondition(e,tp,eg,ep,ev,re,r,rp)
	return eg:IsExists(Rule.PromoteFilter,1,nil)
end
function Rule.PromoteOperation(e,tp,eg,ep,ev,re,r,rp)
	for ec in aux.Next(eg) do
		local op=ec:GetOwner()
		local g=Duel.GetBenchedPokemon(op)
		if g:GetCount()==0 then break end
		Duel.Hint(HINT_SELECTMSG,op,HINTMSG_PROMOTE)
		local sg=g:Select(op,1,1,nil)
		Duel.HintSelection(sg)
		Duel.MoveSequence(sg:GetFirst(),SEQ_MZONE_EX_LEFT)
	end
end
--take prize
function Rule.TakePrizeFilter(c)
	return (c:IsPokemon() or c:GetPreviousTypeOnField()==TYPE_POKEMON+TYPE_TRAINER)
		and c:IsPreviousLocation(LOCATION_INPLAY)
end
function Rule.TakePrizeCondition(e,tp,eg,ep,ev,re,r,rp)
	return eg:IsExists(Rule.TakePrizeFilter,1,nil)
end
function Rule.TakePrizeOperation(e,tp,eg,ep,ev,re,r,rp)
	for ec in aux.Next(eg) do
		if ec:IsHasEffect(EFFECT_CANNOT_TAKE_PRIZE) then break end
		local ct=ec:GetPrizeValue()
		if ec:IsPreviousActive() then
			if Duel.GetAttackingPokemon() then
				local t1={Duel.GetAttackingPokemon():IsHasEffect(EFFECT_ATTACK_UPDATE_PRIZE)}
				for _,te1 in pairs(t1) do
					ct=ct+te1:GetValue()
				end
			end
			local t2={ec:IsHasEffect(EFFECT_DEFEND_UPDATE_PRIZE)}
			for _,te2 in pairs(t2) do
				ct=ct+te2:GetValue()
			end
		end
		if ct<=0 then break end
		Duel.TakePrize(1-ec:GetOwner(),ct,ct,REASON_RULE)
	end
end
--adjust lp
function Rule.AdjustLPOperation(e,tp,eg,ep,ev,re,r,rp)
	local ct1=Duel.GetPrizeCount(PLAYER_ONE)
	local ct2=Duel.GetPrizeCount(PLAYER_TWO)
	if ct1==0 and ct2==0 then
		Rule.sudden_death()
		return
	end
	if Duel.GetLP(PLAYER_ONE)~=ct2 then Duel.SetLP(PLAYER_ONE,ct2) end
	if Duel.GetLP(PLAYER_TWO)~=ct1 then Duel.SetLP(PLAYER_TWO,ct1) end
end
--sudden death
function Rule.sudden_death()
	local g=Duel.GetFieldGroup(0,LOCATION_ALL-LOCATION_DECK,LOCATION_ALL-LOCATION_DECK)
	g:Sub(g:Filter(Card.IsCode,nil,10000000))
	g:Merge(Duel.GetAttachedGroup(0,1,1))
	local turnp=Duel.GetTurnPlayer()
	--reset game
	Duel.Hint(HINT_OPSELECTED,1-turnp,ERROR_SUDDENDEATH)
	Duel.SendtoDeck(g,PLAYER_OWNER,SEQ_DECK_SHUFFLE,REASON_RULE)
	Duel.ShuffleDeck(turnp)
	Duel.ShuffleDeck(1-turnp)
	Duel.ResetFlagEffect(turnp,EFFECT_PRIZE_CARD_CHECK)
	Duel.ResetFlagEffect(1-turnp,EFFECT_PRIZE_CARD_CHECK)
	Duel.ResetFlagEffect(turnp,EFFECT_GX_ATTACK_CHECK)
	Duel.ResetFlagEffect(1-turnp,EFFECT_GX_ATTACK_CHECK)
	--call the coin flip
	local opt=Duel.SelectOption(1-turnp,OPTION_HEADS,OPTION_TAILS)
	local res=Duel.TossCoin(turnp,1)
	local skipp=1-turnp
	if turnp==1-turnp and opt==res then skipp=turnp
	elseif turnp==turnp and opt==res then skipp=1-turnp end
	--skip to draw phase
	Duel.SkipPhase(skipp,PHASE_MAIN1,RESET_PHASE+PHASE_DRAW,1)
	--register Duel.IsFirstTurn
	Duel.RegisterFlagEffect(turnp,EFFECT_SUDDEN_DEATH_CHECK,RESET_PHASE+PHASE_END,0,1)
	--draw starting hand
	Rule.draw_starting_hand(turnp)
	Rule.draw_starting_hand(1-turnp)
	--check for basic pokemon
	Rule.check_basic_pokemon(turnp)
	Rule.check_basic_pokemon(1-turnp)
	--bench pokemon
	Rule.bench_pokemon(turnp)
	Rule.bench_pokemon(1-turnp)
	--check deck size to decide prize count
	local ct1=Duel.GetFieldGroupCount(turnp,LOCATION_HAND,0)+Duel.GetFieldGroupCount(turnp,LOCATION_DECK,0)
	local ct2=Duel.GetFieldGroupCount(1-turnp,LOCATION_HAND,0)+Duel.GetFieldGroupCount(1-turnp,LOCATION_DECK,0)
	local pct=6
	if ct1==30 and ct2==30 then pct=3 end
	--set prize cards
	Rule.set_prize_cards(turnp,pct)
	Rule.set_prize_cards(1-turnp,pct)
	--flip pokemon
	Rule.flip_pokemon()
	--draw extra cards
	Rule.draw_extra(turnp)
	Rule.draw_extra(1-turnp)
	--draw first turn
	Duel.Draw(turnp,1,REASON_RULE)
end
--limit supporter
function Rule.RegisterSupporter(e,tp,eg,ep,ev,re,r,rp)
	local rc=re:GetHandler()
	if re:IsHasType(EFFECT_TYPE_ACTIVATE) and rc:IsSupporter() then
		--register the played Supporter card for the turn
		Duel.RegisterFlagEffect(rc:GetControler(),EFFECT_SUPPORTER_CHECK,RESET_PHASE+PHASE_END,0,1)
	end
end
function Rule.ResetSupporter(e,tp,eg,ep,ev,re,r,rp)
	local rc=re:GetHandler()
	if re:IsHasType(EFFECT_TYPE_ACTIVATE) and rc:IsSupporter() then
		--reset the played Supporter card for the turn
		Duel.ResetFlagEffect(rc:GetControler(),EFFECT_SUPPORTER_CHECK)
	end
end
function Rule.LimitSupporterCondition1(e)
	return not Duel.IsPlayerCanPlaySupporter(e:GetHandlerPlayer())
end
function Rule.LimitSupporterCondition2(e)
	return not Duel.IsPlayerCanPlaySupporter(1-e:GetHandlerPlayer())
end
function Rule.LimitSupporter(e,re,tp)
	return re:IsHasType(EFFECT_TYPE_ACTIVATE) and re:GetHandler():IsSupporter()
end
--adjust special conditions
function Rule.AdjustSPCOperation1(e,tp,eg,ep,ev,re,r,rp)
	local g1=Duel.GetInPlayPokemon():Filter(Card.IsAffectedBySpecialCondition,nil)
	for c in aux.Next(g1) do
		--fix asleep position
		if c:IsAsleep() and not c:IsPosition(POS_FACEUP_CCW) then
			Duel.ChangePosition(c,POS_FACEUP_CCW)
		end
		--fix paralyzed position
		if c:IsParalyzed() and not c:IsPosition(POS_FACEUP_CW) then
			Duel.ChangePosition(c,POS_FACEUP_CW)
		end
	end
	local g2=Duel.GetBenchedPokemon():Filter(Card.IsAffectedBySpecialCondition,nil)
	for c in aux.Next(g2) do
		--remove all special conditions (benched)
		c:RemoveSpecialCondition(ep,SPC_ALL)
		Duel.Readjust()
	end
end
function Rule.AdjustSPCFilter(c)
	return c:IsAffectedBySpecialCondition() and c:IsImmuneToSpecialCondition()
end
function Rule.AdjustSPCOperation2(e,tp,eg,ep,ev,re,r,rp)
	local g=Duel.GetInPlayPokemon():Filter(Rule.AdjustSPCFilter,nil)
	for c in aux.Next(g) do
		--remove all special conditions (immune)
		if c:IsAsleep() and not c:IsCanBeAsleep() then c:RemoveSpecialCondition(ep,SPC_ASLEEP) end
		if c:IsBurned() and not c:IsCanBeBurned() then c:RemoveSpecialCondition(ep,SPC_BURNED) end
		if c:IsConfused() and not c:IsCanBeConfused() then c:RemoveSpecialCondition(ep,SPC_CONFUSED) end
		if c:IsParalyzed() and not c:IsCanBeParalyzed() then c:RemoveSpecialCondition(ep,SPC_PARALYZED) end
		if c:IsPoisoned() and not c:IsCanBePoisoned() then c:RemoveSpecialCondition(ep,SPC_POISONED) end
		Duel.Readjust()
	end
end
--attack
function Rule.AttackCondition(e,tp,eg,ep,ev,re,r,rp)
	return re:IsHasCategory(CATEGORY_POKEMON_ATTACK)
end
function Rule.AttackOperation(e,tp,eg,ep,ev,re,r,rp)
	local turnp=Duel.GetTurnPlayer()
	Duel.PokemonAttack(Duel.GetActivePokemon(turnp),Duel.GetActivePokemon(1-turnp))
end
--end turn (attacked)
function Rule.EndTurnCondition1(e,tp,eg,ep,ev,re,r,rp)
	local rc=re:GetHandler()
	local effct=rc:GetEffectCount(EFFECT_EXTRA_ATTACK)+1
	return rc:IsActive() and rc:IsControler(Duel.GetTurnPlayer())
		and re:IsHasCategory(CATEGORY_POKEMON_ATTACK) and effct==rc:GetAttackedCount()
end
function Rule.EndTurnOperation(e,tp,eg,ep,ev,re,r,rp)
	Duel.EndTurn()
end
--end turn (evolved)
function Rule.EndTurnFilter(c,tp)
	return c:IsMegaEvolution() and c:GetPlayType()==SUMMON_TYPE_EVOLVE and c:IsControler(tp)
		and not c:IsHasEffect(EFFECT_DONOT_END_TURN_MEGA)
end
function Rule.EndTurnCondition2(e,tp,eg,ep,ev,re,r,rp)
	return eg:IsExists(Rule.EndTurnFilter,1,nil,eg:GetFirst():GetControler())
end
--register gx attack
function Rule.RegisterGXAttackCondition(e,tp,eg,ep,ev,re,r,rp)
	local rc=re:GetHandler()
	local turnp=Duel.GetTurnPlayer()
	return rc:IsActive() and rc:IsControler(turnp)
		and re:IsHasCategory(CATEGORY_GX_ATTACK) and not Duel.CheckGXAttackUse(turnp)
end
function Rule.RegisterGXAttackOperation(e,tp,eg,ep,ev,re,r,rp)
	local turnp=Duel.GetTurnPlayer()
	--register the used GX attack for the game
	Duel.RegisterFlagEffect(turnp,EFFECT_GX_ATTACK_CHECK,0,0,1)
	local s_range=(turnp==tp and 1 or 0)
	local o_range=(turnp==1-tp and 1 or 0)
	--add description
	local e1=Effect.GlobalEffect()
	e1:SetDescription(DESC_USED_GX_ATTACK)
	e1:SetType(EFFECT_TYPE_FIELD)
	e1:SetProperty(EFFECT_FLAG_PLAYER_TARGET+EFFECT_FLAG_CLIENT_HINT)
	e1:SetTargetRange(s_range,o_range)
	Duel.RegisterEffect(e1,0)
	--remove description
	local e2=Effect.GlobalEffect()
	e2:SetType(EFFECT_TYPE_FIELD+EFFECT_TYPE_CONTINUOUS)
	e2:SetCode(EVENT_ADJUST)
	e2:SetCountLimit(1)
	e2:SetLabelObject(e1)
	e2:SetOperation(Rule.RemoveDescriptionOperation)
	Duel.RegisterEffect(e2,0)
end
function Rule.RemoveDescriptionOperation(e,tp,eg,ep,ev,re,r,rp)
	if Duel.GetFlagEffect(PLAYER_ONE,EFFECT_SUDDEN_DEATH_CHECK)>0
		or Duel.GetFlagEffect(PLAYER_TWO,EFFECT_SUDDEN_DEATH_CHECK)>0 then
		local e1=e:GetLabelObject()
		e1:Reset()
		e:Reset()
	end
end
--discard incompatible attached card
function Rule.DiscardAttachedOperation(e,tp,eg,ep,ev,re,r,rp)
	local g=Duel.GetAttachedGroup(0,1,1)
	local sg=g:Filter(aux.NOT(Card.IsHasEffect),nil,EFFECT_ATTACH_LIMIT)
	g:Sub(sg)
	for c in aux.Next(g) do
		local tc=c:GetAttachedTarget()
		if not c:CheckAttachedTarget(tc) then
			Duel.SendtoDPile(c,REASON_RULE+REASON_DISCARD)
		end
	end
end
--win game
function Rule.WinOperation(e,tp,eg,ep,ev,re,r,rp)
	local win={}
	win[0]=Duel.GetInPlayPokemon(PLAYER_ONE):GetCount()==0
	win[1]=Duel.GetInPlayPokemon(PLAYER_TWO):GetCount()==0
	if win[0] and win[1] then
		Rule.sudden_death()
	elseif win[0] then
		Duel.Win(PLAYER_TWO,WIN_REASON_KNOCKOUT)
	elseif win[1] then
		Duel.Win(PLAYER_ONE,WIN_REASON_KNOCKOUT)
	end
end
--override yugioh rules
--draw first turn
function Rule.draw_first_turn()
	local e1=Effect.GlobalEffect()
	e1:SetType(EFFECT_TYPE_FIELD+EFFECT_TYPE_CONTINUOUS)
	e1:SetCode(EVENT_PHASE+PHASE_DRAW)
	e1:SetCountLimit(1)
	e1:SetCondition(Rule.DrawCondition)
	e1:SetOperation(Rule.DrawOperation)
	Duel.RegisterEffect(e1,0)
end
function Rule.DrawCondition(e)
	return Duel.IsFirstTurn()
end
function Rule.DrawOperation(e,tp,eg,ep,ev,re,r,rp)
	Duel.Draw(Duel.GetTurnPlayer(),1,REASON_RULE)
end
--cannot summon
function Rule.cannot_summon()
	local e1=Effect.GlobalEffect()
	e1:SetProperty(EFFECT_FLAG_PLAYER_TARGET)
	e1:SetType(EFFECT_TYPE_FIELD)
	e1:SetCode(EFFECT_CANNOT_SUMMON)
	e1:SetTargetRange(1,1)
	Duel.RegisterEffect(e1,0)
end
--cannot mset
function Rule.cannot_mset()
	local e1=Effect.GlobalEffect()
	e1:SetProperty(EFFECT_FLAG_PLAYER_TARGET)
	e1:SetType(EFFECT_TYPE_FIELD)
	e1:SetCode(EFFECT_CANNOT_MSET)
	e1:SetTargetRange(1,1)
	Duel.RegisterEffect(e1,0)
end
--cannot sset
function Rule.cannot_sset()
	local e1=Effect.GlobalEffect()
	e1:SetProperty(EFFECT_FLAG_PLAYER_TARGET)
	e1:SetType(EFFECT_TYPE_FIELD)
	e1:SetCode(EFFECT_CANNOT_SSET)
	e1:SetTargetRange(1,1)
	Duel.RegisterEffect(e1,0)
end
--activate quick-play in non-turn player's hand
function Rule.activate_quick_in_ntphand()
	local e1=Effect.GlobalEffect()
	e1:SetProperty(EFFECT_FLAG_IGNORE_IMMUNE)
	e1:SetType(EFFECT_TYPE_FIELD)
	e1:SetCode(EFFECT_QP_ACT_IN_NTPHAND)
	e1:SetTargetRange(LOCATION_HAND,LOCATION_HAND)
	Duel.RegisterEffect(e1,0)
end
--infinite hand
function Rule.infinite_hand()
	local e1=Effect.GlobalEffect()
	e1:SetProperty(EFFECT_FLAG_PLAYER_TARGET)
	e1:SetType(EFFECT_TYPE_FIELD)
	e1:SetCode(EFFECT_HAND_LIMIT)
	e1:SetTargetRange(1,1)
	e1:SetValue(MAX_NUMBER)
	Duel.RegisterEffect(e1,0)
end
--cannot conduct battle phase
function Rule.cannot_battle_phase()
	local e1=Effect.GlobalEffect()
	e1:SetProperty(EFFECT_FLAG_PLAYER_TARGET)
	e1:SetType(EFFECT_TYPE_FIELD)
	e1:SetCode(EFFECT_CANNOT_BP)
	e1:SetTargetRange(1,1)
	Duel.RegisterEffect(e1,0)
end
--cannot change position
function Rule.cannot_change_position()
	local e1=Effect.GlobalEffect()
	e1:SetProperty(EFFECT_FLAG_IGNORE_IMMUNE+EFFECT_FLAG_SET_AVAILABLE)
	e1:SetType(EFFECT_TYPE_FIELD)
	e1:SetCode(EFFECT_CANNOT_CHANGE_POSITION)
	e1:SetTargetRange(LOCATION_INPLAY,LOCATION_INPLAY)
	Duel.RegisterEffect(e1,0)
end
--no battle damage
function Rule.avoid_battle_damage()
	local e1=Effect.GlobalEffect()
	e1:SetProperty(EFFECT_FLAG_IGNORE_IMMUNE)
	e1:SetType(EFFECT_TYPE_FIELD)
	e1:SetCode(EFFECT_AVOID_BATTLE_DAMAGE)
	e1:SetTargetRange(LOCATION_INPLAY,LOCATION_INPLAY)
	e1:SetValue(1)
	Duel.RegisterEffect(e1,0)
end
--indestructible
function Rule.indestructible()
	local e1=Effect.GlobalEffect()
	e1:SetProperty(EFFECT_FLAG_IGNORE_IMMUNE)
	e1:SetType(EFFECT_TYPE_FIELD)
	e1:SetCode(EFFECT_INDESTRUCTIBLE_BATTLE)
	e1:SetTargetRange(LOCATION_INPLAY,LOCATION_INPLAY)
	e1:SetValue(1)
	Duel.RegisterEffect(e1,0)
end
--clear extra deck
function Rule.clear_extra_deck()
	local e1=Effect.GlobalEffect()
	e1:SetProperty(EFFECT_FLAG_IGNORE_IMMUNE)
	e1:SetType(EFFECT_TYPE_FIELD+EFFECT_TYPE_CONTINUOUS)
	e1:SetCode(EVENT_ADJUST)
	e1:SetOperation(Rule.ClearExtraOperation)
	Duel.RegisterEffect(e1,0)
end
function Rule.ClearFilter(c)
	return c:IsType(TYPE_PENDULUM) and c:IsPreviousLocation(LOCATION_INPLAY)
end
function Rule.ClearExtraOperation(e,tp,eg,ep,ev,re,r,rp)
	local g=Duel.GetMatchingGroup(Rule.ClearFilter,0,LOCATION_EXTRA,LOCATION_EXTRA,nil)
	if Duel.SendtoGrave(g,REASON_RULE)>0 then
		Duel.Readjust()
	end
end
