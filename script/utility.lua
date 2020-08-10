Auxiliary={}
aux=Auxiliary
os=require('os')
ENERGY_G=ENERGY_GRASS
ENERGY_R=ENERGY_FIRE
ENERGY_W=ENERGY_WATER
ENERGY_L=ENERGY_LIGHTNING
ENERGY_P=ENERGY_PSYCHIC
ENERGY_F=ENERGY_FIGHTING
ENERGY_D=ENERGY_DARKNESS
ENERGY_M=ENERGY_METAL
ENERGY_C=ENERGY_COLORLESS
ENERGY_Y=ENERGY_FAIRY
ENERGY_N=ENERGY_DRAGON

--
function Auxiliary.Stringid(code,id)
	return code*16+id
end
--
function Auxiliary.Next(g)
	local first=true
	return	function()
				if first then first=false return g:GetFirst()
				else return g:GetNext() end
			end
end
--
function Auxiliary.NULL()
end
--
function Auxiliary.TRUE()
	return true
end
--
function Auxiliary.FALSE()
	return false
end
--
function Auxiliary.AND(...)
	local function_list={...}
	return	function(...)
				local res=false
				for i,f in ipairs(function_list) do
					res=f(...)
					if not res then return res end
				end
				return res
			end
end
--
function Auxiliary.OR(...)
	local function_list={...}
	return	function(...)
				local res=false
				for i,f in ipairs(function_list) do
					res=f(...)
					if res then return res end
				end
				return res
			end
end
--
function Auxiliary.NOT(f)
	return	function(...)
				return not f(...)
			end
end
--
function Auxiliary.BeginPuzzle(effect)
	local e1=Effect.GlobalEffect()
	e1:SetType(EFFECT_TYPE_FIELD+EFFECT_TYPE_CONTINUOUS)
	e1:SetCode(EVENT_TURN_END)
	e1:SetCountLimit(1)
	e1:SetOperation(Auxiliary.PuzzleOp)
	Duel.RegisterEffect(e1,0)
	local e2=Effect.GlobalEffect()
	e2:SetType(EFFECT_TYPE_FIELD)
	e2:SetProperty(EFFECT_FLAG_PLAYER_TARGET)
	e2:SetCode(EFFECT_SKIP_DP)
	e2:SetTargetRange(1,0)
	Duel.RegisterEffect(e2,0)
	local e3=Effect.GlobalEffect()
	e3:SetType(EFFECT_TYPE_FIELD)
	e3:SetProperty(EFFECT_FLAG_PLAYER_TARGET)
	e3:SetCode(EFFECT_SKIP_SP)
	e3:SetTargetRange(1,0)
	Duel.RegisterEffect(e3,0)
end
function Auxiliary.PuzzleOp(e,tp)
	Duel.SetLP(0,0)
end
--
function Auxiliary.TargetEqualFunction(f,value,...)
	local ext_params={...}
	return	function(effect,target)
				return f(target,table.unpack(ext_params))==value
			end
end
--
function Auxiliary.TargetBoolFunction(f,...)
	local ext_params={...}
	return	function(effect,target)
				return f(target,table.unpack(ext_params))
			end
end
--
function Auxiliary.FilterEqualFunction(f,value,...)
	local ext_params={...}
	return	function(target)
				return f(target,table.unpack(ext_params))==value
			end
end
--
function Auxiliary.FilterBoolFunction(f,...)
	local ext_params={...}
	return	function(target)
				return f(target,table.unpack(ext_params))
			end
end
--get a card script's name and id
function Auxiliary.GetID()
	local str=string.match(debug.getinfo(2,'S')['source'],"c%d+%.lua")
	str=string.sub(str,1,string.len(str)-4)
	local scard=_G[str]
	local sid=tonumber(string.sub(str,2))
	return scard,sid
end
--register a card's "archetype" (e.g. "Misty", "Unown", "Shining", "Ball", etc.)
--required for Card.IsSetCard, Card.IsOriginalSetCard
function Auxiliary.AddSetcode(c,...)
	local setname_list={...}
	for _,setname in ipairs(setname_list) do
		local e1=Effect.CreateEffect(c)
		e1:SetProperty(EFFECT_FLAG_CANNOT_DISABLE+EFFECT_FLAG_UNCOPYABLE+EFFECT_FLAG_IGNORE_IMMUNE+EFFECT_FLAG_SET_AVAILABLE)
		e1:SetType(EFFECT_TYPE_SINGLE)
		e1:SetCode(EFFECT_ADD_SETCODE)
		e1:SetValue(setname)
		c:RegisterEffect(e1)
		--fix for attached cards not getting a setcode
		local e2=Effect.GlobalEffect()
		e2:SetProperty(EFFECT_FLAG_IGNORE_IMMUNE+EFFECT_FLAG_SET_AVAILABLE)
		e2:SetType(EFFECT_TYPE_FIELD)
		e2:SetCode(EFFECT_ADD_SETCODE)
		e2:SetTargetRange(LOCATION_ATTACHED,LOCATION_ATTACHED)
		e2:SetLabel(c:GetCode())
		e2:SetTarget(function(e,c)
			return c:GetCode()==e:GetLabel()
		end)
		e2:SetValue(setname)
		Duel.RegisterEffect(e2,0)
		--register setname for Card.IsOriginalSetCard
		local mt=getmetatable(c)
		mt.setname_list={}
		table.insert(mt.setname_list,setname)
	end
end
--add a description to a pokemon that lists the effects gained from attached cards
--Note: The description is removed if con_func returns false
function Auxiliary.AddAttachedDescription(c,desc,con_func)
	con_func=con_func or aux.TRUE
	local e1=Effect.CreateEffect(c)
	e1:SetType(EFFECT_TYPE_ATTACHED+EFFECT_TYPE_FIELD+EFFECT_TYPE_CONTINUOUS)
	e1:SetCode(EVENT_ADJUST)
	e1:SetProperty(EFFECT_FLAG_CANNOT_DISABLE+EFFECT_FLAG_UNCOPYABLE)
	e1:SetLabelObject(c)
	e1:SetOperation(Auxiliary.AdjustAttachedDescOperation(desc,con_func))
	c:RegisterEffect(e1)
end
function Auxiliary.AdjustAttachedDescOperation(desc,con_func)
	return	function(e,tp,eg,ep,ev,re,r,rp)
				local c=e:GetHandler()
				if not c then return end
				local tc=e:GetLabelObject()
				local code=tc:GetOriginalCode()+desc
				if con_func(e,tp,eg,ep,ev,re,r,rp) and c:GetFlagEffect(code)==0 then
					c:RegisterFlagEffect(code,RESET_EVENT+RESETS_STANDARD,EFFECT_FLAG_CLIENT_HINT,1,0,desc)
				end
				if not con_func(e,tp,eg,ep,ev,re,r,rp) and c:GetFlagEffect(code)>0 then
					c:ResetFlagEffect(code)
				end
				--remove description (no longer attached)
				local e1=Effect.CreateEffect(c)
				e1:SetType(EFFECT_TYPE_FIELD+EFFECT_TYPE_CONTINUOUS)
				e1:SetCode(EVENT_ADJUST)
				e1:SetProperty(EFFECT_FLAG_CANNOT_DISABLE+EFFECT_FLAG_UNCOPYABLE)
				e1:SetOperation(Auxiliary.RemoveAttachedDescOperation(code,tc))
				Duel.RegisterEffect(e1,tp)
			end
end
function Auxiliary.RemoveAttachedDescOperation(code,tc)
	return	function(e,tp,eg,ep,ev,re,r,rp)
				local c=e:GetHandler()
				if not c:GetAttachedGroup():IsContains(tc) and c:GetFlagEffect(code)>0 then
					c:ResetFlagEffect(code)
					e:Reset()
				end
			end
end
--register the counters on a pokemon to transfer to another pokemon that will take its place
--Note: Update this function if a new counter is introduced
function Auxiliary.RegisterCounters(c)
	if c:GetCounter(COUNTER_DAMAGE)>0 then
		if not damage_counter_list then damage_counter_list={} end
		table.insert(damage_counter_list,c:GetCounter(COUNTER_DAMAGE))
	end
	if c:GetCounter(COUNTER_COLORING)>0 then
		if not coloring_counter_list then coloring_counter_list={} end
		table.insert(coloring_counter_list,c:GetCounter(COUNTER_COLORING))
	end
	if c:GetCounter(COUNTER_CHAR)>0 then
		if not char_counter_list then char_counter_list={} end
		table.insert(char_counter_list,c:GetCounter(COUNTER_CHAR))
	end
end
--register the markers on a pokemon to transfer to another pokemon that will take its place
--Note: Update this function if a new marker is introduced
function Auxiliary.RegisterMarkers(c)
	if c:GetCounter(MARKER_LIGHTNING_ROD)>0 then
		if not lrod_marker_list then lrod_marker_list={} end
		table.insert(lrod_marker_list,c:GetMarker(MARKER_LIGHTNING_ROD))
	end
	if c:GetCounter(MARKER_DARK_IVYSAUR)>0 then
		if not divy_marker_list then divy_marker_list={} end
		table.insert(divy_marker_list,c:GetMarker(MARKER_DARK_IVYSAUR))
	end
	if c:GetCounter(MARKER_IMPRISON)>0 then
		if not imprison_marker_list then imprison_marker_list={} end
		table.insert(imprison_marker_list,c:GetMarker(MARKER_IMPRISON))
	end
	if c:GetCounter(MARKER_SHOCKWAVE)>0 then
		if not shockwave_marker_list then shockwave_marker_list={} end
		table.insert(shockwave_marker_list,c:GetMarker(MARKER_SHOCKWAVE))
	end
end
--register a special condition on a pokemon to transfer to another pokemon that will take its place
function Auxiliary.RegisterSPC(c,spc)
	if bit.band(spc,SPC_ASLEEP)~=0 then Auxiliary.KeepAsleep=c:IsAsleep() end
	if bit.band(spc,SPC_BURNED)~=0 then Auxiliary.KeepBurned=c:IsBurned() end
	if bit.band(spc,SPC_CONFUSED)~=0 then Auxiliary.KeepConfused=c:IsConfused() end
	if bit.band(spc,SPC_PARALYZED)~=0 then Auxiliary.KeepParalyzed=c:IsParalyzed() end
	if bit.band(spc,SPC_POISONED)~=0 then Auxiliary.KeepPoisoned=c:IsPoisoned() end
end
--transfer the appropriate counters to a pokemon that took the place of another pokemon
--Note: Update this function if a new counter is introduced
function Auxiliary.TransferCounters(c,remove_damage)
	--remove_damage: true to not transfer damage counters
	if damage_counter_list and not remove_damage then
		c:AddCounter(c:GetControler(),COUNTER_DAMAGE,table.unpack(damage_counter_list),REASON_RULE)
	end
	damage_counter_list=nil
	if coloring_counter_list then
		c:AddCounter(c:GetControler(),COUNTER_COLORING,table.unpack(coloring_counter_list),REASON_RULE)
	end
	coloring_counter_list=nil
	if char_counter_list then
		c:AddCounter(c:GetControler(),COUNTER_CHAR,table.unpack(char_counter_list),REASON_RULE)
	end
	char_counter_list=nil
end
--transfer the appropriate markers to a pokemon that took the place of another pokemon
--Note: Update this function if a new marker is introduced
function Auxiliary.TransferMarkers(c)
	if lrod_marker_list then
		c:AddMarker(c:GetControler(),MARKER_LIGHTNING_ROD,table.unpack(lrod_marker_list),REASON_RULE)
	end
	lrod_marker_list=nil
	if divy_marker_list then
		c:AddMarker(c:GetControler(),MARKER_DARK_IVYSAUR,table.unpack(divy_marker_list),REASON_RULE)
	end
	divy_marker_list=nil
	if imprison_marker_list then
		c:AddMarker(c:GetControler(),MARKER_IMPRISON,table.unpack(imprison_marker_list),REASON_RULE)
	end
	imprison_marker_list=nil
	if shockwave_marker_list then
		c:AddMarker(c:GetControler(),MARKER_SHOCKWAVE,table.unpack(shockwave_marker_list),REASON_RULE)
	end
	shockwave_marker_list=nil
