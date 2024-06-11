ESX = exports["es_extended"]:getSharedObject()

-- A table to hold the number of players for each job
local jobs = {}

-- A flag to prevent the check function from running too frequently
local cooldown = false

-- Function to check the number of players for each job
function check()
    if cooldown then return end
    cooldown = true
    jobs = {}
    
    -- Iterate through all players
    for _, playerId in ipairs(GetPlayers()) do
        local xPlayer = ESX.GetPlayerFromId(playerId)
        local job = xPlayer.job.label
        
        -- Update the count of players for each job
        if jobs[job] == nil then
            jobs[job] = 1
        else
            jobs[job] = jobs[job] + 1
        end
    end

    -- Set a cooldown period of 5 seconds
    CreateThread(function ()
        Wait(5000)
        cooldown = false
    end)
end

-- Event handler for when a player drops from the server
RegisterNetEvent('esx:playerDropped', function(playerId, reason)
    check()
end)

-- Event handler for when a player loads into the server
RegisterNetEvent('esx:playerLoaded', function(player, xPlayer, isNew)
    check()
end)

-- Event handler for when a player changes their job
RegisterNetEvent('esx:setJob', function(player, job, lastJob)
    check()
end)

-- Debugging section to print the number of players for each job every 10 seconds
if Config.Debug then
    CreateThread(function ()
        while true do
            Wait(10000)
            check()
            for job, count in pairs(jobs) do
                print("Job: " .. job .. ", Count: " .. count)
            end
        end
    end)
end

-- Server callback to check if there is at least one player in the specified job
-- @param1 job The Job you want to check
ESX.RegisterServerCallback("ActiveJobs:isPlayerInJob", function(source, cb, job)
    
    if not job then
        print("Something Tried to Call this ServerCallback but without a Job (@param1)")
        cb(false)
        return
    end

    if jobs[job] and jobs[job] > 0 then
        cb(true)
    else
        cb(false)
    end
end)

-- Server callback to get the number of active players in the specified job
-- @param1 job The Job you want to check
ESX.RegisterServerCallback("ActiveJobs:HowManyActive", function(source, cb, job)

    if not job then
        print("Something Tried to Call this ServerCallback but without a Job (@param1)")
        cb(nil)
        return
    end

    cb(jobs[job] or 0)
end)
