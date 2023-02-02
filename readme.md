
# Table of Contents

1.  [Installation](#orgc49f006)
    1.  [Make a bootable sd card for the Raspberry Pi](#orgd330fcd)
    2.  [Login to raspberry pi](#org02696bd)
        1.  [Get IP address of Raspberry Pi](#org6fce0d0)
        2.  [Login to the Rasberry Pi](#org9372e2d)
        3.  [Install and Set up display](#org8004b64)
    3.  [Uploading Missions Letters to the display](#org75849b0)
2.  [Operation](#org9a17782)



<a id="orgc49f006"></a>

# Installation


<a id="orgd330fcd"></a>

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
        
        **User**: user
        
        **Password**: nhbcmissions
    -   Configure wireless LAN
        
        **SSID**: NHBC
        
        **Password**: Enter the wifi password for your wireless connection
        
        Wireless LAN Country: US
    -   Set locale settings
        Time zone: America/Chicago
        Keyboard layout: us
    -   Click save at the bottom
9.  Click &ldquo;Write&rdquo; and wait for it to finish
10. Put it in the slot on the Raspberry pi and power it up.
11. You should see output on the screen, if not move the hdmi cable to the other port.
12. Wait a few minutes for it connect to the internet before going to the next step.


<a id="org02696bd"></a>

## Login to raspberry pi


<a id="org6fce0d0"></a>

### Get IP address of Raspberry Pi

1.  Go here: [DHCP Client Table](http://192.168.1.1/DHCPTable.asp)
2.  Look for &rsquo;mission-display&rsquo; in the **Client Name** Column
3.  Find the corresponding IP Address which looks like 192.168.1.xxx
    -   It might be 192.168.1.109 which is reserved in the router for this device.


<a id="org9372e2d"></a>

### Login to the Rasberry Pi

On Apple products open the *terminal* application

On Windows install [PuTTY](https://www.chiark.greenend.org.uk/~sgtatham/putty/latest.html)

1.  Open the terminal and enter the following: (Replace the ip-address with the ip address you just found)
    
        ssh user@ip-address
2.  Enter the password. You will not see any changes on the screen as you enter the password.
3.  You should get something that looks like this.
    
    ![img](./pictures/logged_in.png)


<a id="org8004b64"></a>

### Install and Set up display

1.  Copy and paste the following
    
        wget https://raw.githubusercontent.com/RaubJo/missions-display/master/scripts/install.sh
        chmod +x install.sh
        sudo ./install.sh --full-install
2.  You can now upload files via the web file browser (link)
3.  The display will automatically restart every night at midnight.
4.  When it restarts it will put all the uploaded letters into rotation


<a id="org75849b0"></a>

## Uploading Missions Letters to the display

1.  Go to the web file browser [here](http://192.168.1.109:8080).
2.  Login with these credentials.
    
    **Username**: NHBCwylie
    
    **Password**: nhbcmissions
3.  Enter the folder called &ldquo;letters&rdquo;
4.  Upload letters into this folder by clicking the Up arrow in the top right corner.
5.  The letters will be automatically put into rotation on the display.


<a id="org9a17782"></a>

# Operation

<table border="2" cellspacing="0" cellpadding="6" rules="groups" frame="hsides">


<colgroup>
<col  class="org-left" />

<col  class="org-left" />
</colgroup>
<tbody>
<tr>
<td class="org-left">Time</td>
<td class="org-left">Function</td>
</tr>


<tr>
<td class="org-left">00:00 Everyday</td>
<td class="org-left">Convert all files in the letters folder</td>
</tr>


<tr>
<td class="org-left">09:45 Sunday</td>
<td class="org-left">Screen On</td>
</tr>


<tr>
<td class="org-left">13:00 Sunday</td>
<td class="org-left">Screen Off</td>
</tr>


<tr>
<td class="org-left">15:15 Sunday</td>
<td class="org-left">Screen On</td>
</tr>


<tr>
<td class="org-left">18:45 Sunday</td>
<td class="org-left">Screen Off</td>
</tr>


<tr>
<td class="org-left">18:45 Wednesday</td>
<td class="org-left">Screen On</td>
</tr>


<tr>
<td class="org-left">21:00 Wednesday</td>
<td class="org-left">Screen Off</td>
</tr>
</tbody>
</table>

1.  The raspberry pi will automatically turn the screen on and off at the above times.
2.  It puts the screen into a deep sleep mode while it is off.
3.  You can view the past events in the log.txt file when you first open the web file browser.

