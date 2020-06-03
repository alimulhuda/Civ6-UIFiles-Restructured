-- ===========================================================================
--	TechTree Replacement
--	Civilization VI, Firaxis Games
-- ===========================================================================
include("TechTree");
include("AllianceResearchSupport");

-- Copied from TechTree.lua to avoid modifying original file more than needed
local ITEM_STATUS = { BLOCKED = 1, READY = 2, CURRENT = 3, RESEARCHED = 4 };

-- ===========================================================================
--	CACHE BASE FUNCTIONS
-- ===========================================================================
BASE_View = View;
BASE_PopulateNode = PopulateNode;
BASE_ShouldUpdateWhenResearchChanges = ShouldUpdateWhenResearchChanges;


-- ===========================================================================
--	OVERRIDE Base
-- ===========================================================================
function View(playerTechData)
	CalculateAllianceResearchBonus();
	BASE_View(playerTechData);
end

-- ===========================================================================
--	OVERRIDE Base
-- ===========================================================================
function PopulateNode(node, playerTechData)
	BASE_PopulateNode(node, playerTechData);
	UpdateAllianceIcon(node);
end

-- ===========================================================================
function UpdateAllianceIcon(node)
	local techID = GameInfo.Technologies[node.Type].Index;
	if AllyHasOrIsResearchingTech(techID) then
		node.AllianceIcon:SetToolTipString(GetAllianceIconToolTip());
		node.AllianceIcon:SetColor(GetAllianceIconColor());
		node.Alliance:SetHide(false);
	else
		node.Alliance:SetHide(true);
	end
end

-- ===========================================================================
--	OVERRIDE Base
-- ===========================================================================
function ShouldUpdateWhenResearchChanges(ePlayer)
	return BASE_ShouldUpdateWhenResearchChanges(ePlayer) or HasMaxLevelResearchAlliance(ePlayer);
end