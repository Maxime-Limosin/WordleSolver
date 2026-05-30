cmake_minimum_required(VERSION 3.16)
project(WordleSolver VERSION 0.1 LANGUAGES CXX)

set(CMAKE_CXX_STANDARD 23)
set(CMAKE_CXX_STANDARD_REQUIRED ON)

find_package(Qt6 REQUIRED COMPONENTS Core Quick Core5Compat QuickControls2)
qt_standard_project_setup()

# Suppress Qt6 QML policy warnings
qt_policy(SET QTP0001 NEW)
qt_policy(SET QTP0004 NEW)

qt_add_executable(WordleSolver
    main.cpp
    src/Controllers/solvercontroller.h
    src/Controllers/solvercontroller.cpp
    src/Model/indexedLetter.h
    src/Model/solver.h
    src/Model/solver.cpp
    src/Model/entropycalculator.h
    src/Model/entropycalculator.cpp
)

qt_add_qml_module(WordleSolver
    URI WordleSolver
    VERSION 1.0
    QML_FILES
        src/qml/Main.qml
        src/qml/AppBackground.qml
        src/qml/Elements/GlassPanel.qml
        src/qml/Elements/LetterField.qml
        src/qml/Elements/WBusyIndicator.qml
        src/qml/Elements/WText.qml
        src/qml/Panels/GameAnswers.qml
        src/qml/Panels/GuessedLetters.qml
        src/qml/Panels/IncorrectLetters.qml
        src/qml/Panels/SolvedLetters.qml
        src/qml/Panels/WKeyboard.qml
    RESOURCES
        src/qml/Theme.js
)

qt_add_resources(WordleSolver "app_resources"
    PREFIX "/"
    FILES
        res/dictionnary_en_5_letters.txt
        res/background.png
        res/Icons/icon.png
        res/Icons/icon2Raw.png
        res/Icons/iconRaw.png
)

target_link_libraries(WordleSolver
    PRIVATE
        Qt6::Core
        Qt6::Quick
        Qt6::Core5Compat
        Qt6::QuickControls2
)

set_target_properties(WordleSolver PROPERTIES
    WIN32_EXECUTABLE TRUE
)

install(TARGETS WordleSolver
    BUNDLE DESTINATION .
    LIBRARY DESTINATION ${CMAKE_INSTALL_LIBDIR}
)
