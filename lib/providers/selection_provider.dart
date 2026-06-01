import 'package:flutter_riverpod/flutter_riverpod.dart'
    show Notifier, NotifierProvider;

final selectionProvider = NotifierProvider<SelectionNotifier, SelectionState>(
  SelectionNotifier.new,
);

class SelectionNotifier extends Notifier<SelectionState> {
  @override
  SelectionState build() => const SelectionState();

  void clearSelection() {
    state = const SelectionState();
  }

  void enterMultiSelect(int id) {
    state = SelectionState(multiSelectMode: true, selectedIds: {id});
  }

  void toggleSelection(int id) {
    final ids = Set<int>.from(state.selectedIds);

    ids.contains(id) ? ids.remove(id) : ids.add(id);

    state = state.copyWith(multiSelectMode: ids.isNotEmpty, selectedIds: ids);
  }
}

class SelectionState {
  final bool multiSelectMode;
  final Set<int> selectedIds;

  const SelectionState({
    this.multiSelectMode = false,
    this.selectedIds = const {},
  });

  SelectionState copyWith({bool? multiSelectMode, Set<int>? selectedIds}) {
    return SelectionState(
      multiSelectMode: multiSelectMode ?? this.multiSelectMode,
      selectedIds: selectedIds ?? this.selectedIds,
    );
  }
}