end
--transfer the appropriate special conditions to a pokemon that took the place of another pokemon
function Auxiliary.TransferSPC(c)
	if Auxiliary.KeepAsleep then c:ApplySpecialCondition(c:GetControler(),SPC_ASLEEP) end
	Auxiliary.KeepAsleep=nil
	if Auxiliary.KeepBurned then c:ApplySpecialCondition(c:GetControler(),SPC_BURNED) end
	Auxiliary.KeepBurned=nil
	if Auxiliary.KeepConfused then c:ApplySpecialCondition(c:GetControler(),SPC_CONFUSED) end
	Auxiliary.KeepConfused=nil
	if Auxiliary.KeepParalyzed then c:ApplySpecialCondition(c:GetControler(),SPC_PARALYZED) end
	Auxiliary.KeepParalyzed=nil
	if Auxiliary.KeepPoisoned then c:ApplySpecialCondition(c:GetControler(),SPC_POISONED) end
	Auxiliary.KeepPoisoned=nil
end
--check if a pokemon is part of another pokemon's evolution chain (excluding mega and break evolution and pokemon vmax)
--e.g. "Omanyte" (Neo Discovery 60/75), "Rare Candy" (Sandstorm 88/100)
--Note: Update this function if a Pokemon with an evolution chain of 5 or more branches is introduced
function Auxiliary.IsEvolutionChain(c,code)
	--check for an evolution chain with only 1 branch
	if c.evolution_list1 then
		if c.evolution_list1["Baby"]==code then return true end
		if c.evolution_list1["Basic"]==code then return true end
		if c.evolution_list1["Stage 1"]==code then return true end
		if c.evolution_list1["Stage 2"]==code then return true end
	end
	--check for an evolution chain with 2 branches
	if c.evolution_list2 then
		if c.evolution_list2["Baby"]==code then return true end
		if c.evolution_list2["Basic"]==code then return true end
		if c.evolution_list2["Stage 1"]==code then return true end
		if c.evolution_list2["Stage 2"]==code then return true end
	end
	--check for an evolution chain with 3 branches
	if c.evolution_list3 then
		if c.evolution_list3["Baby"]==code then return true end
		if c.evolution_list3["Basic"]==code then return true end
		if c.evolution_list3["Stage 1"]==code then return true end
		if c.evolution_list3["Stage 2"]==code then return true end
	end
	--check for an evolution chain with 4 branches
	if c.evolution_list4 then
		if c.evolution_list4["Baby"]==code then return true end
		if c.evolution_list4["Basic"]==code then return true end
		if c.evolution_list4["Stage 1"]==code then return true end
		if c.evolution_list4["Stage 2"]==code then return true end
	end
	return false
end
--check for energy cards with different energy types (for SelectUnselect)
--e.g. "Lady Outing" (Ruby & Sapphire 83/109), "Lanette's Net Search" (Sandstorm 87/100)
function Auxiliary.EnergyTypeClassCheck(g)
	return g:GetClassCount(Card.GetEnergyType)==g:GetCount()
end
--check for cards with different names (for SelectUnselect)
--e.g. "Marley's Request" (Stormfront 87/100)
function Auxiliary.CardNameClassCheck(g)
	return g:GetClassCount(Card.GetOriginalCode)==g:GetCount()
end

--Pokemon card
function Auxiliary.EnablePokemonAttribute(c)
	--counter limit
	c:SetCounterLimit(COUNTER_COLORING,1)
	--marker limit
	c:SetMarkerLimit(MARKER_BURN,1)
	c:SetMarkerLimit(MARKER_POISON,1)
	c:SetMarkerLimit(MARKER_LIGHTNING_ROD,1)
	--bench
	local e1=Effect.CreateEffect(c)
	e1:SetDescription(DESC_BENCH)
	e1:SetType(EFFECT_TYPE_FIELD)
	e1:SetCode(EFFECT_PLAY_POKEMON_PROC)
	e1:SetProperty(EFFECT_FLAG_PLAY_PARAM+EFFECT_FLAG_CANNOT_DISABLE+EFFECT_FLAG_UNCOPYABLE+EFFECT_FLAG_IGNORE_IMMUNE)
	e1:SetRange(LOCATION_HAND)
	e1:SetTargetRange(POS_FACEUP_UPSIDE,0)
	e1:SetCondition(Auxiliary.BenchCondition)
	e1:SetValue(1)
	c:RegisterEffect(e1)
	--bench (extended)
	--reserved
	--[[
	local e1b=Effect.CreateEffect(c)
	e1b:SetDescription(DESC_BENCH)
	e1b:SetType(EFFECT_TYPE_IGNITION)
	e1b:SetProperty(EFFECT_FLAG_PLAY_PARAM+EFFECT_FLAG_CANNOT_DISABLE+EFFECT_FLAG_UNCOPYABLE+EFFECT_FLAG_IGNORE_IMMUNE)
	e1b:SetRange(LOCATION_HAND)
	e1b:SetCondition(Auxiliary.BenchExtCondition)
	e1b:SetTarget(Auxiliary.BenchExtTarget)
	e1b:SetOperation(Auxiliary.BenchExtOperation)
	c:RegisterEffect(e1b)
	]]
	--retreat
	local e2=Effect.CreateEffect(c)
	e2:SetDescription(DESC_RETREAT)
	e2:SetCategory(CATEGORY_RETREAT)
	e2:SetType(EFFECT_TYPE_IGNITION)
	e2:SetProperty(EFFECT_FLAG_CANNOT_DISABLE+EFFECT_FLAG_UNCOPYABLE+EFFECT_FLAG_IGNORE_IMMUNE)
	e2:SetRange(LOCATION_ACTIVE)
	e2:SetCondition(Auxiliary.RetreatCondition)
	e2:SetTarget(Auxiliary.RetreatTarget)
	e2:SetOperation(Auxiliary.RetreatOperation)
	c:RegisterEffect(e2)
end
function Auxiliary.BenchCondition(e,c)
	if c==nil then return true end
	local tp=c:GetControler()
	if Duel.IsBenchFull(tp) or not c:IsCanBePlayed(e,0,tp,false,false) then return false end
	return c:IsBasicPokemon()
end
--bench (extended)
--reserved
--[[
function Auxiliary.BenchExtCondition(e,tp,eg,ep,ev,re,r,rp)
	return Duel.IsPlayerAffectedByEffect(tp,EFFECT_EXTEND_BENCH) and e:GetHandler():IsBasicPokemon()
end
function Auxiliary.BenchExtTarget(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return Duel.GetLocationCount(tp,LOCATION_BENCHEXT)>0
		and e:GetHandler():IsCanBePlayed(e,0,tp,false,false) end
end
function Auxiliary.BenchExtOperation(e,tp,eg,ep,ev,re,r,rp)
	Duel.MoveToField(e:GetHandler(),tp,tp,LOCATION_BENCHEXT,POS_FACEUP,true)
end
]]
function Auxiliary.RetreatCondition(e,tp,eg,ep,ev,re,r,rp)
	return e:GetHandler():IsCanRetreat()
end
function Auxiliary.RetreatTarget(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return true end
	if Auxiliary.CancelRetreat(e,tp) then return end
	Duel.Hint(HINT_OPSELECTED,1-tp,e:GetDescription())
end
function Auxiliary.RetreatOperation(e,tp,eg,ep,ev,re,r,rp)
	if not Auxiliary.RetreatCancelCheck(e) then
		Duel.Retreat(tp)
	end
end
function Auxiliary.CancelRetreat(e,tp)
	if not Duel.SelectYesNo(tp,YESNOMSG_CONFIRMRETREAT) then
		e:SetLabel(1)
		e:SetCategory(0)
		return true
	else return false end
end
function Auxiliary.RetreatCancelCheck(e)
	if e:GetLabel()==1 then
		e:SetLabel(0)
		e:SetCategory(CATEGORY_RETREAT)
		return true
	else return false end
end
--Evolution card
--Not fully implemented: Cannot evolve Pokemon in LOCATION_BENCHEXT
--Rulings: https://compendium.pokegym.net/compendium-bw.html#193
function Auxiliary.EnableEvolutionAttribute(c)
	local e1=Effect.CreateEffect(c)
	e1:SetDescription(DESC_EVOLVE)
	e1:SetType(EFFECT_TYPE_FIELD)
	e1:SetCode(EFFECT_PLAY_POKEMON_PROC)
	e1:SetProperty(EFFECT_FLAG_CANNOT_DISABLE+EFFECT_FLAG_UNCOPYABLE+EFFECT_FLAG_IGNORE_IMMUNE)
	e1:SetRange(LOCATION_HAND)
	e1:SetCondition(Auxiliary.EvolveCondition)
	e1:SetOperation(Auxiliary.EvolveOperation)
	c:RegisterEffect(e1)
	--alternative evolve procedure (use chain link)
	--reserved
	--[[
	local e1=Effect.CreateEffect(c)
	e1:SetDescription(DESC_EVOLVE)
	e1:SetType(EFFECT_TYPE_IGNITION)
	e1:SetProperty(EFFECT_FLAG_CANNOT_DISABLE+EFFECT_FLAG_UNCOPYABLE+EFFECT_FLAG_IGNORE_IMMUNE)
	e1:SetRange(LOCATION_HAND)
	e1:SetTarget(Auxiliary.EvolveTarget)
	e1:SetOperation(Auxiliary.EvolveOperation)
	c:RegisterEffect(e1)
	]]
end
function Auxiliary.EvolveFilter(c,e,tp,code)
	return c:IsFaceup() and c:IsCode(code) and c:IsCanEvolve(e,tp,false,false)
end
function Auxiliary.EvolveCondition(e,c)
	if c==nil then return true end
	local tp=c:GetControler()
	local code=c.evolves_from
	return Duel.GetFreeBenchCount(tp)>-1
		and Duel.IsExistingMatchingCard(Auxiliary.EvolveFilter,tp,LOCATION_INPLAY,0,1,nil,e,tp,code)
		and c:IsCanBePlayed(e,SUMMON_TYPE_EVOLVE,tp,true,false)
end
function Auxiliary.EvolveOperation(e,tp,eg,ep,ev,re,r,rp,c)
	local code=c.evolves_from
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_EVOLVE)
	local g=Duel.SelectMatchingCard(tp,Auxiliary.EvolveFilter,tp,LOCATION_INPLAY,0,1,1,nil,e,tp,code)
	if g:GetCount()==0 then return end
	Duel.HintSelection(g)
	Duel.Evolve(c,g,tp)
end
--alternative evolve procedure (use chain link)
--reserved
--[[
function Auxiliary.EvolveTarget(e,tp,eg,ep,ev,re,r,rp,chk)
	local c=e:GetHandler()
	local code=c.evolves_from
	if chk==0 then return Duel.GetFreeBenchCount(tp)>-1
		and Duel.IsExistingMatchingCard(Auxiliary.EvolveFilter,tp,LOCATION_INPLAY,0,1,nil,e,tp,code)
		and c:IsCanBePlayed(e,SUMMON_TYPE_EVOLVE,tp,true,false) end
end
function Auxiliary.EvolveOperation(e,tp,eg,ep,ev,re,r,rp)
	local c=e:GetHandler()
	local code=c.evolves_from
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_EVOLVE)
	local g=Duel.SelectMatchingCard(tp,Auxiliary.EvolveFilter,tp,LOCATION_INPLAY,0,1,1,nil,e,tp,code)
	if g:GetCount()==0 then return end
	Duel.HintSelection(g)
	Duel.Evolve(c,g,tp)
end
]]
--Baby Pokemon ability (pre-HeartGold & SoulSilver)
function Auxiliary.EnableBabyPokemonAbility(c)
	local e1=Effect.CreateEffect(c)
	e1:SetType(EFFECT_TYPE_FIELD+EFFECT_TYPE_CONTINUOUS)
	e1:SetCode(EVENT_PRE_ATTACK)
	e1:SetProperty(EFFECT_FLAG_CANNOT_DISABLE+EFFECT_FLAG_UNCOPYABLE)
	e1:SetRange(LOCATION_INPLAY)
	e1:SetCondition(Auxiliary.BabyPokemonCondition)
	e1:SetOperation(Auxiliary.BabyPokemonOperation)
	c:RegisterEffect(e1)
