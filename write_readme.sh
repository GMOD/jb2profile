#!/bin/bash
for i in results/*.md; do echo $i; echo -e "\n"; cat $i; echo -e "\n"; done | \
	sed -e 's!node profile_igvjs.js "http://localhost:8000!igvjs!'| \
	sed -e 's!node profile_jb2web.js "http://localhost:8001!jbrowse-web-1.6.5!'| \
	sed -e 's!node profile_jb2web.js "http://localhost:8002!jbrowse-web-1.6.7!'| \
	sed -e 's!node profile_jb2web.js "http://localhost:8003!jbrowse-web-1.6.7_small_opt!'| \
	sed -e 's!node profile_jb2web.js "http://localhost:8004!jbrowse-web-1.6.7_aggro_opt!'| \
	sed -e 's!node profile_jb2web.js "http://localhost:8005!jbrowse-react-lgv!' | \
	sed -e 's!/?loc=.*cram"!!'| \
	sed -e 's!/?loc=.*bam"!!'| \
	sed -e 's/1.00 |/1.00 🍏|/' >>README.md

