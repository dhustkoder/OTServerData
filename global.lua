dofile('data/lib/lib.lua')



STORAGEVALUE_PROMOTION = 30018

ropeSpots = {384, 418}

doors = {
	[1209] = 1211, [1210] = 1211, [1212] = 1214, [1213] = 1214, [1214] = 1212, [1219] = 1220, [1221] = 1222, [1231] = 1233,
	[1232] = 1233, [1234] = 1236, [1235] = 1236, [1237] = 1238, [1239] = 1240, [1249] = 1251, [1250] = 1251,
	[1252] = 1254, [1253] = 1254, [1539] = 1540, [1541] = 1542, [3535] = 3537, [3536] = 3537, [3538] = 3539,
	[3544] = 3546, [3545] = 3546, [3547] = 3548, [4913] = 4915, [4914] = 4915, [4916] = 4918, [4917] = 4918,
	[5082] = 5083, [5084] = 5085, [5098] = 5100, [5099] = 5100, [5101] = 5102, [5107] = 5109, [5108] = 5109,
	[5110] = 5111, [5116] = 5118, [5117] = 5118, [5119] = 5120, [5125] = 5127, [5126] = 5127, [5128] = 5129,
	[5134] = 5136, [5135] = 5136, [5137] = 5139, [5138] = 5139, [5140] = 5142, [5141] = 5142, [5143] = 5145,
	[5144] = 5145, [5278] = 5280, [5279] = 5280, [5281] = 5283, [5282] = 5283, [5284] = 5285, [5286] = 5287,
	[5515] = 5516, [5517] = 5518, [5732] = 5734, [5733] = 5734, [5735] = 5737, [5736] = 5737, [6192] = 6194,
	[6193] = 6194, [6195] = 6197, [6196] = 6197, [6198] = 6199, [6200] = 6201, [6249] = 6251, [6250] = 6251,
	[6252] = 6254, [6253] = 6254, [6255] = 6256, [6257] = 6258, [6795] = 6796, [6797] = 6798, [6799] = 6800,
	[6801] = 6802, [6891] = 6893, [6892] = 6893, [6894] = 6895, [6900] = 6902, [6901] = 6902, [6903] = 6904,
	[7033] = 7035, [7034] = 7035, [7036] = 7037, [7042] = 7044, [7043] = 7044, [7045] = 7046, [7054] = 7055,
	[7056] = 7057,
}

verticalOpenDoors = {1211, 1220, 1224, 1228, 1233, 1238, 1242, 1246, 1251, 1256, 1260, 1540, 3546, 3548, 3550, 3552, 4915, 5083, 5109, 5111, 5113, 5115, 5127, 5129, 5131, 5133, 5142, 5145, 5283, 5285, 5289, 5293, 5516, 5737, 5749, 6194, 6199, 6203, 6207, 6251, 6256, 6260, 6264, 6798, 6802, 6902, 6904, 6906, 6908, 7044, 7046, 7048, 7050, 7055}
horizontalOpenDoors = {1214, 1222, 1226, 1230, 1236, 1240, 1244, 1248, 1254, 1258, 1262, 1542, 3537, 3539, 3541, 3543, 4918, 5085, 5100, 5102, 5104, 5106, 5118, 5120, 5122, 5124, 5136, 5139, 5280, 5287, 5291, 5295, 5518, 5734, 5746, 6197, 6201, 6205, 6209, 6254, 6258, 6262, 6266, 6796, 6800, 6893, 6895, 6897, 6899, 7035, 7037, 7039, 7041, 7057}
openSpecialDoors = {1224, 1226, 1228, 1230, 1242, 1244, 1246, 1248, 1256, 1258, 1260, 1262, 3541, 3543, 3550, 3552, 5104, 5106, 5113, 5115, 5122, 5124, 5131, 5133, 5289, 5291, 5293, 5295, 6203, 6205, 6207, 6209, 6260, 6262, 6264, 6266, 6897, 6899, 6906, 6908, 7039, 7041, 7048, 7050}
questDoors = {1223, 1225, 1241, 1243, 1255, 1257, 3542, 3551, 5105, 5114, 5123, 5132, 5288, 5290, 5745, 5748, 6202, 6204, 6259, 6261, 6898, 6907, 7040, 7049}
levelDoors = {1227, 1229, 1245, 1247, 1259, 1261, 3540, 3549, 5103, 5112, 5121, 5130, 5292, 5294, 6206, 6208, 6263, 6265, 6896, 6905, 7038, 7047}
keys = {2086, 2087, 2088, 2089, 2090, 2091, 2092}

