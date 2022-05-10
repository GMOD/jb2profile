
#!/bin/bash


## kill background scripts after finished
## https://spin.atomicobject.com/2017/08/24/start-stop-bash-background-process/
trap "exit" INT TERM
trap "kill 0" EXIT

## start servers on different ports
npx http-server igvjs/build -p 8000 -s  &
npx http-server jb2_175 -p 8001 -s &
npx http-server jb2lgv/build -p 8002 -s &
npx http-server jbrowse -p 8003 -s &

sleep 100

