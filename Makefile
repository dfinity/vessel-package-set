all: format

format:
	dhall format --transitive package-set.dhall;
	@echo formatted dhall files
check-format:
	dhall format --check --transitive package-set.dhall;
	@echo checked dhall files are formatted
	dhall type --file package-set.dhall;
	@echo checked dhall files are well-typed.
ci: check-format
	vessel verify --version 0.6.5
