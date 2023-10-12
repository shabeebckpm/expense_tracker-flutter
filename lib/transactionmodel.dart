class Transactionmodel {
  final String amount;
  final String dropdown;
  final String description;
  final String time;
  Transactionmodel({required this.amount, required this.dropdown, required this.description,required this.time});
  // Convert Transactionmodel object to a map
  Map<String, dynamic> toMap() {
    return {
      'dropdown': dropdown,
      'amount': amount,
      'description': description,
      'time':time,
    };
  }

  // Create a Transactionmodel object from a map
  factory Transactionmodel.fromMap(Map<String, dynamic> map) {
    return Transactionmodel(
      dropdown: map['dropdown'],
      amount: map['amount'],
      description: map['description'],
      time: map['time'],
    );
  }
}
