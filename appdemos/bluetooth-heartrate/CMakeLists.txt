cmake_minimum_required(VERSION 3.16)

project(bluetooth-heartrate VERSION 0.1 LANGUAGES CXX)

set(CMAKE_AUTOMOC ON)
set(CMAKE_CXX_STANDARD_REQUIRED ON)

find_package(Felgo REQUIRED)

# Project identifier and version
# More information: https://felgo.com/doc/felgo-publishing/#project-configuration
set(PRODUCT_IDENTIFIER "com.felgo.demos.apps.bluetoothheartrate")
set(PRODUCT_VERSION_NAME "1.0.0")
set(PRODUCT_VERSION_CODE 1)

# Set either "test" or "publish" stage:
set(PRODUCT_STAGE "test")

# Optionally set a license key that is used instead of the license key from
# main.qml file (App::licenseKey for your app or GameWindow::licenseKey for your game)
# Only used for local builds and Felgo Cloud Builds (https://felgo.com/cloud-builds)
# Not used if using Felgo Live
set(PRODUCT_LICENSE_KEY "")

# Find all QML/JS files for the QML compiler:
file(GLOB_RECURSE QmlFiles RELATIVE ${CMAKE_CURRENT_SOURCE_DIR} qml/*.qml qml/*.js)

# Find all non-QML/JS files in the qml and assets folder to add as resources:
file(GLOB_RECURSE AssetsFiles RELATIVE ${CMAKE_CURRENT_SOURCE_DIR} assets/* qml/*)
list(REMOVE_ITEM AssetsFiles ${QmlFiles})

# Executable should have same name as project
qt_add_executable(appBluetoothHeartrate
    main.cpp
    ${QmlFiles}
    ${AssetsFiles}
)

felgo_configure_executable(appBluetoothHeartrate)

# Deploy resources to build folder/package directly
# comment for publishing
deploy_resources("${QmlFiles};${AssetsFiles}")

# Add QML files and resources to QML module to included them via QRC automatically:
qt_add_qml_module(appBluetoothHeartrate
    URI BluetoothHeartrate
    VERSION 1.0
# uncomment for publishing:
#    QML_FILES ${QmlFiles}
#    RESOURCES ${AssetsFiles}
    NO_RESOURCE_TARGET_PATH
)

# Add plist file on MacOS to add bluetooth usage description:
if(CMAKE_SYSTEM_NAME STREQUAL "Darwin")
    set_target_properties(appBluetoothHeartrate
        PROPERTIES MACOSX_BUNDLE_INFO_PLIST "${CMAKE_CURRENT_SOURCE_DIR}/macx/Info.plist")

    target_sources(appBluetoothHeartrate PRIVATE "${CMAKE_CURRENT_SOURCE_DIR}/macx/Info.plist")
endif()

# NOTE: for PUBLISHING, perform the following steps:
# 1. comment the deploy_resources line above, to avoid shipping your qml files with the application (instead they get compiled to the app binary)
# 2. uncomment the QML_FILES and RESOURCES above; this compiles your qml files and js files to the app binary and protects your source code
# 3. change the setMainQmlFile() call in main.cpp to the one starting with "qrc:/" - this loads the qml files from the resources
# for more details see the "Deployment Guides" in the Felgo Documentation

# during development, use the deploy_resources because you then get shorter compilation times (the qml files do not need to be compiled to the binary but are just copied)
# also, for quickest deployment on Desktop disable the "Shadow Build" option in Projects/Builds - you can then select "Run Without Deployment" from the Build menu in Qt Creator if you only changed QML files; this speeds up application start, because your app is not copied & re-compiled but just re-interpreted

target_compile_definitions(appBluetoothHeartrate
    PRIVATE $<$<OR:$<CONFIG:Debug>,$<CONFIG:RelWithDebInfo>>:QT_QML_DEBUG>)

target_link_libraries(appBluetoothHeartrate PRIVATE Felgo)

# uncomment this line to add the Live Client Module and use live reloading with your custom C++ code
# for the remaining steps to build a custom Live Code Reload app see here: https://felgo.com/custom-code-reload-app/
#find_package(FelgoLive REQUIRED)
#target_link_libraries(appBluetoothHeartrate PRIVATE FelgoLive)
