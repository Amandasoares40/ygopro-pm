--Crystal Energy (Aquapolis 146/147)
--Note: Update this script if a new basic Energy card is introduced
local scard,sid=aux.GetID()
function scard.initial_effect(c)
	--energy
	aux.EnableEnergyAttribute(c)
	--provide energy
	aux.EnableProvideEnergy(c,scard.val1)
end
scard.energy_special=true
--provide energy
function scard.val1(e,c)
	local tc=c:GetAttachedTarget()
	if not tc then return false end
	local g=tc:GetAttachedGroup()
	if not g:IsExists(Card.IsBasicEnergy,1,nil) then return ENERGY_C end
	local val=0
	if g:IsExists(Card.IsEnergy,1,nil,ENERGY_G) then val=val+ENERGY_G end
	if g:IsExists(Card.IsEnergy,1,nil,ENERGY_R) then val=val+ENERGY_R end
	if g:IsExists(Card.IsEnergy,1,nil,ENERGY_W) then val=val+ENERGY_W end
	if g:IsExists(Card.IsEnergy,1,nil,ENERGY_L) then val=val+ENERGY_L end
	if g:IsExists(Card.IsEnergy,1,nil,ENERGY_P) then val=val+ENERGY_P end
	if g:IsExists(Card.IsEnergy,1,nil,ENERGY_F) then val=val+ENERGY_F end
	if g:IsExists(Card.IsEnergy,1,nil,ENERGY_D) then val=val+ENERGY_D end
	if g:IsExists(Card.IsEnergy,1,nil,ENERGY_M) then val=val+ENERGY_M end
	if g:IsExists(Card.IsEnergy,1,nil,ENERGY_Y) then val=val+ENERGY_Y end
	return val
end
