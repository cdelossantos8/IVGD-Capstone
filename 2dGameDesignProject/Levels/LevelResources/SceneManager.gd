# SceneManager.gd — Autoload
extends Node

var nextLevelMap : Dictionary = {}
var unlockedLevels : Dictionary = {}

var levelPaths : Dictionary = {
	"MainLevels": [
		"res://Levels/MainLevels/MainLevel1.tscn",
		"res://Levels/MainLevels/MainLevel2.scn",
		"res://Levels/MainLevels/MainLevel3.scn"
	]
}


func _ready() -> void:
	_buildNextLevelMap()
	_initUnlocks()

func _buildNextLevelMap() -> void:
	for weapon : String in levelPaths: ## weapon keys
		var levels : Array = levelPaths[weapon] ##get said weapons array of levels 
		for i : int in range(levels.size() - 1): ## get the count == array size -1 
			nextLevelMap[levels[i]] = levels[i + 1] ## map the next level var for each level in an array in the next level dictionary
		nextLevelMap[levels[levels.size() - 1]] = "" ## set it in the next level map dictionary 

func _initUnlocks() -> void:
	for weapon : String in levelPaths:
		var levels : Array = levelPaths[weapon]
		if levels.size() > 0:
			unlockedLevels[levels[0]] = true

func isLevelUnlocked(levelPath : String) -> bool:
	return unlockedLevels.has(levelPath)

func unlockNextLevel(currentLevelPath : String) -> void:
	var nextLevel : String = getNextLevel(currentLevelPath)
	if nextLevel != "":
		unlockedLevels[nextLevel] = true

func getNextLevel(currentLevelPath : String) -> String:
	if nextLevelMap.has(currentLevelPath):
		return nextLevelMap[currentLevelPath]
	return ""

func canAdvance(grade : String) -> bool:
	return grade in ["S", "A", "B"]

func goToNextLevel(currentLevelPath : String) -> void:
	var nextLevel : String = getNextLevel(currentLevelPath)
	if nextLevel != "":
		ScoreManager.resetLevel()
		get_tree().paused = false
		get_tree().change_scene_to_file(nextLevel)
	else:
		get_tree().paused = false
		if areAllLevelsCompleted():
			get_tree().change_scene_to_file("res://Levels/Ending.tscn")
		else:
			get_tree().change_scene_to_file("res://UI/MainMenu.tscn")

func goToMainMenu() -> void:
	ScoreManager.resetLevel()
	get_tree().paused = false
	if areAllLevelsCompleted():
		get_tree().change_scene_to_file("res://Levels/Ending.tscn")
	else:
		get_tree().change_scene_to_file("res://Levels/LevelResources/levelselect.tscn")


## Add to SceneManager.gd

func areAllLevelsCompleted() -> bool:
	for weapon : String in levelPaths:
		for levelPath : String in levelPaths[weapon]:
			if not ScoreManager.bestScores.has(levelPath):
				return false
	return true

func getTotalLevelCount() -> int:
	var count : int = 0
	for weapon : String in levelPaths:
		count += levelPaths[weapon].size()
	return count
