if SERVER then
	local addons = require("GMT_Scripts.addons")

	local path = table.pack(...)[1]
	
	local function loadAddon()
		-- Hook to admin PM event
		Hook.Add("gmtools.adminpm.sent", "gmt_bwoink_event", function(sender, target, message)
			local bwoinkCharacter = target.Character
		
			-- It will works only if player controls a character.
			if bwoinkCharacter ~= nil and bwoinkCharacter.IsDead == false then
				local bwoinkAffliction = AfflictionPrefab.Prefabs["gmtbwoink"]
				bwoinkCharacter.CharacterHealth.ApplyAffliction(bwoinkCharacter.AnimController.MainLimb, bwoinkAffliction.Instantiate(1))
			end
		end)
	end

	-- Hook on GMTools load
	Hook.Add("gmtools.loaded", "gmt_bwoink_load", function(contentPackage, forcedLaunch)
		for i, mod in ipairs(Game.GetEnabledContentPackages()) do
			-- Load only if registration was approved
			if path.."/filelist.xml" == mod.Path and addons.RegisterAddon(mod) then
				loadAddon()
				break
			end
		end
	end)
end