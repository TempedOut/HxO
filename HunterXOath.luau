local repo = 'https://raw.githubusercontent.com/violin-suzutsuki/LinoriaLib/main/'

local Library = loadstring(game:HttpGet(repo .. 'Library.lua'))()
local ThemeManager = loadstring(game:HttpGet(repo .. 'addons/ThemeManager.lua'))()
local SaveManager = loadstring(game:HttpGet(repo .. 'addons/SaveManager.lua'))()

local Window = Library:CreateWindow({
    Title = 'Example menu',
    Center = true,
    AutoShow = true,
    TabPadding = 8,
    MenuFadeTime = 0.2
})

local Tabs = {
    Main = Window:AddTab('Main'),
    ['UI Settings'] = Window:AddTab('UI Settings'),
}

local scriptVariables = {
    runTask = false,

    doingPushups = false,
    meditating = false,
    sprinting = false,

    bottingToHatsu = false,
    bottingToMaxNen = false
}

local WS = cloneref(game:GetService("Workspace"))
local VIM = cloneref(game:GetService("VirtualInputManager"))
local MSS = cloneref(game:GetService("MemStorageService"))
local Players = cloneref(game:GetService("Players"))
local TeleportService = cloneref(game:GetService("TeleportService"))

function rejoin()
    local PlaceId = game.PlaceId
    local JobId = game.JobId

    if #Players:GetPlayers() <= 1 then
        queue_on_teleport(loadstring(game:HttpGet("https://raw.githubusercontent.com/TempedOut/HxO/refs/heads/main/HunterXOath.luau", true))())

		Players.LocalPlayer:Kick("\nRejoining...")
		wait()
		TeleportService:Teleport(PlaceId, Players.LocalPlayer)
	else
        queue_on_teleport(loadstring(game:HttpGet("https://raw.githubusercontent.com/TempedOut/HxO/refs/heads/main/HunterXOath.luau", true))())

		TeleportService:TeleportToPlaceInstance(PlaceId, JobId, Players.LocalPlayer)
	end
end 

function sendKey(VIM ,key, time)
    VIM:SendKeyEvent(true, key, false, game)
    task.wait(time)
    VIM:SendKeyEvent(false, key, false, game)
    task.wait(0.1)
end

--[[ function claimNearestFlag()
    local localPlayer = Players.LocalPlayer
    local char = localPlayer.Character
    local hmrp = char.HumanoidRootPart

    for i, v in pairs(WS.World:GetChildren()) do
        if (v:FindFirstChild("Flag")) then
            for m, n in pairs() do

            end
        end
    end
end ]]

function claimAllFlags()
    local localPlayer = Players.LocalPlayer
    local char = localPlayer.Character
    local hmrp = char.HumanoidRootPart

    hmrp.Anchored = true

    for i, v in pairs(WS.World:GetChildren()) do

        if (v:FindFirstChild("Flag")) or (v:FindFirstChild("Flags")) then
            local flag = v:FindFirstChild("Flag") or v:FindFirstChild("Flags")
            hmrp.Position = flag["Claimable Flag"].AnimatedFlag.FlagPole.WorldPivot.Position
            task.wait(0.3)
            hmrp.Anchored = false
            task.wait(0.7)

            for m, n in pairs(flag["Claimable Flag"].AnimatedFlag.FlagPole:GetChildren()) do
                if n:FindFirstChild("Attachment") then
                    fireproximityprompt(n.Attachment.ProximityPrompt, 3)
                end
            end

            hmrp.Anchored = true
        end
    end

    hmrp.Anchored = false
end

function spinClan()
    local localPlayer = Players.LocalPlayer
    local playerGui = localPlayer.PlayerGui
    local mainGui = playerGui:FindFirstChild("MainGUI")

    if mainGui.Main.Jenny.Text:find("K") then
        local args = {
            [1] = "Killua"
        }

        game:GetService("ReplicatedStorage"):WaitForChild("Events"):WaitForChild("Remote"):WaitForChild("Normal"):WaitForChild("DialogueInitiate"):FireServer(unpack(args))
    end
end

function joinMafia()
    local args = {
        [1] = "Mafia"
    }

    game:GetService("ReplicatedStorage"):WaitForChild("Events"):WaitForChild("Remote"):WaitForChild("Normal"):WaitForChild("DialogueInitiate"):FireServer(unpack(args))
end

function doPushups()
    if not scriptVariables.runTask and not scriptVariables.doingPushups then
        scriptVariables.runTask = true
        scriptVariables.doingPushups = true

        task.spawn(function()
            while (scriptVariables.runTask and scriptVariables.doingPushups) do
                task.wait(0.1)

                function inStance()
                    return game:GetService("Players").LocalPlayer.PlayerGui:FindFirstChild("PushupsGui")
                end

                function stance()
                    if not inStance() then
                        --Press j until we detect we are in pushups stance
                        local bar = game:GetService("Players").LocalPlayer.PlayerGui.MainGUI.Main.StaminaBar.Bar


                        repeat    
                            if bar.Size.X.Scale == 1 then
                                sendKey(VIM, Enum.KeyCode.J)
                                task.wait(1)
                            end
                            
                            task.wait(0.1)

                            --[[ task.wait(0.1)
                            pcall(function()
                                trainTen()
                            end) ]]
                        until not scriptVariables.runTask or not scriptVariables.doingPushups or inStance()     
                    end    

                    return
                end

                stance()

                repeat
                    pcall(function(...)  
                        firesignal(game:GetService("Players").LocalPlayer.PlayerGui.PushupsGui.Pushups.PushupButton.Activated)
                    end)

                    --[[ task.wait(0.1)
                    pcall(function()
                        trainTen()
                    end) ]]

                    task.wait(0.1)
                until not scriptVariables.runTask or not scriptVariables.doingPushups or not inStance()

                if not scriptVariables.runTask or not scriptVariables.doingPushups then
                    break
                end
            end
        end)
    elseif scriptVariables.runTask and scriptVariables.doingPushups then
        scriptVariables.runTask = false
        scriptVariables.doingPushups = false
    end
