abstract class UserProfileRepository {
  Future<void> createProfile(
    String adminUid,
    String name,
    String lastName,
    String document,
    String imagePath,
    String email,
  );
}
