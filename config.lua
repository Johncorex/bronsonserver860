-- Combat settings
-- NOTE: valid values for worldType are: "pvp", "no-pvp" and "pvp-enforced"
worldType = "pvp"
hotkeyAimbotEnabled = true
protectionLevel = 1
killsToRedSkull = 7
killsToBlackSkull = 14
pzLocked = 40000
removeChargesFromRunes = true
removeChargesFromPotions = true
removeWeaponAmmunition = false
removeWeaponCharges = true
timeToDecreaseFrags = 24 * 60 * 60
whiteSkullTime = 10 * 60
stairJumpExhaustion = 1000
experienceByKillingPlayers = false
expFromPlayersLevelRange = 75
pzLockSkullAttacker = false

-- Connection Config
-- NOTE: maxPlayers set to 0 means no limit
-- NOTE: allowWalkthrough is only applicable to players
ip = "127.0.0.1"
bindOnlyGlobalAddress = false
loginProtocolPort = 7171
gameProtocolPort = 7172
statusProtocolPort = 7171
maxPlayers = 0
motd = "Bem vindo ao Bronson Project!"
onePlayerOnlinePerAccount = true
allowClones = false
allowWalkthrough = false
serverName = "Bronson Project"
statusTimeout = 5000
replaceKickOnLogin = true
maxPacketsPerSecond = 200

-- Deaths
-- NOTE: Leave deathLosePercent as -1 if you want to use the default
-- death penalty formula. For the old formula, set it to 10. For
-- no skill/experience loss, set it to 0.
deathLosePercent = -1

-- Houses
-- NOTE: set housePriceEachSQM to -1 to disable the ingame buy house functionality
-- NOTE: valid values for houseRentPeriod are: "daily", "weekly", "monthly", "yearly"
-- use any other value to disable the rent system
housePriceEachSQM = 500
houseRentPeriod = "weekly"
houseOwnedByAccount = false
houseDoorShowPrice = true
onlyInvitedCanMoveHouseItems = true

-- Item Usage
timeBetweenActions = 200
timeBetweenExActions = 1000

-- Map
-- NOTE: set mapName WITHOUT .otbm at the end
mapName = "Bronson"
mapAuthor = "Miguel"

-- Market
marketOfferDuration = 30 * 24 * 60 * 60
premiumToCreateMarketOffer = true
checkExpiredMarketOffersEachMinutes = 60
maxMarketOffersAtATimePerPlayer = 100

-- MySQL
mysqlHost = "127.0.0.1"
mysqlUser = "root"
mysqlPass = ""
mysqlDatabase = "bronsonserver"
mysqlPort = 3306
mysqlSock = "/var/run/mysqld/mysqld.sock"

-- Misc.
-- NOTE: classicAttackSpeed set to true makes players constantly attack at regular
-- intervals regardless of other actions such as item (potion) use. This setting
-- may cause high CPU usage with many players and potentially affect performance!
-- NOTE: forceMonsterTypesOnLoad loads all monster types on startup to validate them.
-- You can disable it to save some memory if you don't see any errors at startup.
allowChangeOutfit = true
freePremium = false
kickIdlePlayerAfterMinutes = 15
maxMessageBuffer = 8
emoteSpells = true
classicEquipmentSlots = true
classicAttackSpeed = true
showScriptsLogInConsole = true
showOnlineStatusInCharlist = false
yellMinimumLevel = 15
yellAlwaysAllowPremium = false
minimumLevelToSendPrivate = 15
premiumToSendPrivate = false
forceMonsterTypesOnLoad = true
cleanProtectionZones = false
luaItemDesc = false
showPlayerLogInConsole = true

-- VIP and Depot limits
-- NOTE: you can set custom limits per group in data/XML/groups.xml
vipFreeLimit = 20
vipPremiumLimit = 100
depotFreeLimit = 2000
depotPremiumLimit = 10000