end
function Auxiliary.BabyPokemonCondition(e,tp,eg,ep,ev,re,r,rp)
	local c=e:GetHandler()
	return c:IsBabyPokemon() and c:IsActive()
		and re:GetHandler():IsControler(1-tp) and re:IsHasCategory(CATEGORY_POKEMON_ATTACK)
end
function Auxiliary.BabyPokemonOperation(e,tp,eg,ep,ev,re,r,rp)
	local code=e:GetHandler():GetOriginalCode()
	Duel.Hint(HINT_CARD,0,code)
	if Duel.TossCoin(1-tp,1)==RESULT_TAILS then
		Duel.NegatePokemonAttack(ev)
	end
end
--"Poke-POWER: Baby Evolution"
--Rulings: https://compendium.pokegym.net/compendium-lvx.html#22
function Auxiliary.EnablePokePowerBabyEvolution(c,desc_id,code)
	local e1=Effect.CreateEffect(c)
	e1:SetDescription(aux.Stringid(c:GetOriginalCode(),desc_id))
	e1:SetCategory(CATEGORY_POKEPOWER)
	e1:SetType(EFFECT_TYPE_IGNITION)
	e1:SetRange(LOCATION_INPLAY)
	e1:SetTarget(Auxiliary.BabyEvolutionTarget(code))
	e1:SetOperation(Auxiliary.BabyEvolutionOperation(code))
	c:RegisterEffect(e1)
end
function Auxiliary.BabyEvolutionFilter(c,e,tp,code)
	return c:IsCode(code) and c:IsCanBePlayed(e,SUMMON_TYPE_EVOLVE,tp,true,false)
end
function Auxiliary.BabyEvolutionTarget(code)
	return	function(e,tp,eg,ep,ev,re,r,rp,chk)
				if chk==0 then return Duel.GetFreeBenchCount(tp)>-1
					and Duel.IsExistingMatchingCard(Auxiliary.BabyEvolutionFilter,tp,LOCATION_HAND,0,1,nil,e,tp,code)
					and e:GetHandler():IsCanEvolve(e,tp,true,true) end
			end
end
function Auxiliary.BabyEvolutionOperation(code)
	return	function(e,tp,eg,ep,ev,re,r,rp)
				Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_EVOLVETO)
				local g=Duel.SelectMatchingCard(tp,Auxiliary.BabyEvolutionFilter,tp,LOCATION_HAND,0,1,1,nil,e,tp,code)
				if g:GetCount()>0 then
					Duel.Evolve(g:GetFirst(),e:GetHandler(),tp,true)
				end
			end
end
--Pokemon LV.X
--Not fully implemented: The names of the gained attacks are wrong
--Rulings: https://compendium.pokegym.net/compendium-lvx.html#92
function Auxiliary.EnableLevelUpAttribute(c)
	local e1=Effect.CreateEffect(c)
	e1:SetDescription(DESC_LEVEL_UP)
	e1:SetType(EFFECT_TYPE_FIELD)
	e1:SetCode(EFFECT_PLAY_POKEMON_PROC)
	e1:SetProperty(EFFECT_FLAG_CANNOT_DISABLE+EFFECT_FLAG_UNCOPYABLE+EFFECT_FLAG_IGNORE_IMMUNE)
	e1:SetRange(LOCATION_HAND)
	e1:SetCondition(Auxiliary.LevelUpCondition)
	e1:SetOperation(Auxiliary.LevelUpOperation)
	c:RegisterEffect(e1)
	--alternative level up procedure (use chain link)
	--reserved
	--[[
	local e1=Effect.CreateEffect(c)
	e1:SetDescription(DESC_LEVEL_UP)
	e1:SetType(EFFECT_TYPE_IGNITION)
	e1:SetProperty(EFFECT_FLAG_CANNOT_DISABLE+EFFECT_FLAG_UNCOPYABLE+EFFECT_FLAG_IGNORE_IMMUNE)
	e1:SetRange(LOCATION_HAND)
	e1:SetTarget(Auxiliary.LevelUpTarget)
	e1:SetOperation(Auxiliary.LevelUpOperation)
	c:RegisterEffect(e1)
	]]
end
function Auxiliary.LevelUpFilter(c,e,tp,code)
	return c:IsFaceup() and c:IsCode(code) and c:IsCanLevelUp(e,tp,false,false)
end
function Auxiliary.LevelUpCondition(e,c)
	if c==nil then return true end
	local tp=c:GetControler()
	local code=c.levels_up_from
	return Duel.GetFreeBenchCount(tp)>-1
		and Duel.IsExistingMatchingCard(Auxiliary.LevelUpFilter,tp,LOCATION_ACTIVE,0,1,nil,e,tp,code)
		and c:IsCanBePlayed(e,SUMMON_TYPE_LEVEL_UP,tp,true,false)
end
function Auxiliary.LevelUpOperation(e,tp,eg,ep,ev,re,r,rp,c)
	local code=c.levels_up_from
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_LEVELUP)
	local g=Duel.SelectMatchingCard(tp,Auxiliary.LevelUpFilter,tp,LOCATION_ACTIVE,0,1,1,nil,e,tp,code)
	if g:GetCount()==0 then return end
	Duel.HintSelection(g)
	Duel.LevelUp(c,g,tp)
end
--alternative level up procedure (use chain link)
--reserved
--[[
function Auxiliary.LevelUpTarget(e,tp,eg,ep,ev,re,r,rp,chk)
	local c=e:GetHandler()
	local code=c.levels_up_from
	if chk==0 then return Duel.GetFreeBenchCount(tp)>-1
		and Duel.IsExistingMatchingCard(Auxiliary.LevelUpFilter,tp,LOCATION_ACTIVE,0,1,nil,e,tp,code)
		and c:IsCanBePlayed(e,SUMMON_TYPE_LEVEL_UP,tp,true,false) end
end
function Auxiliary.LevelUpOperation(e,tp,eg,ep,ev,re,r,rp)
	local c=e:GetHandler()
	local code=c.levels_up_from
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_LEVELUP)
	local g=Duel.SelectMatchingCard(tp,Auxiliary.LevelUpFilter,tp,LOCATION_ACTIVE,0,1,1,nil,e,tp,code)
	if g:GetCount()==0 then return end
	Duel.HintSelection(g)
	Duel.LevelUp(c,g,tp)
end
]]
--Pokemon LEGEND
--Rulings: https://compendium.pokegym.net/compendium-bw.html#177
function Auxiliary.EnablePokemonLEGENDAttribute(c,code)
	--code: the id of the other half of the Pokemon LEGEND card
	code=code or c:GetOriginalCode()+1
	--no retreat cost
	c:SetStatus(STATUS_NO_RETREAT_COST,true)
	--bench
	local e1=Effect.CreateEffect(c)
	e1:SetDescription(DESC_BENCH)
	e1:SetType(EFFECT_TYPE_FIELD)
	e1:SetCode(EFFECT_PLAY_POKEMON_PROC)
	e1:SetProperty(EFFECT_FLAG_PLAY_PARAM+EFFECT_FLAG_CANNOT_DISABLE+EFFECT_FLAG_UNCOPYABLE+EFFECT_FLAG_IGNORE_IMMUNE)
	e1:SetRange(LOCATION_HAND)
	e1:SetTargetRange(POS_FACEUP_UPSIDE,0)
	e1:SetCondition(Auxiliary.BenchLEGENDCondition(code))
	e1:SetValue(1)
	c:RegisterEffect(e1)
	--merge
	local e2=Effect.CreateEffect(c)
	e2:SetType(EFFECT_TYPE_SINGLE+EFFECT_TYPE_CONTINUOUS)
	e2:SetCode(EVENT_PLAY)
	e2:SetProperty(EFFECT_FLAG_CANNOT_DISABLE+EFFECT_FLAG_UNCOPYABLE+EFFECT_FLAG_IGNORE_IMMUNE)
	e2:SetCondition(Auxiliary.MergeLEGENDCondition(code))
	e2:SetOperation(Auxiliary.MergeLEGENDOperation(code))
	c:RegisterEffect(e2)
end
function Auxiliary.BenchLEGENDCondition(code)
	return	function(e,c)
				if c==nil then return true end
				local tp=c:GetControler()
				if Duel.IsBenchFull(tp) or not c:IsCanBePlayed(e,0,tp,false,false) then return false end
				return Duel.IsExistingMatchingCard(Card.IsCode,tp,LOCATION_HAND,0,1,nil,code)
			end
end
function Auxiliary.MergeLEGENDCondition(code)
	return	function(e)
				return Duel.IsExistingMatchingCard(Card.IsCode,e:GetHandlerPlayer(),LOCATION_HAND,0,1,nil,code)
					and e:GetHandler():GetPlayType()==SUMMON_TYPE_SPECIAL+1
			end
end
function Auxiliary.MergeLEGENDOperation(code)
	return	function(e,tp,eg,ep,ev,re,r,rp)
				local c=e:GetHandler()
				local tc=Duel.GetFirstMatchingCard(Card.IsCode,tp,LOCATION_HAND,0,nil,code)
				Duel.MergeCards(c,tc)
				if c:IsStatus(STATUS_NO_RETREAT_COST) then
					--add retreat cost
					c:SetStatus(STATUS_NO_RETREAT_COST,false)
				end
			end
end

--Energy card
--Rulings: https://compendium.pokegym.net/compendium-bw.html#c7
function Auxiliary.EnableEnergyAttribute(c,f,discard,o_only)
	--f: filter function if the energy card can only be attached to a particular pokemon
	--discard: 1 to discard at the end of the turn, 2 to discard at the end of the opponent's turn
	--o_only: true if the energy card can only be attached to an opponent's pokemon
	local s=o_only and 0 or LOCATION_INPLAY
	local o=o_only and LOCATION_INPLAY or 0
	--attach
	local e1=Effect.CreateEffect(c)
	e1:SetDescription(DESC_ATTACH)
	e1:SetType(EFFECT_TYPE_IGNITION)
	e1:SetProperty(EFFECT_FLAG_CANNOT_DISABLE+EFFECT_FLAG_UNCOPYABLE)
	e1:SetRange(LOCATION_HAND)
	e1:SetCondition(Auxiliary.EnergyCondition)
	e1:SetCost(Auxiliary.EnergyCost)
	e1:SetTarget(Auxiliary.EnergyTarget(f,s,o))
	e1:SetOperation(Auxiliary.EnergyOperation(f,s,o,discard))
	c:RegisterEffect(e1)
	--attach limit for Card.CheckAttachedTarget
	Auxiliary.EnableAttachLimit(c,f)
end
function Auxiliary.EnergyCondition(e,tp,eg,ep,ev,re,r,rp)
	return Duel.IsPlayerCanPlayEnergy(tp,e:GetHandler())
