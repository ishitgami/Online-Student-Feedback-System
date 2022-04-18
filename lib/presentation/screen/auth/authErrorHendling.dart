
class ErrorHangling {
   String errorMessage;
  throwErrorMesg({String errorCode}) {
    switch (errorCode) {
       case "email-already-in-use":
        errorMessage = "This e-mail address is already in use, please use a different e-mail address.";
        break;
      case "weak-password":
        errorMessage = "Your password is too short !!";
        break;
      case "invalid-email":
        errorMessage = "Please enter valid E-mail.";
        break;
      case "wrong-password":
        errorMessage = "Please enter currect password.";
        break;
      case "user-not-found":
        errorMessage = "User not found.\nPlease Register yourself !";
        break;
      default:
        errorMessage = "Process failed. Please try again.";
    }
    return errorMessage;
  }
}