end

function meditate()
    if not scriptVariables.runTask and not scriptVariables.meditating then
        scriptVariables.runTask = true
        scriptVariables.meditating = true

        task.spawn(function()
            while (scriptVariables.runTask and scriptVariables.meditating) do
                task.wait(0.1)

                function checkMeditating()
                    return game:GetService("Workspace").Living:FindFirstChild(game:GetService("Players").LocalPlayer.Name).Humanoid.Info.Meditating.Value
                end

                if not checkMeditating() then
                    sendKey(VIM, Enum.KeyCode.M)
                end

                repeat
                    --Handle nen shit here
                    if not checkMeditating() then
                        sendKey(VIM, Enum.KeyCode.M)
                    end
                    task.wait(0.1)
                until not scriptVariables.runTask or not scriptVariables.meditating

                if checkMeditating() then
                    sendKey(VIM, Enum.KeyCode.M)
                end

                if not scriptVariables.runTask and not scriptVariables.meditating then
                    break
                end      
            end
        end)
    elseif scriptVariables.runTask and scriptVariables.meditating then
        scriptVariables.runTask = false
        scriptVariables.meditating = false
    end
end

function sprint()

    function sprinting(startSprinting)
        if startSprinting then
            local args = {
                [1] = "FastSprintStart",
                [2] = false
            }

            game:GetService("Players").LocalPlayer.Character.Server.Core.Character.Events.input:FireServer(unpack(args))
        else
            local args = {
                [1] = "FastSprintEnd",
                [2] = false
            }

            game:GetService("Players").LocalPlayer.Character.Server.Core.Character.Events.input:FireServer(unpack(args))

        end
    end

    if not scriptVariables.runTask and not scriptVariables.sprinting then
        scriptVariables.runTask = true
        scriptVariables.sprinting = true

        task.spawn(function()
            while (scriptVariables.runTask and scriptVariables.sprinting) do
                task.wait(0.1)

                local bar = game:GetService("Players").LocalPlayer.PlayerGui.MainGUI.Main.StaminaBar.Bar

                repeat    
                    if bar.Size.X.Scale == 1 then
                        sprinting(true)
                        task.wait(1)
                    end
                            
                    task.wait(0.1)

                until not scriptVariables.runTask or not scriptVariables.sprinting

                if not scriptVariables.runTask or not scriptVariables.sprinting then
                    break
                end
            end

            sprinting(false)
        end)
    elseif scriptVariables.runTask and scriptVariables.sprinting then
        scriptVariables.runTask = false
        scriptVariables.sprinting = false

        sprinting(false)
    end
end

