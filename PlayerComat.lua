local player = game.Players.LocalPlayer
local mouse = player:GetMouse()

local UIS = game:GetService("UserInputService")
local RS = game:GetService("RunService")
local TweenService = game:GetService("TweenService")

local attackCooldown = false
local attackRange = 5
local damageAmount = 10

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

local function attack()
    if attackCooldown then return end
    attackCooldown = true

    local origin = workspace.CurrentCamera.CFrame.Position
    local direction = (mouse.Hit.p - origin).unit * attackRange

    local raycastParams = RaycastParams.new()
    raycastParams.FilterDescendantsInstances = {player.Character}
    raycastParams.FilterType = Enum.RaycastFilterType.Blacklist

    local raycastResult = workspace:Raycast(origin, direction, raycastParams)

    if raycastResult and raycastResult.Instance then
        local hitPart = raycastResult.Instance
        local humanoid = hitPart.Parent:FindFirstChildOfClass("Humanoid")
        if not humanoid and hitPart.Parent.Parent then
            humanoid = hitPart.Parent.Parent:FindFirstChildOfClass("Humanoid")
        end
        if humanoid and humanoid.Health > 0 then
            humanoid:TakeDamage(damageAmount)
            createHitEffect(raycastResult.Position)
        end
    end

    wait(0.5)
    attackCooldown = false
end

mouse.Button1Down:Connect(attack)