end
function Auxiliary.EnergyCost(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return true end
	--register the played Energy card for the turn
	Duel.RegisterFlagEffect(tp,EFFECT_ENERGY_CHECK,RESET_PHASE+PHASE_END,0,1)
end
function Auxiliary.EnergyFilter1(c,f)
	return c:IsFaceup() and c:IsPokemon() and (not f or f(c))
end
function Auxiliary.EnergyFilter2(c,f)
	--check for "Blaine" (Gym Challenge 17/132) effect
	return Auxiliary.EnergyFilter1(c,f) and c:IsHasEffect(EFFECT_BLAINE)
end
function Auxiliary.EnergyTarget(f,s,o)
	return	function(e,tp,eg,ep,ev,re,r,rp,chk)
				local filt_func=e:GetHandler():IsHasEffect(EFFECT_BLAINE) and Auxiliary.EnergyFilter2 or Auxiliary.EnergyFilter1
				if chk==0 then return Duel.IsExistingMatchingCard(filt_func,tp,s,o,1,nil,f) end
			end
end
function Auxiliary.EnergyOperation(f,s,o,discard)
	return	function(e,tp,eg,ep,ev,re,r,rp)
				local c=e:GetHandler()
				local filt_func=c:IsHasEffect(EFFECT_BLAINE) and Auxiliary.EnergyFilter2 or Auxiliary.EnergyFilter1
				Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_ATTACHENERGYTO)
				local g=Duel.SelectMatchingCard(tp,filt_func,tp,s,o,1,1,nil,f)
				if g:GetCount()==0 then return end
				Duel.HintSelection(g)
				Duel.Attach(e,g:GetFirst(),c)
				if not discard then return end
				--discard self
				local e1=Effect.CreateEffect(c)
				e1:SetDescription(DESC_SELF_DISCARD)
				e1:SetType(EFFECT_TYPE_FIELD+EFFECT_TYPE_CONTINUOUS)
				e1:SetCode(EVENT_PHASE+PHASE_END)
				e1:SetCountLimit(1)
				e1:SetLabel(Duel.GetTurnCount())
				e1:SetLabelObject(c)
				if discard==2 then
					e1:SetCondition(Auxiliary.SelfAttachedDiscardCondition(2))
				else
					e1:SetCondition(Auxiliary.SelfAttachedDiscardCondition)
				end
				e1:SetOperation(Auxiliary.SelfAttachedDiscardOperation)
				if discard==2 then
					e1:SetReset(RESET_PHASE+PHASE_END,2)
				else
					e1:SetReset(RESET_PHASE+PHASE_END)
				end
				Duel.RegisterEffect(e1,tp)
			end
end
function Auxiliary.SelfAttachedDiscardCondition(turn_count)
	return	function(e,tp,eg,ep,ev,re,r,rp)
				if turn_count==2 then
					return Duel.GetTurnCount()~=e:GetLabel()
				else
					return Duel.GetTurnCount()==e:GetLabel()
				end
			end
end
function Auxiliary.SelfAttachedDiscardOperation(e,tp,eg,ep,ev,re,r,rp)
	Duel.SendtoDPile(e:GetLabelObject(),REASON_EFFECT+REASON_DISCARD)
end
--attach limit for Card.CheckAttachedTarget
function Auxiliary.EnableAttachLimit(c,f)
	local e1=Effect.CreateEffect(c)
	e1:SetType(EFFECT_TYPE_SINGLE)
	e1:SetCode(EFFECT_ATTACH_LIMIT)
	e1:SetProperty(EFFECT_FLAG_CANNOT_DISABLE+EFFECT_FLAG_UNCOPYABLE+EFFECT_FLAG_IGNORE_IMMUNE+EFFECT_FLAG_SET_AVAILABLE)
	e1:SetValue(Auxiliary.AttachLimit(f))
	c:RegisterEffect(e1)
	local m=_G["c"..c:GetOriginalCode()]
	if not m.attach_limit_register then
		m.attach_limit_register=true
		--fix for attached cards not getting an attach limit
		local ge1=Effect.GlobalEffect()
		ge1:SetType(EFFECT_TYPE_FIELD)
		ge1:SetCode(EFFECT_ATTACH_LIMIT)
		ge1:SetProperty(EFFECT_FLAG_CANNOT_DISABLE+EFFECT_FLAG_UNCOPYABLE+EFFECT_FLAG_IGNORE_IMMUNE)
		ge1:SetTargetRange(LOCATION_ATTACHED,LOCATION_ATTACHED)
		ge1:SetLabel(c:GetCode())
		ge1:SetTarget(function(e,c)
			return c:GetCode()==e:GetLabel()
		end)
		ge1:SetValue(Auxiliary.AttachLimit(f))
		Duel.RegisterEffect(ge1,0)
	end
end
function Auxiliary.AttachLimit(f)
	return	function(e,c)
				return c:IsFaceup() and c:IsPokemon() and (not f or f(c,e,e:GetHandlerPlayer()))
			end
end
--"This card provides [X] Energy"
function Auxiliary.EnableProvideEnergy(c,energy_type,energy_count,f)
	--energy_type: the type(s) of energy the energy card provides
	--energy_count: the amount of energy the energy card provides (provides 1 by default)
	--f: filter function if the energy card only provides energy while attached to a particular pokemon
	energy_count=energy_count or 1
	local code=c:GetOriginalCode()
	local m=_G["c"..code]
	if not m.provide_energy_check then
		m.provide_energy_check=true
		local range=f and LOCATION_ATTACHED or LOCATION_ALL
		--energy type
		local ge1=Effect.GlobalEffect()
		ge1:SetType(EFFECT_TYPE_FIELD)
		ge1:SetCode(EFFECT_ADD_ENERGY_TYPE)
		ge1:SetTargetRange(range,range)
		ge1:SetTarget(Auxiliary.ProvideEnergyTarget(code,f))
		ge1:SetValue(energy_type)
		Duel.RegisterEffect(ge1,0)
		--energy count
		local ge2=ge1:Clone()
		ge2:SetCode(EFFECT_CHANGE_ENERGY_COUNT)
		ge2:SetValue(energy_count)
		Duel.RegisterEffect(ge2,0)
	end
end
function Auxiliary.ProvideEnergyTarget(code,f)
	return	function(e,c)
				if not c then return false end
				local tc=c:GetAttachedTarget()
				return c:IsCode(code) and (not f or tc and f(tc))
			end
end

--Trainer card
--Rulings: https://compendium.pokegym.net/compendium-bw.html#c6
function Auxiliary.PlayTrainerFunction(c,targ_func,op_func,con_func,cost_func,prop)
	--play (non-stadium)
	local e1=Effect.CreateEffect(c)
	e1:SetType(EFFECT_TYPE_ACTIVATE)
	e1:SetCode(EVENT_FREE_CHAIN)
	if prop then e1:SetProperty(prop) end
	if con_func then e1:SetCondition(con_func) end
	if cost_func then e1:SetCost(cost_func) end
	if targ_func then e1:SetTarget(targ_func) end
	e1:SetOperation(op_func)
	c:RegisterEffect(e1)
end
--Non-Pokemon Tool and non-Technical Machine Trainer card that attaches to Pokemon
function Auxiliary.EnableAttachTrainer(c,f,discard,o_only)
	--f: filter function if the trainer can only be attached to a particular pokemon
	--discard: 1 to discard at the end of the turn, 2 to discard at the end of the opponent's turn
	--o_only: true if the trainer can only be attached to an opponent's pokemon
	local s=o_only and 0 or LOCATION_INPLAY
	local o=o_only and LOCATION_INPLAY or 0
	--attach
	local e1=Effect.CreateEffect(c)
	e1:SetDescription(DESC_ATTACH)
	e1:SetType(EFFECT_TYPE_IGNITION)
	e1:SetProperty(EFFECT_FLAG_CANNOT_DISABLE+EFFECT_FLAG_UNCOPYABLE)
	e1:SetRange(LOCATION_HAND)
	e1:SetTarget(Auxiliary.AttachTrainerTarget(f,s,o))
	e1:SetOperation(Auxiliary.AttachTrainerOperation(f,s,o,discard))
	c:RegisterEffect(e1)
	--attach limit for Card.CheckAttachedTarget
	Auxiliary.EnableAttachLimit(c,f)
end
function Auxiliary.AttachTrainerFilter(c,f)
	return c:IsFaceup() and c:IsPokemon() and (not f or f(c))
end
function Auxiliary.AttachTrainerTarget(f,s,o)
	return	function(e,tp,eg,ep,ev,re,r,rp,chk)
				local filt_func=e:GetHandler():IsPokemonTool() and Auxiliary.PokemonToolFilter or Auxiliary.AttachTrainerFilter
				if chk==0 then return Duel.IsExistingMatchingCard(filt_func,tp,s,o,1,nil,f) end
			end
end
function Auxiliary.AttachTrainerOperation(f,s,o,discard)
	return	function(e,tp,eg,ep,ev,re,r,rp)
				local c=e:GetHandler()
				local filt_func=c:IsPokemonTool() and Auxiliary.PokemonToolFilter or Auxiliary.AttachTrainerFilter
				Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_ATTACHTRAINERTO)
				local g=Duel.SelectMatchingCard(tp,filt_func,tp,s,o,1,1,nil,f)
				if g:GetCount()==0 then return end
				Duel.HintSelection(g)
				Duel.Attach(e,g:GetFirst(),c)
				if not discard then return end
				--discard self
				local e1=Effect.CreateEffect(c)
				e1:SetDescription(DESC_SELF_DISCARD)
				e1:SetType(EFFECT_TYPE_FIELD+EFFECT_TYPE_CONTINUOUS)
				e1:SetCode(EVENT_PHASE+PHASE_END)
				e1:SetCountLimit(1)
				e1:SetLabel(Duel.GetTurnCount())
				e1:SetLabelObject(c)
				if discard==2 then
					e1:SetCondition(Auxiliary.SelfAttachedDiscardCondition(2))
				else
					e1:SetCondition(Auxiliary.SelfAttachedDiscardCondition)
				end
				e1:SetOperation(Auxiliary.SelfAttachedDiscardOperation)
				if discard==2 then
					e1:SetReset(RESET_PHASE+PHASE_END,2)
				else
					e1:SetReset(RESET_PHASE+PHASE_END)
				end
				Duel.RegisterEffect(e1,tp)
			end
end
--Technical Machine
function Auxiliary.EnableTechnicalMachineAttribute(c,f,discard,o_only)
	--f: filter function if the technical machine can only be attached to a particular pokemon
	--discard: 1 to discard at the end of the turn, 2 to discard at the end of the opponent's turn
	--o_only: true if the technical machine can only be attached to an opponent's pokemon
	local s=o_only and 0 or LOCATION_INPLAY
	local o=o_only and LOCATION_INPLAY or 0
	--attach
	local e1=Effect.CreateEffect(c)
	e1:SetDescription(DESC_ATTACH)
	e1:SetType(EFFECT_TYPE_IGNITION)
	e1:SetProperty(EFFECT_FLAG_CANNOT_DISABLE+EFFECT_FLAG_UNCOPYABLE)
	e1:SetRange(LOCATION_HAND)
	e1:SetTarget(Auxiliary.AttachTrainerTarget(f,s,o))
	e1:SetOperation(Auxiliary.AttachTrainerOperation(f,s,o,discard))
	c:RegisterEffect(e1)
	--attach limit for Card.CheckAttachedTarget
	Auxiliary.EnableAttachLimit(c,f)
end
--Pokemon Tool
function Auxiliary.EnablePokemonToolAttribute(c,f,discard,o_only)
	--f: filter function if the pokemon tool can only be attached to a particular pokemon
	--discard: 1 to discard at the end of the turn, 2 to discard at the end of the opponent's turn
	--o_only: true if the pokemon tool can only be attached to an opponent's pokemon
	local s=o_only and 0 or LOCATION_INPLAY
	local o=o_only and LOCATION_INPLAY or 0
	--attach
	local e1=Effect.CreateEffect(c)
	e1:SetDescription(DESC_ATTACH)
	e1:SetType(EFFECT_TYPE_IGNITION)
	e1:SetProperty(EFFECT_FLAG_CANNOT_DISABLE+EFFECT_FLAG_UNCOPYABLE)
	e1:SetRange(LOCATION_HAND)
	e1:SetTarget(Auxiliary.AttachTrainerTarget(f,s,o))
	e1:SetOperation(Auxiliary.AttachTrainerOperation(f,s,o,discard))
	c:RegisterEffect(e1)
	--attach limit for Card.CheckAttachedTarget
	Auxiliary.EnableAttachLimit(c,f)
end
function Auxiliary.PokemonToolFilter(c,f)
	return c:IsFaceup() and c:IsPokemon() and c:IsCanAttachPokemonTool() and (not f or f(c))