-- World Light
-- NOTE: if defaultWorldLight is set to true the world light algorithm will
-- be handled in the sources. set it to false to avoid conflicts if you wish
-- to make use of the function setWorldLight(level, color)
defaultWorldLight = true

-- Server Save
-- NOTE: serverSaveNotifyDuration in minutes
serverSaveNotifyMessage = true
serverSaveNotifyDuration = 3
serverSaveCleanMap = false
serverSaveClose = false
serverSaveShutdown = false

-- Experience stages
-- NOTE: to use a flat experience multiplier, set experienceStages to nil
-- minlevel and multiplier are MANDATORY
-- maxlevel is OPTIONAL, but is considered infinite by default
-- to disable stages, create a stage with minlevel 1 and no maxlevel
experienceStages = {
	{ minlevel = 1, maxlevel = 50, multiplier = 10 },
	{ minlevel = 51, maxlevel = 100, multiplier = 8 },
	{ minlevel = 101, maxlevel = 150, multiplier = 5 },
	{ minlevel = 151, maxlevel = 200, multiplier = 4 },
	{ minlevel = 201, maxlevel = 400, multiplier = 3 },
	{ minlevel = 401, maxlevel = 600, multiplier = 2 },
	{ minlevel = 601, maxlevel = 999, multiplier = 1 }
}

-- Rates
-- NOTE: rateExp is not used if you have enabled stages above
rateExp = 10
rateSkill = 20
rateLoot = 1
rateMagic = 18
rateSpawn = 1

-- Monster Despawn Config
-- despawnRange is the amount of floors a monster can be from its spawn position
-- despawnRadius is how many tiles away it can be from its spawn position
-- removeOnDespawn will remove the monster if true or teleport it back to its spawn position if false
-- walkToSpawnRadius is the allowed distance that the monster will stay away from spawn position when left with no targets, 0 to disable
deSpawnRange = 3
deSpawnRadius = 100
removeOnDespawn = true
walkToSpawnRadius = 15

-- Stamina
staminaSystem = true

-- Scripts
warnUnsafeScripts = true
convertUnsafeScripts = true

-- Startup
-- NOTE: defaultPriority only works on Windows and sets process
-- priority, valid values are: "normal", "above-normal", "high"
defaultPriority = "high"
startupDatabaseOptimization = false

-- Status Server Information
ownerName = "Bronson Server"
ownerEmail = ""
url = "bronsonproject.com"
location = "Brazil"


-- ATRIBUTOS RARE SYSTEM + CRITICAL -- ( FALSE )
apply_item_specialskills = false

-- Default amounts (percentuais) aplicados quando só a chance é definida no item
criticalDefaultAmount = 100      -- 100% de dano extra no crítico
lifeLeechDefaultAmount = 10     -- 10% do dano convertido em vida
manaLeechDefaultAmount = 10      -- 10% do dano convertido em mana

-- Critical, Life Leech, Mana Leech visual feedback
criticalEffect = 35
criticalText = "CRITICAL!"
criticalColor = 198

lifeLeechEffect = 13
lifeLeechText = "leech!"
lifeLeechColor = 30

manaLeechEffect = 12
manaLeechText = "mana leech!"
manaLeechColor = 35

--TEXTCOLOR_BLUE = 5,
--TEXTCOLOR_LIGHTGREEN = 30,
--TEXTCOLOR_LIGHTBLUE = 35,
--TEXTCOLOR_MAYABLUE = 95,
--TEXTCOLOR_DARKRED = 108,
--TEXTCOLOR_LIGHTGREY = 129,
--TEXTCOLOR_SKYBLUE = 143,
--TEXTCOLOR_PURPLE = 155,
--TEXTCOLOR_RED = 180,
--TEXTCOLOR_ORANGE = 198,
--TEXTCOLOR_YELLOW = 210,
--TEXTCOLOR_WHITE_EXP = 215,
--TEXTCOLOR_NONE = 255,