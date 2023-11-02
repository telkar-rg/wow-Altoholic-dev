﻿local addonName = "DataStore_Pets"
local addon = _G[addonName]

-- [itemID] = spellID
addon.CompanionToSpellID = {
	[4401] = 4055,
	[8485] = 10673,
	[8486] = 10674,
	[8487] = 10676,
	[8488] = 10678,
	[8489] = 10679,
	[8490] = 10677,
	[8491] = 10675,
	[8492] = 10683,
	[8494] = 10682,
	[8495] = 10684,
	[8496] = 10680,
	[8497] = 10711,
	[8498] = 10698,
	[8499] = 10697,
	[8500] = 10707,
	[8501] = 10706,
	[10360] = 10714,
	[10361] = 10716,
	[10392] = 10717,
	[10393] = 10688,
	[10394] = 10709,
	[10398] = 12243,
	[10822] = 10695,
	[11023] = 10685,
	[11026] = 10704,
	[11027] = 10703,
	[11110] = 13548,
	[11474] = 15067,
	[11825] = 15048,
	[11826] = 15049,
	[11903] = 15648,
	[12264] = 15999,
	[12529] = 16450,
	[13582] = 17709,
	[13583] = 17707,
	[13584] = 17708,
	[15996] = 19772,
	[18964] = 23429,
	[19054] = 23530,
	[19055] = 23531,
	[19450] = 23811,
	[19462] = 23811,
	[20371] = 24696,
	[20651] = 25018,
	[20769] = 25162,
	[21168] = 25849,
	[21277] = 26010,
	[21301] = 26533,
	[21305] = 26541,
	[21308] = 26529,
	[21309] = 26045,
	[22114] = 27241,
	[22235] = 27570,
	[22780] = 28487,
	[22781] = 28505,
	[23002] = 28738,
	[23007] = 28739,
	[23015] = 28740,
	[23083] = 28871,
	[23712] = 30152,
	[23713] = 30156,
	[25535] = 32298,
	[27445] = 33050,
	[29363] = 35156,
	[29364] = 35239,
	[29901] = 35907,
	[29902] = 35909,
	[29903] = 35910,
	[29904] = 35911,
	[29953] = 36027,
	[29956] = 36028,
	[29957] = 36029,
	[29958] = 36031,
	[29960] = 36034,
	[30360] = 24988,
	[31760] = 39181,
	[32233] = 39709,
	[32465] = 40319,
	[32498] = 40405,
	[32588] = 40549,
	[32616] = 40614,
	[32617] = 40613,
	[32622] = 40634,
	[33154] = 42609,
	[33816] = 43697,
	[33818] = 43698,
	[33993] = 43918,
	[34425] = 54187,
	[34478] = 45082,
	[34492] = 45125,
	[34493] = 45127,
	[34518] = 45174,
	[34519] = 45175,
	[34535] = 10696,
	[34955] = 45890,
	[35349] = 46425,
	[35350] = 46426,
	[35504] = 46599,
	[37297] = 48406,
	[37298] = 48408,
	[38050] = 49964,
	[38628] = 51716,
	[38658] = 51851,
	[39286] = 52615,
	[39656] = 53082,
	[39896] = 61348,
	[39898] = 61351,
	[39899] = 61349,
	[39973] = 53316,
	[40653] = 40990,
	[41133] = 55068,
	[43517] = 61357,
	[43698] = 59250,
	[44721] = 61350,
	[44723] = 61357,
	[44738] = 61472,
	[44794] = 61725,
	[44810] = 61773,
	[44819] = 61855,
	[44822] = 10713,
	[44841] = 61991,
	[44965] = 62491,
	[44970] = 62508,
	[44971] = 62510,
	[44972] = 62514,
	[44973] = 62513,
	[44974] = 62516,
	[44980] = 62542,
	[44982] = 62564,
	[44983] = 62561,
	[44984] = 62562,
	[44998] = 62609,
	[45002] = 62674,
	[45022] = 62746,
	[45180] = 63318,
	[45606] = 63712,
	[45942] = 64351,
	[46398] = 65358,
	[46544] = 65382,
	[46545] = 65381,
	[46707] = 44369,
	[46767] = 65682,
	[46802] = 66030,
	[46820] = 66096,
	[46821] = 66096,
	[46892] = 63318,
	[48112] = 67413,
	[48114] = 67414,
	[48116] = 67415,
	[48118] = 67416,
	[48120] = 67417,
	[48122] = 67418,
	[48124] = 67419,
	[48126] = 67420,
	[48527] = 67527,
	[49287] = 68767,
	[49343] = 68810,
	[49362] = 69002,
	[49646] = 69452,
	[49662] = 69535,
	[49663] = 69536,
	[49665] = 69541,
	[49693] = 69677,
	[49912] = 70613,
	[50446] = 71840,
	[53641] = 74932,
	[54436] = 75134,
	[54810] = 75613,
	[54847] = 75906,
	[54857] = 75936,
	[56806] = 78381,
}