function getDistanceBetween(firstPosition, secondPosition)
	local xDif = math.abs(firstPosition.x - secondPosition.x)
	local yDif = math.abs(firstPosition.y - secondPosition.y)
	local posDif = math.max(xDif, yDif)
	if firstPosition.z ~= secondPosition.z then
		posDif = posDif + 15
	end
	return posDif
end

function getFormattedWorldTime()
	local worldTime = getWorldTime()
	local hours = math.floor(worldTime / 60)

	local minutes = worldTime % 60
	if minutes < 10 then
		minutes = '0' .. minutes
	end
	return hours .. ':' .. minutes
end

string.split = function(str, sep)
	local res = {}
	for v in str:gmatch("([^" .. sep .. "]+)") do
		res[#res + 1] = v
	end
	return res
end

string.trim = function(str)
	return str:match'^()%s*$' and '' or str:match'^%s*(.*%S)'
end

if nextUseStaminaTime == nil then
	nextUseStaminaTime = {}
end





-- Load Lua-made functions
dofile('data/lib/functions.lua')

-- Load House class
dofile('data/lib/house.lua')

-- Load Calculator class
dofile('data/lib/calculator.lua')

-- Load Exp Stages
dofile('data/lib/exp_stages.lua')

-- Load db file
dofile('data/lib/db.lua')

-- Load compat file to make new TFS 1.x oop functions work
dofile('data/lib/compat.lua')

-- Load STORAGES
dofile('data/lib/storages.lua')

-- Load Tibia map lib
dofile('data/lib/tibia.lua')


-- Booleans consts
TRUE = true
FALSE = false

-- Error consts
LUA_ERROR = false
LUA_NO_ERROR = true
LUA_NULL = 0

CONTAINER_POSITION = 65535

-- Directions consts
NORTH = 0
EAST = 1
SOUTH = 2
WEST = 3
SOUTHWEST = 4
SOUTHEAST = 5
NORTHWEST = 6
NORTHEAST = 7

-- World Types
WORLD_TYPE_NO_PVP = 1
WORLD_TYPE_PVP = 2
WORLD_TYPE_PVP_ENFORCED = 3

COMBAT_FORMULA_UNDEFINED = 0
COMBAT_FORMULA_LEVELMAGIC = 1
COMBAT_FORMULA_SKILL = 2
COMBAT_FORMULA_DAMAGE = 3

CONDITION_PARAM_OWNER = 1
CONDITION_PARAM_TICKS = 2
CONDITION_PARAM_OUTFIT = 3
CONDITION_PARAM_HEALTHGAIN = 4
CONDITION_PARAM_HEALTHTICKS = 5
CONDITION_PARAM_MANAGAIN = 6
CONDITION_PARAM_MANATICKS = 7
CONDITION_PARAM_DELAYED = 8
CONDITION_PARAM_SPEED = 9
CONDITION_PARAM_LIGHT_LEVEL = 10
CONDITION_PARAM_LIGHT_COLOR = 11
CONDITION_PARAM_SOULGAIN = 12
CONDITION_PARAM_SOULTICKS = 13
CONDITION_PARAM_MINVALUE = 14
CONDITION_PARAM_MAXVALUE = 15
CONDITION_PARAM_STARTVALUE = 16
CONDITION_PARAM_TICKINTERVAL = 17
CONDITION_PARAM_FORCEUPDATE = 18
CONDITION_PARAM_SKILL_MELEE = 19
CONDITION_PARAM_SKILL_FIST = 20
CONDITION_PARAM_SKILL_CLUB = 21
CONDITION_PARAM_SKILL_SWORD = 22
CONDITION_PARAM_SKILL_AXE = 23
CONDITION_PARAM_SKILL_DISTANCE = 24
CONDITION_PARAM_SKILL_SHIELD = 25
CONDITION_PARAM_SKILL_FISHING = 26
CONDITION_PARAM_STAT_MAXHITPOINTS = 27
CONDITION_PARAM_STAT_MAXMANAPOINTS = 28
CONDITION_PARAM_STAT_SOULPOINTS = 29
CONDITION_PARAM_STAT_MAGICPOINTS = 30
CONDITION_PARAM_STAT_MAXHITPOINTSPERCENT = 31
CONDITION_PARAM_STAT_MAXMANAPOINTSPERCENT = 32
CONDITION_PARAM_STAT_SOULPOINTSPERCENT = 33
CONDITION_PARAM_STAT_MAGICPOINTSPERCENT = 34
CONDITION_PARAM_PERIODICDAMAGE = 35
CONDITION_PARAM_SKILL_MELEEPERCENT = 36
CONDITION_PARAM_SKILL_FISTPERCENT = 37
CONDITION_PARAM_SKILL_CLUBPERCENT = 38
CONDITION_PARAM_SKILL_SWORDPERCENT = 39
CONDITION_PARAM_SKILL_AXEPERCENT = 40
CONDITION_PARAM_SKILL_DISTANCEPERCENT = 41
CONDITION_PARAM_SKILL_SHIELDPERCENT = 42
CONDITION_PARAM_SKILL_FISHINGPERCENT = 43
CONDITION_PARAM_BUFF_SPELL = 44
CONDITION_PARAM_SUBID = 45

COMBAT_PARAM_TYPE = 1
COMBAT_PARAM_EFFECT = 2
COMBAT_PARAM_DISTANCEEFFECT = 3
COMBAT_PARAM_BLOCKSHIELD = 4
COMBAT_PARAM_BLOCKARMOR = 5
COMBAT_PARAM_TARGETCASTERORTOPMOST = 6
COMBAT_PARAM_CREATEITEM = 7
COMBAT_PARAM_AGGRESSIVE = 8
COMBAT_PARAM_DISPEL = 9
COMBAT_PARAM_USECHARGES = 10
COMBAT_PARAM_HITEFFECT = 11
COMBAT_PARAM_HITTEXTCOLOR = 12
COMBAT_PARAM_PZBLOCK = 13

CALLBACK_PARAM_LEVELMAGICVALUE = 1
CALLBACK_PARAM_SKILLVALUE = 2
CALLBACK_PARAM_TARGETTILE = 3
CALLBACK_PARAM_TARGETCREATURE = 4

COMBAT_NONE = 0
COMBAT_PHYSICALDAMAGE = 1
COMBAT_ENERGYDAMAGE = 2
COMBAT_POISONDAMAGE = 4
COMBAT_EARTHDAMAGE = 4
COMBAT_FIREDAMAGE = 8
COMBAT_UNDEFINEDDAMAGE = 16
COMBAT_LIFEDRAIN = 32
COMBAT_MANADRAIN = 64
COMBAT_HEALING = 128

CONDITION_NONE = 0
CONDITION_POISON = 1
CONDITION_FIRE = 2
CONDITION_ENERGY = 4
CONDITION_LIFEDRAIN = 8
CONDITION_HASTE = 16
CONDITION_PARALYZE = 32
CONDITION_OUTFIT = 64
CONDITION_INVISIBLE = 128
CONDITION_LIGHT = 256
CONDITION_MANASHIELD = 512
CONDITION_INFIGHT = 1024
CONDITION_DRUNK = 2048
CONDITION_EXHAUST_YELL = 4096
CONDITION_FOOD = 8192
CONDITION_REGENERATION = 8192
CONDITION_SOUL = 16384
CONDITION_DROWN = 32768
CONDITION_MUTED = 65536
CONDITION_ATTRIBUTES = 131072
CONDITION_FREEZING = 262144
CONDITION_DAZZLED = 524288
CONDITION_CURSED = 1048576
CONDITION_EXHAUST_COMBAT = 2097152
CONDITION_EXHAUST_HEAL   = 4194304
CONDITION_PACIFIED = 8388608
CONDITION_HUNTING = 16777216
CONDITION_TRADE_MUTED = 33554432
CONDITION_EXHAUST_OTHERS = 67108864
CONDITION_EXHAUST_POTION = CONDITION_EXHAUST_OTHERS
CONDITION_EXHAUSTED = CONDITION_EXHAUST_OTHERS

CONDITIONID_DEFAULT = -1
CONDITIONID_COMBAT = 0
CONDITIONID_HEAD = 1
CONDITIONID_NECKLACE = 2
CONDITIONID_BACKPACK = 3
CONDITIONID_ARMOR = 4
CONDITIONID_RIGHT = 5
CONDITIONID_LEFT = 6
CONDITIONID_LEGS = 7
CONDITIONID_FEET = 8
CONDITIONID_RING = 9
CONDITIONID_AMMO = 10

PLAYERLOSS_EXPERIENCE = 0
PLAYERLOSS_MANA = 1
PLAYERLOSS_SKILL = 2
PLAYERLOSS_ITEMS = 3
PLAYERLOSS_CONTAINERS = 4

LEVEL_SKILL_FIST = 0
LEVEL_SKILL_CLUB = 1
LEVEL_SKILL_SWORD = 2
LEVEL_SKILL_AXE = 3
LEVEL_SKILL_DISTANCE = 4
LEVEL_SKILL_SHIELDING = 5
LEVEL_SKILL_FISHING = 6
LEVEL_MAGIC = 7
LEVEL_EXPERIENCE = 8

CONST_SKILL_FIST = 0
CONST_SKILL_CLUB = 1
CONST_SKILL_SWORD = 2
CONST_SKILL_AXE = 3
CONST_SKILL_DISTANCE = 4
CONST_SKILL_SHIELDING = 5
CONST_SKILL_FISHING = 6

CONST_SLOT_HEAD = 1
CONST_SLOT_NECKLACE = 2
CONST_SLOT_BACKPACK = 3
CONST_SLOT_ARMOR = 4
CONST_SLOT_RIGHT = 5
CONST_SLOT_LEFT = 6
CONST_SLOT_LEGS = 7
CONST_SLOT_FEET = 8
CONST_SLOT_RING = 9
CONST_SLOT_AMMO = 10

CONST_ME_DRAWBLOOD = 0
CONST_ME_LOSEENERGY = 1
CONST_ME_POFF = 2
CONST_ME_BLOCKHIT = 3
CONST_ME_EXPLOSIONAREA = 4
CONST_ME_EXPLOSIONHIT = 5
CONST_ME_FIREAREA = 6
CONST_ME_YELLOW_RINGS = 7
CONST_ME_GREEN_RINGS = 8
CONST_ME_HITAREA = 9
CONST_ME_TELEPORT = 10
CONST_ME_ENERGYHIT = 11
CONST_ME_MAGIC_BLUE = 12
CONST_ME_MAGIC_RED = 13
CONST_ME_MAGIC_GREEN = 14
CONST_ME_HITBYFIRE = 15
CONST_ME_HITBYPOISON = 16
CONST_ME_MORTAREA = 17
CONST_ME_SOUND_GREEN = 18
CONST_ME_SOUND_RED = 19
CONST_ME_POISONAREA = 20
CONST_ME_SOUND_YELLOW = 21
CONST_ME_SOUND_PURPLE = 22
CONST_ME_SOUND_BLUE = 23
CONST_ME_SOUND_WHITE = 24
CONST_ME_NONE = 255

CONST_ANI_SPEAR = 0
CONST_ANI_BOLT = 1
CONST_ANI_ARROW = 2
CONST_ANI_FIRE = 3
CONST_ANI_ENERGY = 4
CONST_ANI_POISONARROW = 5
CONST_ANI_BURSTARROW = 6
CONST_ANI_THROWINGSTAR = 7
CONST_ANI_THROWINGKNIFE = 8
CONST_ANI_SMALLSTONE = 9
CONST_ANI_DEATH = 10
CONST_ANI_LARGEROCK = 11
CONST_ANI_SNOWBALL = 12
CONST_ANI_POWERBOLT = 13
CONST_ANI_POISON = 14
CONST_ANI_NONE = 255

TALKTYPE_SAY  = 1
TALKTYPE_WHISPER = 2
TALKTYPE_YELL = 3
TALKTYPE_BROADCAST = 11
TALKTYPE_ORANGE_1 = 16
TALKTYPE_ORANGE_2 = 17
TALKTYPE_ORANGE = TALKTYPE_ORANGE_1
TALKTYPE_ORANGE_YELL = TALKTYPE_ORANGE_2

MESSAGE_CLASS_FIRST = 1
MESSAGE_STATUS_CONSOLE_YELLOW = 1
MESSAGE_STATUS_CONSOLE_LBLUE = 4
MESSAGE_STATUS_CONSOLE_ORANGE = 17
MESSAGE_STATUS_CONSOLE_BLUE = 24
MESSAGE_STATUS_CONSOLE_RED = 25
MESSAGE_STATUS_WARNING = 18
MESSAGE_STATUS_DEFAULT = 21
MESSAGE_STATUS_SMALL = 23
MESSAGE_EVENT_ADVANCE = 19
MESSAGE_EVENT_DEFAULT = 20
MESSAGE_INFO_DESCR = 22
MESSAGE_CLASS_LAST = 23

MESSAGE_TYPES = {
	["advance"] = MESSAGE_EVENT_ADVANCE,
	["event"] = MESSAGE_EVENT_DEFAULT,
	["white"] = MESSAGE_EVENT_DEFAULT,
	["orange"] = MESSAGE_STATUS_CONSOLE_ORANGE,
	["info"] = MESSAGE_INFO_DESCR,
	["green"] = MESSAGE_INFO_DESCR,
	["small"] = MESSAGE_STATUS_SMALL,
	["blue"] = MESSAGE_STATUS_CONSOLE_BLUE,
	["red"] = MESSAGE_STATUS_CONSOLE_RED,
	["warning"] = MESSAGE_STATUS_WARNING,
	["status"] = MESSAGE_STATUS_DEFAULT
}

TEXTCOLOR_BLUE        = 5
TEXTCOLOR_GREEN       = 18
TEXTCOLOR_LIGHTGREEN  = 30
TEXTCOLOR_LIGHTBLUE   = 35
TEXTCOLOR_TEAL	      = 65
TEXTCOLOR_DARKRED     = 108
TEXTCOLOR_LIGHTGREY   = 129
TEXTCOLOR_SKYBLUE	  = 143
TEXTCOLOR_PURPLE      = 154
TEXTCOLOR_RED         = 180
TEXTCOLOR_ORANGE      = 198
TEXTCOLOR_YELLOW      = 210
TEXTCOLOR_WHITE_EXP   = 215
TEXTCOLOR_NONE        = 255

ITEM_TYPE_NONE        = 0
ITEM_TYPE_DEPOT       = 1
ITEM_TYPE_MAILBOX     = 2
ITEM_TYPE_TRASHHOLDER = 3
ITEM_TYPE_CONTAINER   = 4
ITEM_TYPE_DOOR        = 5
ITEM_TYPE_MAGICFIELD  = 6
ITEM_TYPE_TELEPORT    = 7
ITEM_TYPE_BED         = 8

CONST_PROP_BLOCKSOLID = 0
CONST_PROP_HASHEIGHT = 1
CONST_PROP_BLOCKPROJECTILE = 2
CONST_PROP_BLOCKPATHFIND = 3
CONST_PROP_ISVERTICAL = 4
CONST_PROP_ISHORIZONTAL = 5
CONST_PROP_MOVEABLE = 6
CONST_PROP_BLOCKINGANDNOTMOVEABLE = 7
CONST_PROP_SUPPORTHANGABLE = 8

RETURNVALUE_NOERROR = 1
RETURNVALUE_NOTPOSSIBLE = 2
RETURNVALUE_NOTENOUGHROOM = 3
RETURNVALUE_PLAYERISPZLOCKED = 4
RETURNVALUE_PLAYERISNOTINVITED = 5
RETURNVALUE_CANNOTTHROW = 6
RETURNVALUE_THEREISNOWAY = 7
RETURNVALUE_DESTINATIONOUTOFREACH = 8
RETURNVALUE_CREATUREBLOCK = 9
RETURNVALUE_NOTMOVEABLE = 10
RETURNVALUE_DROPTWOHANDEDITEM = 11
RETURNVALUE_BOTHHANDSNEEDTOBEFREE = 12
RETURNVALUE_CANONLYUSEONEWEAPON = 13
RETURNVALUE_NEEDEXCHANGE = 14
RETURNVALUE_CANNOTBEDRESSED = 15
RETURNVALUE_PUTTHISOBJECTINYOURHAND = 16
RETURNVALUE_PUTTHISOBJECTINBOTHHANDS = 17
RETURNVALUE_TOOFARAWAY = 18
RETURNVALUE_FIRSTGODOWNSTAIRS = 19
RETURNVALUE_FIRSTGOUPSTAIRS = 20
RETURNVALUE_CONTAINERNOTENOUGHROOM = 21
RETURNVALUE_NOTENOUGHCAPACITY = 22
RETURNVALUE_CANNOTPICKUP = 23
RETURNVALUE_THISISIMPOSSIBLE = 24
RETURNVALUE_DEPOTISFULL = 25
RETURNVALUE_CREATUREDOESNOTEXIST = 26
RETURNVALUE_CANNOTUSETHISOBJECT = 27
RETURNVALUE_PLAYERWITHTHISNAMEISNOTONLINE = 28
RETURNVALUE_NOTREQUIREDLEVELTOUSERUNE = 29
RETURNVALUE_YOUAREALREADYTRADING = 30
RETURNVALUE_THISPLAYERISALREADYTRADING = 31
RETURNVALUE_YOUMAYNOTLOGOUTDURINGAFIGHT = 32
RETURNVALUE_DIRECTPLAYERSHOOT = 33
RETURNVALUE_NOTENOUGHLEVEL = 34
RETURNVALUE_NOTENOUGHMAGICLEVEL = 35
RETURNVALUE_NOTENOUGHMANA = 36
RETURNVALUE_NOTENOUGHSOUL = 37
RETURNVALUE_YOUAREEXHAUSTED = 38
RETURNVALUE_PLAYERISNOTREACHABLE = 39
RETURNVALUE_CANONLYUSETHISRUNEONCREATURES = 40
RETURNVALUE_ACTIONNOTPERMITTEDINPROTECTIONZONE = 41
RETURNVALUE_YOUMAYNOTATTACKTHISPERSON = 42
RETURNVALUE_YOUMAYNOTATTACKAPERSONINPROTECTIONZONE = 43
RETURNVALUE_YOUMAYNOTATTACKAPERSONWHILEINPROTECTIONZONE = 44
RETURNVALUE_YOUMAYNOTATTACKTHISCREATURE = 45
RETURNVALUE_YOUCANONLYUSEITONCREATURES = 46
RETURNVALUE_CREATUREISNOTREACHABLE = 47
RETURNVALUE_TURNSECUREMODETOATTACKUNMARKEDPLAYERS = 48
RETURNVALUE_YOUNEEDPREMIUMACCOUNT = 49
RETURNVALUE_YOUNEEDTOLEARNTHISSPELL = 50
RETURNVALUE_YOURVOCATIONCANNOTUSETHISSPELL = 51
RETURNVALUE_YOUNEEDAWEAPONTOUSETHISSPELL = 52
RETURNVALUE_PLAYERISPZLOCKEDLEAVEPVPZONE = 53
RETURNVALUE_PLAYERISPZLOCKEDENTERPVPZONE = 54
RETURNVALUE_ACTIONNOTPERMITTEDINANONPVPZONE = 55
RETURNVALUE_YOUCANNOTLOGOUTHERE = 56
RETURNVALUE_YOUCANNOTLOGOUTHERE = 56
RETURNVALUE_YOUNEEDAMAGICITEMTOCASTSPELL = 57
RETURNVALUE_CANNOTCONJUREITEMHERE = 58
RETURNVALUE_YOUNEEDTOSPLITYOURSPEARS = 59
RETURNVALUE_NAMEISTOOAMBIGIOUS = 60
RETURNVALUE_CANONLYUSEONESHIELD = 61
RETURNVALUE_YOUARENOTTHEOWNER = 62
RETURNVALUE_NOTREQUIREDPROFESSION = 63
RETURNVALUE_NOTREQUIREDLEVEL = 64
RETURNVALUE_NEEDPREMIUMTOEQUIPITEM = 65
RETURNVALUE_TILEISFULL = 66
RETURNVALUE_CONTAINERHASTOMANYITEMS = 67

PLAYERFLAG_CANNOTUSECOMBAT = 0
PLAYERFLAG_CANNOTATTACKPLAYER = 1
PLAYERFLAG_CANNOTATTACKMONSTER = 2
PLAYERFLAG_CANNOTBEATTACKED = 3
PLAYERFLAG_CANCONVINCEALL = 4
PLAYERFLAG_CANSUMMONALL = 5
PLAYERFLAG_CANILLUSIONALL = 6
PLAYERFLAG_CANSENSEINVISIBILITY = 7
PLAYERFLAG_IGNOREDBYMONSTERS = 8
PLAYERFLAG_NOTGAININFIGHT = 9
PLAYERFLAG_HASINFINITEMANA = 10
PLAYERFLAG_HASINFINITESOUL = 11
PLAYERFLAG_HASNOEXHAUSTION = 12
PLAYERFLAG_CANNOTUSESPELLS = 13
PLAYERFLAG_CANNOTPICKUPITEM = 14
PLAYERFLAG_CANALWAYSLOGIN = 15
PLAYERFLAG_CANBROADCAST = 16
PLAYERFLAG_CANEDITHOUSES = 17
PLAYERFLAG_CANNOTBEBANNED = 18
PLAYERFLAG_CANNOTBEPUSHED = 19
PLAYERFLAG_HASINFINITECAPACITY = 20
PLAYERFLAG_CANPUSHALLCREATURES = 21
PLAYERFLAG_CANTALKREDPRIVATE = 22
PLAYERFLAG_CANTALKREDCHANNEL = 23
PLAYERFLAG_TALKORANGEHELPCHANNEL = 24
PLAYERFLAG_NOTGAINEXPERIENCE = 25
PLAYERFLAG_NOTGAINMANA = 26
PLAYERFLAG_NOTGAINHEALTH = 27
PLAYERFLAG_NOTGAINSKILL = 28
PLAYERFLAG_SETMAXSPEED = 29
PLAYERFLAG_SPECIALVIP = 30
PLAYERFLAG_NOTGENERATELOOT = 31
PLAYERFLAG_CANTALKREDCHANNELANONYMOUS = 32
PLAYERFLAG_IGNOREPROTECTIONZONE = 33
PLAYERFLAG_IGNORESPELLCHECK = 34
PLAYERFLAG_IGNOREWEAPONCHECK = 35
PLAYERFLAG_CANNOTBEMUTED = 36
PLAYERFLAG_ISALWAYSPREMIUM = 37
PLAYERFLAG_CANANSWERRULEVIOLATIONS = 38
PLAYERFLAG_CANRELOADCONTENT = 39
PLAYERFLAG_SHOWGROUPINSTEADOFVOCATION = 40
PLAYERFLAG_CANNOTMOVEITEMS = 41
PLAYERFLAG_CANNOTMOVECREATURES = 42
PLAYERFLAG_CANREPORTBUGS = 43
PLAYERFLAG_CANSEESPECIALDESCRIPTION = 44
PLAYERFLAG_CANNOTBESEEN = 45

SKULL_NONE = 0
SKULL_YELLOW = 1
SKULL_GREEN = 2
SKULL_WHITE = 3
SKULL_RED = 4

ITEM_BAG = 1987

ITEMCOUNT_MAX = 100

ITEM_GOLD_COIN = 2148
ITEM_PLATINUM_COIN = 2152
ITEM_CRYSTAL_COIN = 2160

ITEM_MAGICWALL = 1497
ITEM_MAGICWALL_SAFE = 1497
ITEM_WILDGROWTH = 1499
ITEM_WILDGROWTH_SAFE  = 1499

PLAYER_ID_RANGE = 268435456 --0x10000000
MONSTER_ID_RANGE = 1073741824 --0x40000000
NPC_ID_RANGE = 2147483648 --0x80000000

--flags for queries
QUERYFLAG_NONE = 0			--Don't bypass any check
QUERYFLAG_NOLIMIT = 1			--Bypass check limits like capacity/container limits, blocking items/creatures etc.
QUERYFLAG_IGNOREBLOCKITEM = 2		--Bypass moveable blocking item checks
QUERYFLAG_IGNOREBLOCKCREATURE = 4	--Bypass creature checks
QUERYFLAG_CHILDISOWNER = 8		--Used by containers to query capacity of the carrier (player)
QUERYFLAG_PATHFINDING = 16		--An additional check is done for floor changing/teleport items
QUERYFLAG_IGNOREFIELDDAMAGE = 32	--Bypass field damage checks
QUERYFLAG_IGNORENOTMOVEABLE = 64	--Bypass check for movability

GAME_STATE_STARTUP = 0
GAME_STATE_INIT = 1
GAME_STATE_NORMAL = 2
GAME_STATE_CLOSED = 3
GAME_STATE_SHUTDOWN = 4
GAME_STATE_CLOSING = 5

RELOAD_TYPE_ACTIONS = 0
RELOAD_TYPE_MONSTERS = 1
RELOAD_TYPE_NPCS = 2
RELOAD_TYPE_CONFIG = 3
RELOAD_TYPE_TALKACTIONS = 4
RELOAD_TYPE_MOVEMENTS = 5
RELOAD_TYPE_SPELLS = 6
RELOAD_TYPE_RAIDS = 7
RELOAD_TYPE_CREATURESCRIPTS = 8
RELOAD_TYPE_ITEMS = 9
RELOAD_TYPE_GLOBALEVENTS = 10

-- Stack Positions
STACKPOS_GROUND = 0
STACKPOS_TOP_CREATURE = 253
STACKPOS_TOP_FIELD = 254
STACKPOS_TOP_MOVABLE_ITEM_OR_CREATURE = 255

-- Weapon Types
WEAPON_NONE     = 0
WEAPON_SWORD    = 1
WEAPON_CLUB     = 2
WEAPON_AXE      = 3
WEAPON_SHIELD   = 4
WEAPON_DIST     = 5
WEAPON_WAND     = 6
WEAPON_AMMO     = 7

-- Fluidtypes
FLUID_NONE = 0
FLUID_WATER = 1
FLUID_BLOOD = 2
FLUID_BEER = 3
FLUID_SLIME = 4
FLUID_LEMONADE = 5
FLUID_MILK = 6
FLUID_MANA = 7
FLUID_LIFE = 10
FLUID_OIL = 11
FLUID_URINE = 13
FLUID_COCONUT_MILK = 14
FLUID_WINE = 15
FLUID_MUD = 19
FLUID_FRUIT_JUICE = 21
FLUID_RUM = 27
FLUID_TEA = 35
FLUID_MEAD = 36

COLOR_BLACK = 0
COLOR_BLUE = 5
COLOR_GREEN = 18
COLOR_TEAL = 35
COLOR_LIGHTGREEN = 66
COLOR_DARKBROWN = 78
COLOR_LIGHTBLUE = 89
COLOR_DARKPURPLE = 112
COLOR_BROWN = 120
COLOR_GREY = 129
COLOR_DARKRED = 144
COLOR_DARKPINK = 152
COLOR_PURPLE = 154
COLOR_DARKORANGE = 156
COLOR_RED = 180
COLOR_PINK = 190
COLOR_ORANGE = 192
COLOR_DARKYELLOW = 205
COLOR_YELLOW = 210
COLOR_WHITE = 215
COLOR_NONE = 255

