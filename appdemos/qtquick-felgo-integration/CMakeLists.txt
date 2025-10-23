cmake_minimum_required(VERSION 3.16)

project(qtqtuick-felgo-integration VERSION 0.1 LANGUAGES CXX)

set(CMAKE_AUTOMOC ON)
set(CMAKE_CXX_STANDARD_REQUIRED ON)

find_package(Felgo REQUIRED)

# Project identifier and version
# More information: https://felgo.com/doc/felgo-publishing/#project-configuration
set(PRODUCT_IDENTIFIER "com.felgo.demos.qtquickfelgo")
set(PRODUCT_VERSION_NAME "1.0.0")
set(PRODUCT_VERSION_CODE 1)

# Add Felgo Amplitude plugin
set(FELGO_PLUGINS amplitude)

# Executable should have same name as project
qt_add_executable(appQtQuickFelgoIntegration
    main.cpp
)

felgo_configure_executable(appQtQuickFelgoIntegration)

# Add QML files and resources to QML module to included them via QRC automatically:
qt_add_qml_module(appQtQuickFelgoIntegration
    URI QtQuickFelgoIntegration
    VERSION 1.0
    QML_FILES qml/main.qml
    NO_RESOURCE_TARGET_PATH # skip the "qtqtuick-felgo-integration" subfolder in QRC
)

target_compile_definitions(appQtQuickFelgoIntegration
    PRIVATE $<$<OR:$<CONFIG:Debug>,$<CONFIG:RelWithDebInfo>>:QT_QML_DEBUG>)

target_link_libraries(appQtQuickFelgoIntegration PRIVATE Felgo)

# uncomment this line to add Felgo Hot Reload and use hot reloading with your custom C++ code
# for the remaining steps see here: https://felgo.com/custom-code-reload-app/
# find_package(FelgoHotReload REQUIRED)
# target_link_libraries(appPropertyCross PRIVATE FelgoHotReload)
