.PHONY: nvim-sync

nvim-sync:
	@echo "[operation]: syncing nvim configs"
	@rm -rf nvim/
	@cp -r ~/.config/nvim/ .
	@rm -rf nvim/.git/