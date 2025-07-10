local dummy = script.Parent
local humanoid = dummy:WaitForChild("Humanoid")
local rootPart = dummy:WaitForChild("HumanoidRootPart")

local TweenService = game:GetService("TweenService")

local function createHitEffect(position)
    local part = Instance.new("Part")
    part.Size = Vector3.new(1,1,1)
    part.Shape = Enum.PartType.Ball
    part.Material = Enum.Material.Neon
    part.BrickColor = BrickColor.new("Bright red")
    part.Anchored = true
    part.CanCollide = false
    part.CFrame = CFrame.new(position)
    part.Parent = workspace

    TweenService:Create(part, TweenInfo.new(0.3), {Transparency = 1, Size = Vector3.new(3,3,3)}):Play()
    game.Debris:AddItem(part, 0.3)
end

local lastHealth = humanoid.Health

humanoid.HealthChanged:Connect(function(health)
    if health < lastHealth then
        local damageTaken = lastHealth - health
        createHitEffect(rootPart.Position)

        -- Knockback effect proportional to damage
        local forceVector = Vector3.new(math.random(-15,15), 30, math.random(-15,15)) * (damageTaken / 10)
        rootPart.Velocity = forceVector
    end
    lastHealth = health
end)
