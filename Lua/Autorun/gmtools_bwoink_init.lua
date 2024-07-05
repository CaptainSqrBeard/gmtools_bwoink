if SERVER then
	local path = table.pack(...)[1]
	
	local function loadAddon()
		-- Hook to admin PM event
		Hook.Add("gmtools.adminpm.sent", "gmt_bwoink_event", function(sender, target, message)
			local bwoink_chr = target.Character
		
			-- It will works only if player controls a character.
			if bwoink_chr ~= nil and bwoink_chr.IsDead == false then
				local bwoinkAff = AfflictionPrefab.Prefabs["gmtbwoink"]
				bwoink_chr.CharacterHealth.ApplyAffliction(bwoink_chr.AnimController.MainLimb, bwoinkAff.Instantiate(1))
			end
		end)
	end
	
	-- Hook on GMTools load
	Hook.Add("gmtools.loaded", "gmt_bwoink_load", function(sender, target, message)
		for i, mod in ipairs(Game.GetEnabledContentPackages()) do
			if path.."/filelist.xml" == mod.Path then
				-- Load only if addon was approved
				if GMT.API.RegisterAddon(mod) then
					loadAddon()
					break
				end
			end
		end
	end)
end