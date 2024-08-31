import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:notivocab/src/model/schema/schema_quiz_scope.dart';
import 'package:notivocab/src/model/transact_quiz_scope_db.dart';

final scopeSelectedProvider =
    StateNotifierProvider<ScopeSelectedNotifier, ScopeSelectedState>((ref) {
  return ScopeSelectedNotifier();
});

class ScopeSelectedState {
  QuizScope quizScope;

  ScopeSelectedState({QuizScope? quizScope})
      : quizScope = quizScope ?? QuizScope(); // コンストラクタ内で初期化

  ScopeSelectedState copyWith({QuizScope? quizScope}) {
    return ScopeSelectedState(
      quizScope: quizScope ?? this.quizScope,
    );
  }
}

class ScopeSelectedNotifier extends StateNotifier<ScopeSelectedState> {
  final TransactQuizScopeDB _transactQuizScopeDB = TransactQuizScopeDB();
  ScopeSelectedNotifier() : super(ScopeSelectedState()) {
    _loadInitialScopeSelected();
  }

  Future<void> _loadInitialScopeSelected() async {
    final QuizScope quizScope = await _transactQuizScopeDB.getValues();
    state = ScopeSelectedState(quizScope: quizScope);
  }

  void updateVal(QuizScope quizScope) {
    state = state.copyWith(quizScope: quizScope);
  }

  Future<void> setScopeSelected() async {
    final QuizScope quizScope = state.quizScope;
    await _transactQuizScopeDB.updateDB(quizScope);
  }
}
