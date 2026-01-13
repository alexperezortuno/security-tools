IMAGE_NAME=nikto_ports:local
RESULTS_DIR=results
DOCKER_FILE=Dockerfile.nikto_ports

build:
	docker build -f $(DOCKER_FILE) -t $(IMAGE_NAME) .

filter:
	docker run --rm -v $(PWD)/$(RESULTS_DIR):/scanner/results:rw \
	-v $(PWD)/raw_targets.txt:/scanner/raw_targets.txt \
	-v $(PWD)/targets.txt:/scanner/targets.txt \
	-v $(PWD)/ports.txt:/scanner/ports.txt \
	$(IMAGE_NAME) ./nmap_filter.sh

scan:
	docker run --rm -v $(PWD)/$(RESULTS_DIR):/scanner/results:rw \
	-v $(PWD)/targets.txt:/scanner/targets.txt \
	$(IMAGE_NAME) ./scan_ports.sh

clean:
	rm -rf $(RESULTS_DIR) targets.txt

all: build filter scan
