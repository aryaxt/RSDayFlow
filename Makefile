WORKSPACE = Example/RSDayFlowExample.xcworkspace
SCHEME = RSDayFlowExample
CONFIGURATION = Release
DEVICE_HOST = platform='iOS Simulator',OS='7.1',name='iPhone 4s'

.PHONY: all build ci clean test lint

all: ci

build:
	set -o pipefail && xcodebuild -workspace $(WORKSPACE) -scheme $(SCHEME) -configuration '$(CONFIGURATION)' -sdk iphonesimulator -destination $(DEVICE_HOST) build | bundle exec xcpretty -c

clean:
	xcodebuild -workspace $(WORKSPACE) -scheme $(SCHEME) -configuration '$(CONFIGURATION)' clean

test:
	set -o pipefail && xcodebuild -workspace $(WORKSPACE) -scheme $(SCHEME) -configuration Debug test -sdk iphonesimulator -destination $(DEVICE_HOST) | bundle exec second_curtain | bundle exec xcpretty -c --test

lint:
	bundle exec fui --path Example/RSDayFlowExample find

ci: CONFIGURATION = Debug
ci: build

bundler:
	gem install bundler
	bundle install
