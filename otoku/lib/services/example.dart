////import 'auth_service.dart';
import 'user_service.dart';

////AuthService authService = AuthService();
////UserService userService = UserService();

// Kayıt olma işlemi
////String registerError = await authService.registerWithEmailAndPassword("example@example.com", "password");
////if (registerError == null) {////
  // Kayıt başarılı
////} else {////
  // Kayıt başarısız, hata mesajını kullanabilirsiniz
 // print("Kayıt başarısız: $registerError");
//}

// Giriş işlemi
////String loginError = await authService.signInWithEmailAndPassword("example@example.com", "password");
////if (loginError == null) {
////  // Giriş başarılı
////} else {
  // Giriş başarısız, hata mesajını kullanabilirsiniz
 // print("Giriş başarısız: $loginError");
//}

// Kullanıcı bilgilerini çekme
////User? currentUser = userService.getCurrentUser();
////if (currentUser != null) {
 // print("Kullanıcı adı: ${currentUser.displayName}");
 // print("E-posta: ${currentUser.email}");
  // Diğer kullanıcı bilgilerini burada kullanabilirsiniz
////} else {
 // print("Kullanıcı oturumu açık değil.");
//}
// E-posta doğrulama kodunu kontrol etme
//Future<void> sendVerificationEmail() async {
//  try {
//    await authService.sendEmailVerification();
//    print("E-posta doğrulama bağlantısı kullanıcının e-postasına gönderildi.");
//  } catch (e) {
//    print("E-posta doğrulama bağlantısı gönderilirken bir hata oluştu: $e");
//  }
//}