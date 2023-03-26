local kAdvancedWeldRange=4 --from 2.4
local kWeldRange = 2.4
local kWelderEffectRate = 0.45
function Welder:GetRepairRate(repairedEntity)

    local repairRate
    if GetHasTech(self,kTechId.AdvancedWelding)then
        repairRate = kAdvancedPlayerWeldRate
        else
        repairRate = kPlayerWeldRate
    end
     
    if repairedEntity.GetReceivesStructuralDamage and repairedEntity:GetReceivesStructuralDamage() then
        if GetHasTech(self,kTechId.AdvancedWelding)then
        repairRate = kAdvancedStructureWeldRate
        else
        repairRate = kStructureWeldRate
        end
    end
    
    return repairRate
    
end

function Welder:GetRange()
    if GetHasTech(self,kTechId.AdvancedWelding)then
            return kAdvancedWeldRange
    else
        return kWeldRange
    end
    
end

--change the welder's fire color
function Welder:OnPrimaryAttackEnd(player)

    if self.welding then
        -- if GetHasTech(self,kTechId.AdvancedWelding)then
        -- self:TriggerEffects("welder_end_orange")
        -- else
        -- self:TriggerEffects("welder_end")
        -- end
        self:TriggerEffects("welder_end")
    end
    
    self.welding = false
    
    if Server then
        self.loopingFireSound:Stop()
    end
    
end

function Welder:OnPrimaryAttack(player)

    if not self.deployed then
        return
    end
    
    PROFILE("Welder:OnPrimaryAttack")
    
    if not self.welding then
    
        self:TriggerEffects("welder_start")
        self.timeWeldStarted = Shared.GetTime()
        
        if Server then
            self.loopingFireSound:Start()
        end
        
    end
    
    local hitPoint

    if self.timeLastWeld + kWelderFireDelay < Shared.GetTime() then
    
        hitPoint = self:PerformWeld(player)
        self.timeLastWeld = Shared.GetTime()
        
    end

    self.welding = true
    
    if not self.timeLastWeldEffect or self.timeLastWeldEffect + kWelderEffectRate < Shared.GetTime() then
    
        -- if GetHasTech(self,kTechId.AdvancedWelding)then
        --      self:TriggerEffects("welder_muzzle_orange")
        --  else
        --     self:TriggerEffects("welder_muzzle")
        -- end
        self:TriggerEffects("welder_muzzle")
        self.timeLastWeldEffect = Shared.GetTime()
        
    end
    
end
--change the welder's fire color:DONE