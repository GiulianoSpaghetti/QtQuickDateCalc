cmake_minimum_required(VERSION 3.14)

project(QtQuickDateCalc LANGUAGES CXX)

set(CMAKE_INCLUDE_CURRENT_DIR ON)

set(CMAKE_AUTOUIC ON)
set(CMAKE_AUTOMOC ON)
set(CMAKE_AUTORCC ON)

set(CMAKE_CXX_STANDARD 11)
set(CMAKE_CXX_STANDARD_REQUIRED ON)

# QtCreator supports the following variables for Android, which are identical to qmake Android variables.
# Check https://doc.qt.io/qt/deployment-android.html for more information.
# They need to be set before the find_package(...) calls below.

#if(ANDROID)
#    set(ANDROID_PACKAGE_SOURCE_DIR "${CMAKE_CURRENT_SOURCE_DIR}/android")
#    if (ANDROID_ABI STREQUAL "armeabi-v7a")
#        set(ANDROID_EXTRA_LIBS
#            ${CMAKE_CURRENT_SOURCE_DIR}/path/to/libcrypto.so
#            ${CMAKE_CURRENT_SOURCE_DIR}/path/to/libssl.so)
#    endif()
#endif()

find_package(QT NAMES Qt6 Qt5 COMPONENTS Core Quick LinguistTools REQUIRED)
find_package(Qt${QT_VERSION_MAJOR} COMPONENTS Core Quick LinguistTools REQUIRED)

set(TS_FILES QtQuickDateCalc_Italian.ts
    QtQuickDateCalc_French.ts
    QtQuickDateCalc_German.ts
    QtQuickDateCalc_Portuguese.ts
    QtQuickDateCalc_Spanish.ts)

set(PROJECT_SOURCES
        main.cpp
        qml.qrc
        ${TS_FILES}
)

if(${QT_VERSION_MAJOR} GREATER_EQUAL 6)
    qt_add_executable(QtQuickDateCalc
        ${PROJECT_SOURCES}
    )

else()
    if(ANDROID)
        add_library(QtQuickDateCalc SHARED
            ${PROJECT_SOURCES}
        )
    else()
        add_executable(QtQuickDateCalc
          ${PROJECT_SOURCES}
        )
    endif()

endif()


add_custom_target(translations DEPENDS ${QM_FILES})
add_dependencies(${CMAKE_PROJECT_NAME} translations)

file(MAKE_DIRECTORY "${CMAKE_CURRENT_BINARY_DIR}/translations")

ADD_CUSTOM_COMMAND(
   TARGET translations POST_BUILD
   COMMAND lrelease
   ARGS    ../*.ts
   )

ADD_CUSTOM_COMMAND(
   TARGET translations POST_BUILD
   COMMAND mv
   ARGS    ../*.qm "${CMAKE_CURRENT_BINARY_DIR}/translations"
   )

 install(PROGRAMS obj-x86_64-linux-gnu/QtQuickDateCalc DESTINATION bin/ )
 install(DIRECTORY obj-x86_64-linux-gnu/translations DESTINATION share/QtQuickDateCalc )
 install(FILES QtQuickDateCalc.desktop DESTINATION share/applications )
 install(FILES QtQuickDateCalc.png DESTINATION share/icons/ )
target_compile_definitions(QtQuickDateCalc
  PRIVATE $<$<OR:$<CONFIG:Debug>,$<CONFIG:RelWithDebInfo>>:QT_QML_DEBUG>)
target_link_libraries(QtQuickDateCalc
  PRIVATE Qt${QT_VERSION_MAJOR}::Core Qt${QT_VERSION_MAJOR}::Quick)
