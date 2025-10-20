#!/bin/bash

# Simple build script for qt_dashboard

set -e

echo "==================================="
echo "Building QT Dashboard"
echo "==================================="

# Create build directory if it doesn't exist
if [ ! -d "build" ]; then
    echo "Creating build directory..."
    mkdir build
fi

cd build

echo "Running CMake configuration..."
cmake ..

echo "Building project..."
cmake --build .

echo ""
echo "==================================="
echo "Build completed successfully!"
echo "==================================="
echo ""
echo "To run the application:"
echo "  cd build && ./qt_dashboard"
echo ""
