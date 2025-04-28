-- Variables de configuración
local player = game.Players.LocalPlayer
local backpack = player.Backpack
local mouse = player:GetMouse()
local leaderstats = player:WaitForChild("leaderstats")
local magicBagName = "MagicBag"
local moneyValue = leaderstats:WaitForChild("Money")

-- Variables de estado
local isAutofarming = false
local isAutoworking = false
local isNoClipping = false

-- Crear la interfaz de usuario (UI)
local screenGui = Instance.new("ScreenGui")
screenGui.Parent = player.PlayerGui

local mainFrame = Instance.new("Frame")
mainFrame.Size = UDim2.new(0, 200, 0, 300)
mainFrame.Position = UDim2.new(0, 10, 0, 10)
mainFrame.BackgroundColor3 = Color3.fromRGB(50, 50, 50)
mainFrame.Parent = screenGui

-- Crear botones
local autofarmButton = Instance.new("TextButton")
autofarmButton.Size = UDim2.new(0, 180, 0, 40)
autofarmButton.Position = UDim2.new(0, 10, 0, 10)
autofarmButton.Text = "Toggle Autofarm"
autofarmButton.BackgroundColor3 = Color3.fromRGB(0, 128, 0)
autofarmButton.Parent = mainFrame

local autoworkButton = Instance.new("TextButton")
autoworkButton.Size = UDim2.new(0, 180, 0, 40)
autoworkButton.Position = UDim2.new(0, 10, 0, 60)
autoworkButton.Text = "Toggle Autowork"
autoworkButton.BackgroundColor3 = Color3.fromRGB(0, 0, 255)
autoworkButton.Parent = mainFrame

local noClipButton = Instance.new("TextButton")
noClipButton.Size = UDim2.new(0, 180, 0, 40)
noClipButton.Position = UDim2.new(0, 10, 0, 110)
noClipButton.Text = "Toggle No-Clip"
noClipButton.BackgroundColor3 = Color3.fromRGB(255, 0, 0)
noClipButton.Parent = mainFrame

-- Funciones de comportamiento
function toggleAutofarm()
    isAutofarming = not isAutofarming
    if isAutofarming then
        autofarmButton.Text = "Autofarm: ON"
        startAutofarm()
    else
        autofarmButton.Text = "Toggle Autofarm"
    end
end

function toggleAutowork()
    isAutoworking = not isAutoworking
    if isAutoworking then
        autoworkButton.Text = "Autowork: ON"
        startAutowork()
    else
        autoworkButton.Text = "Toggle Autowork"
    end
end

function toggleNoClip()
    isNoClipping = not isNoClipping
    if isNoClipping then
        noClipButton.Text = "No-Clip: ON"
        enableNoClip()
    else
        noClipButton.Text = "Toggle No-Clip"
        disableNoClip()
    end
end

-- Función para autofarmear
function startAutofarm()
    while isAutofarming do
        local magicBag = backpack:FindFirstChild(magicBagName)
        if magicBag then
            -- Agregar lógica para recolectar objetos automáticamente de la bolsa mágica
            print("Recolectando recursos de la bolsa mágica...")
            -- Aquí podrías agregar más detalles de la recolección (por ejemplo, extraer recursos específicos).
            wait(2) -- Recolecta cada 2 segundos
        else
            print("No se ha encontrado la bolsa mágica.")
            wait(1)
        end
    end
end

-- Función para trabajar automáticamente
function startAutowork()
    while isAutoworking do
        -- Aquí iría la lógica para trabajar automáticamente, por ejemplo, interactuar con NPCs de trabajo
        print("Trabajando automáticamente...")
        wait(5) -- Esperar 5 segundos entre trabajos
    end
end

-- Funciones para No-Clip (traspasar paredes)
function enableNoClip()
    local character = player.Character or player.CharacterAdded:Wait()
    local humanoid = character:WaitForChild("Humanoid")
    humanoid.PlatformStand = true
    humanoid:ChangeState(Enum.HumanoidStateType.Physics)
end

function disableNoClip()
    local character = player.Character or player.CharacterAdded:Wait()
    local humanoid = character:WaitForChild("Humanoid")
    humanoid.PlatformStand = false
    humanoid:ChangeState(Enum.HumanoidStateType.GettingUp)
end

-- Conectar los botones con las funciones
autofarmButton.MouseButton1Click:Connect(toggleAutofarm)
autoworkButton.MouseButton1Click:Connect(toggleAutowork)
noClipButton.MouseButton1Click:Connect(toggleNoClip)