end
--add an EFFECT_TYPE_SINGLE effect to the pokemon from the attached card
--e.g. "Defender" (Base Set 80/102), "Darkness Energy" (Neo Genesis 104/111), "Balloon Berry" (Neo Revelation 60/64)
function Auxiliary.AddSingleAttachedEffect(c,code,val,con_func)
	--code: EFFECT_UPDATE_DEFEND_AFTER, EFFECT_UPDATE_ATTACK_ACTIVE_BEFORE, EFFECT_CHANGE_RETREAT_COST, etc.
	local e1=Effect.CreateEffect(c)
	e1:SetType(EFFECT_TYPE_ATTACHED)
	e1:SetCode(code)
	e1:SetProperty(EFFECT_FLAG_CANNOT_DISABLE+EFFECT_FLAG_UNCOPYABLE)
	if con_func then e1:SetCondition(con_func) end
	if val then e1:SetValue(val) end
	c:RegisterEffect(e1)
end
--Spirit Link
function Auxiliary.EnableSpiritLink(c,code)
	--code: the id of the Mega Evolution Pokemon card
	local e1=Effect.CreateEffect(c)
	e1:SetType(EFFECT_TYPE_ATTACHED)
	e1:SetCode(EFFECT_DONOT_END_TURN_MEGA)
	e1:SetProperty(EFFECT_FLAG_CANNOT_DISABLE+EFFECT_FLAG_UNCOPYABLE)
	e1:SetCondition(Auxiliary.SelfCardCodeCondition(code))
	c:RegisterEffect(e1)
end
--Stadium card
function Auxiliary.EnableStadiumAttribute(c,double_sided,op_func1,op_func2)
	--double_sided: true if the player must choose which way the stadium faces before playing it
	--op_func1: operation function
	--op_func2: operation function for a double-sided stadium
	if double_sided then
		--play (double-sided stadium)
		local e1=Effect.CreateEffect(c)
		e1:SetDescription(aux.Stringid(c:GetOriginalCode(),0))
		e1:SetType(EFFECT_TYPE_IGNITION)
		e1:SetRange(LOCATION_HAND)
		e1:SetCondition(Auxiliary.StadiumCondition)
		e1:SetCost(Auxiliary.StadiumCost)
		e1:SetTarget(Auxiliary.HintTarget)
		if op_func1 then e1:SetOperation(op_func1) end
		c:RegisterEffect(e1)
		local e2=e1:Clone()
		e2:SetDescription(aux.Stringid(c:GetOriginalCode(),1))
		if op_func2 then e2:SetOperation(op_func2) end
		c:RegisterEffect(e2)
	else
		--play (non-double-sided stadium)
		local e1=Effect.CreateEffect(c)
		e1:SetType(EFFECT_TYPE_ACTIVATE)
		e1:SetCode(EVENT_FREE_CHAIN)
		e1:SetCondition(Auxiliary.StadiumCondition)
		e1:SetCost(Auxiliary.StadiumCost)
		if op_func1 then e1:SetOperation(op_func1) end
		c:RegisterEffect(e1)
	end
end
function Auxiliary.StadiumFilter(c,code)
	return c:IsFaceup() and c:IsCode(code)
end
function Auxiliary.StadiumCondition(e,tp,eg,ep,ev,re,r,rp)
	local code=e:GetHandler():GetOriginalCode()
	return Duel.IsPlayerCanPlayStadium(tp)
		and not Duel.IsExistingMatchingCard(Auxiliary.StadiumFilter,tp,LOCATION_INPLAY,LOCATION_INPLAY,1,nil,code)
