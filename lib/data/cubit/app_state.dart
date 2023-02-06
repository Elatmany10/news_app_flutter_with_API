abstract class AppStates{}
class AppInitialState extends AppStates{}

class GetNewsLoadingState extends AppStates{}
class GetNewsLoadedState extends AppStates{}
class GetNewsFailedState extends AppStates{}

class SearchNewsLoadingState extends AppStates{}
class SearchNewsLoadedState extends AppStates{}
class SearchNewsFailedState extends AppStates{}

class ChangeCurrentIndexState extends AppStates{}
class ChangeModState extends AppStates{}