abstract class UserProfileRepository {
  Future<void> createProfile(
    String adminUid,
    String name,
    String lastName,
    String documentNumber,
    String imagePath,
    String email,
  );
}
