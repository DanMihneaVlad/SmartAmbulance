enum UserRole {
  doctor("Doctor", 1),
  paramedic("Paramedic", 2);

  final String name;
  final int id;
  const UserRole(this.name, this.id);
}