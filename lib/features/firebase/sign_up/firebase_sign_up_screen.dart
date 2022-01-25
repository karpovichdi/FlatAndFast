import 'package:flat_and_fast/common/controls/dialogs/information_dialog.dart';
import 'package:flat_and_fast/common/controls/dialogs/notification_dialog.dart';
import 'package:flat_and_fast/common/controls/loading/loading_page.dart';
import 'package:flat_and_fast/common/navigation/navigation_helper.dart';
import 'package:flat_and_fast/common/redux/app/app_state.dart';
import 'package:flat_and_fast/common/utils/styles/app_colors.dart';
import 'package:flat_and_fast/features/firebase/utils/styles/firebase_colors.dart';
import 'package:flat_and_fast/features/firebase/utils/styles/firebase_dimensions.dart';
import 'package:flat_and_fast/features/firebase/utils/styles/firebase_localization.dart';
import 'package:flat_and_fast/features/firebase/sign_up/redux/firebase_sign_up_view_model.dart';
import 'package:flat_and_fast/gen/assets.gen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';

class FirebaseSignUpScreen extends StatefulWidget {
  const FirebaseSignUpScreen({Key? key}) : super(key: key);

  @override
  State<StatefulWidget> createState() => _FirebaseSignUpScreenState();
}

class _FirebaseSignUpScreenState extends State<FirebaseSignUpScreen> {
  final emailController = TextEditingController();
  final passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return StoreConnector<AppState, FirebaseSignUpViewModel>(
      onWillChange: _stateWillChange,
      converter: (store) {
        return FirebaseSignUpViewModel.fromStore(store);
      },
      builder: (_, viewModel) {
        double width = MediaQuery.of(context).size.width;
        double height = MediaQuery.of(context).size.height;
        return Scaffold(body: Builder(builder: (context) {
          return SizedBox(
            height: height,
            width: width,
            child: SingleChildScrollView(
              child: Builder(builder: (context) {
                return Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    SizedBox(
                      width: width,
                      height: height * FirebaseDimensions.imageHeightCoefficient,
                      child: Image.asset(
                        Assets.images.signUpIcon.path,
                      ),
                    ),
                    Builder(builder: (context) {
                      if (viewModel.isLoading) {
                        return const Center(
                          child: LoadingPage(),
                        );
                      }
                      return Column(
                        children: [
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Column(
                              children: [
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  children: const [
                                    Text(
                                      FirebaseLocalization.signUpText,
                                      style: TextStyle(
                                        fontSize: FirebaseDimensions.loginTitleFontSize,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                  ],
                                ),
                                const SizedBox(height: FirebaseDimensions.emailTopPadding),
                                TextField(
                                  controller: emailController,
                                  decoration: InputDecoration(
                                    hintText: FirebaseLocalization.emailText,
                                    suffixIcon: const Icon(Icons.email),
                                    border: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(FirebaseDimensions.outputBorder),
                                    ),
                                  ),
                                ),
                                const SizedBox(height: FirebaseDimensions.passwordTopPadding),
                                TextField(
                                  controller: passwordController,
                                  obscureText: viewModel.hidePassword,
                                  decoration: InputDecoration(
                                    hintText: FirebaseLocalization.passwordText,
                                    suffixIcon: GestureDetector(
                                      onTap: () => viewModel.changePasswordState(),
                                      child: const Icon(Icons.visibility_off),
                                    ),
                                    border: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(FirebaseDimensions.outputBorder),
                                    ),
                                  ),
                                ),
                                const SizedBox(height: FirebaseDimensions.emailTopPadding),
                                Padding(
                                  padding: const EdgeInsets.symmetric(horizontal: 8.0),
                                  child: Row(
                                    children: [
                                      Expanded(
                                        flex: 1,
                                        child: ElevatedButton(
                                          child: const Text(
                                            FirebaseLocalization.backButtonTitle,
                                            style: TextStyle(
                                              fontSize: FirebaseDimensions.loginButtonFontSize,
                                              fontWeight: FontWeight.normal,
                                              color: FirebaseColors.loginButtonTextColor,
                                            ),
                                          ),
                                          onPressed: () => viewModel.goBack(() => NavigationHelper.goBack(context: context)),
                                          style: ElevatedButton.styleFrom(
                                            primary: FirebaseColors.backButtonColor,
                                          ),
                                        ),
                                      ),
                                      const SizedBox(width: 12.0),
                                      Expanded(
                                        flex: 2,
                                        child: ElevatedButton(
                                          child: const Text(
                                            FirebaseLocalization.signUpText,
                                            style: TextStyle(
                                              fontSize: FirebaseDimensions.loginButtonFontSize,
                                              fontWeight: FontWeight.normal,
                                              color: FirebaseColors.loginButtonTextColor,
                                            ),
                                          ),
                                          onPressed: () => viewModel.signUp(
                                            emailController.text,
                                            passwordController.text,
                                            () => NavigationHelper.goBack(context: context),
                                          ),
                                          style: ElevatedButton.styleFrom(
                                            onPrimary: FirebaseColors.backButtonColor,
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                                const SizedBox(height: FirebaseDimensions.emailTopPadding),
                              ],
                            ),
                          ),
                          const SizedBox(height: FirebaseDimensions.passwordTopPadding),
                        ],
                      );
                    }),
                  ],
                );
              }),
            ),
          );
        }));
      },
    );
  }

  @override
  void dispose() {
    emailController.dispose();
    passwordController.dispose();
    super.dispose();
  }

  _showErrorDialog(FirebaseSignUpViewModel viewModel) {
    showDialog<void>(
        barrierColor: AppColors.transparent,
        context: context,
        builder: (context) {
          return InformationDialog(
            dismissAction: () => _dismissDialogIntent(viewModel),
            message: viewModel.authFailedMessage,
            title: FirebaseLocalization.errorTitle,
          );
        });
  }

  _showSuccessDialog(FirebaseSignUpViewModel viewModel) {
    showDialog<void>(
        barrierColor: AppColors.transparent,
        context: context,
        builder: (context) {
          return NotificationDialog(
            dismissAction: () => _dismissDialogIntent(viewModel),
            message: viewModel.authFailedMessage,
            title: FirebaseLocalization.successTitle,
          );
        });
  }

  _dismissDialogIntent(FirebaseSignUpViewModel viewModel) {
    viewModel.dismissDialog();
  }

  _showDialogIntent(FirebaseSignUpViewModel viewModel) {
    viewModel.showDialog();
  }

  _stateWillChange(
    FirebaseSignUpViewModel? previousViewModel,
    FirebaseSignUpViewModel newViewModel,
  ) {
    if (previousViewModel == null) return;

    var shouldShowErrorDialog = !previousViewModel.errorDialogVisible && newViewModel.errorDialogVisible;
    var shouldHideDialog = previousViewModel.errorDialogVisible && !newViewModel.errorDialogVisible ||
        previousViewModel.successDialogVisible && !newViewModel.successDialogVisible;
    var intentToShowErrorDialog =
        previousViewModel.authFailedMessage.isEmpty && newViewModel.authFailedMessage.isNotEmpty && !previousViewModel.errorDialogVisible;
    var shouldShowSuccessDialog = !previousViewModel.successDialogVisible && newViewModel.successDialogVisible;

    if (shouldShowErrorDialog) {
      _showErrorDialog(newViewModel);
    } else if (shouldShowSuccessDialog) {
      _showSuccessDialog(newViewModel);
    } else if (shouldHideDialog) {
      NavigationHelper.goBack(context: context);
    } else if (intentToShowErrorDialog) {
      _showDialogIntent(newViewModel);
    }
  }
}
