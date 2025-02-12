!define APP_NAME "Access Database Manager"

# Allow user to choose installation path
InstallDir "$PROGRAMFILES\Access Database Manager"  # Updated default install path

# Show directory selection dialog
ShowInstDetails show
Page directory
Page instfiles

Outfile "AccessDatabaseManagerInstaller.exe"  # Updated output filename

Section "Install"
    # Set output directory to user-selected path
    SetOutPath "$INSTDIR"

    # Copy files to installation directory
    File "loader.exe"
    File "gui.exe"

    # Create Desktop Shortcut
    CreateShortcut "$DESKTOP\Access Database Manager.lnk" "$INSTDIR\loader.exe"

    # Create Start Menu Shortcut
    CreateDirectory "$SMPROGRAMS\Access Database Manager"
    CreateShortcut "$SMPROGRAMS\Access Database Manager\Access Database Manager.lnk" "$INSTDIR\loader.exe"

    # Write uninstaller path (moved inside the Install section)
    WriteUninstaller "$INSTDIR\Uninstall.exe"

    # Check if Python is installed
    ReadRegStr $0 HKLM "Software\Python\PythonCore\3.10\InstallPath" ""
    IfErrors 0 DonePython

    MessageBox MB_YESNO "Python not found! Install it now?" IDNO DonePython
    ExecShell "open" "https://www.python.org/ftp/python/3.10.0/python-3.10.0-amd64.exe"

DonePython:
    Exec "$INSTDIR\loader.exe"
SectionEnd

# Uninstall Section
Section "Uninstall"
    Delete "$INSTDIR\loader.exe"
    Delete "$INSTDIR\gui.exe"
    Delete "$INSTDIR\Uninstall.exe"  # Delete the uninstaller

    # Remove shortcuts
    Delete "$DESKTOP\Access Database Manager.lnk"
    Delete "$SMPROGRAMS\Access Database Manager\Access Database Manager.lnk"

    # Remove Start Menu directory
    RMDir "$SMPROGRAMS\Access Database Manager"

    # Remove install directory if empty
    RMDir "$INSTDIR"
SectionEnd