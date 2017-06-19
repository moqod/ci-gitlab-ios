# iOS CI v0.1

Fail early, fail often => succeed sooner.

## Features

Performs and reports:
* UI Tests
* Unit Tests
* Objective-c Static analysis
* Code Duplicates
* Checking Code Guidelines
* Ensure README is useful
* Ensure .gitignore exists

On the list:
* Build number incrementation
* Deploy on Updraft 2.0

## How it works

Currently we use it on a runner and self-hosted GitLab CE.

### Reports Structure
```
- reports/
    - index.html
    - json/
        - summary.json
    - css/
        - ...
    - clang/
        - index.html
        - json/
            - report.json
        - css/
    - jscpd/
        - ...
    - ui_tests/
        - ...
    - unit_tests/
        - ...
```

Every report has it's own JSON file structure. For example, `jscpd` tool output:
```json
 :)
```

Summary JSON file listed below:
```json
{
    "summary": {
        "project": "MirrorMirror",
        "branch": "Develop",
        "commit": "{commit_hash}",
        "time": "UNIX_TIME",
        "bundle_version": "2.5.3"
    },
    "reports": [{
            "type": "clang",
            "issues_count": 56,
            "files_count": 23,
            "report": "clang/index.html"
        }, {
            "type": "jscpd",
            "percentage": 6.56,
            "files_count": 15,
            "report": "jscpd/index.html"
        }, {
            "type": "tailor",
            "issues_count": 78,
            "files_count": 43,
            "report": "tailor/index.html"
        }, {
            "type": "general",
            "readme_status": "good | very_short | missed",
            "gitignore_exists": "true | false",
            "localization_exists": "true | false"
        }, {
            "type": "ui_tests",
            "tests_count": 3,
            "failed_tests_count": 1,
            "report": "ui_tests/index.html"
        }, {
            "type": "unit_tests",
            "tests_count": 8,
            "failed_tests_count": 0,
            "report": "ui_tests/index.html"
        }
    ]
}
```

## Third Party Tools

jscpd
fastlane
xcodebuild
tailor
xcpretty