function botToHatsu()
    --NEED TO ADD REJOIN AND WAY TO KNOW THAT WE ARE STILL BOTTING IT WHEN WE REJOIN
    --The goal of this function will be to bot to hatsu. Meaning botting to unlock ten and ren and getting the stats and money neccasary to unlock hatsu.
    if not scriptVariables.runTask and not scriptVariables.bottingToHatsu then
        scriptVariables.runTask = true
        scriptVariables.bottingToHatsu = true

        --Add thing that union does here.
        if not (MSS:HasItem("botToHatsu")) then
            MSS:SetItem("botToHatsu", true)
        end

        function easyStatCheck(name)
            local statViewer = game:GetService("Players").LocalPlayer.PlayerGui.StatsViewer.StatsViewer.Display
            return tonumber(statViewer:FindFirstChild(name).StatLabel.Text)
        end

        function pushupTillStat(targetLevel)
            while not (easyStatCheck("StrengthEXP") >= targetLevel) do
                task.wait(0.1)

                function inStance()
                    return game:GetService("Players").LocalPlayer.PlayerGui:FindFirstChild("PushupsGui")
                end

                function stance()
                    if not inStance() then
                        --Press j until we detect we are in pushups stance
                        local bar = game:GetService("Players").LocalPlayer.PlayerGui.MainGUI.Main.StaminaBar.Bar


                        repeat    
                            if bar.Size.X.Scale == 1 then
                                sendKey(VIM, Enum.KeyCode.J)
                                task.wait(1)
                            end
                            
                            task.wait(0.1)
                        until easyStatCheck("StrengthEXP") >= targetLevel or inStance()     
                    end    

                    return
                end

                stance()

                repeat
                    pcall(function(...)  
                        firesignal(game:GetService("Players").LocalPlayer.PlayerGui.PushupsGui.Pushups.PushupButton.Activated)
                    end)

                    task.wait(0.1)
                until easyStatCheck("StrengthEXP") >= targetLevel or not inStance() or not scriptVariables.runTask or not scriptVariables.bottingToHatsu

                if easyStatCheck("StrengthEXP") >= targetLevel or not scriptVariables.runTask or not scriptVariables.bottingToHatsu then
                    if inStance() then
                        repeat
                        task.wait(0.1)
                            sendKey(VIM, Enum.KeyCode.J)
                        until not inStance() or not scriptVariables.runTask or not scriptVariables.bottingToHatsu
                    end

                    break
                end
            end
        end

        function meditateTillStat(targetLevel)
            while not (easyStatCheck("MeditationEXP") >= targetLevel) do
                task.wait(0.1)

                function checkMeditating()
                    return game:GetService("Workspace").Living:FindFirstChild(game:GetService("Players").LocalPlayer.Name).Humanoid.Info.Meditating.Value
                end

                if not checkMeditating() then
                    sendKey(VIM, Enum.KeyCode.M)
                end

                repeat
                    --Handle nen shit here
                    if not checkMeditating() then
                        sendKey(VIM, Enum.KeyCode.M)
                    end
                    task.wait(0.1)
                until easyStatCheck("MeditationEXP") >= targetLevel or not scriptVariables.runTask or not scriptVariables.bottingToHatsu

                repeat
                    if checkMeditating() then
                        sendKey(VIM, Enum.KeyCode.M)
                    end
                until not checkMeditating() or not scriptVariables.runTask or not scriptVariables.bottingToHatsu

                if easyStatCheck("MeditationEXP") >= targetLevel or not scriptVariables.runTask or not scriptVariables.bottingToHatsu then
                    break
                end      
            end
        end

        function sprintTillStat(runLevel, staminaLevel)
            function sprinting(startSprinting)
                if startSprinting then
                    local args = {
                        [1] = "FastSprintStart",
                        [2] = false
                    }

                    game:GetService("Players").LocalPlayer.Character.Server.Core.Character.Events.input:FireServer(unpack(args))
                else
                    local args = {
                        [1] = "FastSprintEnd",
                        [2] = false
                    }

                    game:GetService("Players").LocalPlayer.Character.Server.Core.Character.Events.input:FireServer(unpack(args))

                end
            end

            while not (easyStatCheck("RunEXP") >= runLevel and easyStatCheck("StaminaEXP") >= staminaLevel) do
                task.wait(0.1)

                local bar = game:GetService("Players").LocalPlayer.PlayerGui.MainGUI.Main.StaminaBar.Bar

                repeat    
                    if bar.Size.X.Scale == 1 then
                        sprinting(true)
                        task.wait(1)
                    elseif bar.Size.X.Scale <= 0 then
                        sprinting(false)
                    end
                            
                    task.wait(0.1)

                until easyStatCheck("RunEXP") >= runLevel and easyStatCheck("StaminaEXP") >= staminaLevel or not scriptVariables.runTask or not scriptVariables.bottingToHatsu

                if easyStatCheck("RunEXP") >= runLevel and easyStatCheck("StaminaEXP") >= staminaLevel or not scriptVariables.runTask or not scriptVariables.bottingToHatsu then
                    break
                end
            end

            sprinting(false)
        end

        task.spawn(function()

            function trainTen()
                if not game:GetService("Workspace").Living:FindFirstChild(game:GetService("Players").LocalPlayer.Name):FindFirstChild("Ten") then
                    if game:GetService("Workspace").Living:FindFirstChild(game:GetService("Players").LocalPlayer.Name).HumanoidRootPart.Nen.Outline.Container.Bar.Size.X.Scale == 1 then
                        sendKey(VIM, Enum.KeyCode.B)
                    end
                end
            end

            function trainRen()
                if not game:GetService("Workspace").Living:FindFirstChild(game:GetService("Players").LocalPlayer.Name).Humanoid.Info.UsingRen.Value then
                    if game:GetService("Workspace").Living:FindFirstChild(game:GetService("Players").LocalPlayer.Name).HumanoidRootPart.Nen.Outline.Container.Bar.Size.X.Scale == 1 then
                        sendKey(VIM, Enum.KeyCode.V)
                    end
                end
            end

            while (scriptVariables.runTask and scriptVariables.bottingToHatsu) do
                task.wait(0.1)

                if (easyStatCheck("MeditationEXP") >= 7200 and easyStatCheck("StrengthEXP") >= 3600 and easyStatCheck("RunEXP") >= 1000) then

                    if (easyStatCheck("TenMastery") < 15000) then
                        --train ten
                        repeat
                            task.wait(0.1)
                            trainTen()
                        until easyStatCheck("TenMastery") >= 15000 or not scriptVariables.runTask or not scriptVariables.bottingToHatsu
                    end
                end

                if (easyStatCheck("MeditationEXP") >= 15000 and easyStatCheck("StrengthEXP") >= 6000 and easyStatCheck("RunEXP") >= 2000) and easyStatCheck("StaminaEXP") >= 3600 then

                    if (easyStatCheck("RenMastery") < 15000) then
                        --train ren
                        repeat
                            task.wait(0.1)
                            trainRen()
                        until easyStatCheck("RenMastery") >= 15000 or not scriptVariables.runTask or not scriptVariables.bottingToHatsu
                    end
                end

                if (easyStatCheck("TenMastery") >= 15000 or easyStatCheck("RenMastery") >= 15000 or not scriptVariables.runTask or not scriptVariables.bottingToHatsu) then
                    break
                end
            end
        end)

        task.spawn(function()
            --This does not need to loop since it bots to an end

            --check if we have 1k strength.
            if easyStatCheck("StrengthEXP") < 1000 and scriptVariables.runTask and scriptVariables.bottingToHatsu then
                pushupTillStat(1000)
            end

            --check if we have 7200 meditation
            if easyStatCheck("MeditationEXP") < 7200 and scriptVariables.runTask and scriptVariables.bottingToHatsu then
                meditateTillStat(7200)
            end

            --check if we have 3600 strength
            if easyStatCheck("StrengthEXP") < 3600 and scriptVariables.runTask and scriptVariables.bottingToHatsu then
                pushupTillStat(3600)
            end

            --check if we have 2k run and 3.6k stamina
            if easyStatCheck("RunEXP") < 2000 and scriptVariables.runTask and scriptVariables.bottingToHatsu or easyStatCheck("StaminaEXP") < 3600 and scriptVariables.runTask and scriptVariables.bottingToHatsu then
                sprintTillStat(2000, 3600)

                --Rejoin to get Ten
                if not (MSS:HasItem("Recieved Ten")) then
                    MSS:SetItem("Received Ten", true)
                    rejoin()
                end
            end

            --check if we have 15k meditation
            if easyStatCheck("MeditationEXP") < 15000 and scriptVariables.runTask and scriptVariables.bottingToHatsu then
                meditateTillStat(15000)
            end

            --Check if we have 6k strength
            if easyStatCheck("StrengthEXP") < 6000 and scriptVariables.runTask and scriptVariables.bottingToHatsu then
                pushupTillStat(6000)

                --Rejoin to get Ren
                if not (MSS:HasItem("Recieved Ren")) then
                    MSS:SetItem("Recieved Ren", true)
                    rejoin()
                end
            end
        end)

    elseif scriptVariables.runTask and scriptVariables.bottingToHatsu then
        scriptVariables.runTask = false
        scriptVariables.bottingToHatsu = false

        if (MSS:HasItem("botToHatsu")) then
            MSS:RemoveItem("botToHatsu")
        end
    end
