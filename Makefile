# Makefile helpers for ViewStateKit
.PHONY: generate-localizations

generate-localizations:
	@echo "Generating localized strings..."
	swift Tools/generate_localized_strings.swift

# alias
generate: generate-localizations
