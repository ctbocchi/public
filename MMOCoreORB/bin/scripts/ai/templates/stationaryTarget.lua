stationaryTarget = {
	{"root", "CompositeDefault", "none", SELECTORBEHAVIOR},
	{"attack", "GetTarget", "wait", BEHAVIOR},
	{"move", "CompositeDefault", "wait", BEHAVIOR},
}

addAiTemplate("stationaryTarget", stationaryTarget)