const smallSpace = 10.0;
const bigSpace = 20.0;
const biggerSpace = 40.0;
const dtb_user = "user_info";
const tbl_cards = "cards";
const tbl_address = "address";
const String cardTable =
    "CREATE TABLE cards (card_number TEXT PRIMARY KEY NOT NULL,expiration_month TEXT NOT NULL,expiration_year TEXT NOT NULL,cvv TEXT NOT NULL,card_holder TEXT NOT NULL)";
const String addressTable =
    "CREATE TABLE address (name TEXT PRIMARY KEY NOT NULL,phone_number TEXT NOT NULL)";
