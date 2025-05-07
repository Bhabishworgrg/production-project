# Changelog

All notable changes to this project will be documented in this file.

The format is based on [Keep a Changelog](https://keepachangelog.com/en/1.0.0/),
and this project adheres to [Semantic Versioning](https://semver.org/spec/v2.0.0.html).

## [v0.1.0-alpha.1] - 2025-03-15

### Added
- Player character with gravity and collision detection.
- Basic player movement (walking, jumping).
- State machine for each player state (idle, walk, jump, fall, land).
- Initial level scene with platform and player.
- Level completion trigger area.
- Death zone for death scene trigger.

## [v0.1.0-alpha.2] - 2025-03-16

### Added
- Suppressed unnecessary warnings.
- Relevant log messages for debugging.

### Changed
- Project directory structure.
- Death screen to be preloaded on game start.
- Made level complete scene reference immutable.
- Exported player properties for easier tweaking.

### Fixed
- Unstable state transitions on landing.
- Inability to change direction mid-air.

## [v0.1.0-beta.1] - 2025-03-17

### Changed
- Added more detailed error logs.
- Test levels for player movement and area triggers.

### Fixed
- Minor bug fixes.

## [v0.1.0] - 2025-03-17

### Changed
- Adjusted game window to 1920x1080.
- Set window mode to fullscreen.
- Improved UI for death and completion screens.

## [v0.2.0-alpha.1] - 2025-03-30

### Added
- Background removal using the rembg dependency.
- Texture generation for the player and platforms.
- Collision shape generation for the player and platforms.

### Changed
- Placeholder textures for player and platforms to user generated textures.
- Placeholder collision shapes for player and platforms to user generated collision shapes.

## [v0.2.0-alpha.2] - 2025-03-30

### Changed
- Order of nodes in the scene tree.

### Removed
- Usage of rembg.

### Fixed
- Alignment of collision shapes with textures.

## [v0.2.0-alpha.3] - 2025-03-31

### Added
- Resized platform resolution to 1920x1200.

### Changed
- Player collision shape to a capsule, improving movement smoothness.

### Fixed
- Collision inconsistencies in between player and platform.

## [v0.2.0-alpha.4] - 2025-04-08

### Added
- Collision shape generation in segments for improved performance. 

### Changed
- Lower white threshold range in background removal algorithm.

### Fixed
- Collision shape and texture not loading in exported game state.

## [v0.2.0-alpha.5] - 2025-04-08

### Added
- Skimage filters for edge detection and dynamic threshold calculation  

### Changed
- Background removal algorithm to Sobel edge detection + Otsu's thresholding.

## [v0.2.0-beta.1] - 2025-04-10

### Added
- Exported segment count for collision shape generation.

### Changed
- Player collision shape's size datatype to float for better precision.
- Improved sobel edge detection algorithm.

## [v0.2.0] - 2025-04-10

### Added
- Tests for background removal, texture generation, and collision shape generation.

### Changed
- Environment rendering colour to white.
- Segment count to 200 for platform collision shape generation.

## [v0.3.0-alpha.1] - 2025-04-12

### Added
- Import screen for image file paths.
- File dialogs for completing image paths.
- Subprocess call for image processing.
- Scene change to game scene after image processing.

## [v0.3.0-alpha.2] - 2025-04-14

### Added
- Player import functionality in the import screen.

### Changed
- Main scene to import screen.

### Fixed
- Image processing output path issue.

## [v0.3.0-beta.1] - 2025-04-14

### Added
- Logging and error checks for image processing.

### Changed
- Optimized Python subprocess calls and refactoring.

### Removed
- Image processing previews.

### Fixed
- Inoperative error log on process start failure.

## [v0.3.0] - 2025-04-17

### Changed
- Refactor the codebase to maintain consistency and readability.
- Modularize image processing code.

## [v0.3.1] - 2025-04-26

### Added
- Camera capture feature as a substitute for image import.
- Color thresholding and Edge detection (without fill) algorithm.
- Option to select image processing algorithm via UI.
- Keyboard navigation in the import screen.

### Changed
- Normal buttons to texture buttons in the import screen.

### Fixed
- Keypress handling issues in the camera screen.

## [v0.4.0-alpha.1] - 2025-04-26

### Changed
- Redefine instance variables.
- Turn all scripts to modular classes.

## [v0.4.0-alpha.2] - 2025-04-26

### Added
- Standard output logging of python subprocess calls.

### Fixed
- Color thresholding algorithm.
- Path field filling on exiting the camera feed.

## [v0.4.0-alpha.3] - 2025-04-27

### Added
- Editor screen with toolbar and viewport.
- Drag-and-drop functionality for player in the editor.
- Main menu with load, create, play demo and exit options.

### Changed
- Window mode to unresizable windowed.
- Main menu to be the first screen.

### Fixed
- Loading image file warning.

## [v0.4.0-alpha.4] - 2025-04-28

### Added
- Area completed draggable object.
- Viewport camera movement with mouse.

### Changed
- Generate button to navigate to the editor screen.
- Player's draggable functionality to a separate component.

## [v0.4.0-beta.1] - 2025-04-28

### Changed
- New scripts to modular classes.
- Project structure to be more organized.

### Fixed
- Editor scene path.
- Warnings for unused variables and different variable types.
- Viewport camera movement to be smoother.
- Viewport camera movement issues when dragging the player.

# [v0.4.0] - 2025-04-28

### Fixed
- Player disappearing behind platform and area completion object.
- Area completion object not being draggable.

# [v0.5.0-alpha.1] - 2025-04-29

### Added
- Autoload script for global variables.
- Configuration window in the editor.
- Background setting in the editor from config.

# [v0.5.0-alpha.2] - 2025-04-29

### Added
- Getting and setting global variables of the autoload.
- Navigation from editor to game scene.
- Updating of player and area completed object positions in the game scene.
- Updating of background and music in the game scene.

### Changed
- Project structure to be more organized.

### Fixed
- Death zone's and area completion object's sizes.

# [v0.5.0-alpha.3] - 2025-05-07

### Added
- Save and load functionality in the editor.
- Save as functionality in the editor.
- Dynamic filename label in the editor.

### Changed
- Autoload script to sync with save and load functionality.

### Fixed
- File dialogs' titles of the Config window.
