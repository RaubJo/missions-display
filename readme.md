
# Table of Contents

1.  [Installation](#orgdec251c)
    1.  [Make a bootable sd card for the Raspberry Pi](#org044b88b)
    2.  [Login to raspberry pi](#org881c5af)
        1.  [Get IP address of Raspberry Pi](#org50d6ec3)
        2.  [Login to the Rasberry Pi](#org23136b5)
        3.  [Install and Set up display](#orgaf54a4c)
    3.  [Uploading Missions Letters to the display](#orgd152ffd)



<a id="orgdec251c"></a>

# Installation


<a id="org044b88b"></a>

## Make a bootable sd card for the Raspberry Pi

1.  Download the [RPI-Imager](https://www.raspberrypi.com/software/)
2.  Put Micro SD Card into computer
3.  Click &ldquo;Choose OS&rdquo; in RPI-Imager
4.  Select &ldquo;Raspberry Pi OS (other)&rdquo;
5.  Select &ldquo;Raspberry Pi OS (64-bit)&rdquo;
6.  Click &ldquo;Choose Storage&rdquo; and select the Micro SD Card
    -   It may be useful to note the storage capacity of the card before you put it in.
7.  Click the gear button in the bottom right-hand corner
8.  Select the following checkboxes:
    -   Set hostname: mission-display
    -   Enable SSH
    -   Set username and password
        User: user
        Password: nhbcmissions
    -   Configure wireless LAN
        SSID: NHBC
        Password: LfeHQgQXm4fwk3H92q69mdGRAnVBB2FQ9yMJrsLm
        Wireless LAN Country: US
    -   Set locale settings
        Time zone: America/Chicago
        Keyboard layout: us
    -   Click save at the bottom
9.  Click &ldquo;Write&rdquo; and wait for it to finish
10. Put it in the slot on the Raspberry pi and plug it in.


<a id="org881c5af"></a>

## Login to raspberry pi


<a id="org50d6ec3"></a>

### Get IP address of Raspberry Pi

-   You might be able to skip this step, if the next step doesn&rsquo;t work then do this step.
-   Go here: [DHCP Client Table](http://192.168.1.1/DHCPTable.asp)
-   Username: admin, Password: LfeHQgQXm4fwk3H92q69mdGRAnVBB2FQ9yMJrsLm
-   Look for &rsquo;mission-display&rsquo; in the **Client Name** Column
-   Find the corresponding IP Address which looks like 192.168.1.xxx
    -   It might be 192.168.1.109 which is reserved in the router for this device.


<a id="org23136b5"></a>

### Login to the Rasberry Pi

On Apple products open the *terminal* application
On Windows install [PuTTY](https://www.chiark.greenend.org.uk/~sgtatham/putty/latest.html)

1.  Open the terminal and enter the following: (Replace the ip-address with the ip address you just found)

    ssh user@ip-address

1.  Enter the password. You will not see any changes on the screen as you enter the password.
2.  You should get something that looks like this.


<a id="orgaf54a4c"></a>

### Install and Set up display

1.  Copy and paste the following
    <script link>
2.  You can now upload files via the web file browser (link)
3.  The display will automatically restart every night at midnight.
4.  When it restarts it will put all the uploaded letters into rotation


<a id="orgd152ffd"></a>

## Uploading Missions Letters to the display

1.  Go to the web file browser (link)
2.  Login with these credentials. Username: NHBCwylie, password: nhbcmissions
3.  Enter the folder called &ldquo;letters&rdquo;
4.  Upload letters into this folder by clicking the Up arrow in the top right corner.
5.  The letters will be automatically put into rotation on the display.

