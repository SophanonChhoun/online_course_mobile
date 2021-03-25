class Author {
  Author({
    this.id,
    this.firstName,
    this.lastName,
  });

  int id;
  dynamic firstName;
  dynamic lastName;

  factory Author.fromMap(Map<String, dynamic> json) => Author(
        id: json["id"] == null ? null : json["id"],
        firstName: json["first_name"],
        lastName: json["last_name"],
      );

  Map<String, dynamic> toMap() => {
        "id": id == null ? null : id,
        "first_name": firstName,
        "last_name": lastName,
      };
}
