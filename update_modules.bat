@echo off
setlocal enabledelayedexpansion

REM Store the original directory
set "ORIGINAL_DIR=%cd%"

REM Check if the fluent directory exists
if not exist ".\include\fluent\" (
    echo Error: Directory .\include\fluent does not exist
    exit /b 1
)

REM Iterate through subdirectories in .\include\fluent
for /d %%D in (.\include\fluent\*) do (
    if exist "%%D" (
        echo Processing %%D...
        pushd "%%D"

        REM Execute git commands
        git fetch
        git pull origin master
        if errorlevel 1 (
            echo Git operations failed in %%D
            popd
            exit /b 1
        )

        popd
    )
)

REM After processing all subdirectories, perform final git commands
echo Committing changes in main repository...
git add .
git commit -m "Sync submodules"
if errorlevel 1 (
    echo Final git commit failed
    exit /b 1
)

git push origin master
echo All operations completed successfully
