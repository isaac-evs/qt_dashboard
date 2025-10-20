# QT Dashboard - System Monitoring Dashboard

A minimalist and user-friendly system monitoring dashboard built with Qt6 and QML.

## Screenshot
[screenshot.png]

## Features

- **EC2 Disk Storage Dashboard** - Monitor disk storage across EC2 instances with:
  - Overview cards showing total alerts, instances, disks, and critical alerts
  - Top 5 servers by alert count
  - Interactive scatter plot of disk usage over time
  - Pie chart showing alerts by environment
  - Donut chart showing traffic by region
  - Timeline chart of critical alerts over the last 24 hours

## Requirements

- Qt 6.x
- CMake 3.16 or higher
- C++17 compatible compiler

### Required Qt Modules

- Qt6::Core
- Qt6::Quick
- Qt6::Qml
- Qt6::Core5Compat (for graphical effects)

## Building the Project

### Linux

```bash
# Create build directory
mkdir build
cd build

# Configure with CMake
cmake ..

# Build
cmake --build .

# Run
./qt_dashboard
```

### Alternative: Using Qt Creator

1. Open `CMakeLists.txt` in Qt Creator
2. Configure the project with your Qt6 kit
3. Build and run

## Project Structure

```
qt_dashboard/
├── CMakeLists.txt          # Build configuration
├── main.cpp                # Application entry point
├── Main.qml                # Main window with navigation
├── EC2DiskStorage.qml      # EC2 Disk Storage dashboard
├── OverviewCard.qml        # Reusable card component
├── TopServersList.qml      # Top servers list component
├── ScatterPlot.qml         # Scatter plot chart component
├── PieChart.qml            # Pie chart component
├── DonutChart.qml          # Donut chart component
└── TimelineChart.qml       # Timeline bar chart component
```

## Design Philosophy

- **Minimalist**: Clean, uncluttered interface with purposeful use of color
- **User-Friendly**: Intuitive navigation and clear data visualization
- **Efficient**: Optimized layout for quick insights
- **Responsive**: Proper spacing and scaling for different screen sizes

## Current Implementation

This is the **frontend UI only** with static, hard-coded data. The goal is to perfect the UI structure and layout before backend integration.

### Features Implemented

- ✅ Left navigation sidebar with dashboard selection
- ✅ EC2 Disk Storage dashboard with all components
- ✅ Overview cards (Total Alerts, Instances, Disks, Critical Alerts)
- ✅ Top 5 servers by alert count list
- ✅ Interactive scatter plot with instance and disk dropdowns
- ✅ Pie chart for alerts by environment
- ✅ Donut chart for traffic by region
- ✅ Timeline chart for critical alerts

### Future Dashboards (Placeholders)

- Network Latency
- CPU Usage

## Color Palette

The dashboard uses a restrained color palette where colors convey meaning:

- **Red (#e53935)**: Critical alerts and danger zones
- **Orange (#f57c00)**: Warnings and medium priority
- **Blue (#2196f3)**: Normal status and informational
- **Green (#4caf50)**: Safe zones and success states
- **Gray (#757575, #2c3e50)**: Text and neutral elements

## Customization

All data is currently hard-coded in the QML files. To customize:

- **Overview Cards**: Edit values in `EC2DiskStorage.qml`
- **Server List**: Modify `serversModel` in `TopServersList.qml`
- **Charts Data**: Update data arrays in respective chart components

## License

This project is for demonstration purposes.
