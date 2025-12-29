// BLoC for managing link-related state and operations.
//
// Handles CRUD operations for video links and search functionality.
// Uses the repository pattern to interact with the data layer.

import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../domain/repositories/link_repository.dart';
import '../../../../core/error/failure.dart';
import '../../../../domain/entities/link_entity.dart';
part 'link_event.dart';
part 'link_state.dart';

class LinkBloc extends Bloc<LinkEvent, LinkState> {
  final LinkRepository repo;

  LinkBloc(this.repo) : super(LinkInitial()) {
    on<LoadLinks>(_onLoadLinks);
    on<AddLink>(_onAddLink);
    on<UpdateLink>(_onUpdateLink);
    on<DeleteLink>(_onDeleteLink);
    on<SearchLinks>(_onSearchLinks);
  }

  /// Handles loading all links from the repository.
  Future<void> _onLoadLinks(LoadLinks event, Emitter<LinkState> emit) async {
    emit(LinkLoading());
    final result = await repo.getAllLinks();
    result.fold(
      (failure) => emit(LinkError(_mapFailure(failure))),
      (links) => emit(LinkLoaded(links)),
    );
  }

  /// Handles adding a new link.
  /// Reloads all links after successful addition.
  Future<void> _onAddLink(AddLink event, Emitter<LinkState> emit) async {
    final result = await repo.addLink(event.link);
    result.fold(
      (failure) {
        emit(LinkError(_mapFailure(failure)));
      },
      (success) {
        add(LoadLinks());
      },
    );
  }

  /// Handles updating an existing link.
  /// Reloads all links after successful update.
  Future<void> _onUpdateLink(UpdateLink event, Emitter<LinkState> emit) async {
    final result = await repo.updateLink(event.link);
    result.fold(
      (failure) {
        emit(LinkError(_mapFailure(failure)));
      },
      (success) {
        add(LoadLinks());
      },
    );
  }

  /// Handles deleting a link by ID.
  /// Note: Does not reload links automatically - caller should trigger LoadLinks.
  Future<void> _onDeleteLink(DeleteLink event, Emitter<LinkState> emit) async {
    await repo.deleteLink(event.id);
  }

  /// Handles searching links by query string.
  /// Searches both title and URL fields.
  Future<void> _onSearchLinks(
    SearchLinks event,
    Emitter<LinkState> emit,
  ) async {
    emit(LinkLoading());
    final result = await repo.searchLinks(event.query);
    result.fold(
      (failure) => emit(LinkError(_mapFailure(failure))),
      (links) => emit(SearchLinkLoaded(links)),
    );
  }

  /// Maps failure to user-friendly error message.
  String _mapFailure(Failure failure) {
    return failure.displayMessage;
  }
}
