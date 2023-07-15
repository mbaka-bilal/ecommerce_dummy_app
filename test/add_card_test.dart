import 'package:ecommerce_dummy_app/common/provider/add_card_bloc.dart';
import 'package:ecommerce_dummy_app/common/provider/add_card_event.dart';
import 'package:ecommerce_dummy_app/common/provider/add_card_state.dart';
import 'package:ecommerce_dummy_app/common/repository/add_card_repository.dart';
import 'package:ecommerce_dummy_app/utils/constants.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

class MockAddCardRepository extends Mock implements AddCardRepository {}

void main() {
  late AddCardBloc addCardBloc;
  late MockAddCardRepository cardRepository;

  setUp(() {
    cardRepository = MockAddCardRepository();
    addCardBloc = AddCardBloc(cardRepository);
  });

  tearDown(() {
    addCardBloc.close();
  });

  test("Initial state are correct", () {
    expect(addCardBloc.state.requestStatus, RequestStatus.initial);
    expect(addCardBloc.state.cardNumber, "");
    expect(addCardBloc.state.expirationyear, "");
    expect(addCardBloc.state.cvv, "");
    expect(addCardBloc.state.expirationMonth, "");
    expect(addCardBloc.state.cardHolderName, "");
  });

  test("Check card info",() {
    final expectedStates = [
      AddCardState(requestStatus: RequestStatus.loading),
      AddCardState(requestStatus: RequestStatus.success),
    ];

    when(cardRepository.checkCard).thenAnswer((_) => Future.value({"":""}));

    expectLater(
      addCardBloc.state,
      emitsInOrder(expectedStates)
    );

    addCardBloc.add(AddCard());
  });
  
}
