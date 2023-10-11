-- 技能升级天赋相关
print(">> Script: ic-level-up")

ICLvup = {}

ICLvup.MaxPlayerLevel = 80    -- Max player level change to your liking.
local AutoDualSpec = true    -- Auto learn Dual Specialization
local AutoRiding = true      -- Auto learn Riding
local NorthrendFlyLevel = 77 -- Which level to learn Cold Weather Flying
-- (68 = When alt characters can learn from Tome of Cold Weather Flight)
-- (77 = Level to learn it from trainer, for first character)
-- (81 = disable, never autolearn Cold Weather Flying)

local CLASS_WARRIOR = 1
local CLASS_PALADIN = 2
local CLASS_HUNTER = 3
local CLASS_ROGUE = 4
local CLASS_PRIEST = 5
local CLASS_DEATHKNIGHT = 6
local CLASS_SHAMAN = 7
local CLASS_MAGE = 8
local CLASS_WARLOCK = 9
local CLASS_DRUID = 11

-- class.level
local SKILL = {
    [CLASS_WARRIOR] = {
        [1] = { 6673, 264, 5011, 15590, 266, 200, 227, 2567, 199, 1180 },
        [4] = { 100, 772 },
        [6] = { 3127, 6343, 34428 },
        [8] = { 284, 1715 },
        [10] = { 2687, 6546, 71, 355, 7386 },
        [12] = { 72, 5242, 7384 },
        [14] = { 1160, 6572 },
        [16] = { 285, 694, 2565 },
        [18] = { 676, 8198 },
        [20] = { 674, 845, 6547, 12678, 20230 },
        [22] = { 5246, 6192 },
        [24] = { 1608, 5308, 6190, 6574 },
        [26] = { 1161, 6178 },
        [28] = { 871, 8204 },
        [30] = { 1464, 6548, 7369, 20252, 2458 },
        [32] = { 11549, 11564, 18499, 20658 },
        [34] = { 7379, 11554 },
        [36] = { 1680 },
        [38] = { 6552, 8205, 8820 },
        [40] = { 750, 11565, 11572, 11608, 20660, 23922 },
        [42] = { 11550 },
        [44] = { 11555, 11600 },
        [46] = { 11578, 11604 },
        [48] = { 11566, 11580, 20661, 23923 },
        [50] = { 1719, 11573, 11609 },
        [52] = { 11551 },
        [54] = { 11556, 11601, 11605, 23924 },
        [56] = { 11567, 20662 },
        [58] = { 11581 },
        [60] = { 11574, 20569, 23925, 25286, 25288, 25289 },
        [61] = { 25241 },
        [62] = { 25202 },
        [63] = { 25269 },
        [64] = { 23920 },
        [65] = { 25234 },
        [66] = { 25258, 29707 },
        [67] = { 25264 },
        [68] = { 469, 25208, 25231 },
        [69] = { 2048, 25242 },
        [70] = { 3411, 25203, 25236, 30324, 30356, 30357 },
        [71] = { 46845, 64382 },
        [72] = { 47449, 47519 },
        [73] = { 47470, 47501 },
        [74] = { 47439, 47474 },
        [75] = { 47487, 55694 },
        [76] = { 47450, 47465 },
        [77] = { 47520 },
        [78] = { 47436, 47502 },
        [79] = { 47437, 47475 },
        [80] = { 47440, 47471, 47488, 57755, 57823 }
    },
    [CLASS_PALADIN] = {
        [1] = { 465, 196, 200, 197 },
        [8] = { 853, 1152, 3127 },
        [4] = { 19740, 20271 },
        [6] = { 498, 639 },
        [10] = { 633, 1022, 10290 },
        [12] = { 19834, 53408, 7328 },
        [14] = { 647, 19742, 31789 },
        [16] = { 7294, 25780, 62124 },
        [18] = { 1044 },
        [20] = { 643, 879, 5502, 19750, 20217, 26573 },
        [22] = { 1026, 19746, 19835, 20164 },
        [24] = { 5588, 5599, 10322, 10326, 19850 },
        [26] = { 1038, 10298, 19939 },
        [28] = { 5614, 19876, 53407 },
        [30] = { 1042, 2800, 10291, 19752, 20116, 20165 },
        [32] = { 19836, 19888 },
        [34] = { 642, 19852, 19940 },
        [36] = { 5615, 10299, 10324, 19891 },
        [38] = { 3472, 10278, 20166 },
        [40] = { 750, 1032, 5589, 19895, 20922 },
        [42] = { 4987, 19837, 19941 },
        [44] = { 10312, 19853, 19897, 24275 },
        [46] = { 6940, 10300, 10328 },
        [48] = { 19899, 20772 },
        [50] = { 2812, 10292, 10310, 19942, 20923 },
        [52] = { 10313, 19838, 19896, 24274, 25782 },
        [54] = { 10308, 10329, 19854, 25894 },
        [56] = { 10301, 19898 },
        [58] = { 19943 },
        [60] = { 10293, 10314, 10318, 19900, 20773, 20924, 24239, 25290, 25291, 25292, 25898, 25916, 25918 },
        [62] = { 27135, 32223 },
        [63] = { 27151 },
        [65] = { 27142, 27143 },
        [66] = { 27137, 27150 },
        [68] = { 27138, 27152, 27180 },
        [69] = { 27139, 27154 },
        [70] = { 27136, 27140, 27141, 27149, 27153, 27173, 31884 },
        [71] = { 48935, 48937, 54428 },
        [72] = { 48816, 48949 },
        [73] = { 48800, 48931, 48933 },
        [74] = { 48784, 48805, 48941 },
        [75] = { 48781, 48818, 53600 },
        [76] = { 48943, 54043 },
        [77] = { 48936, 48938, 48945 },
        [78] = { 48788, 48817, 48947 },
        [79] = { 48785, 48801, 48932, 48934, 48942, 48950 },
        [80] = { 48782, 48806, 48819, 53601, 61411 }
    },
    [CLASS_HUNTER] = {
        [1] = { 1494, 5011, 15590, 266, 200, 227, 2567, 202, 1180, 264 },
        [4] = { 1978, 13163 },
        [6] = { 1130, 3044 },
        [8] = { 3127, 5116, 14260 },
        [10] = { 13165, 13549, 19883, 1515, 883, 2641, 982, 6991 },
        [12] = { 136, 2974, 14281, 20736 },
        [14] = { 1002, 1513, 6197 },
        [16] = { 1495, 5118, 13795, 14261 },
        [18] = { 2643, 13550, 14318, 19884 },
        [20] = { 674, 781, 1499, 3111, 14282, 34074 },
        [22] = { 3043, 14323 },
        [24] = { 1462, 14262, 19885 },
        [26] = { 3045, 13551, 14302, 19880 },
        [28] = { 3661, 13809, 14283, 14319 },
        [30] = { 5384, 13161, 14269, 14288, 14326 },
        [32] = { 1543, 14263, 19878 },
        [34] = { 13552, 13813 },
        [36] = { 3034, 3662, 14284, 14303 },
        [38] = { 14320 },
        [40] = { 1510, 8737, 13159, 14264, 14310, 14324, 19882 },
        [42] = { 13553, 14289 },
        [44] = { 13542, 14270, 14285, 14316 },
        [46] = { 14304, 14327, 20043 },
        [48] = { 14265, 14321 },
        [50] = { 13554, 14294, 19879, 56641 },
        [52] = { 13543, 14286 },
        [54] = { 14290, 14317 },
        [56] = { 14266, 14305, 20190 },
        [58] = { 13555, 14271, 14295, 14322, 14325 },
        [60] = { 13544, 14287, 14311, 19263, 19801, 25294, 25295, 25296 },
        [61] = { 27025 },
        [62] = { 34120 },
        [63] = { 27014 },
        [65] = { 27023 },
        [66] = { 34026 },
        [67] = { 27016, 27021, 27022 },
        [68] = { 27044, 27045, 27046, 34600 },
        [69] = { 27019 },
        [70] = { 34477, 36916 },
        [71] = { 48995, 49051, 49066, 53351 },
        [72] = { 49055 },
        [73] = { 49000, 49044 },
        [74] = { 48989, 49047, 58431, 61846 },
        [75] = { 53271, 61005 },
        [76] = { 49071, 53338 },
        [77] = { 48996, 49052, 49067 },
        [78] = { 49056 },
        [79] = { 49001, 49045 },
        [80] = { 48990, 49048, 53339, 58434, 60192, 61006, 61847, 62757 }
    },
    [CLASS_ROGUE] = {
        [1] = { 1784, 264, 5011, 15590, 266, 196, 198, 201 },
        [4] = { 53, 921 },
        [6] = { 1757, 1776 },
        [8] = { 5277, 6760 },
        [10] = { 674, 2983, 5171, 6770 },
        [12] = { 1766, 2589, 3127 },
        [14] = { 703, 1758, 8647 },
        [16] = { 1804, 1966, 6761 },
        [18] = { 8676 },
        [20] = { 1943, 2590, 51722, 2842 },
        [22] = { 1725, 1759, 1856, 8631 },
        [24] = { 2836, 6762 },
        [26] = { 1833, 8724 },
        [28] = { 2070, 2591, 6768, 8639 },
        [30] = { 408, 1760, 1842, 8632 },
        [32] = { 8623 },
        [34] = { 2094, 8696, 8725 },
        [36] = { 8640, 8721 },
        [38] = { 8621, 8633 },
        [40] = { 1860, 8624, 8637 },
        [42] = { 1857, 6774, 11267 },
        [44] = { 11273, 11279 },
        [46] = { 11289, 11293 },
        [48] = { 11297, 11299 },
        [50] = { 8643, 11268, 26669 },
        [52] = { 11274, 11280, 11303 },
        [54] = { 11290, 11294 },
        [56] = { 11300 },
        [58] = { 11269, 11305 },
        [60] = { 11275, 11281, 25300, 25302, 31016 },
        [61] = { 26839 },
        [62] = { 26861, 26889, 32645 },
        [64] = { 26679, 26865, 27448 },
        [66] = { 27441, 31224 },
        [68] = { 26863, 26867 },
        [69] = { 32684 },
        [70] = { 5938, 26862, 26884, 48673, 48689 },
        [71] = { 51724 },
        [72] = { 48658 },
        [73] = { 48667 },
        [74] = { 48656, 48671, 57992 },
        [75] = { 48675, 48690, 57934 },
        [76] = { 48637, 48674 },
        [78] = { 48659 },
        [79] = { 48668, 48672 },
        [80] = { 48638, 48657, 48676, 48691, 51723, 57993 }
    },
    [CLASS_PRIEST] = {
        [1] = { 1243, 1180 },
        [4] = { 589, 2052 },
        [6] = { 17, 591 },
        [8] = { 139, 586 },
        [10] = { 594, 2006, 2053, 8092 },
        [12] = { 588, 592, 1244 },
        [14] = { 528, 598, 6074, 8122 },
        [16] = { 2054, 8102 },
        [18] = { 527, 600, 970 },
        [20] = { 453, 2061, 2944, 6075, 6346, 7128, 9484, 14914, 15237 },
        [22] = { 984, 2010, 2055, 2096, 8103 },
        [24] = { 1245, 3747, 8129, 15262 },
        [26] = { 992, 6076, 9472 },
        [28] = { 6063, 8104, 8124, 15430, 19276 },
        [30] = { 596, 602, 605, 976, 1004, 6065, 14752, 15263 },
        [32] = { 552, 6077, 9473 },
        [34] = { 1706, 2767, 6064, 8105, 10880 },
        [36] = { 988, 2791, 6066, 15264, 15431, 19277 },
        [38] = { 6060, 6078, 9474 },
        [40] = { 996, 1006, 2060, 8106, 9485, 14818 },
        [42] = { 10888, 10892, 10898, 10957, 15265 },
        [44] = { 10909, 10915, 10927, 19278, 27799 },
        [46] = { 10881, 10933, 10945, 10963 },
        [48] = { 10899, 10937, 15266, 21562 },
        [50] = { 10893, 10916, 10928, 10951, 10960, 14819 },
        [52] = { 10946, 10964, 19279, 27800 },
        [54] = { 10900, 10934, 15267 },
        [56] = { 10890, 10917, 10929, 10958, 27683 },
        [58] = { 10894, 10947, 10965, 20770 },
        [60] = { 10901, 10938, 10952, 10955, 10961, 15261, 19280, 21564, 25314, 25315, 25316, 27681, 27801, 27841 },
        [61] = { 25233, 25363 },
        [62] = { 32379 },
        [63] = { 25210, 25372 },
        [64] = { 32546 },
        [65] = { 25217, 25221, 25367 },
        [66] = { 25384, 34433 },
        [67] = { 25235 },
        [68] = { 25213, 25308, 25331, 25433, 25435, 25467, 33076 },
        [69] = { 25364, 25375, 25431 },
        [70] = { 25218, 25222, 25312, 25368, 25389, 25392, 32375, 32996, 32999, 39374 },
        [71] = { 48040 },
        [72] = { 48119, 48134 },
        [73] = { 48062, 48070, 48299 },
        [74] = { 48112, 48122, 48126 },
        [75] = { 48045, 48065, 48067, 48077, 48124, 48157 },
        [76] = { 48072, 48169 },
        [77] = { 48168, 48170 },
        [78] = { 48063, 48120, 48135, 48171 },
        [79] = { 48071, 48113, 48123, 48127, 48300 },
        [80] = { 48066, 48068, 48073, 48074, 48078, 48125, 48158, 48161, 48162, 53023, 64843, 64901 }
    },
    [CLASS_DEATHKNIGHT] = {
        [55] = { 198, 199, 49142, 53428 },
        [56] = { 49998, 46584, 50842, 53343, 53341 },
        [57] = { 48263, 53342, 54447, 47528 },
        [58] = { 45524, 48721 },
        [59] = { 47476, 49926 },
        [60] = { 43265, 49917, 53331 },
        [61] = { 3714, 49896, 49020 },
        [62] = { 48792, 49892 },
        [63] = { 54446, 53323, 49999 },
        [64] = { 45529, 49927 },
        [65] = { 49918, 57330, 56222 },
        [66] = { 49939, 48743 },
        [67] = { 49936, 51423, 56815, 49903 },
        [68] = { 49893, 48707 },
        [69] = { 49928 },
        [70] = { 45463, 48265, 53344, 49919 },
        [72] = { 49940, 70164, 61999, 62158 },
        [73] = { 49937, 49904, 51424 },
        [74] = { 49929 },
        [75] = { 47568, 49920, 49923, 57623 },
        [76] = { 49894 },
        [78] = { 49941, 49909 },
        [79] = { 51425 },
        [80] = { 49924, 49921, 42650, 49895, 49930, 49938 }
    },
    [CLASS_SHAMAN] = {
        [1] = { 8017, 264, 5011, 15590, 266, 196, 198, 201 },
        [4] = { 8042, 8071 },
        [6] = { 332, 2484 },
        [8] = { 324, 529, 5730, 8018, 8044 },
        [10] = { 8024, 8050, 8075, 3599 },
        [12] = { 370, 547, 1535, 2008 },
        [14] = { 548, 8045, 8154 },
        [16] = { 325, 526, 2645, 8019, 57994 },
        [18] = { 913, 6390, 8027, 8052, 8143 },
        [20] = { 915, 6363, 8004, 8033, 8056, 52127, 5394 },
        [22] = { 131, 8498 },
        [24] = { 905, 939, 8046, 8155, 8160, 8181, 10399, 20609 },
        [26] = { 943, 5675, 6196, 8030, 8190 },
        [28] = { 546, 6391, 8008, 8038, 8053, 8184, 8227, 52129 },
        [30] = { 556, 6364, 6375, 8177, 8232, 10595, 20608, 36936, 51730, 66842 },
        [32] = { 421, 945, 959, 6041, 8012, 8499, 8512 },
        [34] = { 6495, 8058, 10406, 52131 },
        [36] = { 8010, 10412, 10495, 10585, 16339, 20610 },
        [38] = { 6392, 8161, 8170, 8249, 10391, 10456, 10478 },
        [40] = { 930, 1064, 6365, 6377, 8005, 8134, 8235, 8737, 10447, 51988, 66843 },
        [41] = { 52134 },
        [42] = { 10537, 11314 },
        [44] = { 10392, 10407, 10466, 10600 },
        [46] = { 10472, 10496, 10586, 10622, 16341 },
        [48] = { 2860, 10395, 10413, 10427, 10431, 10526, 16355, 20776, 52136 },
        [50] = { 10437, 10462, 10486, 15207, 51991, 66844 },
        [52] = { 10442, 10448, 10467, 11315 },
        [54] = { 10408, 10479, 10623 },
        [55] = { 52138 },
        [56] = { 10396, 10432, 10497, 10587, 10605, 15208, 16342 },
        [58] = { 10428, 10473, 10538, 16356, 16387 },
        [60] = { 10414, 10438, 10463, 10468, 10601, 16362, 20777, 25357, 25361, 29228, 51992 },
        [61] = { 25422, 25546 },
        [62] = { 24398, 25448 },
        [63] = { 25391, 25439, 25469, 25508 },
        [64] = { 3738, 25489 },
        [65] = { 25528, 25552, 25570 },
        [66] = { 2062, 25420, 25500 },
        [67] = { 25449, 25525, 25557, 25560 },
        [68] = { 2894, 25423, 25464, 25505, 25563 },
        [69] = { 25454, 25533, 25567, 25574, 25590, 33736 },
        [70] = { 25396, 25442, 25457, 25472, 25509, 25547, 51993 },
        [71] = { 58580, 58649, 58699, 58755, 58771, 58785, 58794, 58801 },
        [72] = { 49275 },
        [73] = { 49235, 49237, 58731, 58751 },
        [74] = { 49230, 49270, 55458 },
        [75] = { 49232, 49272, 49280, 51505, 57622, 58581, 58652, 58703, 58737, 58741, 58746, 61649 },
        [76] = { 57960, 58756, 58773, 58789, 58795, 58803 },
        [77] = { 49276 },
        [78] = { 49236, 58582, 58734, 58753 },
        [79] = { 49231, 49238 },
        [80] = { 49233, 49271, 49273, 49277, 49281, 51514, 51994, 55459, 58643, 58656, 58704, 58739, 58745, 58749, 58757,
            58774, 58790, 58796, 58804, 60043, 61657 }
    },
    [CLASS_MAGE] = {
        [1] = { 1459, 1180, 201 },
        [4] = { 116, 5504 },
        [6] = { 143, 587, 2136 },
        [8] = { 118, 205, 5143 },
        [10] = { 122, 5505, 7300 },
        [12] = { 130, 145, 597, 604 },
        [14] = { 837, 1449, 1460, 2137 },
        [16] = { 2120, 5144 },
        [18] = { 475, 1008, 3140 },
        [20] = { 10, 543, 1463, 1953, 5506, 7301, 7322, 12051, 12824 },
        [22] = { 990, 2138, 2948, 6143, 8437 },
        [24] = { 2121, 2139, 5145, 8400, 8450 },
        [26] = { 120, 865, 8406 },
        [28] = { 759, 1461, 6141, 8444, 8494 },
        [30] = { 6127, 7302, 8401, 8412, 8438, 8455, 8457, 45438 },
        [32] = { 6129, 8407, 8416, 8422, 8461 },
        [34] = { 6117, 8445, 8492 },
        [36] = { 8402, 8427, 8451, 8495 },
        [38] = { 3552, 8408, 8413, 8439 },
        [40] = { 6131, 7320, 8417, 8423, 8446, 8458, 10138, 12825 },
        [42] = { 8462, 10144, 10148, 10156, 10159, 10169 },
        [44] = { 10179, 10185, 10191 },
        [46] = { 10197, 10201, 10205, 22782 },
        [48] = { 10053, 10149, 10173, 10211, 10215 },
        [50] = { 10139, 10160, 10180, 10219, 10223 },
        [52] = { 10145, 10177, 10186, 10192, 10206 },
        [54] = { 10150, 10170, 10199, 10202, 10230 },
        [56] = { 10157, 10181, 10212, 10216, 23028 },
        [58] = { 10054, 10161, 10207, 22783 },
        [60] = { 10140, 10151, 10174, 10187, 10193, 10220, 10225, 12826, 25304, 25345, 28609, 28612 },
        [61] = { 27078 },
        [62] = { 25306, 27080, 30482 },
        [63] = { 27071, 27075, 27130 },
        [64] = { 27086, 30451 },
        [72] = { 42913, 42925, 42930 },
        [76] = { 42896, 42920, 43015 },
        [65] = { 27073, 27087, 37420 },
        [69] = { 27072, 27124, 27125, 27128, 33946, 38699 },
        [73] = { 42858, 43019 },
        [77] = { 42985, 43017 },
        [66] = { 27070, 30455 },
        [70] = { 27074, 27079, 27082, 27090, 27126, 27127, 30449, 32796, 33717, 38692, 38697, 38704, 43987 },
        [74] = { 42832, 42872, 42939, 53142 },
        [78] = { 42833, 42859, 42914, 43010 },
        [67] = { 27088, 33944 },
        [71] = { 42894, 43023, 43045, 53140 },
        [75] = { 42841, 42843, 42917, 42955, 44614 },
        [79] = { 42842, 42846, 42926, 42931, 43008, 43012, 43020, 43024, 43046 },
        [68] = { 66, 27085, 27101, 27131 },
        [80] = { 42873, 42897, 42921, 42940, 42956, 42995, 43002, 47610, 55342, 58659 }
    },
    [CLASS_WARLOCK] = {
        [1] = { 688, 201 },
        [3] = { 348 },
        [4] = { 172, 702 },
        [6] = { 695, 1454 },
        [8] = { 980, 5782 },
        [10] = { 696, 707, 1120, 6201, 697 },
        [12] = { 705, 755, 1108 },
        [14] = { 689, 6222 },
        [16] = { 1455, 5697 },
        [18] = { 693, 1014, 5676 },
        [20] = { 698, 706, 1088, 1094, 1710, 3698, 5740, 712, 5785, 5784 },
        [22] = { 126, 699, 6202, 6205 },
        [24] = { 5138, 5500, 6223, 8288 },
        [26] = { 132, 1456, 1714, 17919 },
        [28] = { 710, 1106, 3699, 6217, 6366 },
        [30] = { 709, 1086, 1098, 1949, 2941, 20752, 691 },
        [32] = { 1490, 6213, 6229, 7646 },
        [34] = { 5699, 6219, 7648, 17920 },
        [36] = { 2362, 3700, 7641, 11687, 17951 },
        [38] = { 7651, 8289, 11711 },
        [40] = { 5484, 11665, 11733, 20755, 23160, 23161 },
        [42] = { 6789, 11683, 11707, 11739, 17921 },
        [44] = { 11659, 11671, 11693, 11725 },
        [46] = { 11677, 11688, 11699, 11721, 11729, 17952 },
        [48] = { 6353, 11712, 17727, 18647 },
        [50] = { 11667, 11719, 11734, 17922, 17925, 20756, 1122 },
        [52] = { 11660, 11675, 11694, 11708, 11740 },
        [54] = { 11672, 11684, 11700, 17928 },
        [56] = { 6215, 11689, 17924, 17953 },
        [58] = { 11678, 11713, 11726, 11730, 17923, 17926 },
        [60] = { 603, 11661, 11668, 11695, 11722, 11735, 17728, 20757, 25309, 25311, 28610, 18540 },
        [61] = { 27224 },
        [62] = { 25307, 27219, 28176 },
        [64] = { 27211, 29722 },
        [65] = { 27210, 27216 },
        [66] = { 27250, 28172, 29858 },
        [67] = { 27217, 27218, 27259 },
        [68] = { 27213, 27222, 27223, 27230, 29893 },
        [69] = { 27209, 27212, 27215, 27220, 27228, 28189, 30909 },
        [70] = { 27238, 27243, 27260, 30459, 30545, 30910, 32231 },
        [71] = { 47812, 50511 },
        [72] = { 47819, 47886, 47890, 61191 },
        [73] = { 47859, 47863, 47871 },
        [74] = { 47808, 47814, 47837, 47892, 60219 },
        [75] = { 47810, 47824, 47835, 47897 },
        [76] = { 47793, 47856, 47884 },
        [77] = { 47813, 47855 },
        [78] = { 47823, 47857, 47860, 47865, 47888, 47891 },
        [79] = { 47809, 47815, 47820, 47864, 47878, 47893 },
        [80] = { 47811, 47825, 47836, 47838, 47867, 47889, 48018, 48020, 57946, 58887, 60220, 61290 }
    },
    [CLASS_DRUID] = {
        [1] = { 1126, 1180, 15590, 200, 199 },
        [4] = { 774, 8921 },
        [6] = { 467, 5177 },
        [8] = { 339, 5186 },
        [10] = { 99, 1058, 5232, 8924, 16689, 5487, 6795, 6807, 18960 },
        [12] = { 5229, 8936, 50769 },
        [14] = { 782, 5178, 5187, 5211, 8946 },
        [16] = { 779, 783, 1066, 1430, 8925 },
        [18] = { 770, 1062, 2637, 6808, 8938, 16810, 16857 },
        [20] = { 768, 1079, 1082, 1735, 2912, 5188, 5215, 6756, 20484 },
        [22] = { 2090, 2908, 5179, 5221, 8926 },
        [24] = { 780, 1075, 1822, 2782, 5217, 8939, 50768 },
        [26] = { 1850, 2893, 5189, 6809, 8949 },
        [28] = { 2091, 3029, 5195, 5209, 8927, 8998, 9492, 16811 },
        [30] = { 740, 5180, 5234, 6798, 6800, 8940, 20739 },
        [32] = { 5225, 6778, 6785, 9490, 22568 },
        [34] = { 769, 1823, 3627, 8914, 8928, 8950, 8972 },
        [36] = { 6793, 8941, 9005, 9493, 22842, 50767 },
        [38] = { 5196, 5201, 6780, 8903, 8955, 8992, 16812, 18657 },
        [40] = { 8907, 8910, 8918, 8929, 9000, 9634, 16914, 20719, 20742, 22827, 29166, 62600 },
        [42] = { 6787, 8951, 9745, 9747, 9750 },
        [44] = { 1824, 9752, 9754, 9756, 9758, 22812 },
        [46] = { 8905, 8983, 9821, 9823, 9829, 9833, 9839 },
        [48] = { 9845, 9849, 9852, 9856, 16813, 22828, 50766 },
        [50] = { 9862, 9866, 9875, 9880, 9884, 9888, 17401, 20747, 21849 },
        [52] = { 9834, 9840, 9892, 9894, 9898 },
        [54] = { 9830, 9857, 9901, 9904, 9908, 9910, 9912 },
        [56] = { 9827, 9889, 22829 },
        [58] = { 9835, 9841, 9850, 9853, 9867, 9876, 9881, 17329, 18658 },
        [60] = { 9846, 9858, 9863, 9885, 9896, 17402, 20748, 21850, 25297, 25298, 25299, 31018, 31709, 33950, 50765 },
        [61] = { 26984, 27001 },
        [62] = { 22570, 26978, 26998 },
        [63] = { 24248, 26981, 26987 },
        [64] = { 26992, 26997, 27003, 33763 },
        [65] = { 26980, 33357 },
        [66] = { 27005, 27006, 33745 },
        [67] = { 26986, 26996, 27000, 27008 },
        [68] = { 26989, 27009 },
        [69] = { 26979, 26982, 26985, 26994, 27004, 50764 },
        [70] = { 26983, 26988, 26990, 26991, 26995, 27002, 27012, 33786 },
        [71] = { 40120, 48442, 48559, 49799, 50212, 62078 },
        [72] = { 48450, 48464, 48561, 48573, 48576 },
        [73] = { 48479, 48567, 48569, 48578 },
        [74] = { 48377, 48459, 49802, 53307 },
        [75] = { 48440, 48446, 48462, 48571, 52610 },
        [76] = { 48575 },
        [77] = { 48443, 48560, 48562, 49803 },
        [78] = { 48465, 48574, 48577, 53308, 53312 },
        [79] = { 48378, 48461, 48477, 48480, 48570, 48579, 50213 },
        [80] = { 48441, 48447, 48451, 48463, 48467, 48469, 48470, 48568, 48572, 49800, 50464, 50763 }
    }
}

