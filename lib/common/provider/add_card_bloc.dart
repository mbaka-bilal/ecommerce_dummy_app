import 'package:bloc/bloc.dart';

import '../repository/add_card_repository.dart';

import '../../common/provider/add_card_state.dart';
import '../../utils/constants.dart';

import 'add_card_event.dart';



class AddCardBloc extends Bloc<AddCardEvent,AddCardState>{
    final AddCardRepository addCardRepository;

    AddCardBloc(this.addCardRepository) : super(const AddCardState()){
      on<AddCard>(_mapAddCardEventToState);
    }


    void _mapAddCardEventToState(AddCard event,Emitter<AddCardState> emit) async {
      emit(state.copyWith(requestStatus: RequestStatus.loading));

      try{

      }catch(e){

      }
    }

    @override
  Future<void> close() {
        emit(state.copyWith(requestStatus: RequestStatus.initial, ));
    return super.close();
  }
}