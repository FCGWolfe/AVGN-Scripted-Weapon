
AddCSLuaFile( "cl_init.lua" )
AddCSLuaFile( "shared.lua" )

include('shared.lua')

function ENT:SpawnFunction(ply, tr)
	if (!tr.Hit) then return end
	local SpawnPos = tr.HitPos
	local ent = ents.Create("avgn_console")
        ent:SetOwner(self.Owner) 
        ent:SetPos(SpawnPos)
	ent:Spawn()
	ent:Activate()
	ent:SetName("Atari 5200")
	return ent
end

function ENT:Think()
        if CurTime() >= self.timer then
            local blowcons = ents.Create("env_explosion")
            blowcons:SetPos(self.Entity:GetPos())
            blowcons:SetKeyValue("iMagnitude", "150")
            blowcons:Spawn()
            blowcons:SetOwner(self.Owner)
            blowcons:Fire("explode", "", 0)
            blowcons:Fire("kill", "", 0)
            self.Entity:Remove()
			--self.Entity:EmitSound("weapons/avgn/work2.wav")
         end
end	

function ENT:Initialize()
        self.timer = CurTime() + 5
	self.Entity:SetModel("models/props_lab/reciever01b.mdl")
	self.Entity:PhysicsInit(SOLID_VPHYSICS)
	self.Entity:SetMoveType(MOVETYPE_VPHYSICS)
	self.Entity:SetSolid(SOLID_VPHYSICS)
	local phys = self.Entity:GetPhysicsObject()
	if (phys:IsValid()) then
		phys:Wake()
	end
end