-- team.class.level
local TEAMSKILL = {
    [0] = {
        [CLASS_PALADIN] = {
            [20] = { 13820, 13819 },
            [40] = { 23215, 34767 },
            [64] = { 31801 }
        },
        [CLASS_SHAMAN] = {
            [70] = { 32182 }
        },
        [CLASS_MAGE] = {
            [20] = { 3561, 3562, 32271 },
            [30] = { 3565 },
            [35] = { 49359, 49360 },
            [40] = { 10059, 11416, 32266 },
            [50] = { 11419 },
            [60] = { 33690 },
            [65] = { 33691 }
        }
    },
    [1] = {
        [CLASS_PALADIN] = {
            [20] = { 34768, 34769 },
            [40] = { 34766, 34767 },
            [66] = { 53736 }
        },
        [CLASS_SHAMAN] = {
            [70] = { 2825 }
        },
        [CLASS_MAGE] = {
            [20] = { 3563, 3567, 32272 },
            [30] = { 3566 },
            [35] = { 49358, 49361 },
            [40] = { 11417, 11418, 32267 },
            [50] = { 11420 },
            [60] = { 35715 },
            [65] = { 35717 }
        }
    }
}

-- class.talent.level
local TALENTSKILL = {
    [CLASS_WARRIOR] = {
        [20243] = {
            [60] = { 30016 },
            [70] = { 30022 },
            [75] = { 47497 },
            [80] = { 47498 }
        },
        [12294] = {
            [48] = { 21551 },
            [54] = { 21552 },
            [60] = { 21553 },
            [66] = { 25248 },
            [70] = { 30330 },
            [75] = { 47485 },
            [80] = { 47486 }
        }
    },
    [CLASS_PALADIN] = {
        [20925] = {
            [50] = { 20927 },
            [60] = { 20928 },
            [70] = { 27179 },
            [75] = { 49591 },
            [80] = { 48952 }
        },
        [20473] = {
            [48] = { 20929 },
            [56] = { 20930 },
            [64] = { 27174 },
            [70] = { 33072 },
            [75] = { 48824 },
            [80] = { 48825 }
        },
        [20911] = {
            [60] = { 25899 }
        },
        [31935] = {
            [60] = { 32699 },
            [70] = { 32700 },
            [75] = { 48826 },
            [80] = { 48827 }
        }
    },
    [CLASS_HUNTER] = {
        [19434] = {
            [28] = { 20900 },
            [36] = { 20901 },
            [44] = { 20902 },
            [52] = { 20903 },
            [60] = { 20904 },
            [70] = { 27065 },
            [75] = { 49049 },
            [80] = { 49050 }
        },
        [19306] = {
            [42] = { 20909 },
            [54] = { 20910 },
            [66] = { 27067 },
            [72] = { 48998 },
            [78] = { 48999 }
        },
        [19386] = {
            [50] = { 24132 },
            [60] = { 24133 },
            [70] = { 27068 },
            [75] = { 49011 },
            [80] = { 49012 }
        },
        [53301] = {
            [70] = { 60051 },
            [75] = { 60052 },
            [80] = { 60053 }
        },
        [3674] = {
            [57] = { 63668 },
            [63] = { 63669 },
            [69] = { 63670 },
            [75] = { 63671 },
            [80] = { 63672 }
        }
    },
    [CLASS_ROGUE] = {
        [1329] = {
            [50] = { 34411 },
            [60] = { 34412 },
            [70] = { 34413 },
            [75] = { 48663 },
            [80] = { 48666 }
        },
        [16511] = {
            [46] = { 17347 },
            [58] = { 17348 },
            [70] = { 26864 },
            [80] = { 48660 }
        }
    },
    [CLASS_PRIEST] = {
        [15407] = {
            [28] = { 17311 },
            [36] = { 17312 },
            [44] = { 17313 },
            [52] = { 17314 },
            [60] = { 18807 },
            [68] = { 25387 },
            [74] = { 48155 },
            [80] = { 48156 }
        },
        [19236] = {
            [26] = { 19238 },
            [34] = { 19240 },
            [42] = { 19241 },
            [50] = { 19242 },
            [58] = { 19243 },
            [66] = { 25437 },
            [73] = { 48172 },
            [80] = { 48173 }
        },
        [47540] = {
            [70] = { 53005 },
            [75] = { 53006 },
            [80] = { 53007 }
        },
        [724] = {
            [50] = { 27870 },
            [60] = { 27871 },
            [70] = { 28275 },
            [75] = { 48086 },
            [80] = { 48087 }
        },
        [34861] = {
            [56] = { 34863 },
            [60] = { 34864 },
            [65] = { 34865 },
            [70] = { 34866 },
            [75] = { 48088 },
            [80] = { 48089 }
        },
        [34914] = {
            [60] = { 34916 },
            [70] = { 34917 },
            [75] = { 48159 },
            [80] = { 48160 }
        },

    },
    [CLASS_DEATHKNIGHT] = {
        [55050] = {
            [59] = { 55258 },
            [64] = { 55259 },
            [69] = { 55260 },
            [74] = { 55261 },
            [80] = { 55262 }
        },
        [49143] = {
            [60] = { 51416 },
            [65] = { 51417 },
            [70] = { 51418 },
            [75] = { 51419 },
            [80] = { 55268 }
        },
        [49158] = {
            [60] = { 51325 },
            [70] = { 51326 },
            [75] = { 51327 },
            [80] = { 51328 }
        },
        [55090] = {
            [67] = { 55265 },
            [73] = { 55270 },
            [79] = { 55271 }
        },
        [49184] = {
            [70] = { 51409 },
            [75] = { 51410 },
            [80] = { 51411 }
        }
    },
    [CLASS_SHAMAN] = {
        [974] = {
            [60] = { 32593 },
            [70] = { 32594 },
            [75] = { 49283 },
            [80] = { 49284 }
        },
        [30706] = {
            [60] = { 57720 },
            [70] = { 57721 },
            [80] = { 57722 }
        },
        [51490] = {
            [70] = { 59156 },
            [75] = { 59158 },
            [80] = { 59159 }
        },
        [61295] = {
            [70] = { 61299 },
            [75] = { 61300 },
            [80] = { 61301 }
        }
    },
    [CLASS_MAGE] = {
        [11366] = {
            [24] = { 12505 },
            [30] = { 12522 },
            [36] = { 12523 },
            [42] = { 12524 },
            [48] = { 12525 },
            [54] = { 12526 },
            [60] = { 18809 },
            [66] = { 27132 },
            [70] = { 33938 },
            [73] = { 42890 },
            [77] = { 42981 }
        },
        [11113] = {
            [36] = { 13018 },
            [44] = { 13019 },
            [52] = { 13020 },
            [60] = { 13021 },
            [65] = { 27133 },
            [70] = { 33933 },
            [75] = { 42944 },
            [80] = { 42945 }
        },
        [11426] = {
            [46] = { 13031 },
            [52] = { 13032 },
            [58] = { 13033 },
            [64] = { 27134 },
            [70] = { 33405 },
            [75] = { 43408 },
            [80] = { 43039 }
        },
        [31661] = {
            [56] = { 33041 },
            [64] = { 33042 },
            [70] = { 33043 },
            [75] = { 42949 },
            [80] = { 42950 }
        },
        [44425] = {
            [70] = { 44780 },
            [80] = { 44781 }
        },
        [44457] = {
            [70] = { 55359 },
            [80] = { 55360 }
        }
    },
    [CLASS_WARLOCK] = {
        [17877] = {
            [24] = { 18867 },
            [32] = { 18868 },
            [40] = { 18869 },
            [48] = { 18870 },
            [56] = { 18871 },
            [63] = { 27263 },
            [70] = { 30546 },
            [75] = { 47826 },
            [80] = { 47827 }
        },
        [18220] = {
            [50] = { 18937 },
            [60] = { 18938 },
            [70] = { 27265 },
            [80] = { 59092 }
        },
        [30108] = {
            [60] = { 30404 },
            [70] = { 30405 },
            [75] = { 47841 },
            [80] = { 47843 }
        },
        [30283] = {
            [60] = { 30413 },
            [70] = { 30414 },
            [75] = { 47846 },
            [80] = { 47847 }
        },
        [48181] = {
            [70] = { 59161 },
            [75] = { 59163 },
            [80] = { 59164 }
        },
        [50796] = {
            [70] = { 59170 },
            [75] = { 59171 },
            [80] = { 59172 }
        }
    },
    [CLASS_DRUID] = {
        [5570] = {
            [30] = { 24974 },
            [40] = { 24975 },
            [50] = { 24976 },
            [60] = { 24977 },
            [70] = { 27013 },
            [80] = { 48468 }
        },
        [48505] = {
            [70] = { 53199 },
            [75] = { 53200 },
            [80] = { 53201 }
        },
        [50516] = {
            [60] = { 53223 },
            [70] = { 53225 },
            [75] = { 53226 },
            [80] = { 61384 }
        },
        [48438] = {
            [70] = { 53248 },
            [75] = { 53249 },
            [80] = { 53251 }
        },
        [33917] = {
            [58] = { 33982, 33986 },
            [68] = { 33983, 33987 },
            [75] = { 48565, 48563 },
            [80] = { 48566, 48564 }
        }
    }
}

