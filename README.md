# ESX-Active-Jobs

ESX Job Player Count Script

This script counts the number of players in each job on an ESX-based FiveM server. It updates the counts when players join, leave, or change their job.

## Installation

1. Copy the script file into the resources directory of your FiveM server.
2. Add the script to your `server.cfg` file by adding the following line:

    ensure ActiveJobs

    
3. Restart your FiveM server.

## Features

### `check()`

This function checks the number of players in each job. It prevents the check from running too frequently by setting a cooldown flag, which remains active for 5 seconds.

### Event Handlers

- `esx:playerDropped`: Called when a player leaves the server.
- `esx:playerLoaded`: Called when a player joins the server.
- `esx:setJob`: Called when a player changes their job.

## Debugging

If `Config.Debug` is set to true, the number of players in each job will be printed to the console every 10 seconds.

## Server Callbacks

### `ActiveJobs:isPlayerInJob`

Checks if there is at least one player in a specified job.

**Parameters:**

- `job` (string): The job to check.

**Callback:**

- `cb` (function): A function that returns true if there is at least one player in the job, otherwise false.

### `ActiveJobs:HowManyActive`

Returns the number of active players in a specified job.

**Parameters:**

- `job` (string): The job to check.

**Callback:**

- `cb` (function): A function that returns the number of players in the job, or nil if no job is specified.

## Usage

### Check if there are players in a specific job

```lua
ESX.TriggerServerCallback('ActiveJobs:isPlayerInJob', function(isInJob)
 if isInJob then
     -- There is at least one player in this job
 else
     -- There are no players in this job
 end
end, 'police') -- Replace 'police' with the desired job

ESX.TriggerServerCallback('ActiveJobs:HowManyActive', function(count)
    print('Number of players in the job:', count)
end, 'police') -- Replace 'police' with the desired job

```

## Configuration

### Enable Debug Mode
To enable debug mode, set Config.Debug to true
When debug mode is enabled, the number of players in each job will be printed to the console every 10 seconds.