end

function botToMaxNen()
    --The goal of this function will be to first bot to unlock all nen techniques, and bot to hatsu at the same time. Once completed it will bot to max all stats.
    --All at the same time it will be rolling for the best clan and potential.

    if not scriptVariables.runTask and not scriptVariables.bottingToMaxNen then
        scriptVariables.runTask = true
        scriptVariables.bottingToMaxNen = true

        if not (MSS:HasItem("botToMaxNen")) then
            MSS:SetItem("botToMaxNen", true)
        end

        function easyStatCheck(name)
            local statViewer = game:GetService("Players").LocalPlayer.PlayerGui.StatsViewer.StatsViewer.Display
            return tonumber(statViewer:FindFirstChild(name).StatLabel.Text)
        end

        function pushupTillStat(targetLevel)
            while not (easyStatCheck("StrengthEXP") >= targetLevel) do
                task.wait(0.1)

                function checkMeditating()
                    return game:GetService("Workspace").Living:FindFirstChild(game:GetService("Players").LocalPlayer.Name).Humanoid.Info.Meditating.Value
                end

                function inStance()
                    return game:GetService("Players").LocalPlayer.PlayerGui:FindFirstChild("PushupsGui")
                end

                function stance()
                    if not inStance() then
                        --Press j until we detect we are in pushups stance
                        local bar = game:GetService("Players").LocalPlayer.PlayerGui.MainGUI.Main.StaminaBar.Bar


                        repeat    
                            if bar.Size.X.Scale == 1 then
                                if checkMeditating() then
                                    repeat
                                        task.wait(0.1)
                                        sendKey(VIM, Enum.KeyCode.M)
                                    until not checkMeditating()
                                end

                                sendKey(VIM, Enum.KeyCode.J)
                                task.wait(1)
                            else
                                if not checkMeditating() then
                                    repeat
                                        task.wait(0.1)
                                        sendKey(VIM, Enum.KeyCode.M)
                                    until checkMeditating()
                                end
                            end
                            
                            task.wait(0.1)
                        until easyStatCheck("StrengthEXP") >= targetLevel or inStance()     
                    end    

                    return
                end

                stance()

                repeat
                    pcall(function(...)  
                        firesignal(game:GetService("Players").LocalPlayer.PlayerGui.PushupsGui.Pushups.PushupButton.Activated)
                    end)

                    task.wait(0.1)
                until easyStatCheck("StrengthEXP") >= targetLevel or not inStance() or not scriptVariables.runTask or not scriptVariables.bottingToMaxNen

                if easyStatCheck("StrengthEXP") >= targetLevel or not scriptVariables.runTask or not scriptVariables.bottingToMaxNen then
                    if inStance() then
                        repeat
                        task.wait(0.1)
                            sendKey(VIM, Enum.KeyCode.J)
                        until not inStance() or not scriptVariables.runTask or not scriptVariables.bottingToMaxNen
                    end

                    break
                end
            end
        end

        function meditateTillStat(targetLevel)
            while not (easyStatCheck("MeditationEXP") >= targetLevel) do
                task.wait(0.1)

                function checkMeditating()
                    return game:GetService("Workspace").Living:FindFirstChild(game:GetService("Players").LocalPlayer.Name).Humanoid.Info.Meditating.Value
                end

                if not checkMeditating() then
                    sendKey(VIM, Enum.KeyCode.M)
                end

                repeat
                    --Handle nen shit here
                    if not checkMeditating() then
                        sendKey(VIM, Enum.KeyCode.M)
                    end
                    task.wait(0.1)
                until easyStatCheck("MeditationEXP") >= targetLevel or not scriptVariables.runTask or not scriptVariables.bottingToMaxNen

                repeat
                    if checkMeditating() then
                        sendKey(VIM, Enum.KeyCode.M)
                    end
                until not checkMeditating() or not scriptVariables.runTask or not scriptVariables.bottingToMaxNen

                if easyStatCheck("MeditationEXP") >= targetLevel or not scriptVariables.runTask or not scriptVariables.bottingToMaxNen then
                    break
                end      
            end
        end

        function sprintTillStat(runLevel, staminaLevel)
            function sprinting(startSprinting)
                if startSprinting then
                    local args = {
                        [1] = "FastSprintStart",
                        [2] = false
                    }

                    game:GetService("Players").LocalPlayer.Character.Server.Core.Character.Events.input:FireServer(unpack(args))
                else
                    local args = {
                        [1] = "FastSprintEnd",
                        [2] = false
                    }

                    game:GetService("Players").LocalPlayer.Character.Server.Core.Character.Events.input:FireServer(unpack(args))

                end
            end

            function checkMeditating()
                return game:GetService("Workspace").Living:FindFirstChild(game:GetService("Players").LocalPlayer.Name).Humanoid.Info.Meditating.Value
            end

            while not (easyStatCheck("RunEXP") >= runLevel and easyStatCheck("StaminaEXP") >= staminaLevel) do
                task.wait(0.1)

                local bar = game:GetService("Players").LocalPlayer.PlayerGui.MainGUI.Main.StaminaBar.Bar

                repeat    
                    if bar.Size.X.Scale == 1 then
                        if checkMeditating() then
                            repeat
                                task.wait(0.1)
                                sendKey(VIM, Enum.KeyCode.M)
                            until not checkMeditating()
                        end

                        sprinting(true)
                        task.wait(1)
                    elseif bar.Size.X.Scale <= 0 then
                        sprinting(false)

                        if not checkMeditating() then
                            repeat
                                task.wait(0.1)
                                sendKey(VIM, Enum.KeyCode.M)
                            until checkMeditating()
                        end
                    end
                            
                    task.wait(0.1)

                until easyStatCheck("RunEXP") >= runLevel and easyStatCheck("StaminaEXP") >= staminaLevel or not scriptVariables.runTask or not scriptVariables.bottingToMaxNen

                if easyStatCheck("RunEXP") >= runLevel and easyStatCheck("StaminaEXP") >= staminaLevel or not scriptVariables.runTask or not scriptVariables.bottingToMaxNen then
                    break
                end
            end

            sprinting(false)
        end

        --Anti AFK
        task.spawn(function()
            while (game:IsLoaded()) do
                sendKey(VIM, Enum.KeyCode.Unknown)
                task.wait(1000)
            end
        end)

        task.spawn(function()
            while (scriptVariables.runTask and scriptVariables.bottingToMaxNen) do
                task.wait(0.1)
                if not (WS.Living:FindFirstChild(Players.LocalPlayer.Name).Humanoid.DisplayName:find("Freecss")) then
                    spinClan()
                    task.wait(1)
                end
            end
        end)

        task.spawn(function()
            function trainAura(onOff)
                local localPlayer = Players.LocalPlayer

                if onOff then
                    if not WS.Living:FindFirstChild(localPlayer.Name).Torso:FindFirstChild("Aura1") then
                        if WS.Living:FindFirstChild(localPlayer.Name).HumanoidRootPart.Nen.Outline.Container.Bar.Size.X.Scale == 1 then
                            sendKey(VIM, Enum.KeyCode.N)
                        end
                    end
                else
                    if WS.Living:FindFirstChild(localPlayer.Name).Torso:FindFirstChild("Aura1") then
                        repeat
                            task.wait(0.1)
                            sendKey(VIM, Enum.KeyCode.N)
                        until not WS.Living:FindFirstChild(localPlayer.Name).Torso:FindFirstChild("Aura1")
                    end
                end
            end

            function trainTen(onOff)
                local localPlayer = Players.LocalPlayer

                if onOff then
                    if not WS.Living:FindFirstChild(localPlayer.Name):FindFirstChild("Ten") then
                        if WS.Living:FindFirstChild(localPlayer.Name).HumanoidRootPart.Nen.Outline.Container.Bar.Size.X.Scale == 1 then
                            sendKey(VIM, Enum.KeyCode.B)
                        end
                    end
                else
                    if WS.Living:FindFirstChild(localPlayer.Name):FindFirstChild("Ten") then
                        repeat
                            task.wait(0.1)
                            sendKey(VIM, Enum.KeyCode.B)
                        until not WS.Living:FindFirstChild(localPlayer.Name):FindFirstChild("Ten")
                    end
                end
                
            end

            function trainRen(onOff)
                local localPlayer = Players.LocalPlayer

                if onOff then
                    if not WS.Living:FindFirstChild(localPlayer.Name).Humanoid.Info.UsingRen.Value then
                        if WS.Living:FindFirstChild(localPlayer.Name).HumanoidRootPart.Nen.Outline.Container.Bar.Size.X.Scale == 1 then
                            sendKey(VIM, Enum.KeyCode.V)
                        end
                    end
                else
                    if WS.Living:FindFirstChild(localPlayer.Name).Humanoid.Info.UsingRen.Value then
                        repeat
                            task.wait(0.1)
                            sendKey(VIM, Enum.KeyCode.V)
                        until not WS.Living:FindFirstChild(localPlayer.Name).Humanoid.Info.UsingRen.Value
                    end
                end
            end

            function trainZetsu(onOff)
                local localPlayer = Players.LocalPlayer

                if onOff then
                    if not WS.Living:FindFirstChild(localPlayer.Name).Humanoid.Info.Zetsu.Value then
                        if WS.Living:FindFirstChild(localPlayer.Name).HumanoidRootPart.Nen.Outline.Container.Bar.Size.X.Scale == 1 then
                            sendKey(VIM, Enum.KeyCode.C)
                        end
                    end
                else
                    if WS.Living:FindFirstChild(localPlayer.Name).Humanoid.Info.Zetsu.Value then
                        repeat
                            task.wait(0.1)
                            sendKey(VIM, Enum.KeyCode.C)
                        until not WS.Living:FindFirstChild(localPlayer.Name).Humanoid.Info.Zetsu.Value
                    end
                end
            end

            function trainGyo(onOff)
                local localPlayer = Players.LocalPlayer

                if onOff then
                    if not WS.Living:FindFirstChild(localPlayer.Name).Head:FindFirstChild("LEYE") then
                        if WS.Living:FindFirstChild(localPlayer.Name).HumanoidRootPart.Nen.Outline.Container.Bar.Size.X.Scale == 1 then
                            sendKey(VIM, Enum.KeyCode.G)
                        end
                    end
                else
                    if WS.Living:FindFirstChild(localPlayer.Name).Head:FindFirstChild("LEYE") then
                        repeat
                            task.wait(0.1)
                            sendKey(VIM, Enum.KeyCode.G)
                        until not WS.Living:FindFirstChild(localPlayer.Name).Head:FindFirstChild("LEYE")
                    end
                end
            end

            function trainKen(onOff)
                local localPlayer = Players.LocalPlayer

                if onOff then
                    if not WS.Living:FindFirstChild(localPlayer.Name).Torso:FindFirstChild("Ken") then
                        if WS.Living:FindFirstChild(localPlayer.Name).HumanoidRootPart.Nen.Outline.Container.Bar.Size.X.Scale == 1 then
                            sendKey(VIM, Enum.KeyCode.H)
                        end
                    end
                else
                    if WS.Living:FindFirstChild(localPlayer.Name).Torso:FindFirstChild("Ken") then
                        repeat
                            task.wait(0.1)
                            sendKey(VIM, Enum.KeyCode.H)
                        until not WS.Living:FindFirstChild(localPlayer.Name).Torso:FindFirstChild("Ken")
                    end
                end
            end

            function trainKo(onOff)
                local localPlayer = Players.LocalPlayer

                if onOff then
                    if not WS.Living:FindFirstChild(localPlayer.Name)["Right Arm"]:FindFirstChild("Ko") then
                        if WS.Living:FindFirstChild(localPlayer.Name).HumanoidRootPart.Nen.Outline.Container.Bar.Size.X.Scale == 1 then
                            sendKey(VIM, Enum.KeyCode.X)
                        end
                    end
                else
                    if WS.Living:FindFirstChild(localPlayer.Name)["Right Arm"]:FindFirstChild("Ko") then
                        repeat
                            task.wait(0.1)
                            sendKey(VIM, Enum.KeyCode.X)
                        until not WS.Living:FindFirstChild(localPlayer.Name)["Right Arm"]:FindFirstChild("Ko")
                    end
                end
            end

            function trainEn(onOff)
                local localPlayer = Players.LocalPlayer

                if onOff then
                    if not WS.Effects:FindFirstChild(localPlayer.Name .. "EnBox") then
                        if WS.Living:FindFirstChild(localPlayer.Name).HumanoidRootPart.Nen.Outline.Container.Bar.Size.X.Scale == 1 then
                            sendKey(VIM, Enum.KeyCode.K)
                        end
                    end
                else
                    if WS.Effects:FindFirstChild(localPlayer.Name .. "EnBox") then
                        repeat
                            task.wait(0.1)
                            sendKey(VIM, Enum.KeyCode.K)
                        until not WS.Effects:FindFirstChild(localPlayer.Name .. "EnBox")
                    end
                end
            end

            function trainIn(onOff)
                local localPlayer = Players.LocalPlayer

                if onOff then
                    if not (WS.Living:FindFirstChild(localPlayer.Name)["Head"].Transparency > 0) then
                        if WS.Living:FindFirstChild(localPlayer.Name).HumanoidRootPart.Nen.Outline.Container.Bar.Size.X.Scale == 1 then
                            sendKey(VIM, Enum.KeyCode.P)
                        end
                    end
                else
                    if WS.Living:FindFirstChild(localPlayer.Name)["Head"].Transparency > 0 then
                        repeat
                            task.wait(0.1)
                            sendKey(VIM, Enum.KeyCode.P)
                        until not (WS.Living:FindFirstChild(localPlayer.Name)["Head"].Transparency > 0)
                    end
                end
            end

            while (scriptVariables.runTask and scriptVariables.bottingToMaxNen) do
                task.wait(0.1)

                --Aura
                --[[ if (easyStatCheck("MeditationEXP") >= 4000) then
                    if (easyStatCheck("AuraMastery") < 100000) then
                        repeat
                            task.wait(0.1)
                            trainAura()
                        until easyStatCheck("AuraMastery") >= 100000 or not scriptVariables.runTask or not scriptVariables.bottingToMaxNen
                    end
                end ]]

                --Ten
                if (easyStatCheck("MeditationEXP") >= 7200 and easyStatCheck("StrengthEXP") >= 3600 and easyStatCheck("RunEXP") >= 1000) then
                    if (easyStatCheck("TenMastery") < 100000) then
                        repeat
                            task.wait(0.1)
                            trainTen(true)
                        until easyStatCheck("TenMastery") >= 100000 or not scriptVariables.runTask or not scriptVariables.bottingToMaxNen

                        trainTen(false)
                    end
                end

                --Ren
                if (easyStatCheck("MeditationEXP") >= 15000 and easyStatCheck("StrengthEXP") >= 6000 and easyStatCheck("RunEXP") >= 2000 and easyStatCheck("StaminaEXP") >= 3600) then
                    if (easyStatCheck("RenMastery") < 100000) then
                        repeat
                            task.wait(0.1)
                            trainRen(true)
                        until easyStatCheck("RenMastery") >= 100000 or not scriptVariables.runTask or not scriptVariables.bottingToMaxNen

                        trainRen(false)
                    end
                end

                --Gyo
                --[[ if (easyStatCheck("MeditationEXP") >= 15000 and easyStatCheck("StrengthEXP") >= 6000 and easyStatCheck("RunEXP") >= 2000 and easyStatCheck("StaminaEXP") >= 3600 and easyStatCheck("RenMastery") >= 10000) then
                    if (easyStatCheck("GyoMastery") < 100000) then

                        if not (MSS:HasItem("recievedGyo")) then
                            MSS:SetItem("recievedGyo", true)
                            rejoin()
                        end

                        repeat
                            task.wait(0.1)
                            trainGyo(true)
                        until easyStatCheck("GyoMastery") >= 100000 or not scriptVariables.runTask or not scriptVariables.bottingToMaxNen

                        trainGyo(false)
                    end
                end ]]

                --Zetsu
                if (easyStatCheck("MeditationEXP") >= 20000 and easyStatCheck("StrengthEXP") >= 8000 and easyStatCheck("RunEXP") >= 3500 and easyStatCheck("StaminaEXP") >= 6000) then
                    if (easyStatCheck("ZetsuMastery") < 100000) then
                        repeat
                            task.wait(0.1)
                            trainZetsu(true)
                        until easyStatCheck("ZetsuMastery") >= 100000 or not scriptVariables.runTask or not scriptVariables.bottingToMaxNen

                        trainZetsu(false)
                    end
                end

                --Ken
                if (easyStatCheck("MeditationEXP") >= 60000 and easyStatCheck("StrengthEXP") >= 15000 and easyStatCheck("RunEXP") >= 9000 and easyStatCheck("StaminaEXP") >= 10000 and easyStatCheck("TenMastery") >= 10000) then
                    if (easyStatCheck("KenMastery") < 100000) then

                        if not (MSS:HasItem("recievedKen")) then
                            MSS:SetItem("recievedKen", true)
                            rejoin()
                        end

                        repeat
                            task.wait(0.1)
                            trainKen(true)
                        until easyStatCheck("KenMastery") >= 100000 or not scriptVariables.runTask or not scriptVariables.bottingToMaxNen

                        trainKen(false)
                    end
                end

                --En
                if (easyStatCheck("MeditationEXP") >= 100000 and easyStatCheck("StrengthEXP") >= 20000 and easyStatCheck("RunEXP") >= 12000 and easyStatCheck("StaminaEXP") >= 13000) then
                    if (easyStatCheck("EnMastery") < 100000) then
                        repeat
                            task.wait(0.1)
                            trainEn(true)
                        until easyStatCheck("EnMastery") >= 100000 or not scriptVariables.runTask or not scriptVariables.bottingToMaxNen

                        trainEn(false)
                    end
                end

                --In
                if (easyStatCheck("MeditationEXP") >= 150000 and easyStatCheck("StrengthEXP") >= 30000 and easyStatCheck("RunEXP") >= 20000 and easyStatCheck("StaminaEXP") >= 20000) then
                    if (easyStatCheck("InMastery") < 100000) then
                        repeat
                            task.wait(0.1)
                            trainIn(true)
                        until easyStatCheck("InMastery") >= 100000 or not scriptVariables.runTask or not scriptVariables.bottingToMaxNen

                        trainIn(false)
                    end
                end

                --Ko
                if (easyStatCheck("MeditationEXP") >= 31000 and easyStatCheck("StrengthEXP") >= 11000 and easyStatCheck("RunEXP") >= 6000 and easyStatCheck("StaminaEXP") >= 8000) then
                    if (easyStatCheck("KoMastery") < 1000000) then
                        repeat
                            task.wait(0.1)
                            trainKo(true)
                        until easyStatCheck("KoMastery") >= 1000000 or not scriptVariables.runTask or not scriptVariables.bottingToMaxNen

                        trainKo(false)
                    end
                end
            end

        end)

        task.spawn(function()

            --Do pushups till 1000 strength
            if (easyStatCheck("StrengthEXP") < 1000) then
                pushupTillStat(1000)
            end

            --Meditate till 4000 meditation
            if (easyStatCheck("MeditationEXP") < 4000) then
                meditateTillStat(4000)

                --Aura unlocked so rejoin
                if not (MSS:HasItem("Recieved Aura")) then
                    MSS:SetItem("Recieved Aura", true)
                    rejoin()
                end
            end

            --Do pushups till 3600 strength
            if (easyStatCheck("StrengthEXP") < 3600) then
                pushupTillStat(3600)
            end

            --Sprint till 1000 run
            if (easyStatCheck("RunEXP") < 1000) then
                sprintTillStat(1000, 0)
            end

            --Meditate till 7200 meditation
            if (easyStatCheck("MeditationEXP") < 7200) then
                meditateTillStat(7200)

                --Ten unlocked so rejoin
                if not (MSS:HasItem("Recieved Ten")) then
                    MSS:SetItem("Recieved Ten", true)
                    rejoin()
                end
            end

            --Do pushups till 6k strength
            if (easyStatCheck("StrengthEXP") < 6000) then
                pushupTillStat(6000)
            end

            --Sprint till 2000 run and 3600 stamina
            if (easyStatCheck("RunEXP") < 2000 and easyStatCheck("StaminaEXP") < 3600) then
                sprintTillStat(2000, 3600)
            end

            --Meditate till 20000 meditation
            if (easyStatCheck("MeditationEXP") < 20000) then
                meditateTillStat(20000)

                --Ren unlocked so rejoin
                if MSS:HasItem("Recieved Ren") == nil then
                    MSS:SetItem("Recieved Ren", true)
                    rejoin()
                end
            end

            --Do pushups till 8k strength
            if (easyStatCheck("StrengthEXP") < 8000) then
                pushupTillStat(8000)
            end

            --Sprint till 3.5k run and 6k stamina
            if (easyStatCheck("RunEXP") < 3500 and easyStatCheck("StaminaEXP") < 6000) then
                sprintTillStat(3500, 6000)

                --Zetsu unlocked so rejoin
                if MSS:HasItem("Recieved Zetsu") == nil then
                    MSS:SetItem("Recieved Zetsu", true)
                    rejoin()
                end
            end

            --Meditate till 31k meditation
            if (easyStatCheck("MeditationEXP") < 31000) then
                meditateTillStat(31000)
            end

            --Do pushups till 11k strength
            if (easyStatCheck("StrengthEXP") < 11000) then
                pushupTillStat(11000)
            end

            --Sprint till 6000 run and 8000 stamina
            if (easyStatCheck("RunEXP") < 6000 and easyStatCheck("StaminaEXP") < 8000) then
                sprintTillStat(6000, 8000)
            end

            --Meditate till 60k
            if (easyStatCheck("MeditationEXP") < 60000) then
                meditateTillStat(60000)

                --Ko unlocked so rejoin
                if MSS:HasItem("Recieved Ko") == nil then
                    MSS:SetItem("Recieved Ko", true)
                    rejoin()
                end
            end

            --Do pushups till 15k
            if (easyStatCheck("StrengthEXP") < 15000) then
                pushupTillStat(15000)
            end     

            --Sprint till 9k run and 10k stamina
            if (easyStatCheck("RunEXP") < 9000 and easyStatCheck("StaminaEXP") < 10000) then
                sprintTillStat(9000, 10000)
            end

            --Meditate till 100k
            if (easyStatCheck("MeditationEXP") < 100000) then
                meditateTillStat(100000)
            end

            --Do pushups till 20k strength
            if (easyStatCheck("StrengthEXP") < 20000) then
                pushupTillStat(20000)
            end

            --Sprint till 12k run and 13k stamina
            if (easyStatCheck("RunEXP") < 12000 and easyStatCheck("StaminaEXP") < 13000) then
                sprintTillStat(12000, 13000)

                --En unlocked so rejoin
                if MSS:HasItem("Recieved En") == nil then
                    MSS:SetItem("Recieved En", true)
                    rejoin()
                end
            end

            --Meditate till 150k
            if (easyStatCheck("MeditationEXP") < 150000) then
                meditateTillStat(150000)
            end

            --Do pushups till 30k
            if (easyStatCheck("StrengthEXP") < 30000) then
                pushupTillStat(30000)
            end

            --Sprint till 20k run and 20k stamina
            if (easyStatCheck("RunEXP") < 20000 and easyStatCheck("StaminaEXP") < 20000) then
                sprintTillStat(20000, 20000)

                --In unlocked so rejoin
                if MSS:HasItem("Recieved In") == nil then
                    MSS:SetItem("Recieved In", true)
                    rejoin()
                end
            end

            --Do pushups till 100k (max)
            if (easyStatCheck("StrengthEXP") < 100000) then
                pushupTillStat(100000)
            end

            --Meditate till 500k (max)
            if (easyStatCheck("MeditationEXP") < 500000) then
                meditateTillStat(500000)
            end

            --Sprint till 100k run and 100k stamina
            if (easyStatCheck("RunEXP") < 100000 and easyStatCheck("StaminaEXP") < 100000) then
                sprintTillStat(100000, 100000)
            end

        end)

    elseif scriptVariables.runTask and scriptVariables.bottingToMaxNen then
        scriptVariables.runTask = false
        scriptVariables.bottingToMaxNen = false

        if (MSS:HasItem("botToMaxNen")) then
            MSS:RemoveItem("botToMaxNen")
        end
    end
