DNDDiceThingy
-------------

DNDDiceThingy is a Flutter application designed to help Dungeons & Dragons players calculate the probability of rolling a specific target number or higher on various dice types, taking into account advantage, disadvantage, and single rolls.

Table of Contents
-----------------

- [Features](/search/I-created-a-T_qMCBjTSOaxIoZjd4Q.nw#features)
- [Releases](/search/I-created-a-T_qMCBjTSOaxIoZjd4Q.nw#releases)
- [Getting Started](/search/I-created-a-T_qMCBjTSOaxIoZjd4Q.nw#getting-started)
- [Usage](/search/I-created-a-T_qMCBjTSOaxIoZjd4Q.nw#usage)
- [Contributing](/search/I-created-a-T_qMCBjTSOaxIoZjd4Q.nw#contributing)
- [License](/search/I-created-a-T_qMCBjTSOaxIoZjd4Q.nw#license)

Features
--------

- Select dice type from d4 to d100
- Enter custom non-standard dice types
- Enter the target Difficulty Class (DC)
- Add modifiers to the roll
- Choose between advantage (rolling two dice and taking the higher roll), disadvantage (rolling two dice and taking the lower roll), or a single roll
- Calculate and display the probability of rolling the DC or higher

Releases
--------

You can download the latest release of DNDDiceThingy for your platform from the [Releases](https://github.com/KleinerCodeDrago/DNDDiceThingy/releases) page on GitHub.

Available platforms:

- Android (APK)
- Linux (tar.gz)
- Windows (zip)

To install and run the application:

- **Android**: Enable installation from unknown sources in your device settings, then download and install the APK file.
- **Linux**: Extract the tar.gz file and run the executable inside the extracted directory.
- **Windows**: Download the zip file and run the executable in it as an administrator. Note that you need to have the Visual C++ Redistributable installed on your system to run the Windows release. If you encounter an error about missing DLL files, please download and install the Visual C++ Redistributable from the [Microsoft website](https://support.microsoft.com/en-us/help/2977003/the-latest-supported-visual-c-downloads).

Note: The releases are automatically generated using GitHub Actions whenever a new tag is pushed to the repository. This ensures that you always have access to the latest version of the application.

Getting Started
---------------

To run the DNDDiceThingy application on your local machine, follow these steps:

1. Ensure you have Flutter installed on your system. You can find the installation instructions for your operating system on the [Flutter website](https://flutter.dev/docs/get-started/install).
2. Clone the repository or download the source code.
3. Open the project in your preferred IDE or text editor.
4. Run the application using the following command in the terminal:

```
flutter run
```

This will launch the application on your connected device or emulator.

Usage
-----

1. Upon launching the application, you will see the main screen with various input fields and controls.
2. Select the dice type you want to use from the dropdown menu (e.g., d20, d6, d100).
3. To use a non-standard dice type, click the "Non-standard Dice" button and enter the number of sides in the text field.
4. Enter the target Difficulty Class (DC) in the provided text field. If you enter an invalid DC value, an error message will be displayed.
5. Enter any modifiers to the roll in the "Modifier" text field. If you enter an invalid modifier value, an error message will be displayed.
6. Choose whether you want to roll with advantage, disadvantage, or a single roll by toggling the respective switch.
7. The calculated probability of rolling the DC or higher based on your input will be displayed at the bottom of the screen.

Contributing
------------

Contributions to DNDDiceThingy are welcome! If you find any issues or have suggestions for improvements, please open an issue or submit a pull request on the project's GitHub repository.

To contribute to the project:

1. Fork the repository and clone it to your local machine.
2. Create a new branch for your feature or bug fix.
3. Make your changes and ensure that the code passes all tests.
4. Submit a pull request describing your changes and referencing any relevant issues.

Please follow the existing code style and conventions used in the project. If you have any questions or need assistance, feel free to reach out to the maintainers.

License
-------

DNDDiceThingy is released under the [MIT License](https://opensource.org/licenses/MIT). And here's the issue you can create on GitHub:
