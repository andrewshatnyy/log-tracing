SHELL='/bin/bash'

alb:
	goaccess \
		-o pages/alb.html \
		--geoip-database=./geodb/GeoLite2-City.mmdb \
		--log-format='%^ %dT%t.%^ %v %h:%^ %^ %^ %T %^ %s %^ %^ %b "%r" "%u" %^' \
		--date-format=%Y-%m-%d \
		--time-format=%T
nginx: access.log
	cat access.log | rg -v '(\[error\]|\[info\]|\[notice\])' | \
		goaccess \
		-o pages/access.html \
		--geoip-database=./geodb/GeoLite2-City.mmdb \
		--log-format='%h - %^ [%d:%t %^] "%r" %s %b "%R" "%u"' \
		--time-format %T \
		--date-format %d/%b/%Y
pods:
	- kubectl get pods --template '{{range .items}}{{.metadata.name}}{{"\n"}}{{end}}' -n image-services > pods
access.log: pods
	cat pods | while read pod; do kubectl logs $$pod -c nginx -n image-services >> access.log; done