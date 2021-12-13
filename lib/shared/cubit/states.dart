abstract class AppStates {}

class AppInitState extends AppStates {}

class AppTopTitleState extends AppStates {}

class AppBottomNavState extends AppStates {}

// ----------------- Breaking News -------------------------

class AppGetBreakingNewsLoadingState extends AppStates {}

class AppGetBreakingNewsSuccessfulState extends AppStates {}

class AppGetBreakingNewsFailedState extends AppStates {}

//----------------- Begin Business --------------------------
class AppGetBusinessNewsSuccessState extends AppStates {}

class AppGetBusinessNewsFailedState extends AppStates {}

class AppGetBusinessLoadingNewsState extends AppStates {}
//----------------- End Business --------------------------

//----------------- Begin Sports --------------------------
class AppGetSportsNewsSuccessState extends AppStates {}

class AppGetSportsNewsFailedState extends AppStates {}

class AppGetSportsLoadingNewsState extends AppStates {}
//----------------- End Sports --------------------------

//----------------- Begin Science --------------------------
class AppGetScienceNewsSuccessState extends AppStates {}

class AppGetScienceNewsFailedState extends AppStates {}

class AppGetScienceLoadingNewsState extends AppStates {}
//----------------- Begin Science --------------------------

//----------------- Begin Entertainment --------------------------
class AppGetEntertainmentNewsSuccessState extends AppStates {}

class AppGetEntertainmentNewsFailedState extends AppStates {}

class AppGetEntertainmentLoadingNewsState extends AppStates {}
//----------------- End Entertainment --------------------------

//----------------- Begin General ------------------------------
class AppGetGeneralNewsSuccessState extends AppStates {}

class AppGetGeneralNewsFailedState extends AppStates {}

class AppGetGeneralLoadingNewsState extends AppStates {}
//----------------- End General ----------------------------------

//----------------- Begin Health ---------------------------------
class AppGetHealthNewsSuccessState extends AppStates {}

class AppGetHealthNewsFailedState extends AppStates {}

class AppGetHealthLoadingNewsState extends AppStates {}
//----------------- End Health ----------------------------------

//----------------- Begin Technology -----------------------------
class AppGetTechnologyNewsSuccessState extends AppStates {}

class AppGetTechnologyNewsFailedState extends AppStates {}

class AppGetTechnologyLoadingNewsState extends AppStates {}
//----------------- End Technology ------------------------------

class AppChangeThemeModeState extends AppStates {}

class AppChangLanguageState extends AppStates {}

class AppGetSearchNewsSuccessState extends AppStates {}

class AppGetSearchNewsFailedState extends AppStates {}

class AppGetSearchLoadingNewsState extends AppStates {}

class AppMoveToNextPageState extends AppStates {}
