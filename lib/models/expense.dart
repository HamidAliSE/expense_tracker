class Expense {
  const Expense({required this.title, required this.amount, required this.date})
    : id = '123';

  final String id;
  final String title;
  final double amount;
  final DateTime date;
}
