
#!/bin/bash


## kill background scripts after finished
## https://spin.atomicobject.com/2017/08/24/start-stop-bash-background-process/
trap "exit" INT TERM
trap "kill 0" EXIT

## start servers on different ports
node express_cross_origin_isolated/index.js igvjs/build 8000 &
node express_cross_origin_isolated/index.js jb2_175 8001 &
node express_cross_origin_isolated/index.js jb2lgv/build 8002 &
node express_cross_origin_isolated/index.js jbrowse 8003 &

sleep 100

