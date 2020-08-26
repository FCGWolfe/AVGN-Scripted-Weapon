
AddCSLuaFile( "cl_init.lua" )
AddCSLuaFile( "shared.lua" )

include('shared.lua')

function ENT:SpawnFunction(ply, tr)
	if (!tr.Hit) then return end
	local SpawnPos = tr.HitPos + tr.HitNormal * 16
	local ent = ents.Create("rolling_rock")
        ent:SetOwner(self.Owner) 
        ent:SetPos(SpawnPos)
	ent:Spawn()
	ent:Activate()
	ent:SetName("Rolling Rock")
	return ent
end

function ENT:Touch(hitEnt)
	if hitEnt:IsValid() and hitEnt:IsNPC() then
		self.Owner = self.Entity:GetOwner()
		local ballexp = ents.Create("env_explosion")
		ballexp:SetPos(self.Entity:GetPos())
		ballexp:SetKeyValue("iMagnitude", "150")
		ballexp:Spawn()
		ballexp:SetOwner(self.Owner)
		ballexp:Fire("explode", "", 0)
		ballexp:Fire("kill", "", 0)
		self.Entity:Remove()
	end
end	


function ENT:Think()
	if CurTime() >= self.timer then
		self.Entity:Remove()
	end
end

function ENT:Initialize()
	self.timer = CurTime() + 5
	self.Entity:SetModel("models/props_junk/garbage_glassbottle003a.mdl")
	self.Entity:PhysicsInit(SOLID_VPHYSICS)
	self.Entity:SetMoveType(MOVETYPE_VPHYSICS)
	self.Entity:SetSolid(SOLID_VPHYSICS)
	local phys = self.Entity:GetPhysicsObject()
	if (phys:IsValid()) then
		phys:Wake()
	end
end