## Release Guide

This file is intended for Clima maintainers.

In this file, any occurrences of `VERSION` are to be replaced with the new release version, and any occurrences of `VERSION_CODE` are to be replaced with the new version code.

To release a new version:

1. In your local Clima clone, create a new branch named `release-VERSION` based on the latest upstream `master` (don't push anything yet, you'll do that later).
2. Bump the Clima version and version code in `pubspec.yaml`, and the Clima version in `lib/constants.dart`.
3. Build and run the app on a real device, to ensure everything is working as expected.
4. Add a changelog for the release to `fastlane/metadata/android/en-US/changelogs/VERSION_CODE.txt`. For instance, if the version code of the release is 10, you will add a `10.txt` file to that directory. Keep in mind that F-Droid limits Fastlane changelogs to a maximum of 500 bytes; anything more than that will be trimmed.
5. Commit all those changes, with a commit message of "Release vVERSION". Note that there's a `v` attached to the actual version.
6. Push the release branch, preferably to https://github.com/Lacerte/clima, not your fork.
7. Create a PR, and discuss/act on the feedback.
8. When the PR is merged into `master`, check out your local `master` and run `git pull`.
9. Run `git tag -e -a vVERSION`, again noting that there is a `v` before the version. This will open up your editor of choice for you to attach release notes to the tag. <!-- TODO: write something about copying the Fastlane changelog here --> Once you're done, save the file and close your editor.
10. Push the newly-created tag to https://github.com/Lacerte/clima. For instance, if you have `upstream` as your Lacerte remote, run `git push upstream vVersion`.
<!-- TODO: mention what to do about F-Droid -->
