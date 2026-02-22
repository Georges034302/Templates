# fix-display.sh

Turns your laptop screen back **on**, sets it as **primary**, and **mirrors** it to the HDMI projector.

## Use
```bash
chmod +x fix-display.sh
./fix-display.sh
```

## If it fails
Run:
```bash
xrandr
```
Then replace `eDP-1` and `HDMI-1` in the script with the output names shown on your laptop.
