# Aero Collect Logs

A tool to collect logs from Aero Appliances when the Aero web module does not launch.

## Usage

First, contact AeroFS support at [support.aerofs.com](mailto:support.aerofs.com) and ask for
instructions as to how to enter your appliance console.

Second, run the following command in your appliance console root shell:

    bash <(curl -sL https://raw.githubusercontent.com/mpillar/aero-collect-logs/master/aero-collect-logs.sh)

Alternatively, use:

    bash <(curl -sL https://bit.ly/1PMPUOH)

A web server will be running on port 8080. Navigate to `http://<appliance-ip>:8080/` to download
your logs.

## Credits

Bash HTTP server apapted from [avleen's](https://github.com/avleen)
[bashttpd](https://github.com/avleen/bashttpd). Thanks avleen!
