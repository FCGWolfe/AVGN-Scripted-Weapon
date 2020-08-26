if ( SERVER ) then
	AddCSLuaFile( "shared.lua" )	
end

if ( CLIENT ) then
	SWEP.PrintName			= "AVGN 1.2_idb-0"
	SWEP.Author			= "Kliker, NULLPTR"
        SWEP.Category 			= "Kliker (Unstable)"
	SWEP.Slot			= 1
	SWEP.SlotPos			= 0
	SWEP.IconLetter			= "f"
	SWEP.DrawCrosshair		= true
end

function SWEP:Deploy()
	self.RandomSoundOnEquipRandomizer = math.random(15) -- randomizer/RNG that dictates which sound plays upon equipping the weapon.
	if self.RandomSoundOnEquipRandomizer == 1 then
	self.Weapon:EmitSound("weapons/avgn/start.wav")
	elseif self.RandomSoundOnEquipRandomizer == 2 then
	self.Weapon:EmitSound("weapons/avgn/startrock.wav")
	end
end

function SWEP:Reload()
	if CurTime() >= self.taunttime then
		self.tauntrand = math.random(10) -- randomizer/RNG that dictates which sound plays upon
	if self.tauntrand == 1 then
		self.Weapon:EmitSound("weapons/avgn/tnt1.wav")
	elseif self.tauntrand == 2 then
        	self.Weapon:EmitSound("weapons/avgn/tnt2.wav")
	elseif self.tauntrand == 3 then
        	self.Weapon:EmitSound("weapons/avgn/tnt3.wav")
	elseif self.tauntrand == 4 then
        	self.Weapon:EmitSound("weapons/avgn/tnt4.wav")
	elseif self.tauntrand == 5 then
        	self.Weapon:EmitSound("weapons/avgn/tnt5.wav")
	elseif self.tauntrand == 6 then
        	self.Weapon:EmitSound("weapons/avgn/tnt6.wav")
	elseif self.tauntrand == 7 then
        	self.Weapon:EmitSound("weapons/avgn/tnt7.wav")
	elseif self.tauntrand > 7 then
        	if SERVER then
        		local Console = ents.Create("avgn_console")
				Console:SetOwner(self:GetOwner())
				Console:SetPhysicsAttacker(self:GetOwner())
				Console:SetPos(self.Owner:GetShootPos())
				Console:SetAngles(self.Owner:EyeAngles())
				Console:Spawn()
				Console:Activate()
				self.craptimer = CurTime() + 6
				self.working = true
		end
		self.Weapon:EmitSound("weapons/avgn/work1.wav")
	end
		self.taunttime = CurTime() + 1
	end

end 
 
function SWEP:Think()
	if self.working and CurTime() >= self.craptimer then
		self.Weapon:EmitSound("weapons/avgn/work2.wav")
		self.working = false
	end
end

function SWEP:Initialize()
	self.randomizer = 1
	self.tauntrand = 1
	self.taunttime = 0
	self.craptimer = 0
	self.rolling = 0
	self.working = false
	if SERVER then self:SetWeaponHoldType( "melee" ) end
end
 
function SWEP:PrimaryAttack()
	self.Weapon:SetNextPrimaryFire(CurTime() + 0.2)
	self.randomizer = math.random(9)
	local trace = self.Owner:GetEyeTrace()
		if trace.HitPos:Distance(self.Owner:GetShootPos()) <= 75 then
			bullet = {}
			bullet.Num    = 1
			bullet.Src    = self.Owner:GetShootPos()
			bullet.Dir    = self.Owner:GetAimVector()
			bullet.Spread = Vector(0, 0, 0)
			bullet.Tracer = 0
			bullet.Force  = 50
			bullet.Damage = 50
        		self.Owner:FireBullets(bullet)
		end
		if self.randomizer == 1 then
        		self.Weapon:EmitSound("weapons/avgn/snd1.wav")
		elseif self.randomizer == 2 then
        		self.Weapon:EmitSound("weapons/avgn/snd2.wav")
		elseif self.randomizer == 3 then
        		self.Weapon:EmitSound("weapons/avgn/snd3.wav")
		elseif self.randomizer == 4 then
        		self.Weapon:EmitSound("weapons/avgn/snd4.wav")
		elseif self.randomizer == 5 then
        		self.Weapon:EmitSound("weapons/avgn/snd5.wav")
		elseif self.randomizer == 6 then
        		self.Weapon:EmitSound("weapons/avgn/snd6.wav")
		elseif self.randomizer == 7 then
        		self.Weapon:EmitSound("weapons/avgn/snd7.wav")
		elseif self.randomizer == 8 then
        		self.Weapon:EmitSound("weapons/avgn/snd8.wav")
		elseif self.randomizer == 9 then
				self.Weapon:EmitSound("weapons/avgn/move.wav")
		end

end
 
function SWEP:SecondaryAttack()
	self.Weapon:SetNextSecondaryFire(CurTime() + 1)
	self.chooseclip = math.random(3)
	if self.chooseclip == 1 then
	       self.Weapon:EmitSound("weapons/avgn/rollinrock1.mp3")
	elseif self.chooseclip == 2 then
	       self.Weapon:EmitSound("weapons/avgn/rollinrock2.mp3")
	elseif self.chooseclip == 3 then
		   self.Weapon:EmitSound("weapons/avgn/rollinrock3.mp3")
	end
	--self.Weapon:EmitSound("weapons/avgn/rollinrock.wav")
        self.Weapon:SendWeaponAnim(ACT_VM_HITCENTER)
        	if SERVER then
        		local RollingRock = ents.Create("rolling_rock")
				RollingRock:SetOwner(self:GetOwner())
				RollingRock:SetPhysicsAttacker(self:GetOwner())
				RollingRock:SetPos(self.Owner:GetShootPos())
				RollingRock:SetAngles(self.Owner:EyeAngles())
				RollingRock:Spawn()
				RollingRock:Activate()
			local RollingRockPhys = RollingRock:GetPhysicsObject()
				RollingRockPhys:ApplyForceCenter(self.Owner:GetAimVector()*700)
        end
end

SWEP.Author = "Kliker"
SWEP.Contact = ""
SWEP.Purpose = "Fuckballs!"
SWEP.Instructions = "Primary - Swear a blue streak!\nSecondary - Throw Rolling Rock.\nReload - Tell your enemies to go fuck themselves."
SWEP.Spawnable = true
SWEP.AdminSpawnable  = true

SWEP.ViewModel = "models/weapons/v_fists.mdl"
SWEP.WorldModel = "models/weapons/w_fists.mdl"

SWEP.Primary.Delay = 0.2
SWEP.Primary.Recoil = 0
SWEP.Primary.Damage = 999999999
SWEP.Primary.NumShots = 1	
SWEP.Primary.Cone = 0 	
SWEP.Primary.ClipSize = -1	
SWEP.Primary.DefaultClip = -1	
SWEP.Primary.Automatic = false
SWEP.Primary.Ammo = "none"

SWEP.Secondary.Delay = 0
SWEP.Secondary.Recoil = 0
SWEP.Secondary.Damage = 0
SWEP.Secondary.NumShots = 1
SWEP.Secondary.Cone = 0
SWEP.Secondary.ClipSize	= -1
SWEP.Secondary.DefaultClip = -1
SWEP.Secondary.Automatic = false
SWEP.Secondary.Ammo = "none"