# Project settings
PROJECT_NAME := quickey
SCHEME := $(PROJECT_NAME)
CONFIGURATION := Debug
SDK := macosx
BUILD_DIR := build
DERIVED_DATA := $(PWD)/DerivedData

# Targets
.PHONY: all clean build archive run

# Default target
all: build

# Build the project
build:
	xcodebuild \
		-project $(PROJECT_NAME).xcodeproj \
		-scheme $(SCHEME) \
		-configuration $(CONFIGURATION) \
		-sdk $(SDK) \
		-derivedDataPath $(DERIVED_DATA) \
		clean build \
		CONFIGURATION_BUILD_DIR=$(BUILD_DIR)

# Archive (for distribution)
archive:
	xcodebuild \
		-project $(PROJECT_NAME).xcodeproj \
		-scheme $(SCHEME) \
		-configuration Release \
		-sdk $(SDK) \
		-derivedDataPath $(DERIVED_DATA) \
		archive \
		-archivePath $(BUILD_DIR)/$(PROJECT_NAME).xcarchive

# Run the built app
run: build
	open $(BUILD_DIR)/$(PROJECT_NAME).app

# Clean build artifacts
clean:
	xcodebuild -project $(PROJECT_NAME).xcodeproj -scheme $(SCHEME) clean
	rm -rf $(BUILD_DIR)
	rm -rf $(DERIVED_DATA)

