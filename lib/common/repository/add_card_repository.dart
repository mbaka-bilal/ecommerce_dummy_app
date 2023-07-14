abstract class IAddCardRepository{
  Future<Map<String,dynamic>> checkCard();
}

class AddCardRepository implements IAddCardRepository{
  ///Logic to add card to local database, remote database and confirm card is
  ///valid.


  @override
  Future<Map<String, dynamic>> checkCard() {
    // TODO: implement checkCard
    throw UnimplementedError();
  }
}