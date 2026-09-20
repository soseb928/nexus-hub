-- NexusPlay Hub - Combat Candidate Scanner
-- TEST BRANCH ONLY: instant-kill-test
-- This diagnostic does not bypass cooldowns, alter damage values, or spoof server state.

local ReplicatedStorage = game:GetService("ReplicatedStorage")

local Net = ReplicatedStorage:FindFirstChild("NetworkComm")
local SkillService = Net and Net:FindFirstChild("SkillService")
local CombatService = Net and Net:FindFirstChild("CombatService")

local StartSkill = SkillService and (
    SkillService:FindFirstChild("StartSkilll_Method")
    or SkillService:FindFirstChild("StartSkill_Method")
)
local DamageCharacter = CombatService and CombatService:FindFirstChild("DamageCharacter_Method")

local candidates = {
    "Dismantle",
    "Cleave",
    "Fuga",
    "Sukuna",
    "Plunge",
    "Limitless",
    "Awakened Limitless",
    "Infinite Aura",
}

local function findConfigRoot()
    local configs = ReplicatedStorage:FindFirstChild("Configs")
    local combat = configs and configs:FindFirstChild("CombatConfig")
    return combat
end

local function snapshot()
    local combat = findConfigRoot()
    local skillData = combat and combat:FindFirstChild("SkillData")

    print("=== NexusPlay Combat Candidate Scanner ===")
    print("StartSkill remote:", StartSkill and StartSkill:GetFullName() or "MISSING")
    print("Damage remote:", DamageCharacter and DamageCharacter:GetFullName() or "MISSING")

    for _, name in ipairs(candidates) do
        local node = skillData and skillData:FindFirstChild(name)
        if node then
            print("[FOUND]", name, node:GetFullName())
        else
            print("[NOT FOUND]", name)
        end
    end
end

local function hpOf(model)
    local hum = model and model:FindFirstChildOfClass("Humanoid")
    return hum and hum.Health or nil
end

local function compareTarget(target, before)
    local after = hpOf(target)
    if before and after then
        local damage = math.max(0, before - after)
        print(string.format(
            "[RESULT] HP %.2f -> %.2f | damage %.2f | one-hit=%s",
            before, after, damage, after <= 0 and "YES" or "NO"
        ))
    else
        print("[RESULT] Could not read target Humanoid health.")
    end
end

_G.NexusCombatTest = {
    snapshot = snapshot,
    hpOf = hpOf,
    compareTarget = compareTarget,
    StartSkill = StartSkill,
    DamageCharacter = DamageCharacter,
}

snapshot()
print("Use the existing NexusPlay skill controls for the actual cast, then call:")
print("  _G.NexusCombatTest.compareTarget(targetModel, beforeHealth)")
