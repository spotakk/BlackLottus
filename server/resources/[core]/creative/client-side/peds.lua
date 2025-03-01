-----------------------------------------------------------------------------------------------------------------------------------------
-- VARIABLES
-----------------------------------------------------------------------------------------------------------------------------------------
local localPeds = {}
-----------------------------------------------------------------------------------------------------------------------------------------
-- PEDLIST
-----------------------------------------------------------------------------------------------------------------------------------------
local pedList = {
	{ -- Concessionária
		distance = 30,
		coords = { -56.49,-1098.61,26.42,31.19 },
		model = { 0x999B00C6,"ig_paper" },
		anim = { "anim@heists@heist_corona@single_team","single_team_loop_boss" }
	},
	{ -- TowDriver
		distance = 100,
		coords = { 1737.95,3709.1,34.14,19.85 },
		model = { 0xF1E823A2,"g_m_m_armboss_01" },
		anim = { "anim@heists@heist_corona@single_team","single_team_loop_boss" }
	},
	{ -- TowDriver
		distance = 30,
		coords = { 371.25,-1612.76,29.28,328.82 },
		model = { 0xF1E823A2,"g_m_m_armboss_01" },
		anim = { "anim@heists@heist_corona@single_team","single_team_loop_boss" }
	},
	{ -- WeedShop
		distance = 30,
		coords = { -1171.3,-1571.12,4.67,127.56 },
		model = { 0xE83B93B7,"g_m_y_famca_01" },
		anim = { "anim@heists@heist_corona@single_team","single_team_loop_boss" }
	},
	{ -- Coveiro
		distance = 100,
		coords = { -1745.92,-204.83,57.39,320.32 },
		model = { 0xF1E823A2,"g_m_m_armboss_01" },
		anim = { "timetable@trevor@smoking_meth@base","base" }
	},
	{ -- Leiteiro
		distance = 100,
		coords = { 2440.58,4736.35,34.29,317.50 },
		model = { 0xFCFA9E1E,"a_c_cow" }
	},
	{ -- Leiteiro
		distance = 100,
		coords = { 2432.5,4744.58,34.31,317.50 },
		model = { 0xFCFA9E1E,"a_c_cow" }
	},
	{ -- Leiteiro
		distance = 100,
		coords = { 2424.47,4752.37,34.31,317.50 },
		model = { 0xFCFA9E1E,"a_c_cow" }
	},
	{ -- Leiteiro
		distance = 100,
		coords = { 2416.28,4760.8,34.31,317.50 },
		model = { 0xFCFA9E1E,"a_c_cow" }
	},
	{ -- Leiteiro
		distance = 100,
		coords = { 2408.6,4768.88,34.31,317.50 },
		model = { 0xFCFA9E1E,"a_c_cow" }
	},
	{ -- Leiteiro
		distance = 100,
		coords = { 2400.32,4777.48,34.53,317.50 },
		model = { 0xFCFA9E1E,"a_c_cow" }
	},
	{ -- Leiteiro
		distance = 100,
		coords = { 2432.46,4802.66,34.83,137.50 },
		model = { 0xFCFA9E1E,"a_c_cow" }
	},
	{ -- Leiteiro
		distance = 100,
		coords = { 2440.62,4794.22,34.66,137.50 },
		model = { 0xFCFA9E1E,"a_c_cow" }
	},
	{ -- Leiteiro
		distance = 100,
		coords = { 2448.65,4786.57,34.64,137.50 },
		model = { 0xFCFA9E1E,"a_c_cow" }
	},
	{ -- Leiteiro
		distance = 100,
		coords = { 2456.88,4778.08,34.49,137.50 },
		model = { 0xFCFA9E1E,"a_c_cow" }
	},
	{ -- Leiteiro
		distance = 100,
		coords = { 2464.53,4770.04,34.37,137.50 },
		model = { 0xFCFA9E1E,"a_c_cow" }
	},
	{ -- Leiteiro
		distance = 100,
		coords = { 2473.38,4760.98,34.31,137.50 },
		model = { 0xFCFA9E1E,"a_c_cow" }
	},
	{ -- Leiteiro
		distance = 100,
		coords = { 2495.03,4762.77,34.37,137.50 },
		model = { 0xFCFA9E1E,"a_c_cow" }
	},
	{ -- Leiteiro
		distance = 100,
		coords = { 2503.13,4754.08,34.31,137.50 },
		model = { 0xFCFA9E1E,"a_c_cow" }
	},
	{ -- Leiteiro
		distance = 100,
		coords = { 2511.34,4746.04,34.31,137.50 },
		model = { 0xFCFA9E1E,"a_c_cow" }
	},
	{ -- Leiteiro
		distance = 100,
		coords = { 2519.56,4737.35,34.29,137.50 },
		model = { 0xFCFA9E1E,"a_c_cow" }
	},
	{ -- Agricultor
		distance = 100,
		coords = { 2301.09,5064.78,45.81,170.08 },
		model = { 0x1536D95A,"a_m_o_ktown_01" },
		anim = { "anim@heists@heist_corona@single_team","single_team_loop_boss" }
	},
	{ -- Imobiliária
		distance = 100,
		coords = { 1655.27,4874.31,42.04,280.63 },
		model = { 0x3293B9CE,"mp_f_boatstaff_01" },
		anim = { "anim@heists@heist_corona@single_team","single_team_loop_boss" }
	},
	{ -- Lavagem PUB
		distance = 100,
		coords = { -1051.42,-231.9,44.01,116.23 },
		model = { 0x3293B9CE,"mp_f_boatstaff_01" },
		anim = { "anim@heists@heist_corona@single_team","single_team_loop_boss" }
	},
	{ -- Prefeitura
		distance = 30,
		coords = { -544.78,-185.86,52.2,300.48 },
		model = { 0x2F8845A3,"ig_barry" },
		anim = { "anim@heists@heist_corona@single_team","single_team_loop_boss" }
	},
	{ -- Prefeitura
		distance = 30,
		coords = { -551.1,-191.07,38.22,221.11 },
		model = { 0x2F8845A3,"ig_barry" },
		anim = { "anim@heists@prison_heistig1_p1_guard_checks_bus","loop" }
	},
	{ -- Prefeitura
		distance = 30,
		coords = { -553.3,-192.34,38.22,206.93 },
		model = { 0x2F8845A3,"ig_barry" },
		anim = { "anim@heists@prison_heistig1_p1_guard_checks_bus","loop" }
	},
	{ -- Black Market  ARMAS
	distance = 20,
	coords = { -1647.33,-1075.21,12.15,136.07 },
	model = { 0xF42EE883,"g_m_y_ballaeast_01" },
	anim = { "anim@heists@heist_corona@single_team","single_team_loop_boss" }
    },
	{ -- Black Market
		distance = 20,
		coords = { -585.45,-1051.8,22.34,178.59 },
		model = { 0x158C439C,"g_f_y_ballas_01" },
		anim = { "anim@heists@heist_corona@single_team","single_team_loop_boss" }
	},
	{ -- Black Market
		distance = 20,
		coords = { 2436.08,4965.39,42.34,226.78 },
		model = { 0x4F46D607,"g_m_y_lost_01" },
		anim = { "amb@prop_human_parking_meter@female@idle_a","idle_a_female" }
	},
	{ -- Black Market
		distance = 20,
		coords = { 2432.44,4964.06,42.34,178.59 },
		model = { 0x4F46D607,"g_m_y_lost_01" },
		anim = { "amb@world_human_bum_wash@male@high@base","base" }
	},
	{ -- Black Market
		distance = 20,
		coords = { 2431.57,4965.22,42.34,124.73 },
		model = { 0x4F46D607,"g_m_y_lost_01" },
		anim = { "amb@world_human_bum_wash@male@high@base","base" }
	},
	{ -- Black Market
		distance = 20,
		coords = { 2428.67,4969.51,42.34,133.23 },
		model = { 0x4F46D607,"g_m_y_lost_01" },
		anim = { "anim@amb@business@coc@coc_packing_hi@","full_cycle_v1_pressoperator" }
	},
	{ -- Black Market
		distance = 20,
		coords = { 2437.05,4967.61,42.34,317.49 },
		model = { 0x4F46D607,"g_m_y_lost_01" },
		anim = { "anim@amb@business@coc@coc_packing_hi@","full_cycle_v1_pressoperator" }
	},
	{ -- Taxi
		distance = 50,
		coords = { -1039.34,-2730.8,20.2,235.28 },
		model = { 0x8674D5FC,"a_m_y_stlat_01" },
		anim = { "amb@lo_res_idles@","world_human_lean_male_foot_up_lo_res_base" }
	},
	{ -- Groove
		distance = 100,
		coords = { -134.17,-1606.24,35.11,144.57 },
		model = { 0x23B88069,"g_m_y_ballasout_01" },
		anim = { "amb@lo_res_idles@","world_human_lean_male_foot_up_lo_res_base" }
	},
	{ -- Police  
		distance = 100,
		coords = { -426.44,1196.33,325.76,260.79 },
		model = { 0x15F8700D,"s_f_y_cop_01" },
		anim = { "anim@heists@heist_corona@single_team","single_team_loop_boss" }
	},
	{ -- Police  
	distance = 100,
	coords = { 61.86,-751.88,44.21,68.04 },
	model = { 0x15F8700D,"s_f_y_cop_01" },
	anim = { "anim@heists@heist_corona@single_team","single_team_loop_boss" }
    }, 
	{ -- Police  
	distance = 100,
	coords = { -909.01,-2036.76,9.47,226.78 },
	model = { 0x15F8700D,"s_f_y_cop_01" },
	anim = { "anim@heists@heist_corona@single_team","single_team_loop_boss" }
    },
	{ -- Police
	distance = 100,
	coords = { -448.29,6012.49,31.71,317.49 },
	model = { 0x15F8700D,"s_f_y_cop_01" },
	anim = { "amb@prop_human_bum_shopping_cart@male@base","base" }
    },
	{ -- Police CADETE
	distance = 100,
	coords = { 2525.5,-342.68,101.89,357.17 },
	model = { 0x15F8700D,"s_f_y_cop_01" },
	anim = { "anim@heists@heist_corona@single_team","single_team_loop_boss" }
    },
	{ -- Police ARSENAL
	distance = 100,
	coords = { -424.39,1082.63,327.68,351.5 },
	model = { 0x15F8700D,"s_f_y_cop_01" },
	anim = { "anim@heists@heist_corona@single_team","single_team_loop_boss" }
    },

	{ -- Police
	distance = 100,
	coords = { -967.63,-2065.31,9.4,136.07 },
	model = { 0x15F8700D,"s_f_y_cop_01" },
	anim = { "anim@heists@heist_corona@single_team","single_team_loop_boss" }
    },
	{ -- Mecânica Hayes
	distance = 100,
	coords = { -1410.09,-439.45,35.91,308.98 },
	model = {  0x3B474ADF,"hc_driver" },
	anim = { "amb@medic@standing@tendtodead@idle_a","idle_a" }
    }, 
	{ -- MECANICA
	distance = 100,
	coords = { 728.75,-1069.09,28.31,87.88 },
	model = {  0xF7A74139,"mp_m_waremech_01" },
	anim = { "anim@heists@heist_corona@single_team","single_team_loop_boss" }
    },
	{ -- Bennys
	distance = 100,
	coords = { -241.78,-1333.13,30.9,274.97 },
	model = {  0xF7A74139,"mp_m_waremech_01" },
	anim = { "anim@heists@heist_corona@single_team","single_team_loop_boss" }
    },

	{ -- Paramedic
		distance = 100,
		coords = { -271.7,6321.75,32.42,0.0 },
		model = { 0xB353629E,"s_m_m_paramedic_01" },
		anim = { "anim@heists@heist_corona@single_team","single_team_loop_boss" }
	},
	{ -- Paramedic
		distance = 100,
		coords = { -253.92,6339.42,32.42,5.67 },
		model = { 0xB353629E,"s_m_m_paramedic_01" },
		anim = { "anim@heists@heist_corona@single_team","single_team_loop_boss" }
	},
	{ -- Paramedic
		distance = 100,
		coords = { 338.19,-586.91,74.16,252.29 },
		model = { 0xB353629E,"s_m_m_paramedic_01" },
		anim = { "anim@heists@heist_corona@single_team","single_team_loop_boss" }
	},
	{ -- Paramedic
		distance = 100,
		coords = { 340.08,-576.19,28.8,73.71 },
		model = { 0xB353629E,"s_m_m_paramedic_01" },
		anim = { "anim@heists@heist_corona@single_team","single_team_loop_boss" }
	},
	{ -- Departament Store
		distance = 10,
		coords = { 24.49,-1346.08,29.49,272.13 },
		model = { 0x18CE57D0,"mp_m_shopkeep_01" },
		anim = { "anim@heists@heist_corona@single_team","single_team_loop_boss" }
	},
	{ -- Departament Store
		distance = 10,
		coords = { 2556.04,380.89,108.61,0.0 },
		model = { 0x18CE57D0,"mp_m_shopkeep_01" },
		anim = { "anim@heists@heist_corona@single_team","single_team_loop_boss" }
	},
	{ -- Departament Store
		distance = 10,
		coords = { 1164.82,-323.63,69.2,99.22 },
		model = { 0x18CE57D0,"mp_m_shopkeep_01" },
		anim = { "anim@heists@heist_corona@single_team","single_team_loop_boss" }
	},
	{ -- Departament Store
		distance = 10,
		coords = { -706.16,-914.55,19.21,90.71 },
		model = { 0x18CE57D0,"mp_m_shopkeep_01" },
		anim = { "anim@heists@heist_corona@single_team","single_team_loop_boss" }
	},
	{ -- Departament Store
		distance = 10,
		coords = { -47.39,-1758.63,29.42,51.03 },
		model = { 0x18CE57D0,"mp_m_shopkeep_01" },
		anim = { "anim@heists@heist_corona@single_team","single_team_loop_boss" }
	},
	{ -- Departament Store
		distance = 10,
		coords = { 372.86,327.53,103.56,257.96 },
		model = { 0x18CE57D0,"mp_m_shopkeep_01" },
		anim = { "anim@heists@heist_corona@single_team","single_team_loop_boss" }
	},
	{ -- Departament Store
		distance = 6,
		coords = { -3243.38,1000.11,12.82,0.0 },
		model = { 0x18CE57D0,"mp_m_shopkeep_01" },
		anim = { "anim@heists@heist_corona@single_team","single_team_loop_boss" }
	},
	{ -- Departament Store
		distance = 6,
		coords = { 1728.39,6416.21,35.03,246.62 },
		model = { 0x18CE57D0,"mp_m_shopkeep_01" },
		anim = { "anim@heists@heist_corona@single_team","single_team_loop_boss" }
	},
	{ -- Departament Store
		distance = 6,
		coords = { 549.2,2670.22,42.16,96.38 },
		model = { 0x18CE57D0,"mp_m_shopkeep_01" },
		anim = { "anim@heists@heist_corona@single_team","single_team_loop_boss" }
	},
	{ -- Departament Store
		distance = 6,
		coords = { 1959.54,3741.01,32.33,303.31 },
		model = { 0x18CE57D0,"mp_m_shopkeep_01" },
		anim = { "anim@heists@heist_corona@single_team","single_team_loop_boss" }
	},
	{ -- Departament Store
		distance = 6,
		coords = { 2677.07,3279.95,55.23,334.49 },
		model = { 0x18CE57D0,"mp_m_shopkeep_01" },
		anim = { "anim@heists@heist_corona@single_team","single_team_loop_boss" }
	},
	{ -- Departament Store
		distance = 6,
		coords = { 1697.35,4923.46,42.06,328.82 },
		model = { 0x18CE57D0,"mp_m_shopkeep_01" },
		anim = { "anim@heists@heist_corona@single_team","single_team_loop_boss" }
	},
	{ -- Departament Store
		distance = 6,
		coords = { -1819.55,793.51,138.08,133.23 },
		model = { 0x18CE57D0,"mp_m_shopkeep_01" },
		anim = { "anim@heists@heist_corona@single_team","single_team_loop_boss" }
	},
	{ -- Departament Store
		distance = 10,
		coords = { 1392.03,3606.1,34.98,204.1 },
		model = { 0x18CE57D0,"mp_m_shopkeep_01" },
		anim = { "anim@heists@heist_corona@single_team","single_team_loop_boss" }
	},
	{ -- Departament Store
		distance = 10,
		coords = { -2966.41,391.59,15.05,85.04 },
		model = { 0x18CE57D0,"mp_m_shopkeep_01" },
		anim = { "anim@heists@heist_corona@single_team","single_team_loop_boss" }
	},
	{ -- Departament Store
		distance = 10,
		coords = { -3040.04,584.22,7.9,19.85 },
		model = { 0x18CE57D0,"mp_m_shopkeep_01" },
		anim = { "anim@heists@heist_corona@single_team","single_team_loop_boss" }
	},
	{ -- Departament Store
		distance = 10,
		coords = { 1134.33,-983.09,46.4,277.8 },
		model = { 0x18CE57D0,"mp_m_shopkeep_01" },
		anim = { "anim@heists@heist_corona@single_team","single_team_loop_boss" }
	},
	{ -- Departament Store
		distance = 10,
		coords = { 1165.26,2710.79,38.15,178.59 },
		model = { 0x18CE57D0,"mp_m_shopkeep_01" },
		anim = { "anim@heists@heist_corona@single_team","single_team_loop_boss" }
	},
	{ -- Departament Store
		distance = 10,
		coords = { -1486.77,-377.56,40.15,133.23 },
		model = { 0x18CE57D0,"mp_m_shopkeep_01" },
		anim = { "anim@heists@heist_corona@single_team","single_team_loop_boss" }
	},
	{ -- Departament Store
		distance = 10,
		coords = { -1221.42,-907.91,12.32,31.19 },
		model = { 0x18CE57D0,"mp_m_shopkeep_01" },
		anim = { "anim@heists@heist_corona@single_team","single_team_loop_boss" }
	},
	{ -- Ammu-Nation Store
		distance = 12,
		coords = { 1692.28,3760.94,34.69,229.61 },
		model = { 0x467415E9,"ig_dale" },
		anim = { "anim@heists@heist_corona@single_team","single_team_loop_boss" }
	},
	{ -- Lockpick
	distance = 12,
	coords = { 846.02,2123.11,52.86,90.71 },
	model = { 0x467415E9,"ig_dale" },
	anim = { "anim@heists@heist_corona@single_team","single_team_loop_boss" }
    },
	{ -- Ammu-Nation Store
		distance = 12,
		coords = { 253.79,-50.5,69.94,68.04 },
		model = { 0x467415E9,"ig_dale" },
		anim = { "anim@heists@heist_corona@single_team","single_team_loop_boss" }
	},
	{ -- Ammu-Nation Store
		distance = 12,
		coords = { 842.41,-1035.28,28.19,0.0 },
		model = { 0x467415E9,"ig_dale" },
		anim = { "anim@heists@heist_corona@single_team","single_team_loop_boss" }
	},
	{ -- Ammu-Nation Store
		distance = 12,
		coords = { -331.62,6084.93,31.46,226.78 },
		model = { 0x467415E9,"ig_dale" },
		anim = { "anim@heists@heist_corona@single_team","single_team_loop_boss" }
	},
	{ -- Ammu-Nation Store
		distance = 12,
		coords = { -662.29,-933.62,21.82,181.42 },
		model = { 0x467415E9,"ig_dale" },
		anim = { "anim@heists@heist_corona@single_team","single_team_loop_boss" }
	},
	{ -- Ammu-Nation Store
		distance = 12,
		coords = { -1304.17,-394.62,36.7,73.71 },
		model = { 0x467415E9,"ig_dale" },
		anim = { "anim@heists@heist_corona@single_team","single_team_loop_boss" }
	},
	{ -- Ammu-Nation Store
		distance = 12,
		coords = { -1118.95,2699.73,18.55,223.94 },
		model = { 0x467415E9,"ig_dale" },
		anim = { "anim@heists@heist_corona@single_team","single_team_loop_boss" }
	},
	{ -- Ammu-Nation Store
		distance = 12,
		coords = { 2567.98,292.65,108.73,0.0 },
		model = { 0x467415E9,"ig_dale" },
		anim = { "anim@heists@heist_corona@single_team","single_team_loop_boss" }
	},
	{ -- Ammu-Nation Store
		distance = 12,
		coords = { -3173.51,1088.38,20.84,249.45 },
		model = { 0x467415E9,"ig_dale" },
		anim = { "anim@heists@heist_corona@single_team","single_team_loop_boss" }
	},
	{ -- Ammu-Nation Store
		distance = 12,
		coords = { 22.59,-1105.54,29.79,155.91 },
		model = { 0x467415E9,"ig_dale" },
		anim = { "anim@heists@heist_corona@single_team","single_team_loop_boss" }
	},
	{ -- Ammu-Nation Store
		distance = 12,
		coords = { 810.22,-2158.99,29.62,0.0 },
		model = { 0x467415E9,"ig_dale" },
		anim = { "anim@heists@heist_corona@single_team","single_team_loop_boss" }
	},
	{ -- Life Invader
		distance = 20,
		coords = { -1083.15,-245.88,37.76,209.77 },
		model = { 0x2F8845A3,"ig_barry" },
		anim = { "anim@heists@heist_corona@single_team","single_team_loop_boss" }
	},
	{ -- Pharmacy Store
		distance = 30,
		coords = { -172.89,6381.32,31.48,223.94 },
		model = { 0x5244247D,"u_m_y_baygor" },
		anim = { "anim@heists@heist_corona@single_team","single_team_loop_boss" }
	},
	{ -- Pharmacy Store
	distance = 30,
	coords = { -452.08,-324.9,34.91,0.0 },
	model = { 0x5244247D,"u_m_y_baygor" },
	anim = { "anim@heists@heist_corona@single_team","single_team_loop_boss" }
    },
	{ -- Concessionária
	distance = 100,
	coords = { 1224.78,2728.01,38.0,178.59 },
	model = "ig_ramp_hic",
	anim = { "anim@heists@heist_corona@single_team","single_team_loop_boss" }
    },
	{ -- Pharmacy Store
		distance = 30,
		coords = { 1690.16,3581.65,35.62,215.44 },
		model = { 0x5244247D,"u_m_y_baygor" },
		anim = { "anim@heists@heist_corona@single_team","single_team_loop_boss" }
	},
	{ -- Pharmacy Store
		distance = 15,
		coords = { 326.5,-1074.43,29.47,0.0 },
		model = { 0x5244247D,"u_m_y_baygor" },
		anim = { "anim@heists@heist_corona@single_team","single_team_loop_boss" }
	},
	{ -- Pharmacy Store  
		distance = 15,
		coords = { 114.39,-4.85,67.82,204.1 },
		model = { 0x5244247D,"u_m_y_baygor" },
		anim = { "anim@heists@heist_corona@single_team","single_team_loop_boss" }
	},
	{ -- Hospital Store
	distance = 15,
	coords = { 309.12,-569.9,43.29,340.16 },
	model = { 0x5244247D,"u_m_y_baygor" },
	anim = { "anim@heists@heist_corona@single_team","single_team_loop_boss" }
},
	{ -- Mercado Central
		distance = 50,
		coords = { 46.65,-1749.7,29.62,51.03 },
		model = { 0xE6631195,"ig_cletus" },
		anim = { "anim@heists@heist_corona@single_team","single_team_loop_boss" }
	},
	{ -- Mercado Central
		distance = 50,
		coords = { 2747.31,3473.07,55.67,249.45 },
		model = { 0xE6631195,"ig_cletus" },
		anim = { "anim@heists@heist_corona@single_team","single_team_loop_boss" }
	},
	{ -- Recycling Sell
		distance = 50,
		coords = { -428.54,-1728.29,19.78,70.87 },
		model = { 0xEE75A00F,"s_m_y_garbage" },
		anim = { "anim@heists@heist_corona@single_team","single_team_loop_boss" }
	},
	{ -- Recycling Sell
		distance = 50,
		coords = { 180.07,2793.29,45.65,283.47 },
		model = { 0xEE75A00F,"s_m_y_garbage" },
		anim = { "anim@heists@heist_corona@single_team","single_team_loop_boss" }
	},
	{ -- Recycling Sell
		distance = 50,
		coords = { -195.42,6264.62,31.49,42.52 },
		model = { 0xEE75A00F,"s_m_y_garbage" },
		anim = { "anim@heists@heist_corona@single_team","single_team_loop_boss" }
	},
	{ -- Bowling
		distance = 25,
		coords = { 756.32,-768.02,26.34,90.71 },
		model = { 0x780C01BD,"s_f_y_bartender_01" },
		anim = { "amb@prop_human_bum_shopping_cart@male@base","base" }
	},
	{ -- Jewelry
		distance = 15,
		coords = { -628.79,-238.7,38.05,311.82 },
		model = { 0xC314F727,"cs_gurk" },
		anim = { "anim@heists@heist_corona@single_team","single_team_loop_boss" }
	},
	{ -- Oxy Store
		distance = 30,
		coords = { -1636.74,-1092.17,13.08,320.32 },
		model = { 0x689C2A80,"a_f_y_epsilon_01" },
		anim = { "anim@heists@heist_corona@single_team","single_team_loop_boss" }
	},
	{ -- Moto Club
		distance = 12,
		coords = { 987.46,-95.61,74.85,226.78 },
		model = { 0x6CCFE08A,"ig_clay" },
		anim = { "anim@heists@heist_corona@single_team","single_team_loop_boss" }
	},
	{ -- Moto Club
		distance = 30,
		coords = { 2512.3,4098.11,38.59,243.78 },
		model = { 0x6CCFE08A,"ig_clay" },
		anim = { "anim@heists@heist_corona@single_team","single_team_loop_boss" }
	},
	{ -- Transportador
		distance = 30,
		coords = { 354.14,270.56,103.02,345.83 },
		model = { 0xE0FA2554,"ig_casey" },
		anim = { "anim@heists@heist_corona@single_team","single_team_loop_boss" }
	},
	{ -- Lenhador
		distance = 30,
		coords = { -840.64,5398.94,34.61,303.31 },
		model = { 0x1536D95A,"a_m_o_ktown_01" },
		anim = { "anim@heists@heist_corona@single_team","single_team_loop_boss" }
	},
	{ -- Lenhador
		distance = 30,
		coords = { -842.92,5403.49,34.61,300.48 },
		model = { 0x1C95CB0B,"u_m_m_markfost" },
		anim = { "anim@heists@heist_corona@single_team","single_team_loop_boss" }
	},
	{ -- Minerador
		distance = 30,
		coords = { -594.55,2090.22,131.66,19.85 },
		model = { 0xD7DA9E99,"s_m_y_construct_01" },
		anim = { "anim@heists@heist_corona@single_team","single_team_loop_boss" }
	},
	{ -- Mergulhador
		distance = 20,
		coords = { 1520.56,3780.08,34.46,274.97 },
		model = { 0xC79F6928,"a_f_y_beach_01" },
		anim = { "anim@heists@heist_corona@single_team","single_team_loop_boss" }
	},
	{ -- Garagem The Boat House
		distance = 50,
		coords = { 1509.64,3788.7,33.51,266.46 },
		model = { 0xC79F6928,"a_f_y_beach_01" },
		anim = { "anim@heists@heist_corona@single_team","single_team_loop_boss" }
	},
	{ -- Colheita
		distance = 30,
		coords = { 406.08,6526.17,27.75,87.88 },
		model = { 0x94562DD7,"a_m_m_farmer_01" },
		anim = { "anim@heists@heist_corona@single_team","single_team_loop_boss" }
	},
	{ -- Motorista
		distance = 30,
		coords = { 452.97,-607.75,28.59,266.46 },
		model = { 0x2A797197,"u_m_m_edtoh" },
		anim = { "anim@heists@heist_corona@single_team","single_team_loop_boss" }
	},
	{ -- Lixeiro
		distance = 50,
		coords = { 82.98,-1553.55,29.59,51.03 },
		model = { 0xEE75A00F,"s_m_y_garbage" },
		anim = { "anim@heists@heist_corona@single_team","single_team_loop_boss" }
	},
	{ -- Lixeiro
		distance = 50,
		coords = { 287.77,2843.9,44.7,121.89 },
		model = { 0xEE75A00F,"s_m_y_garbage" },
		anim = { "anim@heists@heist_corona@single_team","single_team_loop_boss" }
	},
	{ -- Lixeiro
		distance = 50,
		coords = { -413.97,6171.58,31.48,320.32 },
		model = { 0xEE75A00F,"s_m_y_garbage" },
		anim = { "anim@heists@heist_corona@single_team","single_team_loop_boss" }
	},
	{ -- Bicicletário
	distance = 50,
	coords = { 137.39,-1086.18,29.18,0.0 },
	model = { 0x4186506E,"mp_m_weapwork_01" },
	anim = { "anim@heists@heist_corona@single_team","single_team_loop_boss" }
    },
	{ -- AÇOUGUE
	distance = 50,
	coords = { 991.61,-2183.69,30.67,269.3 },
	model = { 0x0DE9A30A,"s_m_m_ammucountry" },
	anim = { "anim@heists@heist_corona@single_team","single_team_loop_boss" }
    },
	{ -- NIÓBIO
	distance = 50,
	coords = { 3609.58,3726.43,29.69,328.82 },
	model = { 0xCDEF5408,"mp_s_m_armoured_01" },
	anim = { "anim@heists@heist_corona@single_team","single_team_loop_boss" }
    },
	{ -- Loja de Roupas
		distance = 15,
		coords = { 73.96,-1393.04,29.37,277.8 },
		model = { 0x689C2A80,"a_f_y_epsilon_01" },
		anim = { "anim@heists@heist_corona@single_team","single_team_loop_boss" }
	},
	{ -- Loja de Roupas
		distance = 15,
		coords = { -709.23,-151.35,37.41,119.06 },
		model = { 0x689C2A80,"a_f_y_epsilon_01" },
		anim = { "anim@heists@heist_corona@single_team","single_team_loop_boss" }
	},
	{ -- Loja de Roupas
		distance = 15,
		coords = { -165.08,-303.46,39.73,249.45 },
		model = { 0x689C2A80,"a_f_y_epsilon_01" },
		anim = { "anim@heists@heist_corona@single_team","single_team_loop_boss" }
	},
	{ -- Loja de Roupas
		distance = 15,
		coords = { -823.12,-1072.36,11.32,209.77 },
		model = { 0x689C2A80,"a_f_y_epsilon_01" },
		anim = { "anim@heists@heist_corona@single_team","single_team_loop_boss" }
	},
	{ -- Loja de Roupas
		distance = 15,
		coords = { -1194.6,-767.56,17.3,215.44 },
		model = { 0x689C2A80,"a_f_y_epsilon_01" },
		anim = { "anim@heists@heist_corona@single_team","single_team_loop_boss" }
	},
	{ -- Loja de Roupas
		distance = 15,
		coords = { -1448.61,-237.61,49.81,51.03 },
		model = { 0x689C2A80,"a_f_y_epsilon_01" },
		anim = { "anim@heists@heist_corona@single_team","single_team_loop_boss" }
	},
	{ -- Loja de Roupas
		distance = 15,
		coords = { 5.82,6511.47,31.88,42.52 },
		model = { 0x689C2A80,"a_f_y_epsilon_01" },
		anim = { "anim@heists@heist_corona@single_team","single_team_loop_boss" }
	},
	{ -- Loja de Roupas
		distance = 15,
		coords = { 1695.3,4823.0,42.06,93.55 },
		model = { 0x689C2A80,"a_f_y_epsilon_01" },
		anim = { "anim@heists@heist_corona@single_team","single_team_loop_boss" }
	},
	{ -- Loja de Roupas
		distance = 15,
		coords = { 127.23,-223.39,54.56,65.2 },
		model = { 0x689C2A80,"a_f_y_epsilon_01" },
		anim = { "anim@heists@heist_corona@single_team","single_team_loop_boss" }
	},
	{ -- Loja de Roupas
		distance = 15,
		coords = { 613.09,2761.8,42.09,274.97 },
		model = { 0x689C2A80,"a_f_y_epsilon_01" },
		anim = { "anim@heists@heist_corona@single_team","single_team_loop_boss" }
	},
	{ -- Loja de Roupas
		distance = 15,
		coords = { 1196.64,2711.62,38.22,181.42 },
		model = { 0x689C2A80,"a_f_y_epsilon_01" },
		anim = { "anim@heists@heist_corona@single_team","single_team_loop_boss" }
	},
	{ -- Loja de Roupas
		distance = 15,
		coords = { -3169.1,1044.04,20.86,65.2 },
		model = { 0x689C2A80,"a_f_y_epsilon_01" },
		anim = { "anim@heists@heist_corona@single_team","single_team_loop_boss" }
	},
	{ -- Loja de Roupas
		distance = 15,
		coords = { -1102.41,2711.57,19.11,221.11 },
		model = { 0x689C2A80,"a_f_y_epsilon_01" },
		anim = { "anim@heists@heist_corona@single_team","single_team_loop_boss" }
	},
	{ -- Loja de Roupas
		distance = 15,
		coords = { 426.97,-806.17,29.49,87.88 },
		model = { 0x689C2A80,"a_f_y_epsilon_01" },
		anim = { "anim@heists@heist_corona@single_team","single_team_loop_boss" }
	},
	{ -- Taxista
		distance = 30,
		coords = { 894.9,-179.15,74.7,240.95 },
		model = { 0x8674D5FC,"a_m_y_stlat_01" },
		anim = { "anim@heists@heist_corona@single_team","single_team_loop_boss" }
	},
	{ -- Taxista
		distance = 30,
		coords = { 1696.19,4785.25,42.02,93.55 },
		model = { 0x8674D5FC,"a_m_y_stlat_01" },
		anim = { "anim@heists@heist_corona@single_team","single_team_loop_boss" }
	},
	{ -- Caçador
		distance = 10,
		coords = { -679.13,5839.52,17.32,226.78 },
		model = { 0xCE1324DE,"ig_hunter" },
		anim = { "anim@heists@heist_corona@single_team","single_team_loop_boss" }
	},
	{ -- Caçador
		distance = 30,
		coords = { -695.56,5802.12,17.32,65.2 },
		model = { 0x1536D95A,"a_m_o_ktown_01" },
		anim = { "anim@heists@heist_corona@single_team","single_team_loop_boss" }
	},
	{ -- Animal Park
		distance = 15,
		coords = { 563.19,2752.92,42.87,187.09 },
		model = { 0x51C03FA4,"a_f_y_eastsa_03" },
		anim = { "anim@heists@heist_corona@single_team","single_team_loop_boss" }
	},
	{ -- Burguer Shot
		distance = 15,
		coords = { -1194.68,-894.02,13.88,348.67 },
		model = { 0x8B7D3766,"u_m_y_burgerdrug_01" },  
		anim = { "amb@medic@standing@timeofdeath@base","prop_notepad_01" }
	},
	{ -- Burguer Shot
	distance = 15,
	coords = { -1203.12,-895.17,13.88,215.44 },
	model = { 0x8B7D3766,"u_m_y_burgerdrug_01" },  
	anim = { "amb@medic@standing@timeofdeath@base","prop_notepad_01" }
    },
	{ -- Pescador
		distance = 30,
		coords = { 1524.77,3783.84,34.49,187.09 },
		model = { 0x51C03FA4,"a_f_y_eastsa_03" },
		anim = { "anim@heists@heist_corona@single_team","single_team_loop_boss" }
	},
	{ -- Cassino
		distance = 30,
		coords = { 1111.79,228.12,-49.64,141.74 },
		model = { 0xF0D4BE2E,"u_f_y_jewelass_01" },
		anim = { "anim@heists@heist_corona@single_team","single_team_loop_boss" }
	}
}
-----------------------------------------------------------------------------------------------------------------------------------------
-- THREADPEDLIST
-----------------------------------------------------------------------------------------------------------------------------------------
Citizen.CreateThread(function()
	while true do
		local ped = PlayerPedId()
		local coords = GetEntityCoords(ped)

		for k,v in pairs(pedList) do
			local distance = #(coords - vector3(v["coords"][1],v["coords"][2],v["coords"][3]))
			if distance <= v["distance"] then
				if localPeds[k] == nil then
					local mHash = GetHashKey(v["model"][2])

					RequestModel(mHash)
					while not HasModelLoaded(mHash) do
						Citizen.Wait(1)
					end

					if HasModelLoaded(mHash) then
						localPeds[k] = CreatePed(4,v["model"][1],v["coords"][1],v["coords"][2],v["coords"][3] - 1,v["coords"][4],false,false)
						SetPedArmour(localPeds[k],100)
						SetEntityInvincible(localPeds[k],true)
						FreezeEntityPosition(localPeds[k],true)
						SetBlockingOfNonTemporaryEvents(localPeds[k],true)

						SetModelAsNoLongerNeeded(mHash)

						if v["anim"] ~= nil then
							RequestAnimDict(v["anim"][1])
							while not HasAnimDictLoaded(v["anim"][1]) do
								Citizen.Wait(1)
							end

							TaskPlayAnim(localPeds[k],v["anim"][1],v["anim"][2],8.0,0.0,-1,1,0,0,0,0)
						end
					end
				end
			else
				if localPeds[k] then
					DeleteEntity(localPeds[k])
					localPeds[k] = nil
				end
			end
		end

		Citizen.Wait(1000)
	end
end)
