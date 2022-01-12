
Citizen.CreateThread(function()
	OnEnterMp() -- required to load heist ipl?
	RequestAllIpls()
end)


-- https://wiki.gtanet.work/index.php?title=Online_Interiors_and_locations
-- IPL list 1.0.1290: https://pastebin.com/iNGLY32D
-- Extra IPL info: https://pastebin.com/SE5t8CnE
function RequestAllIpls()

	-- RequestIpl('apa_v_mp_h_01_b') -- Modern
	-- RequestIpl('apa_v_mp_h_02_b') -- Mody
	-- RequestIpl('apa_v_mp_h_03_b') -- Vibrant
	RequestIpl('apa_v_mp_h_04_b') -- Sharp
	-- RequestIpl('apa_v_mp_h_05_b') -- Monochrome
	-- RequestIpl('apa_v_mp_h_06_b') -- Seductive
	-- RequestIpl('apa_v_mp_h_07_b') -- Regal
	-- RequestIpl('apa_v_mp_h_08_b') -- Aqua

end
