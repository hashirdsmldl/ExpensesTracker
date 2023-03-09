import 'dart:core';
class Transaction
{
   final String id;
   final String title;
   final double amount;
   final DateTime dateTime;
   final String category;


  Transaction({required this.id, required this.title, required this.amount, required this.dateTime,required this.category});
}