end

local BotGroup = Tabs['Main']:AddRightGroupbox('Bots')
BotGroup:AddButton('Bot Pushups', function() doPushups() end)
BotGroup:AddButton('Bot Meditation', function() meditate() end)
BotGroup:AddButton('Bot Sprint', function() sprint() end)
BotGroup:AddButton('Bot To Hatsu', function() botToHatsu() end)
BotGroup:AddButton('Bot To Max Nen', function() botToMaxNen() end)

local SpinGroup = Tabs['Main']:AddLeftGroupbox('Spin Remotes')
SpinGroup:AddButton('Spin Clan Type', function() spinClan() end)

local FlagsGroup = Tabs['Main']:AddLeftGroupbox('Flags')
FlagsGroup:AddButton('Claim All Flags', function() claimAllFlags() end)

local MenuGroup = Tabs['UI Settings']:AddLeftGroupbox('Menu')
MenuGroup:AddButton('Unload', function() Library:Unload() end)
MenuGroup:AddLabel('Menu bind'):AddKeyPicker('MenuKeybind', { Default = 'End', NoUI = true, Text = 'Menu keybind' })

Library.ToggleKeybind = Options.MenuKeybind


ThemeManager:SetLibrary(Library)
SaveManager:SetLibrary(Library)


SaveManager:IgnoreThemeSettings()


SaveManager:SetIgnoreIndexes({ 'MenuKeybind' })


ThemeManager:SetFolder('MyScriptHub')
SaveManager:SetFolder('MyScriptHub/specific-game')

SaveManager:BuildConfigSection(Tabs['UI Settings'])

ThemeManager:ApplyToTab(Tabs['UI Settings'])

SaveManager:LoadAutoloadConfig()

--Auto load tasks here
if (MSS:HasItem("botToHatsu")) then
    task.spawn(function()
        repeat task.wait() until game:GetService("Players").LocalPlayer
        repeat task.wait() until game:GetService("Players").LocalPlayer.Character

        task.wait(5)

        botToHatsu()
    end)
end

if (MSS:HasItem("botToMaxNen")) then
    task.spawn(function()
        repeat task.wait() until game:GetService("Players").LocalPlayer
        repeat task.wait() until game:GetService("Players").LocalPlayer.Character

        task.wait(5)

        botToMaxNen()
    end)
end
