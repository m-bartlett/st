# st

Pick which `PATCHES` you want to apply by uncommenting their basenames in `install.sh` and then run:

```
./install.sh
```

to apply the patches, compile, and install. The build takes place in a temporary directory that is deleted after use so if any patching errors occur the code is not left in an undefined state.
