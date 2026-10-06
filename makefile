gen:
	flutter pub run build_runner build --delete-conflicting-outputs

format:
	dart format . --line-length 100

icon:
	flutter pub run flutter_launcher_icons:main
