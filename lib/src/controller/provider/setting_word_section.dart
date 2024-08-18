import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:notivocab/src/constants.dart';
import '../access_shared_preference.dart';

final scopeSelectedProvider =
    StateNotifierProvider<ScopeSelectedNotifier, ScopeSelectedState>((ref) {
  return ScopeSelectedNotifier();
});

class ScopeSelectedState {
  List<bool> scopeSelected;
  ScopeSelectedState({this.scopeSelected = const []});

  ScopeSelectedState copyWith({List<bool>? scopeSelected}) {
    return ScopeSelectedState(
      scopeSelected: scopeSelected ?? this.scopeSelected,
    );
  }
}

class ScopeSelectedNotifier extends StateNotifier<ScopeSelectedState> {
  final SharedPreferencesService _sharedPreferencesService =
      SharedPreferencesService();

  ScopeSelectedNotifier() : super(ScopeSelectedState()) {
    _loadInitialScopeSelected();
  }

  Future<void> _loadInitialScopeSelected() async {
    final List<String>? scopeSelectedString =
        await _sharedPreferencesService.getValue('examScope');
    if (scopeSelectedString == null) {
      state = ScopeSelectedState(
          scopeSelected: List.generate(examScope.length, (index) => true));
      return;
    }
    final List<bool> scopeSelected = scopeSelectedString
        .map((String e) => e == 'true' ? true : false)
        .toList();
    state = ScopeSelectedState(scopeSelected: scopeSelected);
  }

  void updateList(List<bool> scopeSelected) {
    state = state.copyWith(scopeSelected: scopeSelected);
  }

  Future<void> setScopeSelected() async {
    final List<bool> scopeSelected = state.scopeSelected;
    final List<String> scopeSelectedString =
        scopeSelected.map((e) => e.toString()).toList();
    await _sharedPreferencesService.setValue('examScope', scopeSelectedString);
  }
}
