ESX = exports["es_extended"]:getSharedObject()

-- Server callback to check if there is at least one player in the specified job
-- @param1 job The Job you want to check
ESX.RegisterServerCallback("ActiveJobs:isPlayerInJob", function(source, cb, job)
    if not job then
        print("Something Tried to Call this ServerCallback but without a Job (@param1)")
		
        cb(false)
        
		return
    end

	local isSomeoneInJob = false
	local peopleInJob = ESX.GetExtendedPlayers("job", job)
	
	if #peopleInJob > 0 then isSomeoneInJob = true end
	
	cb(isSomeoneInJob)
end)

-- Server callback to get the number of active players in the specified job
-- @param1 job The Job you want to check
ESX.RegisterServerCallback("ActiveJobs:HowManyActive", function(source, cb, job)
    if not job then
        print("Something Tried to Call this ServerCallback but without a Job (@param1)")
        
		cb(0) -- Change: Return 0 instead of nil to avoid errors
        
		return
    end

	local peopleInJob = ESX.GetExtendedPlayers("job", job)

    cb(#peopleInJob or 0)
end)
