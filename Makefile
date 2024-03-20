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
	substreams run -e $(ENDPOINT) substreams.yaml db_out -s 781930 -t +10000 -o json

.PHONY: create_db
create_db: 
	substreams-sink-sql setup "$(DSN)" sink/substreams.dev.yaml

.PHONY: sink_db_out
sink_db_out: build
	substreams-sink-sql run -e mainnet.btc.streamingfast.io:443 "$(DSN)" sink/substreams.dev.yaml 791930:7799300
