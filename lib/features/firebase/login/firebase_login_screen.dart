import 'package:flat_and_fast/common/controls/dialogs/information_dialog.dart';
import 'package:flat_and_fast/common/controls/loading/loading_page.dart';
import 'package:flat_and_fast/common/navigation/navigation_helper.dart';
import 'package:flat_and_fast/common/redux/app/app_state.dart';
import 'package:flat_and_fast/common/utils/styles/app_colors.dart';
import 'package:flat_and_fast/features/firebase/home/firebase_home_screen.dart';
import 'package:flat_and_fast/features/firebase/login/redux/firebase_login_view_model.dart';
import 'package:flat_and_fast/features/firebase/sign_up/firebase_sign_up_screen.dart';
import 'package:flat_and_fast/features/firebase/utils/styles/firebase_colors.dart';
import 'package:flat_and_fast/features/firebase/utils/styles/firebase_dimensions.dart';
import 'package:flat_and_fast/features/firebase/utils/styles/firebase_localization.dart';
import 'package:flat_and_fast/gen/assets.gen.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

import '../../../common/controls/cards/tinder/tinder_button.dart';

class FirebaseLoginScreen extends StatefulWidget {
  const FirebaseLoginScreen({Key? key}) : super(key: key);

  @override
  State<StatefulWidget> createState() => _FirebaseLoginScreenState();
}

class _FirebaseLoginScreenState extends State<FirebaseLoginScreen> {
  final emailController = TextEditingController();
  final passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return StoreConnector<AppState, FirebaseLoginViewModel>(
      onWillChange: _stateWillChange,
      converter: (store) {
        return FirebaseLoginViewModel.fromStore(store);
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
                      child: Image.asset(Assets.images.purchases.path),
                    ),
                    Builder(builder: (context) {
                      if (viewModel.isLoading) {
                        return SizedBox(
                          width: width,
                          height: height * (1 - FirebaseDimensions.imageHeightCoefficient),
                          child: const LoadingPage(),
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
                                      FirebaseLocalization.loginText,
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
                                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                    children: [
                                      Expanded(
                                        flex: 2,
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
                                      TinderButton(
                                        elevation: 2.0,
                                        buttonSize: 40.0,
                                        iconSize: 40.0,
                                        buttonBorder: 0.0,
                                        positiveColor: AppColors.white,
                                        icon: FontAwesomeIcons.google,
                                        action: () => viewModel.googleLogin(
                                          () => NavigationHelper.goToWidget(
                                            widget: const FirebaseHomeScreen(),
                                            context: context,
                                          ),
                                        ),
                                        negativeColor: AppColors.froly,
                                      ),
                                      const SizedBox(width: 12.0),
                                      Expanded(
                                        flex: 5,
                                        child: ElevatedButton(
                                          child: const Text(
                                            FirebaseLocalization.loginText,
                                            style: TextStyle(
                                              fontSize: FirebaseDimensions.loginButtonFontSize,
                                              fontWeight: FontWeight.normal,
                                              color: FirebaseColors.loginButtonTextColor,
                                            ),
                                          ),
                                          onPressed: () => viewModel.login(
                                            emailController.text,
                                            passwordController.text,
                                            () => NavigationHelper.goToWidget(
                                              widget: const FirebaseHomeScreen(),
                                              context: context,
                                            ),
                                          ),
                                          style: ElevatedButton.styleFrom(
                                            onPrimary: FirebaseColors.backButtonColor,
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          ),
                          const SizedBox(height: FirebaseDimensions.passwordTopPadding),
                          GestureDetector(
                            onTap: () => viewModel.navigateToSignUp(
                              () => NavigationHelper.goToWidget(
                                widget: const FirebaseSignUpScreen(),
                                context: context,
                              ),
                            ),
                            child: const Text.rich(
                              TextSpan(text: '${FirebaseLocalization.haveNotAccountText} ', children: [
                                TextSpan(
                                  text: FirebaseLocalization.signUpText,
                                  style: TextStyle(color: FirebaseColors.loginButtonColor),
                                ),
                              ]),
                            ),
                          ),
                          const SizedBox(height: FirebaseDimensions.passwordTopPadding),
                          GestureDetector(
                            onTap: () => NavigationHelper.goToWidget(
                                widget: const FirebaseHomeScreen(),
                                context: context,
                              ),
                            child: const Text.rich(
                              TextSpan(
                                text: 'Debug login ',
                                style: TextStyle(color: FirebaseColors.loginButtonColor),
                              ),
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

  _showDialog(FirebaseLoginViewModel viewModel) {
    showDialog<void>(
        barrierColor: AppColors.transparent,
        context: context,
        builder: (context) {
          return InformationDialog(
            dismissAction: () => _dismissDialogIntent(viewModel),
            message: viewModel.loginFailedMessage,
            title: FirebaseLocalization.errorTitle,
          );
        });
  }

  _dismissDialogIntent(FirebaseLoginViewModel viewModel) {
    viewModel.dismissDialog();
  }

  _showDialogIntent(FirebaseLoginViewModel viewModel) {
    viewModel.showErrorDialog();
  }

  _stateWillChange(
    FirebaseLoginViewModel? previousViewModel,
    FirebaseLoginViewModel newViewModel,
  ) {
    if (previousViewModel == null) return;

    var shouldShowDialog = !previousViewModel.errorDialogVisible && newViewModel.errorDialogVisible;
    var shouldHideDialog = previousViewModel.errorDialogVisible && !newViewModel.errorDialogVisible;
    var intentToShowDialog =
        previousViewModel.loginFailedMessage.isEmpty && newViewModel.loginFailedMessage.isNotEmpty && !previousViewModel.errorDialogVisible;

    if (shouldShowDialog) {
      _showDialog(newViewModel);
    } else if (shouldHideDialog) {
      Navigator.pop(context);
    } else if (intentToShowDialog) {
      _showDialogIntent(newViewModel);
    }

    if (!previousViewModel.isAuthorized && newViewModel.isAuthorized) {
      newViewModel.updateGlobalAuthState();
    }
  }
}
