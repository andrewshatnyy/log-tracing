alb:
	goaccess \
		-o pages/alb.html \
		--geoip-database=./geodb/GeoLite2-City.mmdb \
		--log-format='%^ %dT%t.%^ %v %h:%^ %^ %^ %T %^ %s %^ %^ %b "%r" "%u" %^' \
		--date-format=%Y-%m-%d \
		--time-format=%T
nginx:
	rg -v '(\[error\]|\[info\]|\[notice\])' | \
		goaccess \
		-o pages/access.html \
		--geoip-database=./geodb/GeoLite2-City.mmdb \
		--log-format='%h - %^ [%d:%t %^] "%r" %s %b "%R" "%u"' \
		--time-format %T \
		--date-format %d/%b/%Y