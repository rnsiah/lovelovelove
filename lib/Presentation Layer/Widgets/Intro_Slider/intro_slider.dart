import 'package:flutter/material.dart';
import 'package:intro_slider/intro_slider.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:lovelovelove/Data%20Layer/Blocs/validationCubit.dart';
import 'package:lovelovelove/Data%20Layer/Repositories/user_repository.dart';

class IntroductionSlider extends StatefulWidget {
  IntroductionSlider({
    Key? key,
  }) : super(key: key);

  @override
  State<IntroductionSlider> createState() => _IntroductionSliderState();
}

class _IntroductionSliderState extends State<IntroductionSlider> {
  List<ContentConfig> slides = [];
  late Function goToTab;
  UserRepository userRepository = UserRepository();

  @override
  void initState() {
    super.initState();
    slides.add(const ContentConfig(
      pathImage: 'images/Altrue Logo White.png',
      centerWidget: Text(
        'With Altrue, Give in a new Way',
        style: TextStyle(color: Colors.amber),
      ),
      title: 'Welcome',
      description: 'With Atrue, Give in a new Way',
      styleDescription: TextStyle(color: Colors.amber, fontSize: 16),
      maxLineTitle: 2,
      backgroundColor: Color(0xfff5a623),
      styleTitle: TextStyle(
          color: Colors.white, fontSize: 40, fontWeight: FontWeight.bold),
    ));
    slides.add(const ContentConfig(
        pathImage: 'images/Altrue Logo White.png',
        description: 'With Atrue, Give in a new Way',
        styleDescription: TextStyle(color: Colors.amber, fontSize: 16),
        title: 'Learn',
        maxLineTitle: 2,
        styleTitle: TextStyle(
            color: Colors.white, fontSize: 40, fontWeight: FontWeight.bold),
        backgroundColor: Colors.black));
    slides.add(const ContentConfig(
        pathImage: 'images/Altrue Logo White.png',
        title: 'Do Something',
        description: 'With Atrue, Give in a new Way',
        styleDescription: TextStyle(color: Colors.amber, fontSize: 16),
        maxLineTitle: 2,
        styleTitle: TextStyle(
            color: Colors.white, fontSize: 40, fontWeight: FontWeight.bold),
        backgroundColor: Colors.black));
    slides.add(const ContentConfig(
        pathImage: 'images/Altrue Logo White.png',
        description: 'With Atrue, Give in a new Way',
        styleDescription: TextStyle(color: Colors.amber, fontSize: 16),
        title: 'Get Rewarded',
        maxLineTitle: 2,
        styleTitle: TextStyle(
            color: Colors.white, fontSize: 40, fontWeight: FontWeight.bold),
        backgroundColor: Colors.black));
  }

  onDonePress() {
    goToTab(1);
  }

  void onTabChangeCompleted(index) {
    print(index);
  }

  Widget nextBtn() {
    return const Icon(
      Icons.navigate_next,
      color: Colors.white,
      size: 35,
    );
  }

  Widget doneBtn(BuildContext context) {
    return IconButton(
        icon: const Icon(
          Icons.done,
          color: Colors.green,
          size: 35,
        ),
        onPressed: () => Navigator.of(context).popAndPushNamed('/signUp'));
  }

  Widget skipBtn() {
    return const Icon(
      Icons.skip_next,
      color: Colors.amber,
      size: 35,
    );
  }

  ButtonStyle myButtonStyle() {
    return ButtonStyle(
      shape: MaterialStateProperty.all<OutlinedBorder>(const StadiumBorder()),
      backgroundColor: MaterialStateProperty.all<Color>(Colors.amber),
      overlayColor: MaterialStateProperty.all<Color>(Colors.amber),
    );
  }

  List<Widget> renderTabList() {
    List<Widget> tabs = [];
    for (int i = 0; i < slides.length; i++) {
      ContentConfig current = slides[i];
      tabs.add(SizedBox(
        width: double.infinity,
        height: double.infinity,
        child: Container(
          margin: const EdgeInsets.only(bottom: 160, top: 60),
          child: ListView(
            children: [
              GestureDetector(
                child: Image.asset(
                  current.pathImage!,
                  width: 200,
                  height: 200,
                  fit: BoxFit.contain,
                ),
              ),
              Container(
                margin: const EdgeInsets.only(top: 20),
                child: Text(
                  current.title!,
                  style: current.styleTitle,
                  textAlign: TextAlign.center,
                ),
              ),
              Text(
                current.description!,
                style: current.styleDescription,
                textAlign: TextAlign.center,
                maxLines: 5,
                overflow: TextOverflow.ellipsis,
              )
            ],
          ),
        ),
      ));
    }
    return tabs;
  }

  @override
  Widget build(BuildContext context) {
    return IntroSlider(
      renderSkipBtn: skipBtn(),
      skipButtonStyle: myButtonStyle(),
      renderNextBtn: nextBtn(),
      nextButtonStyle: myButtonStyle(),
      renderDoneBtn: doneBtn(context),
      doneButtonStyle: myButtonStyle(),
      listCustomTabs: renderTabList(),
      refFuncGoToTab: (refFunc) {
        goToTab = refFunc;
      },
      onDonePress: () {
        context.read<ValidationCubit>().showSignUp();
        userRepository.introDone();
      },
      scrollPhysics: const BouncingScrollPhysics(),
      onTabChangeCompleted: onTabChangeCompleted,
    );
  }
}
