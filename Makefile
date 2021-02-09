all: format

format:
	@find src/ -iname "*.dhall" -exec dhall format --inplace {} \;
	@echo formatted dhall files
check-format:
	@find src/ -iname "*.dhall" -exec dhall format --check {} \;
ci: check-format
	vessel verify --version 0.5.7
