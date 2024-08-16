import 'dart:math';

class TokenGenerator {


   String generateToken(int length) {
    const characters = 'ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz0123456789';
    final random = Random.secure();
    return List.generate(length, (index) => characters[random.nextInt(characters.length)]).join();
  }
}
