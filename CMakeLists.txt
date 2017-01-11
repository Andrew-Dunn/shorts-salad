# Basic CMake Build Config for building Swift projects.
cmake_minimum_required(VERSION 3.5)
project(shorts_salad)

file(GLOB_RECURSE shorts_salad_SRCS
                  ${CMAKE_SOURCE_DIR}/Sources/*.swift)

message("CMAKE SOURCE DIR: " ${CMAKE_SOURCE_DIR})
message("SWIFT FILES: " ${shorts_salad_SRCS})

add_custom_target(swift-compile ALL
        COMMAND /usr/bin/swift build
        WORKING_DIRECTORY ${CMAKE_SOURCE_DIR}
        SOURCES Package.swift
                ${shorts_salad_SRCS})