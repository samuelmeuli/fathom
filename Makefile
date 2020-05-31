EXECUTABLE := fathom
LDFLAGS += -extldflags "-static" -X "main.version=$(shell git describe --tags --always | sed 's/-/+/' | sed 's/^v//')" -X "main.commit=$(shell git rev-parse HEAD)"  -X "main.date=$(date -u +'%Y-%m-%dT%H:%M:%SZ')"
MAIN_PKG := ./main.go
PACKAGES ?= $(shell go list ./...)
ASSET_SOURCES ?= $(shell find assets/src/. -type f)
GO_SOURCES ?= $(shell find . -name "*.go" -type f)
BLACKLIST_DIR := pkg/aggregator/data/
BLACKLIST_TXT := $(BLACKLIST_DIR)blacklist.txt

# `make` with no arguments executes this rule
.PHONY: all
all: build

.PHONY: download
download:
	go mod download

.PHONY: install-tools
install-tools: download
	cat tools.go | grep _ | awk -F'"' '{print $$2}' | xargs -tI % go install %

.PHONY: build
build: $(EXECUTABLE)

$(EXECUTABLE): $(BLACKLIST_TXT) assets/build $(GO_SOURCES)
	go build -o $@ $(MAIN_PKG)

$(BLACKLIST_TXT):
	mkdir -p $(BLACKLIST_DIR)
	wget https://raw.githubusercontent.com/matomo-org/referrer-spam-blacklist/master/spammers.txt -O $(BLACKLIST_TXT)

.PHONY: docker
docker: $(BLACKLIST_TXT) $(GO_SOURCES)
	GOOS=linux GOARCH=amd64 packr build -v -ldflags '-w $(LDFLAGS)' -o $(EXECUTABLE) $(MAIN_PKG)

.PHONY: npm
npm:
	if [ ! -d "node_modules" ]; then npm install; fi

assets/build: $(ASSET_SOURCES) npm
	./node_modules/gulp/bin/gulp.js

assets/dist: $(ASSET_SOURCES) npm
	NODE_ENV=production ./node_modules/gulp/bin/gulp.js

.PHONY: clean
clean:
	go clean -i ./...
	packr clean
	rm -rf $(EXECUTABLE)

.PHONY: fmt
fmt:
	gofmt -l -w -s .

.PHONY: vet
vet:
	go vet $(PACKAGES)

.PHONY: errcheck
errcheck:
	errcheck $(PACKAGES)

.PHONY: lint
lint:
	for PKG in $(PACKAGES); do golint -set_exit_status $$PKG || exit 1; done;

.PHONY: test
test:
	for PKG in $(PACKAGES); do go test -cover -coverprofile ./coverage.out $$PKG || exit 1; done;