end
function Auxiliary.StadiumCost(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return true end
	--register the played Stadium card for the turn
	Duel.RegisterFlagEffect(tp,EFFECT_STADIUM_CHECK,RESET_PHASE+PHASE_END,0,1)
end

--Pokemon attack
function Auxiliary.AddPokemonAttack(c,desc_id,cate,op_func,cost_func,con_func)
	--desc_id: the id of the attack's name (0-15)
	--cate: CATEGORY_GX_ATTACK if the attack is a GX attack
	--op_func: operation function
	--cost_func: cost function
	--con_func: condition function
	cate=cate or 0
	con_func=con_func or aux.TRUE
	local e1=Effect.CreateEffect(c)
	e1:SetDescription(aux.Stringid(c:GetOriginalCode(),desc_id))
	e1:SetCategory(CATEGORY_POKEMON_ATTACK+cate)
	e1:SetType(EFFECT_TYPE_IGNITION)
	e1:SetRange(LOCATION_ACTIVE)
	if bit.band(cate,CATEGORY_GX_ATTACK)~=0 then
		e1:SetCondition(aux.AND(Auxiliary.GXAttackCondition,con_func))
	else
		e1:SetCondition(con_func)
	end
	if cost_func then e1:SetCost(cost_func) end
	e1:SetTarget(Auxiliary.HintTarget)
	e1:SetOperation(op_func)
	c:RegisterEffect(e1)
	return e1
end
--add an attack to a pokemon from the attached trainer card
function Auxiliary.AddTrainerAttack(c,desc_id,cate,op_func,cost_func,con_func)
	cate=cate or 0
	con_func=con_func or aux.TRUE
	local e1=Effect.CreateEffect(c)
	e1:SetDescription(aux.Stringid(c:GetOriginalCode(),desc_id))
	e1:SetCategory(CATEGORY_POKEMON_ATTACK+cate)
	e1:SetType(EFFECT_TYPE_ATTACHED+EFFECT_TYPE_IGNITION)
	e1:SetProperty(EFFECT_FLAG_CANNOT_DISABLE+EFFECT_FLAG_UNCOPYABLE)
	e1:SetRange(LOCATION_ACTIVE)
	if bit.band(cate,CATEGORY_GX_ATTACK)~=0 then
		e1:SetCondition(aux.AND(Auxiliary.GXAttackCondition,Auxiliary.SelfActiveCondition,con_func))
	else
		e1:SetCondition(aux.AND(Auxiliary.SelfActiveCondition,con_func))
	end
	if cost_func then e1:SetCost(cost_func) end
	e1:SetTarget(Auxiliary.HintTarget)
	e1:SetOperation(op_func)
	c:RegisterEffect(e1)
	return e1
end
--operation for an attack that only does damage
function Auxiliary.AttackDamageOperation(count,apply_weak,apply_resist,apply_effect)
	return	function(e,tp,eg,ep,ev,re,r,rp)
				Duel.AttackDamage(e,count,apply_weak,apply_resist,apply_effect)
			end
end

--add an effect to a card
--e.g. "Pewter City Gym" (Gym Heroes 115/132), "Cinnabar City Gym" (Gym Challenge 113/132), "Holon Legacy" (Dragon Frontiers 74/100)
function Auxiliary.EnableEffectCustom(c,code,range,s_range,o_range,targ_func,con_func)
	--code: EFFECT_NO_WEAKNESS, EFFECT_NO_RESISTANCE, EFFECT_DISABLE_POKEBODY, etc.
	local e1=Effect.CreateEffect(c)
	if s_range or o_range then
		e1:SetType(EFFECT_TYPE_FIELD)
		e1:SetTargetRange(s_range,o_range)
		if targ_func then e1:SetTarget(targ_func) end
	else
		e1:SetType(EFFECT_TYPE_SINGLE)
	end
	e1:SetCode(code)
	e1:SetProperty(EFFECT_FLAG_UNCOPYABLE)
	if range then e1:SetRange(range) end
	if con_func then e1:SetCondition(con_func) end
	c:RegisterEffect(e1)
	return e1
end
--add a temporary effect to a card
--e.g. "Giovanni" (Gym Challenge 18/132), "Mirage Stadium" (Skyridge 132/144), "Haxorus" (Noble Victories 88/101)
function Auxiliary.AddTempEffectCustom(c,tc,desc,code,reset_flag,reset_count)
	--desc: DESC_EVOLVE_TURN, DESC_CANNOT_RETREAT, DESC_CANNOT_ATTACK, etc.
	--code: EFFECT_EVOLVE_PLAY_TURN, EFFECT_CANNOT_RETREAT, EFFECT_CANNOT_ATTACK, etc.
	reset_flag=reset_flag or 0
	if tc==c then reset_flag=reset_flag+RESET_DISABLE end
	reset_count=reset_count or 1
	local e1=Effect.CreateEffect(c)
	e1:SetDescription(desc)
	e1:SetType(EFFECT_TYPE_SINGLE)
	e1:SetCode(code)
	e1:SetProperty(EFFECT_FLAG_CANNOT_DISABLE+EFFECT_FLAG_UNCOPYABLE+EFFECT_FLAG_CLIENT_HINT)
	e1:SetReset(RESET_EVENT+RESETS_STANDARD+reset_flag,reset_count)
	tc:RegisterEffect(e1)
	return e1
end
--add an effect to a player
--e.g. "Pokemon Tower", "Broken Time-Space" (Platinum 104/127), "Full Flame" (Legend Maker 74/92)
function Auxiliary.EnablePlayerEffectCustom(c,code,range,s_range,o_range,targ_func,con_func)
	--code: EFFECT_CANNOT_TO_HAND, EFFECT_EVOLVE_PLAY_TURN, EFFECT_DONOT_REMOVE_BURNED_EVOLVE_DEVOLVE, etc.
	local e1=Effect.CreateEffect(c)
	e1:SetType(EFFECT_TYPE_FIELD)
	e1:SetCode(code)
	e1:SetProperty(EFFECT_FLAG_UNCOPYABLE+EFFECT_FLAG_PLAYER_TARGET)
	if range then e1:SetRange(range) end
	e1:SetTargetRange(s_range,o_range)
	if con_func then e1:SetCondition(con_func) end
	if targ_func then e1:SetTarget(targ_func) end
	c:RegisterEffect(e1)
	return e1
end
--"Prevent all effects of attacks, including damage done by either player's Pokemon."
--"Prevent all effects of that card done to this card"
--e.g. "Holon Circle" (Crystal Guardians 79/100), "Heat Factory Prism Star" (Lost Thunder 178/214)
function Auxiliary.EnableEffectImmune(c,val,range,s_range,o_range,targ_func)
	local e1=Effect.CreateEffect(c)
	if s_range or o_range then
		e1:SetType(EFFECT_TYPE_FIELD)
		e1:SetTargetRange(s_range,o_range)
		if targ_func then e1:SetTarget(targ_func) end
	else
		e1:SetType(EFFECT_TYPE_SINGLE)
	end
	e1:SetCode(EFFECT_IMMUNE_EFFECT)
	e1:SetProperty(EFFECT_FLAG_UNCOPYABLE+EFFECT_FLAG_SINGLE_RANGE)
	if range then e1:SetRange(range) end
	e1:SetValue(val)
	c:RegisterEffect(e1)
	return e1
end
--e.g. "Mewtwo" (Base Set 10/102), "Ancient Technical Machine [Ice]" (Hidden Legends 84/101)
function Auxiliary.AddTempEffectImmune(c,tc,desc,val,reset_flag,reset_count)
	--desc: DESC_IMMUNE_ATTACK, DESC_IMMUNE_EFFECT, etc.
	--val: aux.AttackImmuneFilter if immune to all attack effects
	reset_flag=reset_flag or 0
	reset_count=reset_count or 1
	local e1=Effect.CreateEffect(c)
	e1:SetDescription(desc)
	e1:SetType(EFFECT_TYPE_SINGLE)
	e1:SetCode(EFFECT_IMMUNE_EFFECT)
	e1:SetProperty(EFFECT_FLAG_CANNOT_DISABLE+EFFECT_FLAG_UNCOPYABLE+EFFECT_FLAG_CLIENT_HINT)
	e1:SetRange(LOCATION_INPLAY)
	e1:SetValue(val)
	e1:SetReset(RESET_EVENT+RESETS_STANDARD+reset_flag,reset_count)
	c:RegisterEffect(e1)
	return e1
end
--"All damage done by a Pokemon's attacks is increased/reduced by N."
--e.g. "Sprout Tower" (Neo Genesis 97/111), "Drake's Stadium" (Power Keepers 72/108)
function Auxiliary.EnableUpdateDamage(c,code,val,range,s_range,o_range,targ_func,con_func)
	--code: EFFECT_UPDATE_ATTACK_BEFORE, EFFECT_UPDATE_DEFEND_AFTER, etc.
	local e1=Effect.CreateEffect(c)
	if s_range or o_range then
		e1:SetType(EFFECT_TYPE_FIELD)
		e1:SetTargetRange(s_range,o_range)
		if targ_func then e1:SetTarget(targ_func) end
	else
		e1:SetType(EFFECT_TYPE_SINGLE)
	end
	e1:SetCode(code)
	e1:SetProperty(EFFECT_FLAG_UNCOPYABLE)
	if range then e1:SetRange(range) end
	if con_func then e1:SetCondition(con_func) end
	e1:SetValue(val)
	c:RegisterEffect(e1)
	return e1
end
--e.g. "Registeel-EX" (Dragons Exalted 81/124), "Mewtwo-EX" (BREAKthrough 61/162)
function Auxiliary.AddTempEffectUpdateDamage(c,tc,desc,code,val,reset_flag,reset_count)
	--desc: DESC_TAKE_LESS_DAMAGE, DESC_DO_LESS_DAMAGE
	--code: EFFECT_UPDATE_DEFEND_AFTER, EFFECT_UPDATE_ATTACK_BEFORE, etc.
	reset_flag=reset_flag or 0
	if tc==c then reset_flag=reset_flag+RESET_DISABLE end
	reset_count=reset_count or 1
	local e1=Effect.CreateEffect(c)
	e1:SetDescription(desc)
	e1:SetType(EFFECT_TYPE_SINGLE)
	e1:SetCode(code)
	e1:SetProperty(EFFECT_FLAG_CANNOT_DISABLE+EFFECT_FLAG_UNCOPYABLE+EFFECT_FLAG_CLIENT_HINT)
	e1:SetValue(val)
	e1:SetReset(RESET_EVENT+RESETS_STANDARD+reset_flag,reset_count)
	tc:RegisterEffect(e1)
	return e1
end
--e.g. "Smeargle" (Black Star Promo Wizards of the Coast 32), "Kingdra" (Aquapolis 148/147)
function Auxiliary.AddTempEffectChangeEnergyType(c,tc,val,reset_flag,reset_count)
	reset_flag=reset_flag or 0
	if tc==c then reset_flag=reset_flag+RESET_DISABLE end
	reset_count=reset_count or 1
	local e1=Effect.CreateEffect(c)
	e1:SetDescription(DESC_TYPE_CHANGED)
	e1:SetType(EFFECT_TYPE_SINGLE)
	e1:SetCode(EFFECT_CHANGE_ENERGY_TYPE)
	e1:SetProperty(EFFECT_FLAG_CANNOT_DISABLE+EFFECT_FLAG_UNCOPYABLE+EFFECT_FLAG_CLIENT_HINT)
	e1:SetValue(val)
	e1:SetReset(RESET_EVENT+RESETS_STANDARD+reset_flag,reset_count)
	tc:RegisterEffect(e1)
	return e1
end
--target and operation functions for a draw effect
--e.g. "Bill" (Base Set 91/102), "Erika" (Gym Heroes 16/132)
function Auxiliary.DrawTarget(p)
	--p: the player who draws cards (PLAYER_SELF for you or PLAYER_OPPO for opponent)
	return	function(e,tp,eg,ep,ev,re,r,rp,chk)
				local player=(p==PLAYER_SELF and tp) or (p==PLAYER_OPPO and 1-tp)
				if chk==0 then return Duel.IsPlayerCanDraw(player,1) end
			end
end
function Auxiliary.DrawOperation(p,ct,bottom)
	--ct: the number of cards to draw
	--bottom: true to draw cards from the bottom of the deck instead of the top
	return	function(e,tp,eg,ep,ev,re,r,rp)
				local player=(p==PLAYER_SELF and tp) or (p==PLAYER_OPPO and 1-tp)
				Duel.Draw(player,ct,REASON_EFFECT,bottom)
			end
end
--target and operation functions for a switch effect
--e.g. "Gust of Wind" (Base Set 93/102), "Switch" (Base Set 95/102), "Escape Rope" (Plasma Storm 120/135)
function Auxiliary.SwitchTarget(p,f1,f2)
	--p: the player whose pokemon to switch (PLAYER_SELF for you or PLAYER_OPPO for opponent)
	--f1: filter function if the active pokemon is specified
	--f2: filter function if the benched pokemon is specified
	return	function(e,tp,eg,ep,ev,re,r,rp,chk)
				local player=(p==PLAYER_SELF and tp) or (p==PLAYER_OPPO and 1-tp)
				local tc=Duel.GetActivePokemon(player)
				local g=Duel.GetBenchedPokemon(player)
				if chk==0 then
					if f1 and not f1(tc) then return false end
					if f2 and not g:IsExists(f2,1,nil) then return false end
					return tc and g:GetCount()>0
				end
			end
end
function Auxiliary.SwitchOperation(p1,p2,f1,f2)
	--p1: the player who switches the pokemon (PLAYER_SELF for you or PLAYER_OPPO for opponent)
	--p2: the player whose pokemon to switch (PLAYER_SELF for you or PLAYER_OPPO for opponent)
	return	function(e,tp,eg,ep,ev,re,r,rp)
				local switch_player=(p1==PLAYER_SELF and tp) or (p1==PLAYER_OPPO and 1-tp)
				local target_player=(p2==PLAYER_SELF and tp) or (p2==PLAYER_OPPO and 1-tp)
				Duel.SwitchPokemon(switch_player,target_player,f1,f2)
			end
end
--target and operation functions for a trainer card that can be played as if it were a basic pokemon
--e.g. "Clefairy Doll" (Base Set 70/102), "Mysterious Fossil" (Fossil 62/62), "Claw Fossil" (Sandstorm 90/100)
function Auxiliary.PlayTrainerPokemonTarget(hp,setcode)
	--hp: the amount of hp the pokemon has
	--setcode: if the pokemon has a supported name in its card name (e.g. SETNAME_FOSSIL)
	return	function(e,tp,eg,ep,ev,re,r,rp,chk)
				setcode=setcode or 0
				local code=e:GetHandler():GetCode()
				if chk==0 then return Duel.IsNotBenchFull(tp)
					and Duel.IsPlayerCanPlayPokemon(tp,code,setcode,TYPE_POKEMON,hp,hp,0,0,ENERGY_C) end
			end
end
function Auxiliary.PlayTrainerPokemonOperation(hp,setcode,enable_trainer,immune_spc,cannot_take_prize)
	--enable_trainer: false if the pokemon does not count as a trainer card (counts as a trainer card by default)
	--immune_spc: false if not immune to special conditions (immune to special conditions by default)
	--cannot_take_prize: false if the opponent does take a prize card if knocked out (does not take prize by default)
	return	function(e,tp,eg,ep,ev,re,r,rp)
				setcode=setcode or 0
				enable_trainer=enable_trainer or true
				immune_spc=immune_spc or true
				cannot_take_prize=cannot_take_prize or true
				local c=e:GetHandler()
				local code=c:GetCode()
				local attribute=TYPE_POKEMON+TYPE_TRAINER and enable_trainer or TYPE_POKEMON
				if not c:IsRelateToEffect(e)
					or not Duel.IsPlayerCanPlayPokemon(tp,code,setcode,TYPE_POKEMON,hp,hp,0,0,ENERGY_C)
					or Duel.IsBenchFull(tp) then return end
				c:AddPokemonAttribute(attribute)
				Duel.PlayPokemonStep(c,0,tp,tp,true,false,POS_FACEUP_UPSIDE)
				c:AddPokemonAttributeComplete()
				--no retreat cost
				c:SetStatus(STATUS_NO_RETREAT_COST,true)
				--treat as basic pokemon
				local e1=Effect.CreateEffect(c)
				e1:SetDescription(DESC_BASIC_POKEMON)
				e1:SetType(EFFECT_TYPE_SINGLE)
				e1:SetCode(TYPE_BASIC_POKEMON)
				e1:SetProperty(EFFECT_FLAG_CANNOT_DISABLE+EFFECT_FLAG_UNCOPYABLE+EFFECT_FLAG_CLIENT_HINT)
				e1:SetReset(RESET_EVENT+RESETS_STANDARD-RESET_TURN_SET)
				c:RegisterEffect(e1,true)
				--discard self
				local e2=Effect.CreateEffect(c)
				e2:SetDescription(DESC_SELF_DISCARD)
				e2:SetType(EFFECT_TYPE_IGNITION)
				e2:SetProperty(EFFECT_FLAG_CANNOT_DISABLE+EFFECT_FLAG_UNCOPYABLE)
				e2:SetRange(LOCATION_INPLAY)
				e2:SetOperation(Auxiliary.SelfDiscardOperation)
				e2:SetReset(RESET_EVENT+RESETS_STANDARD-RESET_TURN_SET)
				c:RegisterEffect(e2,true)
				--cannot retreat
				local e3=e1:Clone()
				e3:SetDescription(DESC_CANNOT_RETREAT)
				e3:SetCode(EFFECT_CANNOT_RETREAT)
				c:RegisterEffect(e3,true)
				if immune_spc then
					--immune to special conditions
					local e4=e1:Clone()
					e4:SetDescription(DESC_IMMUNE_SPC)
					e4:SetCode(EFFECT_IMMUNE_SPECIAL_CONDITION)
					c:RegisterEffect(e4,true)
				end
				if cannot_take_prize then
					--cannot take prize
					local e5=e1:Clone()
					e5:SetCode(EFFECT_CANNOT_TAKE_PRIZE)
					e5:SetReset(RESET_EVENT+RESET_TOFIELD+RESET_ATTACH)
					c:RegisterEffect(e5,true)
				end
				Duel.PlayPokemonComplete()
			end
end
function Auxiliary.SelfDiscardOperation(e,tp,eg,ep,ev,re,r,rp)
	local c=e:GetHandler()
	if c:IsRelateToEffect(e) and c:IsInPlay() then
		Duel.SendtoDPile(c,REASON_EFFECT+REASON_DISCARD)
	end
end
--"Each Pokemon in play (both yours and your opponent's) gets +N HP."
--e.g. "Rocket's Hideout" (Neo Revelation 63/64)
function Auxiliary.EnableUpdateHP(c,val,range,s_range,o_range,targ_func)
	local e1=Effect.CreateEffect(c)
	e1:SetType(EFFECT_TYPE_FIELD)
	e1:SetCode(EFFECT_UPDATE_MAX_HP)
	e1:SetProperty(EFFECT_FLAG_UNCOPYABLE)
	e1:SetRange(range)
	e1:SetTargetRange(s_range,o_range)
	if targ_func then e1:SetTarget(targ_func) end
	e1:SetValue(val)
	c:RegisterEffect(e1)
	return e1
end
--e.g. "Focus Band" (Neo Genesis 86/111)
function Auxiliary.AddTempEffectSetRemHP(c,tc,val,reset_flag,reset_count)
	reset_flag=reset_flag or 0
	if tc==c then reset_flag=reset_flag+RESET_DISABLE end
	reset_count=reset_count or 1
	local e1=Effect.CreateEffect(c)
	e1:SetType(EFFECT_TYPE_SINGLE)
	e1:SetCode(EFFECT_SET_REMAINING_HP)
	e1:SetProperty(EFFECT_FLAG_CANNOT_DISABLE+EFFECT_FLAG_UNCOPYABLE)
	e1:SetValue(val)
	e1:SetReset(RESET_EVENT+RESETS_STANDARD+reset_flag,reset_count)
	tc:RegisterEffect(e1)
	return e1
end
--"The Retreat Cost of each Pokemon in play (both yours and your opponent's) is [X] more/less."
--e.g. "The Rocket's Training Gym" (Gym Heroes 104/132), "Cerulean City Gym" (Gym Heroes 108/132)
function Auxiliary.EnableUpdateRetreatCost(c,val,range,s_range,o_range,targ_func)
	local e1=Effect.CreateEffect(c)
	e1:SetType(EFFECT_TYPE_FIELD)
	e1:SetCode(EFFECT_UPDATE_RETREAT_COST)
	e1:SetProperty(EFFECT_FLAG_UNCOPYABLE)
	e1:SetRange(range)
	e1:SetTargetRange(s_range,o_range)
	if targ_func then e1:SetTarget(targ_func) end
	e1:SetValue(val)
	c:RegisterEffect(e1)
	return e1
end
--"The Retreat Cost for each Pokemon (both yours and your opponent's) is 0."
--"Each Pokemon (both yours and your opponent's) has no Retreat Cost."
--e.g. "Moonlight Stadium" (Great Encounters 100/106), "Fairy Garden" (XY 117/146)
function Auxiliary.EnableChangeRetreatCost(c,val,range,s_range,o_range,targ_func)
	local e1=Effect.CreateEffect(c)
	e1:SetType(EFFECT_TYPE_FIELD)
	e1:SetCode(EFFECT_CHANGE_RETREAT_COST)
	e1:SetProperty(EFFECT_FLAG_UNCOPYABLE)
	e1:SetRange(range)
	e1:SetTargetRange(s_range,o_range)
	if targ_func then e1:SetTarget(targ_func) end
	e1:SetValue(val)
	c:RegisterEffect(e1)
	return e1
end
--e.g. "Probopass G" (Black Star Promo DP43)
function Auxiliary.AddTempEffectChangeRetreatCost(c,tc,val,reset_flag,reset_count)
	reset_flag=reset_flag or 0
	if tc==c then reset_flag=reset_flag+RESET_DISABLE end
	reset_count=reset_count or 1
	local e1=Effect.CreateEffect(c)
	e1:SetDescription(DESC_RETREAT_COST_CHANGED)
	e1:SetType(EFFECT_TYPE_SINGLE)
	e1:SetCode(EFFECT_CHANGE_RETREAT_COST)
	e1:SetProperty(EFFECT_FLAG_CANNOT_DISABLE+EFFECT_FLAG_UNCOPYABLE+EFFECT_FLAG_CLIENT_HINT)
	e1:SetValue(val)
	e1:SetReset(RESET_EVENT+RESETS_STANDARD+reset_flag,reset_count)
	tc:RegisterEffect(e1)
	return e1
end

--condition to check who the turn player is
function Auxiliary.TurnPlayerCondition(p)
	--p: the player to check (PLAYER_SELF for you or PLAYER_OPPO for opponent)
	return	function(e)
				local tp=e:GetHandlerPlayer()
				local player=(p==PLAYER_SELF and tp) or (p==PLAYER_OPPO and 1-tp)
				return Duel.GetTurnPlayer()==player
			end
end
--condition for attacks
function Auxiliary.AttackCostCondition(...)
	--...: the energy required for the attack
	local energy_list={...}
	return	function(e,tp,eg,ep,ev,re,r,rp)
				local c=e:GetHandler()
				return c:IsCanAttack(e) and c:CheckAttackCost(table.unpack(energy_list))
			end
end
--condition for a pokemon to be active
function Auxiliary.SelfActiveCondition(e,tp,eg,ep,ev,re,r,rp)
	local c=e:GetHandler()
	return c:IsFaceup() and c:IsPokemon() and c:IsActive()
end
--condition for a pokemon to be benched
function Auxiliary.SelfBenchedCondition(e,tp,eg,ep,ev,re,r,rp)
	local c=e:GetHandler()
	return c:IsFaceup() and c:IsPokemon() and c:IsBenched()
end
--condition for a card to be played from the hand
--e.g. "Rainbow Energy" (Team Rocket 17/82), "Giovanni's Persian" (Gym Challenge 8/132)
function Auxiliary.PlayedFromHandCondition(playtype)
	return	function(e,tp,eg,ep,ev,re,r,rp)
				return e:GetHandler():IsPlayedFromHand(playtype)
			end
end
--condition for a card to be a Basic Pokemon card
--e.g. "Eviolite" (Noble Victories 91/101)
function Auxiliary.SelfBasicPokemonCondition(e,tp,eg,ep,ev,re,r,rp)
	return e:GetHandler():IsBasicPokemon()
end
--condition for a card to be a Stage 1 Pokemon card
--e.g. "Bodybuilding Dumbbells" (Burning Shadows 113/147)
function Auxiliary.SelfStage1Condition(e,tp,eg,ep,ev,re,r,rp)
	return e:GetHandler():IsStage1()
end
--condition for a card to be an evolved card
--e.g. "Boost Energy" (Aquapolis 145/147)
function Auxiliary.SelfEvolvedCondition(e,tp,eg,ep,ev,re,r,rp)
	return e:GetHandler():IsEvolved()
end
--condition for a card to be a Pokemon-ex card
--e.g. "Mysterious Shard" (Crystal Guardians 81/100)
function Auxiliary.SelfPokemonexCondition(e,tp,eg,ep,ev,re,r,rp)
	return e:GetHandler():IsPokemonex()
end
--condition for a card to be a Pokemon SP card
--e.g. "Team Galactic's Invention G-101 Energy Gain" (Platinum 116/127)
function Auxiliary.SelfPokemonSPCondition(e,tp,eg,ep,ev,re,r,rp)
	return e:GetHandler():IsPokemonSP()
end
--condition for a card to be a Pokemon-EX card
--e.g. "Head Ringer Team Flare Hyper Gear" (Phantom Forces 97/119)
function Auxiliary.SelfPokemonEXCondition(e,tp,eg,ep,ev,re,r,rp)
	return e:GetHandler():IsPokemonEX()
end
--condition for a card to be an Ultra Beast card
--e.g. "Beast Energy Prism Star" (Forbidden Light 117/131)
function Auxiliary.SelfUltraBeastCondition(e,tp,eg,ep,ev,re,r,rp)
	return e:GetHandler():IsUltraBeast()
end
--condition for a card to have an HP of N or less
--e.g. "Healing Berry" (Aquapolis 125/147)
function Auxiliary.SelfHPBelowCondition(hp)
	return	function(e,tp,eg,ep,ev,re,r,rp)
				return e:GetHandler():IsRemainingHPBelow(hp)
			end
end
--condition for a card to have a Retreat Cost of N or more
--e.g. "Heavy Boots" (BREAKthrough 141/162)
function Auxiliary.SelfRCAboveCondition(cost)
	return	function(e,tp,eg,ep,ev,re,r,rp)
				return e:GetHandler():IsRetreatCostAbove(cost)
			end
end
--condition for a card to have a particular energy type
--e.g. "Metal Energy" (Neo Genesis 19/111)
function Auxiliary.SelfEnergyTypeCondition(energy_type)
	return	function(e,tp,eg,ep,ev,re,r,rp)
				return e:GetHandler():IsEnergyType(energy_type)
			end
end
--condition for a card to have a particular card name
--e.g. "Crystal Edge" (Boundaries Crossed 138/149), "Ancient Crystal" (Ultra Prism 118/156)
function Auxiliary.SelfCardCodeCondition(...)
	local card_code_list={...}
	return	function(e,tp,eg,ep,ev,re,r,rp)
				for _,code in ipairs(card_code_list) do
					if e:GetHandler():IsCode(code) then return true end
				end
				return false
			end
end
--condition for a card to have a particular setcode
--e.g. "R Energy" (Team Rocket Returns 95/109), "Aqua Diffuser" (Double Crisis 23/34)
function Auxiliary.SelfSetCardCondition(...)
	local setcode_list={...}
	return	function(e,tp,eg,ep,ev,re,r,rp)
				for _,setcode in ipairs(setcode_list) do
					if e:GetHandler():IsSetCard(setcode) then return true end
				end
				return false
			end
end
--condition for a pokemon to use a pokemon power
--e.g. "Goop Gas Attack" (Team Rocket 78/82)
function Auxiliary.PokemonPowerCondition(e,tp,eg,ep,ev,re,r,rp)
	return e:GetHandler():IsCanUsePokemonPower()
end
--condition for a pokemon to use a poke-power
--e.g. "Mt. Moon" (FireRed & LeafGreen 94/112)
function Auxiliary.PokePowerCondition(e,tp,eg,ep,ev,re,r,rp)
	return e:GetHandler():IsCanUsePokePower()
end
--condition for a pokemon to use a poke-body
--e.g. "Space Center" (Deoxys 91/107)
function Auxiliary.PokeBodyCondition(e,tp,eg,ep,ev,re,r,rp)
	return e:GetHandler():IsCanUsePokeBody()
end
--condition for a pokemon to use an ability
--e.g. "Silent Lab" (Primal Clash 140/160)
function Auxiliary.AbilityCondition(e,tp,eg,ep,ev,re,r,rp)
	return e:GetHandler():IsCanUseAbility()
end
--condition for a pokemon to use a gx attack
--e.g. "Snorlax-GX" (Black Star Promo SM05)
function Auxiliary.GXAttackCondition(e,tp,eg,ep,ev,re,r,rp)
	return e:GetHandler():IsCanUseGXAttack()
end
--condition for a pokemon to use a pokemon tool's effect
--e.g. "Lysandre Labs" (Forbidden Light 111/131)
function Auxiliary.UsePokemonToolCondition(e,tp,eg,ep,ev,re,r,rp)
	return e:GetHandler():IsCanUsePokemonTool()
end
--condition for a pokemon to be affected by a special condition
--e.g. "Miracle Berry" (Neo Genesis 94/111)
function Auxiliary.AffectedBySpecialCondition(e,tp,eg,ep,ev,re,r,rp)
	return e:GetHandler():IsAffectedBySpecialCondition()
end
--condition for a pokemon to not be affected by a special condition
--e.g. "Charizard" (Base Set 4/102)
function Auxiliary.NotAffectedBySpecialCondition(e,tp,eg,ep,ev,re,r,rp)
	return not e:GetHandler():IsAffectedBySpecialCondition()
end
--condition to check if a player is going second
--e.g. "Wait and See Hammer" (Lost Thunder 192/214)
function Auxiliary.GoingSecondCondition(p)
	--p: the player to check (PLAYER_SELF for you or PLAYER_OPPO for opponent)
	return	function(e,tp,eg,ep,ev,re,r,rp)
				local player=(p==PLAYER_SELF and tp) or (p==PLAYER_OPPO and 1-tp)
				return Duel.GetTurnCount()==2 and Duel.GetTurnPlayer()==player
			end
end
--cost for discarding a card from the hand
function Auxiliary.DiscardHandCost(min,max,f,...)
	--min,max: the number of cards to discard (nil to discard all cards)
	--f: filter function if the card is specified
	local ext_params={...}
	return	function(e,tp,eg,ep,ev,re,r,rp,chk)
				local minc=min or 1
				local maxc=max or minc
				local filt_func=function(c,f,ext_params)
					return c:IsDiscardable() and (not f or f(c,table.unpack(ext_params)))
				end
				local c=e:GetHandler()
				if chk==0 then return Duel.IsExistingMatchingCard(filt_func,tp,LOCATION_HAND,0,minc,c,f,ext_params) end
				if min then
					Duel.DiscardHand(tp,filt_func,minc,maxc,REASON_COST+REASON_DISCARD,c,f,ext_params)
				else
					local g=Duel.GetMatchingGroup(filt_func,tp,LOCATION_HAND,0,c,f,ext_params)
					Duel.SendtoDPile(g,REASON_COST+REASON_DISCARD)
				end
			end
end
--cost for putting a card into the deck
function Auxiliary.SendtoDeckCost(f,location,min,max,seq,...)
	--f: filter function if the card is specified
	--location: the location to send the card from
	--min,max: the number of cards to send (nil to send all cards)
	--seq: where to put the card in the deck (SEQ_DECK_SHUFFLE by default)
	local ext_params={...}
	return	function(e,tp,eg,ep,ev,re,r,rp,chk)
				local minc=min or 1
				local maxc=max or minc
				seq=seq or SEQ_DECK_SHUFFLE
				local filt_func=function(c,f,ext_params)
					return c:IsAbleToDeckAsCost() and (not f or f(c,table.unpack(ext_params)))
				end
				local c=e:GetHandler()
				if chk==0 then return Duel.IsExistingMatchingCard(filt_func,tp,location,0,minc,c,f,ext_params) end
				if min then
					Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_TODECK)
					local g=Duel.SelectMatchingCard(tp,filt_func,tp,location,0,minc,maxc,c,f,ext_params)
					if f then Duel.ConfirmCards(1-tp,g) end
					Duel.SendtoDeck(g,PLAYER_OWNER,seq,REASON_COST)
				else
					local g=Duel.GetMatchingGroup(filt_func,tp,location,0,c,f,ext_params)
					if f then Duel.ConfirmCards(1-tp,g) end
					Duel.SendtoDeck(g,PLAYER_OWNER,seq,REASON_COST)
				end
			end
