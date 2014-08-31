# Intro

This guide is for [Private Internet Access](https://www.privateinternetaccess.com/) VPNs, but might be adaptable to other [OpenVPN](http://en.wikipedia.org/wiki/OpenVPN) providers.

# Use

```
nmcli con up id <vpn_name>
nmcli con down id <vpn_name>
```

# Setup

Adapted from here, with modifications for this NixOS setup:
https://www.privateinternetaccess.com/pages/client-support/#linux_ubuntu_openvpn_12_04

1. [from root] `./bin/nmapplet`.
2. Click the icon > VPN Connections > Configure VPN > Add
3. Choose OpenVPN as your VPN Connection Type, and press Create
5. The following will walk you though all configuration steps needed for the PIA VPN.
    Gateway: Select one of the Hostnames provided on the Network page
    Authentication
        Type: Password
        Username: The username provided with the PIA account
        Password: The password provided with the PIA account
        CA Certificate: Downloaded this zip file and extract the ca.crt file to somewhere it won't be deleted. We suggest your Home folder. If you extract this to your home folder, when searching for it, please click on your username on the left side, which will take you right to the home folder, then select the ca.crt file from the options on the right. 
    Advanced: Under the general tab, check the Use LZO data compression
    IPv4 Settings:
        Method: Automatic (VPN) Addresses Only 
6. Press Save. If you chose to have your password saved it may ask for you to verify your password to open your keyring. 
7. Open `/etc/NetworkManager/system-connections/<vpn_name>`
    Change `password-flags=1` to `password-flags=0`.
    Add the line `[vpn-secrets]`, and right below it `password=<vpn_password>`.
