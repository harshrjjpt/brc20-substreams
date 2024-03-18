DSN ?= psql://postgres:root@localhost:5432/substreams_e?&schema="bitcoin"&sslmode=disable
ENDPOINT ?= mainnet.btc.streamingfast.io:443

.PHONY: build
build:
	cargo build --target wasm32-unknown-unknown --release

.PHONY: protogen
protogen:
	substreams protogen ./substreams.yaml --exclude-paths="sf/substreams,google"

.PHONY: stream_db_out
stream_db_out: build
	substreams run -e $(ENDPOINT) substreams.yaml db_out -s 779830 -t +100 -o json

.PHONY: create_db
create_db: 
	substreams-sink-sql setup "$(DSN)" sink/substreams.dev.yaml

.PHONY: sink_db_out
sink_db_out: build
	substreams-sink-sql run "$(DSN)" sink/substreams.dev.yaml 779830:77983011


# {"token":"eyJhbGciOiJLTVNFUzI1NiIsInR5cCI6IkpXVCJ9.eyJleHAiOjE3MTA3MDU1NzcsImp0aSI6ImY4MjIxOTE1LWQ5OTEtNGNmNC04NzQyLTQ1MzFhMDU5ZDZhMiIsImlhdCI6MTcxMDcwMTk3NywiaXNzIjoiZGZ1c2UuaW8iLCJzdWIiOiIwa2VrZTk3MGZlNTMxZjg4M2UxOTIiLCJ2IjoxLCJha2kiOiIwNDNiZjFhZmY2YTZmYzQwNjU3ZTgwYTcyMTExYzZlNjQ2ZWJhMWQwZjNiMzAzMDg1ZmFjYjZmZmU5NjM5MDcyIiwidWlkIjoiMGtla2U5NzBmZTUzMWY4ODNlMTkyIn0.W7MVF-6y5-tZKk2ACvs72sf2kbfIZc-UWpPKookU3M75cAyS3Vm7A6q9Iy2lkAYOZBQZ7sSlI7XqlEpIxfm-DQ","expires_at":1710705577}