end
--cost for discarding a card from a pokemon
function Auxiliary.DiscardAttachedCost(f,min,max,...)
	--f: filter function if the card is specified
	--min,max: the number of cards to discard
	local ext_params={...}
	return	function(e,tp,eg,ep,ev,re,r,rp,chk)
				local minc=min or 1
				local maxc=max or minc
				local c=e:GetHandler()
				local g=c:GetAttachedGroup()
				if chk==0 then return g:IsExists(f,minc,nil,table.unpack(ext_params)) end
				Duel.DiscardAttached(tp,c,f,minc,maxc,REASON_COST,nil,table.unpack(ext_params))
			end
end
--target for Duel.Hint(HINT_OPSELECTED,1-tp,e:GetDescription())
function Auxiliary.HintTarget(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return true end
	Duel.Hint(HINT_OPSELECTED,1-tp,e:GetDescription())
end
--target to check if a card exists in a location
function Auxiliary.CheckCardFunction(f,s,o,count,ex,...)
	--f: filter function if the card is specified
	--s: your location
	--o: opponent's location
	--count: the number of cards that must exist
	--ex: the cards to exclude
	local ext_params={...}
	return	function(e,tp,eg,ep,ev,re,r,rp,chk)
				count=count or 1
				local exg=Group.CreateGroup()
				if type(ex)=="Card" then exg:AddCard(ex)
				elseif type(ex)=="Group" then exg:Merge(ex) end
				if chk==0 then return Duel.IsExistingMatchingCard(f,tp,s,o,count,exg,table.unpack(ext_params)) end
				if e:GetHandler():IsPokemon() then Duel.Hint(HINT_OPSELECTED,1-tp,e:GetDescription()) end
			end
end
--target to check if a player has cards in their hand
function Auxiliary.CheckHandFunction(p)
	--p: the player to check (PLAYER_SELF for you or PLAYER_OPPO for opponent)
	return	function(e,tp,eg,ep,ev,re,r,rp,chk)
				local player=(p==PLAYER_SELF and tp) or (p==PLAYER_OPPO and 1-tp)
				if chk==0 then return Duel.GetFieldGroupCount(player,LOCATION_HAND,0)>0 end
				if e:GetHandler():IsPokemon() then Duel.Hint(HINT_OPSELECTED,1-tp,e:GetDescription()) end
			end
end
--target to check if a player has cards in their deck
function Auxiliary.CheckDeckFunction(p)
	return	function(e,tp,eg,ep,ev,re,r,rp,chk)
				local player=(p==PLAYER_SELF and tp) or (p==PLAYER_OPPO and 1-tp)
				if chk==0 then return Duel.GetFieldGroupCount(player,LOCATION_DECK,0)>0 end
				if e:GetHandler():IsPokemon() then Duel.Hint(HINT_OPSELECTED,1-tp,e:GetDescription()) end
			end
end
--filter for active pokemon
function Auxiliary.ActivePokemonFilter(f)
	--f: filter function
	return	function(target,...)
				return target:IsFaceup() and target:IsPokemon() and target:IsActive() and (not f or f(target,...))
			end
end
--filter for pokemon on the bench
function Auxiliary.BenchedPokemonFilter(f)
	--f: filter function
	return	function(target,...)
				return target:IsFaceup() and target:IsPokemon() and target:IsBenched() and (not f or f(target,...))
			end
end
--filter for prize cards
function Auxiliary.PrizeFilter(f)
	--f: filter function
	return	function(target,...)
				return target:IsPrize() and (not f or f(target,...))
			end
end
--filter for the lost zone
function Auxiliary.LostZoneFilter(f)
	--f: filter function
	return	function(target,...)
				return target:IsFaceup() and not target:IsPrize() and (not f or f(target,...))
			end
end
--filter for an effect that makes a pokemon immune to all effects done by attacks
--e.g. "Mewtwo" (Base Set 10/102), "Holon Circle" (Crystal Guardians 79/100)
function Auxiliary.AttackImmuneFilter(e,te)
	return te:IsHasCategory(CATEGORY_POKEMON_ATTACK)
end
--filter for an effect that makes a pokemon immune to all effects done by the opponent's attacks
--e.g. "Holon Energy WP" (Delta Species 106/113), "Sky Pillar" (Celestial Storm 144/168)
function Auxiliary.AttackImmuneOppoFilter(e,te)
	return te:IsHasCategory(CATEGORY_POKEMON_ATTACK) and te:GetOwnerPlayer()~=e:GetHandlerPlayer()
end
--utility entry for SelectUnselect loops
--returns bool if chk==0, returns Group if chk==1
function Auxiliary.SelectUnselectLoop(c,sg,mg,e,tp,minc,maxc,rescon)
	local res
	if sg:GetCount()>=maxc then return false end
	sg:AddCard(c)
	if sg:GetCount()<minc then
		res=mg:IsExists(Auxiliary.SelectUnselectLoop,1,sg,sg,mg,e,tp,minc,maxc,rescon)
	elseif sg:GetCount()<maxc then
		res=(not rescon or rescon(sg,e,tp,mg)) or mg:IsExists(Auxiliary.SelectUnselectLoop,1,sg,sg,mg,e,tp,minc,maxc,rescon)
	else
		res=(not rescon or rescon(sg,e,tp,mg))
	end
	sg:RemoveCard(c)
	return res
end
function Auxiliary.SelectUnselectGroup(g,e,tp,minc,maxc,rescon,chk,seltp,hintmsg,cancelcon,breakcon)
	local minc=minc and minc or 1
	local maxc=maxc and maxc or 99
	if chk==0 then return g:IsExists(Auxiliary.SelectUnselectLoop,1,nil,Group.CreateGroup(),g,e,tp,minc,maxc,rescon) end
	local hintmsg=hintmsg and hintmsg or 0
	local sg=Group.CreateGroup()
	while true do
		local cancel=sg:GetCount()>=minc and (not cancelcon or cancelcon(sg,e,tp,g))
		local mg=g:Filter(Auxiliary.SelectUnselectLoop,sg,sg,g,e,tp,minc,maxc,rescon)
		if (breakcon and breakcon(sg,e,tp,mg)) or mg:GetCount()<=0 or sg:GetCount()>=maxc then break end
		Duel.Hint(HINT_SELECTMSG,seltp,hintmsg)
		local tc=mg:SelectUnselect(sg,seltp,cancel,cancel)
		if not tc then break end
		if sg:IsContains(tc) then
			sg:RemoveCard(tc)
		else
			sg:AddCard(tc)
		end
	end
	return sg
end
--Description (for SetDescription, EFFECT_FLAG_CLIENT_HINT)
DESC_BROCKS_PROTECTION_G2101	=aux.Stringid(10007101,0)	--Energy can't be removed by opp's attacks or Trainers
DESC_KOGAS_NINJA_TRICK_G2115	=aux.Stringid(10007115,1)	--May switch with Benched Pokemon when attacked
DESC_TIME_SHARD_AQ135			=aux.Stringid(10014135,1)	--Owner may return basic Energy to hand when KO'd
DESC_LUCKY_EGG_AR88				=aux.Stringid(10042088,1)	--Owner draws card(s) when KO'd
DESC_REVERSAL_TRIGGER_PLB86		=aux.Stringid(10057086,1)	--Owner searches deck when KO'd
DESC_ENERGY_POUCH_FCO97			=aux.Stringid(10069097,1)	--Owner returns basic Energy to hand when KO'd
DESC_WISHFUL_BATON_BUS128		=aux.Stringid(10074128,1)	--Owner moves basic Energy to another Pokemon when KO'd
DESC_SPELL_TAG_LOT190			=aux.Stringid(10081190,1)	--Put damage counter(s) on opp's Pokemon when KO'd
DESC_LUCKY_HELMET_AOR77			=aux.Stringid(10065077,1)	--Owner draws card(s) when damaged
DESC_MYSTERIOUS_SHARD_CG81		=aux.Stringid(10029081,0)	--Immune to all effects of attacks by opp's Pokemon-ex
DESC_ARCEUS_AR9					=aux.Stringid(10042111,1)	--Immune to all effects of attacks by Pokemon LV.X
DESC_SILVER_MIRROR_PLB89		=aux.Stringid(10057089,0)	--Immune to all effects of attacks by opp's Team Plasma non-EX
DESC_PROTECTION_CUBE_FLF95		=aux.Stringid(10060095,0)	--Immune to damage from own attacks
DESC_FAIRY_CHARM_G_LOT174		=aux.Stringid(10081174,0)	--Immune to damage from attacks by opp's [G]-GX and [G]-EX
DESC_FAIRY_CHARM_P_LOT175		=aux.Stringid(10081175,0)	--Immune to damage from attacks by opp's [P]-GX and [P]-EX
DESC_FAIRY_CHARM_F_LOT176		=aux.Stringid(10081176,0)	--Immune to damage from attacks by opp's [F]-GX and [F]-EX
DESC_FAIRY_CHARM_N_LOT177		=aux.Stringid(10081177,0)	--Immune to damage from attacks by opp's [N]-GX and [N]-EX
DESC_FAIRY_CHARM_L_UNB172		=aux.Stringid(10083172,0)	--Immune to damage from attacks by opp's [L]-GX and [L]-EX
DESC_FAIRY_CHARM_UB_TEU142		=aux.Stringid(10082142,0)	--Immune to damage from attacks by opp's UB GX and UB EX
DESC_FAIRY_CHARM_AB_UNB171		=aux.Stringid(10083171,0)	--Immune to damage from attacks by opp's GX and EX with Abilities
DESC_METAL_GOGGLES_TEU148		=aux.Stringid(10082148,0)	--Immune to damage counters from opp's attacks and Abilities
DESC_AMULET_COIN_GE97			=aux.Stringid(10035097,1)	--Owner draws card(s) during Checkup
DESC_ENERGY_LINK_SF83			=aux.Stringid(10038083,1)	--Owner may move Energy between Pokemon
DESC_TEAM_PLASMA_BADGE_PLF104	=aux.Stringid(10056104,0)	--Joined Team Plasma
DESC_HEALING_SCARF_ROS84		=aux.Stringid(10064084,1)	--Heal when Energy is attached
DESC_WIDE_LENS_ROS95			=aux.Stringid(10064095,0)	--Apply Weakness and Resistance for opp's Benched Pokemon
DESC_DASHING_POUCH_CIN92		=aux.Stringid(10076092,0)	--Owner puts Energy into their hand when retreating
DESC_DARKRAI_PRISM_STAR_UPR77	=aux.Stringid(10077077,2)	--This player must flip extra coins to awaken their Pokemon
DESC_BONNIE_FLI103				=aux.Stringid(10078103,0)	--Can use GX attack
--
function loadutility(file)
	local f=loadfile("expansions/script/"..file)
	if f==nil then
		dofile("script/"..file)
	else
		f()
	end
end
loadutility("bit.lua")
loadutility("card.lua")
loadutility("duel.lua")
loadutility("effect.lua")
loadutility("group.lua")
loadutility("lua.lua")
loadutility("rule.lua")
loadutility("table.lua")
