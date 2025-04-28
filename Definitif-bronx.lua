-- Crear el GUI del menú
local ScreenGui = Instance.new("ScreenGui")
ScreenGui.Parent = game.Players.LocalPlayer.PlayerGui

-- Marco del menú
local menuFrame = Instance.new("Frame")
menuFrame.Size = UDim2.new(0, 200, 0, 400)  -- Tamaño del menú (ancho: 200px, alto: 400px)
menuFrame.Position = UDim2.new(0, 50, 0, 50)  -- Posición en la pantalla
menuFrame.BackgroundColor3 = Color3.fromRGB(0, 0, 0)  -- Color de fondo negro
menuFrame.BackgroundTransparency = 0.5  -- Transparencia del fondo
menuFrame.BorderSizePixel = 2  -- Bordes del marco

-- Agregar desplazamiento
local scrollFrame = Instance.new("ScrollingFrame")
scrollFrame.Size = UDim2.new(1, 0, 1, 0)  -- Llenar todo el marco
scrollFrame.Position = UDim2.new(0, 0, 0, 0)
scrollFrame.Parent = menuFrame
scrollFrame.CanvasSize = UDim2.new(0, 0, 0, 1000)  -- Tamaño de la tela para desplazamiento
scrollFrame.ScrollBarThickness = 10  -- Grosor de la barra de desplazamiento

-- Fondo de las opciones
local contentFrame = Instance.new("Frame")
contentFrame.Size = UDim2.new(1, 0, 1, 1000)  -- Opciones dentro del scroll
contentFrame.BackgroundTransparency = 1
contentFrame.Parent = scrollFrame

-- Función para crear un botón
function createButton(label, position, callback)
    local button = Instance.new("TextButton")
    button.Size = UDim2.new(1, 0, 0, 50)  -- Tamaño del botón
    button.Position = UDim2.new(0, 0, 0, position)  -- Posición del botón
    button.Text = label
    button.BackgroundColor3 = Color3.fromRGB(50, 50, 50)
    button.TextColor3 = Color3.fromRGB(255, 255, 255)
    button.TextSize = 18
    button.Parent = contentFrame
    button.MouseButton1Click:Connect(callback)  -- Llama a la función cuando el botón es presionado
end

-- Opciones del autofarm
local autofarmEnabled = true
local farmSpeed = 1  -- Velocidad de recolección
local collectionLimit = 100  -- Límite de recolección de bolsas mágicas
local collectedBags = 0  -- Contador de bolsas recolectadas

-- Función para iniciar/detener el autofarm
function toggleAutofarm()
    autofarmEnabled = not autofarmEnabled
    if autofarmEnabled then
        print("Autofarm activado.")
    else
        print("Autofarm desactivado.")
    end
end

-- Función para ajustar la velocidad de recolección
function adjustFarmSpeed(speed)
    farmSpeed = speed
    print("Velocidad de autofarm ajustada a: " .. farmSpeed)
end

-- Función para establecer un límite de recolección
function setCollectionLimit(limit)
    collectionLimit = limit
    print("Límite de recolección ajustado a: " .. collectionLimit)
end

-- Función para recolectar la bolsa mágica
local magicBag = game.Workspace.MagicBag  -- Ajusta la ruta de la bolsa mágica
function collectMagicBag()
    if magicBag and magicBag:FindFirstChild("Touch") then
        magicBag.Touch:Fire()
        print("Coleccionada la bolsa mágica.")
        collectedBags = collectedBags + 1
    end
end

-- Función para vender la bolsa mágica automáticamente
function sellMagicBag()
    print("Vendiendo la bolsa mágica.")
    -- Aquí iría la lógica de venta
end

-- Función de autofarm con límite y velocidad
function autofarm()
    while autofarmEnabled and collectedBags < collectionLimit do
        wait(farmSpeed)
        collectMagicBag()  -- Recoge la bolsa mágica
        sellMagicBag()  -- Vende la bolsa mágica
    end
    if collectedBags >= collectionLimit then
        print("Límite de recolección alcanzado.")
        toggleAutofarm()  -- Detiene el autofarm cuando se alcanza el límite
    end
end

-- Crear botones para controlar el menú
createButton("Activar/Desactivar Autofarm", 0, toggleAutofarm)
createButton("Ajustar Velocidad de Autofarm (1)", 60, function() adjustFarmSpeed(1) end)
createButton("Ajustar Velocidad de Autofarm (0.5)", 120, function() adjustFarmSpeed(0.5) end)
createButton("Establecer Límite de Recolección (100)", 180, function() setCollectionLimit(100) end)
createButton("Mostrar/Ocultar Menú", 240, function()
    menuFrame.Visible = not menuFrame.Visible
end)

-- Inicia el autofarm si está habilitado
while true do
    if autofarmEnabled then
        autofarm()
    end
    wait(1)
end
