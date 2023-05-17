#!/usr/bin/env sh

if [ "$(whoami | awk '{print $1}')" != 'root' ]; then
    printf "Please run this script as sudo\n"
    exit 1
fi

update () {
    printf "Updateing Pi\n"
    sudo apt-get update -y
    sudo apt-get upgrade -y


    printf "Installing software\n"
    sudo apt-get install unclutter -y
    sudo apt-get install imagemagick -y
    sudo apt-get install feh -y
    sudo apt-get install git -y
    sudo apt-get install inotify-tools -y
}

panel () {
    printf "Removing Panel\n"
    printf "#@lxpanel --profile LXDE-pi\n@pcmanfm --desktop --profile LXDE-pi\n@xscreensaver -no-splash\n" | sudo tee "/etc/xdg/lxsession/LXDE-pi/autostart"
    printf "#@lxpanel --profile LXDE-pi\n@pcmanfm --desktop --profile LXDE-pi\n@xscreensaver -no-splash\n" | sudo tee "/etc/xdg/lxsession/LXDE/autostart"

    printf "Removing Cursor\n"
    printf "@unclutter -idle 0\n" | sudo tee -a "/etc/xdg/lxsession/LXDE-pi/autostart"
    printf "@unclutter -idle 0\n" | sudo tee -a "/etc/xdg/lxsession/LXDE/autostart"

    printf "Setting Display\n"
    printf "@DISPLAY=:0 xrandr --output HDMI-1 --rotate left\n" | sudo tee -a "/etc/xdg/lxsession/LXDE/autostart"
    printf "@DISPLAY=:0 xrandr --output HDMI-2 --rotate left\n" | sudo tee -a "/etc/xdg/lxsession/LXDE/autostart"
    printf "@DISPLAY=:0 xrandr --output HDMI-1 --rotate left\n" | sudo tee -a "/etc/xdg/lxsession/LXDE-pi/autostart"
    printf "@DISPLAY=:0 xrandr --output HDMI-2 --rotate left\n" | sudo tee -a "/etc/xdg/lxsession/LXDE-pi/autostart"
}

cloneRepo () {
    printf "Cloning Software\n"
    if [ ! -d "/home/$SUDO_USER/missions-display" ]; then
        git clone "https://github.com/raubjo/missions-display.git" "/home/$SUDO_USER/missions-display"
    else
        printf "Folder already exists\n"
    fi
}

installFilebrowser () {
    FB_VER=$(sudo -u "$SUDO_USER" filebrowser version)
    EXP_VER="File Browser v2.23.0/02db83c7"

    if [ "$FB_VER" = "$EXP_VER" ]; then
       echo "Filebrowser already installed"
    else
       sudo -u "$SUDO_USER" curl -fsSL "https://raw.githubusercontent.com/filebrowser/get/master/get.sh" | bash
       mkdir -p "/home/$SUDO_USER/.config/systemd/user"
       mkdir -p "/home/$SUDO_USER/.config/filebrowser"
       cp "filebrowser.service" "/home/$SUDO_USER/.config/systemd/user"
       cp "fb.json" "/home/$SUDO_USER/.config/filebrowser/fb.json"
       cp "filebrowser.db" "/home/$SUDO_USER/.config/filebrowser/filebrowser.db"
       sudo chown "$SUDO_USER:$SUDO_USER" "/home/$SUDO_USER/.config/filebrowser/fb.json"
       sudo chown "$SUDO_USER:$SUDO_USER" "/home/$SUDO_USER/.config/filebrowser/filebrowser.db"
       systemctl daemon-reload
       systemctl --user start filebrowser.service
       systemctl --user enable filebrowser.service
    fi


}

watchFolder () {
    inotifywait -mre close_write "/home/$SUDO_USER/letters" && "export NEW_LETTERS=True"
}

installCrons () {
    printf "Installing Automatic Services\n"

    # Re-convert all pdf files in /home/user/letters at midnight every night
    printf "0 0 * * * user /home/user/missions-display/scripts/convert.sh\n" | sudo tee "/etc/cron.d/convert"

    # Screen On
    # 9:45am Sunday
    printf "45 8 * * 0 user /home/user/missions-display/scripts/screen_on.sh\n" | sudo tee "/etc/cron.d/screen_on"
    # 5:15pm Sunday
    printf "15 17 * * 0 user /home/user/missions-display/scripts/screen_on.sh\n" | sudo tee -a "/etc/cron.d/screen_on"
    # 6:45pm Wednesday
    printf "45 18 * * 3 user /home/user/missions-display/scripts/screen_on.sh\n" | sudo tee -a "/etc/cron.d/screen_on"

    # Screen Off
    # 1:00pm Sunday
    printf "0 13 * * 3 user /home/user/missions-display/scripts/screen_off.sh\n" | sudo tee "/etc/cron.d/screen_off"
    # 7:30pm Sunday
    printf "30 19 * * 3 user /home/user/missions-display/scripts/screen_off.sh\n" | sudo tee -a "/etc/cron.d/screen_off"
    # 9:00pm Wednesday
    printf "00 21 * * 3 user /home/user/missions-display/scripts/screen_off.sh\n" | sudo tee -a "/etc/cron.d/screen_off"
}

fullInstall () {
    update
    panel
    cloneRepo
    installFilebrowser
    installCrons
}



case "$1" in
    -u|--update)
        update
        ;;
    -p|--panel)
        panel
        ;;
    -c|--install-crons)
        installCrons
        ;;
    -r|--repo)
        cloneRepo
        ;;
    -f|--install-filebrowser)
        installFilebrowser
        ;;
    -w|--watch)
        watchFolder
        ;;
    -F|--full-install)
        fullInstall
        ;;
    *)
        echo "Usage: ./install.sh <command>"
        echo "-u/--update: Update software."
        echo "-p/--panel: Reset panel settings. Do this if you see a bar on the screen "
        echo "-c/--install-crons: Install the automatic screen on/off and slideshow"
        echo "-r/--repo: Clone the software behind this system"
        echo "-f/--install-filebrowser: Install the web file explorer"
        echo "-w/--watch: Watches the letters folder for new files"
        echo "-F/--full-install: Do all of the above steps. Do this for a new system"
esac
