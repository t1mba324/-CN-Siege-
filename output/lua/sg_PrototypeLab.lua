function PrototypeLab:GetTechButtons(techId)
   
    local techButtons= { kTechId.JetpackTech, kTechId.None, kTechId.None, kTechId.None, 
             kTechId.ExosuitTech, kTechId.None, kTechId.None, kTechId.None } -- kTechId.DualRailgunTech
    
    -- if GetHasTech(self,kTechId.JetpackTech) then
    --     techButtons[1]=kTechId.AntiStompJetpackTech
    -- end
    return techButtons
end