cmake_minimum_required(VERSION 3.16)

project(qt_dashboard VERSION 1.0.0 LANGUAGES CXX)

set(CMAKE_CXX_STANDARD 17)
set(CMAKE_CXX_STANDARD_REQUIRED ON)

set(CMAKE_AUTOMOC ON)
set(CMAKE_AUTORCC ON)
set(CMAKE_AUTOUIC ON)

find_package(Qt6 REQUIRED COMPONENTS Core Quick Qml)

qt_add_executable(qt_dashboard
    main.cpp
)

qt_add_qml_module(qt_dashboard
    URI Dashboard
    VERSION 1.0
    QML_FILES
        Main.qml
        EC2DiskStorage.qml
        OverviewCard.qml
        TopServersList.qml
        ScatterPlot.qml
        PieChart.qml
        DonutChart.qml
        TimelineChart.qml
)

target_link_libraries(qt_dashboard PRIVATE
    Qt6::Core
    Qt6::Quick
    Qt6::Qml
)

set_target_properties(qt_dashboard PROPERTIES
    WIN32_EXECUTABLE ON
    MACOSX_BUNDLE ON
)