local RIDING = {
    [20] = { 33388 },                -- Apprentince Riding (75)
    [40] = { 33391 },                -- Journeyman Riding (150)
    [60] = { 34090 },                -- Expert Riding (225)
    [NorthrendFlyLevel] = { 54197 }, -- Cold Weather Flying
    [70] = { 34091 }                 -- Artisan Riding (300)
}

function ICLvup.onLevelChange(event, player, oldLevel)
    local class = player:GetClass()
    local level = player:GetLevel()
    local team = player:GetTeam()
    local classSkills = SKILL[class]
    local teamSkills = TEAMSKILL[team][class]
    local talentSkills = TALENTSKILL[class]

    if classSkills then
        for i = oldLevel + 1, level do
            local levelSkills = classSkills[i] or {}
            for _, skillId in ipairs(levelSkills) do
                if not player:HasSpell(skillId) then -- If the player doesn't already know the skill try to reduce the amount of queries in console
                    player:LearnSpell(skillId)
                end
            end
        end
    end
    if teamSkills then
        for i = oldLevel + 1, level do
            local levelSkills = teamSkills[i] or {}
            for _, skillId in ipairs(levelSkills) do
                player:LearnSpell(skillId)
            end
        end
    end
    if talentSkills then
        for spellId, t in pairs(talentSkills) do
            if player:HasSpell(spellId) then
                for i = oldLevel + 1, level do
                    local levelSkills = t[i] or {}
                    for _, skillId in ipairs(levelSkills) do
                        player:LearnSpell(skillId)
                    end
                end
            end
        end
    end
    if AutoRiding then
        for i = oldLevel + 1, level do
            local levelSkills = RIDING[i] or {}
            for _, skillId in ipairs(levelSkills) do
                if not player:HasSpell(skillId) then -- If the player doesn't already know the skill try to reduce the amount of queries in console
                    player:LearnSpell(skillId)
                else
                    break
                end
            end
        end
    end
    if AutoDualSpec then
        if level >= 40 and oldLevel < 40 then
            player:CastSpell(player, 63680, true) -- Teach Learn Talent Specialization Switches (63680)
            player:CastSpell(player, 63624, true) -- Learn a Second Talent Specialization (63624)
        end
    end

    -- icwow 每升1级增加level 10000 = 1g
    player:ModifyMoney((oldLevel + 1) * 5000)
end

function ICLvup.onLearnTalent(event, player, talentId, talentRank, spellId)
    local class = player:GetClass()
    local level = player:GetLevel()
    local talentSkills = TALENTSKILL[class]
    if talentSkills then
        for requiredLevel, skillIds in pairs(talentSkills) do
            if level >= requiredLevel then
                for _, skillId in ipairs(skillIds) do
                    player:LearnSpell(skillId)
                end
            end
        end
    end
end

RegisterPlayerEvent(PLAYER_EVENT_ON_LEVEL_CHANGE, ICLvup.onLevelChange)
RegisterPlayerEvent(PLAYER_EVENT_ON_LEARN_TALENTS, ICLvup.onLearnTalent)